Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6637C9645
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 22:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrlLl-0005JX-FZ; Sat, 14 Oct 2023 16:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlLj-0005JK-Jr; Sat, 14 Oct 2023 16:35:03 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qrlLh-0003GB-88; Sat, 14 Oct 2023 16:35:03 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E7C02757202;
 Sat, 14 Oct 2023 22:33:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AC0687456A7; Sat, 14 Oct 2023 22:33:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A709A745681;
 Sat, 14 Oct 2023 22:33:53 +0200 (CEST)
Date: Sat, 14 Oct 2023 22:33:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, qemu-stable@nongnu.org
Subject: Re: [PATCH 05/12] lasips2: LASI PS/2 devices are not user-createable
In-Reply-To: <20231014195719.151397-6-deller@kernel.org>
Message-ID: <b5bce14d-082e-bab4-9345-668f90d876e7@eik.bme.hu>
References: <20231014195719.151397-1-deller@kernel.org>
 <20231014195719.151397-6-deller@kernel.org>
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
> Those PS/2 ports are created with the LASI controller when
> a 32-bit PA-RISC machine is created.
>
> Mark them not user-createable to avoid showing them in
> the qemu device list.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: qemu-stable@nongnu.org
> ---
> hw/input/lasips2.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/hw/input/lasips2.c b/hw/input/lasips2.c
> index ea7c07a2ba..93c9c887d3 100644
> --- a/hw/input/lasips2.c
> +++ b/hw/input/lasips2.c
> @@ -351,6 +351,8 @@ static void lasips2_port_class_init(ObjectClass *klass, void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
>
> +    /* Lasi devices can not be created by users */

That's what the next line says so this comment does not add any info. It 
should instead explain why, such as "part of LASI" or something like that.

Regards,
BALATON Zoltan

> +    dc->user_creatable = false;
>     dc->realize = lasips2_port_realize;
> }
>
> @@ -397,6 +399,8 @@ static void lasips2_kbd_port_class_init(ObjectClass *klass, void *data)
>     DeviceClass *dc = DEVICE_CLASS(klass);
>     LASIPS2PortDeviceClass *lpdc = LASIPS2_PORT_CLASS(klass);
>
> +    /* Lasi devices can not be created by users */
> +    dc->user_creatable = false;
>     device_class_set_parent_realize(dc, lasips2_kbd_port_realize,
>                                     &lpdc->parent_realize);
> }
>

