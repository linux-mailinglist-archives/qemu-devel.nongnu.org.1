Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE57ADD8A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkozR-0007CQ-Il; Mon, 25 Sep 2023 13:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkozQ-0007BZ-1A
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:03:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkozO-0000es-53
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:03:19 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mgebs-1rIkhD43JM-00h46z; Mon, 25 Sep 2023 19:03:16 +0200
Message-ID: <8268a9df-7f21-f3c0-4b89-8fb1feb3f256@vivier.eu>
Date: Mon, 25 Sep 2023 19:03:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/20] q800-glue.c: convert to Resettable interface
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-2-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9edEKdYnCxdEL8LpSImZ7PExheo9minQQvS2rXmeLqRENaJV7DT
 O2jGvkQzuBgmZBNK4RrnenQtcis42acwd6BQsJ13vzJih1XD5GnrdCkXZwFm1zK/AA6utx5
 m0H0z795ocIxE08C1ax+u6Ww5TJOyewZ/XpYa1hWvc8GqjGt1oLxWkHs9tWGOKeAM4/fqfC
 BnxZR4KfJOY4sy0rVkhig==
UI-OutboundReport: notjunk:1;M01:P0:jwJevqP8x0I=;7ZgSm9I2gNiCKkEg24CVPVOKQbq
 pvJQ8ZM4AnMENXXMYOhj+eC38tlDZ/bqGNKVB29xxVbsv3wYh6it3i8BLnFCQhBN1M12O8MOw
 9+2Hg89u0pOwyVuA1jRZhCXBc3+WHz7riDLZqqz5avN+5qzHR0YCLQpUbBjsZsCNJKGXQF/wp
 boWcgk8DztJ/Vu0f03Tja3mrRrh56YWSmufkm4uht4Bp+xduOrpR8L6aqehp7h9W5RT8LG40o
 1lcp2BErX4WW5SRVWpWyt3EH/9IPdJgPdilLTNNRP5j2sk4vpaPn+FOjZYWy/NLZDgSeanNJ7
 13h2ITvkonxMvaFY+iEvVovKcnkEIH6/ghdw730hXO1KSZtWGkm1FQDPaOeBy96fz0lNu5Gqb
 3G8c8JxpROrCCmKJ14UU2apusautYP3wMlLMpzpI+rr6d8jcA5PmkI7jytaJrWre+XY2qkWkF
 coMWNlCZqHrJcccwvtKCgn5fklDBVA/yPek3ixa3Gt2VcfZhChoKDgtrlUiwBIX1R6KBFf+0a
 3Ja0PtOZRNWGGoNkLbBL3kutsYSycfDa5JReefVY3bOJHjsC6Lw8ALskvePbkEF2Rya/rrlbj
 YRvfB5qsbkL4QmDWNvGHurghYwS5767zGQUIe057fsphkoo8j3auDN4agzHCSxvPp7SYI6N44
 5CfVStus4qCxJsz5AhcohngxjZ6vHojddmHo/tVrL1++gP5gTi7PGLGflHHw6yL8+ss7K/8Ez
 eIRLhGs7qHX4nFRESK7Qw8HOF6HMgK8C/KoyUORoTJYoLxs8oPbbqL4xRGE1bqAyMS1ZazAfw
 a1Cf+S11WTeh1KFhtPX/YDxO6CMG9yxAGPrVxpMeCeI6eqwvs/2WquCx0TQqCp8GwK0lwVmWA
 wBiVQnWIGVlwJdQ==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> Convert the GLUE device to 3-phase reset. The legacy method
> doesn't do anything that's invalid in the hold phase, so the
> conversion is simple and not a behaviour change.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/m68k/q800-glue.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
> index 34c4f0e987..710a5c331e 100644
> --- a/hw/m68k/q800-glue.c
> +++ b/hw/m68k/q800-glue.c
> @@ -166,9 +166,9 @@ static void glue_nmi_release(void *opaque)
>       GLUE_set_irq(s, GLUE_IRQ_IN_NMI, 0);
>   }
>   
> -static void glue_reset(DeviceState *dev)
> +static void glue_reset_hold(Object *obj)
>   {
> -    GLUEState *s = GLUE(dev);
> +    GLUEState *s = GLUE(obj);
>   
>       s->ipr = 0;
>       s->auxmode = 0;
> @@ -223,11 +223,12 @@ static void glue_init(Object *obj)
>   static void glue_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>       NMIClass *nc = NMI_CLASS(klass);
>   
>       dc->vmsd = &vmstate_glue;
> -    dc->reset = glue_reset;
>       device_class_set_props(dc, glue_properties);
> +    rc->phases.hold = glue_reset_hold;
>       nc->nmi_monitor_handler = glue_nmi;
>   }
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


