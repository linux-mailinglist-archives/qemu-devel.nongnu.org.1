Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7827AE76D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql36U-0003t3-5e; Tue, 26 Sep 2023 04:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql36R-0003ny-UT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:07:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql36Q-0008T1-0Z
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:07:31 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M89TB-1qgMHD1c27-005Hk0; Tue, 26 Sep 2023 10:07:28 +0200
Message-ID: <dc8156c0-fd49-b767-104b-77124859b9b0@vivier.eu>
Date: Tue, 26 Sep 2023 10:07:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 20/20] mac_via: extend timer calibration hack to work
 with A/UX
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-21-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-21-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U39FGfBD/e2keQrir2N9TB10vpxFuGAzHqevvtt/6aKJ+aJEw3N
 6I/QRZGyd57W9KooWpgyIq2QWtuJIVELnKd+ZCBpvaJzQQST9k173ygCBUwy+z7BMiJIgyf
 2BiX7Rm9GBV8op/9y8qX7h/dNGu+vkpr4R2x80YYbcYw+qeLMGDGHCVq25GGJIXrF044Q5q
 1Z4GgiJttTfA+FtvIilhw==
UI-OutboundReport: notjunk:1;M01:P0:zR85xIgHDEw=;CirupD8sIKmskGZR8CjPH3hO/6T
 AOxn11ReKe7EC9/vSR7t9WnZduTbDRcblZI9kVPF/N7IA+83YZ38soMORVT+l5yvdCt9k9Hax
 bnAjezMVSPLeeo2S6eUevT+OTO+69EyXCLE/FDbJ8a6VyMt0/uU7CRsqrqW3I1/dBj+Dos8mD
 4N/39hOWtF2ut4nMfiTgOgP1lUf21+RSxrUN5d6iN4RAdZvo0opXQz9ul4PSvKGflSVqhQOAU
 J1Kl/vjOs90ftRDPINo+GUonV7jRoHuYUssdVaJVsK71fBuJfKUnvmK1WCknc9L3r782CT9Ar
 E/5eSHqDNhHpevKrl6p7vskfW8mCDgM1xQ52hD6bZOxG1HxpahOomx5wBPJqpKU17lhYykDZf
 +oyg0Ht4j82bqhe3QdoodT0g4UXQdMFs+wmgJVKApamMusBe+J4LbIWlzMAa2uVmDmcPE9kWP
 9zo9jlCiGOta6ns5qQRKtH20YBDxmN139eyNQfnxdhrPEKW0TIEsvKlnRjQNo0sFW5tLwKFB4
 nJ/PaD85fWRpG8mFgdZt9XkRFc4lxMVuwmtciQxS+cSqPj0ltHMnmCgHVD1N8HEgPx4Wb36ZC
 xMlJRe0+5G4nmsJYtco85zs54b7A/EQP3BHHbDvEvbr6Yih4HrLWvoLD39MLXxz0q2T8oNQRQ
 1OAuV2/t6W6RwPE7yPi0gvgNxUkMEGywrqDAE+IcvkOBXJAi5dBOTRDyzwcWQGHOx7VEqxg+v
 vXWRhKTVsYjottFJqv1z3PU91TgcXLFdIgacTRoXv5CO6SNvMiG8UKdnyFlX9CDwmmcp4zrkl
 JBbCZkDyOXAce9KsLehj79XZSzzSF0kFflTzoVe3MOgCetHZpAZJrfMU7q/+5bB/N1hs34Q5U
 wDNFIpUzgdqf4MQ==
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
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
> The A/UX timer calibration loop runs continuously until 2 consecutive iterations
> differ by at least 0x492 timer ticks. Modern hosts execute the timer calibration
> loop so fast that this situation never occurs causing a hang on boot.
> 
> Use a similar method to Shoebill which is to randomly add 0x500 to the T2
> counter value during calibration to enable it to eventually succeed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 5d1adf5863..2ce389e435 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -983,6 +983,44 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
>               /* Looks like there has been a reset? */
>               v1s->timer_hack_state = 1;
>           }
> +
> +        if (addr == VIA_REG_T2CL && val == 0xf0) {
> +            /* VIA_REG_T2CL: low byte of counter (A/UX) */
> +            v1s->timer_hack_state = 5;
> +        }
> +        break;
> +    case 5:
> +        if (addr == VIA_REG_T2CH && val == 0x3c) {
> +            /*
> +             * VIA_REG_T2CH: high byte of counter (A/UX). We are now extremely
> +             * likely to be in the A/UX timer calibration routine, so move to
> +             * the next state where we enable the calibration hack.
> +             */
> +            v1s->timer_hack_state = 6;
> +        } else if ((addr == VIA_REG_IER && val == 0x20) ||
> +                   addr == VIA_REG_T2CH) {
> +            /* We're doing something else with the timer, not calibration */
> +            v1s->timer_hack_state = 0;
> +        }
> +        break;
> +    case 6:
> +        if ((addr == VIA_REG_IER && val == 0x20) || addr == VIA_REG_T2CH) {
> +            /* End of A/UX timer calibration routine, or another write */
> +            v1s->timer_hack_state = 7;
> +        } else {
> +            v1s->timer_hack_state = 0;
> +        }
> +        break;
> +    case 7:
> +        /*
> +         * This is the normal post-calibration timer state once both the
> +         * MacOS toolbox and A/UX have been calibrated, until we see a write
> +         * to VIA_REG_PCR to suggest a reset
> +         */
> +        if (addr == VIA_REG_PCR && val == 0x22) {
> +            /* Looks like there has been a reset? */
> +            v1s->timer_hack_state = 1;
> +        }
>           break;
>       default:
>           g_assert_not_reached();
> @@ -998,6 +1036,7 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
>       MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
>       MOS6522State *ms = MOS6522(s);
>       uint64_t ret;
> +    int64_t now;
>   
>       addr = (addr >> 9) & 0xf;
>       ret = mos6522_read(ms, addr, size);
> @@ -1007,6 +1046,23 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
>           /* Quadra 800 Id */
>           ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
>           break;
> +    case VIA_REG_T2CH:
> +        if (s->timer_hack_state == 6) {
> +            /*
> +             * The A/UX timer calibration loop runs continuously until 2
> +             * consecutive iterations differ by at least 0x492 timer ticks.
> +             * Modern hosts execute the timer calibration loop so fast that
> +             * this situation never occurs causing a hang on boot. Use a
> +             * similar method to Shoebill which is to randomly add 0x500 to
> +             * the T2 counter value during calibration to enable it to
> +             * eventually succeed.
> +             */
> +            now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +            if (now & 1) {
> +                ret += 0x5;
> +            }
> +        }
> +        break;
>       }
>       return ret;
>   }

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


