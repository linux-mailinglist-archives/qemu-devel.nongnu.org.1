Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A31E67C8628
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHfq-0005sZ-4e; Fri, 13 Oct 2023 08:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrHfn-0005rI-Bi; Fri, 13 Oct 2023 08:53:47 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=fS+4=F3=kaod.org=clg@ozlabs.org>)
 id 1qrHfi-0001uT-T0; Fri, 13 Oct 2023 08:53:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S6RJh1RzYz4xRn;
 Fri, 13 Oct 2023 23:53:40 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6RJd4jYsz4wy9;
 Fri, 13 Oct 2023 23:53:37 +1100 (AEDT)
Message-ID: <b5945531-40b1-4cae-83d4-121ed6159a28@kaod.org>
Date: Fri, 13 Oct 2023 14:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 70/78] hw/rtc: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <7bad24a9243a3d9f0190e2f89c86aa68816de5d6.1697186560.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <7bad24a9243a3d9f0190e2f89c86aa68816de5d6.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=fS+4=F3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/13/23 10:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   hw/rtc/aspeed_rtc.c  | 4 ++--
>   hw/rtc/mc146818rtc.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
> index fa861e2d49..59c64b01b9 100644
> --- a/hw/rtc/aspeed_rtc.c
> +++ b/hw/rtc/aspeed_rtc.c
> @@ -78,7 +78,7 @@ static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
>           if (rtc->reg[CONTROL] & RTC_ENABLED) {
>               rtc->reg[r] = aspeed_rtc_get_counter(rtc, r);
>           }
> -        /* fall through */
> +        fallthrough;
>       case CONTROL:
>           val = rtc->reg[r];
>           break;
> @@ -106,7 +106,7 @@ static void aspeed_rtc_write(void *opaque, hwaddr addr,
>           if (!(rtc->reg[CONTROL] & RTC_UNLOCKED)) {
>               break;
>           }
> -        /* fall through */
> +        fallthrough;
>       case CONTROL:
>           rtc->reg[r] = val;
>           aspeed_rtc_calc_offset(rtc);
> diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
> index c27c362db9..6b6eef94fd 100644
> --- a/hw/rtc/mc146818rtc.c
> +++ b/hw/rtc/mc146818rtc.c
> @@ -457,7 +457,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
>               break;
>           case RTC_IBM_PS2_CENTURY_BYTE:
>               s->cmos_index = RTC_CENTURY;
> -            /* fall through */
> +            fallthrough;
>           case RTC_CENTURY:
>           case RTC_SECONDS:
>           case RTC_MINUTES:
> @@ -686,7 +686,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
>           switch(s->cmos_index) {
>           case RTC_IBM_PS2_CENTURY_BYTE:
>               s->cmos_index = RTC_CENTURY;
> -            /* fall through */
> +            fallthrough;
>           case RTC_CENTURY:
>           case RTC_SECONDS:
>           case RTC_MINUTES:


