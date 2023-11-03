Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B91067E03B8
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 14:22:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyu6b-0004MK-Df; Fri, 03 Nov 2023 09:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qyu6Z-0004M5-Su; Fri, 03 Nov 2023 09:20:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qyu6Y-0001gy-1a; Fri, 03 Nov 2023 09:20:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 63657442A9;
 Fri,  3 Nov 2023 14:20:51 +0100 (CET)
Message-ID: <7534e14e-df32-4772-99d2-335c486ddd72@proxmox.com>
Date: Fri, 3 Nov 2023 14:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers
 <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
 <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
 <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
 <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
 <ZS56FzuqZSApXBbc@redhat.com>
 <c2a6c1b6-0438-488f-bba3-1014ffdadbce@proxmox.com>
 <ZS6YFtYKyFLbfrrP@redhat.com>
 <3e1c941b-2b76-4f85-88cb-4a2a968eb3e6@proxmox.com>
 <ZTEdk5gKXlIrKNm8@redhat.com>
 <b8007a25-10e1-483c-81c4-9d7dc3c67ed9@proxmox.com>
 <e13b488e-bf13-44f2-acca-e724d14f43fd@proxmox.com>
In-Reply-To: <e13b488e-bf13-44f2-acca-e724d14f43fd@proxmox.com>
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

Am 20.10.23 um 15:52 schrieb Fiona Ebner:
> And I found that with drive-mirror, the issue during starting seems to
> manifest with the bdrv_open() call. Adding a return before it, the guest
> IO didn't get stuck in my testing, but adding a return after it, it can
> get stuck. I'll try to see if I can further narrow it down next week,
> but maybe that's already a useful hint?
> 

In the end, I was able to find a reproducer that just does draining and
bisected the issue (doesn't seem related to the graph lock after all). I
replied there, to avoid all the overhead from this thread:

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg00681.html

Best Regards,
Fiona


