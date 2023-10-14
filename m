Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0580A7C9646
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 22:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrlPD-0006TW-G5; Sat, 14 Oct 2023 16:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlPB-0006TC-RM
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 16:38:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlP1-0003np-Fv
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 16:38:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B43B675721D;
 Sat, 14 Oct 2023 22:37:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 83D78757202; Sat, 14 Oct 2023 22:37:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 81E5C745681;
 Sat, 14 Oct 2023 22:37:23 +0200 (CEST)
Date: Sat, 14 Oct 2023 22:37:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 06/12] tulip: Use the HP PCI vendor ID instead of
 number
In-Reply-To: <20231014195719.151397-7-deller@kernel.org>
Message-ID: <40d9d539-1064-19d8-6c89-cb1102be4b5e@eik.bme.hu>
References: <20231014195719.151397-1-deller@kernel.org>
 <20231014195719.151397-7-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 14 Oct 2023, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> hw/net/tulip.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index 915e5fb595..11d866e431 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -1020,7 +1020,7 @@ static void tulip_class_init(ObjectClass *klass, void *data)
>     k->exit = pci_tulip_exit;
>     k->vendor_id = PCI_VENDOR_ID_DEC;
>     k->device_id = PCI_DEVICE_ID_DEC_21143;
> -    k->subsystem_vendor_id = 0x103c;
> +    k->subsystem_vendor_id = PCI_VENDOR_ID_HP;

Seems to be first use of value introduced in patch 2. I don't know if this 
is worrh two separate patches. I'd just squash patch 2 in this patch but 
not sure what others or maintainer prefers.

Regards,
BALATON Zoltan

>     k->subsystem_id = 0x104f;
>     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
>     dc->vmsd = &vmstate_pci_tulip;
>

