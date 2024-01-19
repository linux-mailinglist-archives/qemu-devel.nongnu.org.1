Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C062832B92
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:47:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq9C-0007Z6-I5; Fri, 19 Jan 2024 09:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQq8x-0006Ww-5B; Fri, 19 Jan 2024 09:46:52 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rQq8u-000778-8G; Fri, 19 Jan 2024 09:46:50 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 560C649214;
 Fri, 19 Jan 2024 15:46:45 +0100 (CET)
Message-ID: <9479f045-1c09-41a6-b625-940b0ee723d5@proxmox.com>
Date: Fri, 19 Jan 2024 15:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
 <20240117160737.1057513-4-vsementsov@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240117160737.1057513-4-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 17.01.24 um 17:07 schrieb Vladimir Sementsov-Ogievskiy:
> Add a parameter that enables discard-after-copy. That is mostly useful
> in "push backup with fleecing" scheme, when source is snapshot-access
> format driver node, based on copy-before-write filter snapshot-access
> API:
> 
> [guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
>    |            |
>    | root       | file
>    v            v
> [copy-before-write]
>    |             |
>    | file        | target
>    v             v
> [active disk]   [temp.img]
> 
> In this case discard-after-copy does two things:
> 
>  - discard data in temp.img to save disk space
>  - avoid further copy-before-write operation in discarded area
> 
> Note that we have to declare WRITE permission on source in
> copy-before-write filter, for discard to work.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Unfortunately, setting BLK_PERM_WRITE unconditionally breaks
blockdev-backup for a read-only node (even when not using discard-source):

> #!/bin/bash
> ./qemu-img create /tmp/disk.raw -f raw 1G
> ./qemu-img create /tmp/backup.raw -f raw 1G
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw,read-only=true \
> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/backup.raw \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "blockdev-backup", "arguments": { "device": "node0", "target": "node1", "sync": "full", "job-id": "backup0" } }
> EOF

The above works before applying this patch, but leads to an error
afterwards:

> {"error": {"class": "GenericError", "desc": "Block node is read-only"}}

Best Regards,
Fiona


