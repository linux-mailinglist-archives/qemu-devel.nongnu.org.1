Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15018767CE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Mar 2024 16:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricTZ-0003kw-P9; Fri, 08 Mar 2024 10:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTX-0003d8-JE; Fri, 08 Mar 2024 10:49:35 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ricTV-0004Al-Uy; Fri, 08 Mar 2024 10:49:35 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 70BD6488C0;
 Fri,  8 Mar 2024 16:49:32 +0100 (CET)
Message-ID: <232bfccc-0ebf-4096-8f35-6a329beb492b@proxmox.com>
Date: Fri, 8 Mar 2024 16:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iotests: add backup-discard-source
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, den@virtuozzo.com,
 alexander.ivanov@virtuozzo.com
References: <20240228141501.455989-1-vsementsov@yandex-team.ru>
 <20240228141501.455989-6-vsementsov@yandex-team.ru>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240228141501.455989-6-vsementsov@yandex-team.ru>
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

Am 28.02.24 um 15:15 schrieb Vladimir Sementsov-Ogievskiy:
> Add test for a new backup option: discard-source.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  .../qemu-iotests/tests/backup-discard-source  | 151 ++++++++++++++++++
>  .../tests/backup-discard-source.out           |   5 +
>  2 files changed, 156 insertions(+)
>  create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>  create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
> 
> diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
> new file mode 100755
> index 0000000000..8a88b0f6c4
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/backup-discard-source
> @@ -0,0 +1,151 @@
> +#!/usr/bin/env python3
> +#
> +# Test removing persistent bitmap from backing
> +#
> +# Copyright (c) 2022 Virtuozzo International GmbH.
> +#

Title and copyright year are wrong.

Apart from that:

Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>


