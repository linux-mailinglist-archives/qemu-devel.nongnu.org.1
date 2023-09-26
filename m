Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3075D7AE750
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:04:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql33B-0008Bp-Cd; Tue, 26 Sep 2023 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql339-0008BT-20
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:04:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql336-0007iD-UX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:04:06 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Ma1D8-1r8Eis39xU-00VzDg; Tue, 26 Sep 2023 10:04:02 +0200
Message-ID: <f199dbec-0e75-81c8-7625-ef5224354687@vivier.eu>
Date: Tue, 26 Sep 2023 10:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/20] mac_via: work around underflow in TimeDBRA
 timing loop in SETUPTIMEK
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-15-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PsLKYdhBeLxhhGcwSYQbMrh+oziI5MF/6ILJwxJOiDA1pL6AMem
 YI6WNE/nITl38vQcc/My1EaHlivj4KK0o5zUl9whpGBD8uShvUQwLND843r5xUWJ7ltC5GS
 nuCbUvvR7Lsk7zzNgmX69hI9OPx+H0nlX4CiakCBtyzJ7htdJftyKynxtMk15LzQKgzL9ZG
 /U+8rbZNJ1hJLt+GgThNQ==
UI-OutboundReport: notjunk:1;M01:P0:XToLDsawzOY=;VA/4QN94BoFYB6cETin4jTXAmi/
 W6ddl7EzYQSzWMgEasp0vlg0Jg9aRebf3FsH+YJ7xkzvyXBUrmd0cfUIgwQRn7WboSFdjmhV5
 NMbj5WiK+5/hOGLk9jprYUI54tAiKjvpsME7lUIJxs4tmtxuchASJ/HQDaqwQMynu0I3GyzO5
 8Ol7SfyeZJ/Rp7mTBLDMHVbDvATYS7a7WL9G3y8RzKZZk70ol9QelxUfqFbmEUHiE6c8Ypd0P
 HmqZI8s3ZCahON/30dozJTv4m5vgjzj1CJp5MUzYI016w6fQFfClCXIGgI50EpJ3QUlW3pbvs
 nOPtGN19acyfU4c+vBnxbTPObVnl66b8cqcMrkDn7HSVl0Yry0KPP8CXJfj5+q07mq4Us+Rwq
 J/UmSjjSi7y6SKPeAx/b1NvWQi2x50iBeiLQGt7dj1RaTx5Hl4WVK5bIQEuDoq9+didyE/1Zj
 Dfbz/6NYNxpqYtvWYrZ6/c8f6KV1SM/3JF7WhNNBNC/PfL205GObjJ0faOBaEq/OJlRYYYc8Y
 q4fUpdJHy8fif8ELyAVST/5Al+LR9eVs3JvrX3pMNW4MbVrqY+QCnI+uQbAoDA0tk0qv3VIwd
 s14RcOuSIFZ+EFPwikbwXMIIGMEcds9lLkXg8I1Pn4l6Vhfv8YndwwY9PPEYNNWaMYQOSF6BW
 VRliIOjudMeNLykt+W0f4SrBpwV/9rCj9T87UKWc28dTfhmDhSHAetgJapPQKowS9pHYJQmSY
 onLgJPnroAyz3Z1FBlBzIa6+9sU9iJ54KZkzCbnm5NhVOdfwGF/CksoELZ/0E/I0pM5UJWVuq
 JHeMWufYtjsWOHcupwABtVCAjtjvcPdPOJRR5NF72Qfi0XeRpaXm63eseRiGz8X8UQTGNZL5+
 zBQT7LbpTgPD8sA==
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
> The MacOS toolbox ROM calculates the number of branches that can be executed
> per millisecond as part of its timer calibration. Since modern hosts are
> considerably quicker than original hardware, the negative counter reaches zero
> before the calibration completes leading to division by zero later in
> CALCULATESLOD.
> 
> Instead of trying to fudge the timing loop (which won't work for TimeDBRA/TimeSCCDB
> anyhow), use the pattern of access to the VIA1 registers to detect when SETUPTIMEK
> has finished executing and write some well-known good timer values to TimeDBRA
> and TimeSCCDB taken from real hardware with a suitable scaling factor.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c         | 115 ++++++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events      |   1 +
>   include/hw/misc/mac_via.h |   3 +
>   3 files changed, 119 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index baeb73eeb3..766a32a95d 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "exec/address-spaces.h"
>   #include "migration/vmstate.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
> @@ -871,6 +872,112 @@ static void via1_auxmode_update(MOS6522Q800VIA1State *v1s)
>       }
>   }
>   
> +/*
> + * Addresses and real values for TimeDBRA/TimeSCCB to allow timer calibration
> + * to succeed (NOTE: both values have been multiplied by 3 to cope with the
> + * speed of QEMU execution on a modern host
> + */
> +#define MACOS_TIMEDBRA        0xd00
> +#define MACOS_TIMESCCB        0xd02
> +
> +#define MACOS_TIMEDBRA_VALUE  (0x2a00 * 3)
> +#define MACOS_TIMESCCB_VALUE  (0x079d * 3)
> +
> +static bool via1_is_toolbox_timer_calibrated(void)
> +{
> +    /*
> +     * Indicate whether the MacOS toolbox has been calibrated by checking
> +     * for the value of our magic constants
> +     */
> +    uint16_t timedbra = lduw_be_phys(&address_space_memory, MACOS_TIMEDBRA);
> +    uint16_t timesccdb = lduw_be_phys(&address_space_memory, MACOS_TIMESCCB);
> +
> +    return (timedbra == MACOS_TIMEDBRA_VALUE &&
> +            timesccdb == MACOS_TIMESCCB_VALUE);
> +}
> +
> +static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
> +                                        uint64_t val, int size)
> +{
> +    /*
> +     * Work around timer calibration to ensure we that we have non-zero and
> +     * known good values for TIMEDRBA and TIMESCCDB.
> +     *
> +     * This works by attempting to detect the reset and calibration sequence
> +     * of writes to VIA1
> +     */
> +    int old_timer_hack_state = v1s->timer_hack_state;
> +
> +    switch (v1s->timer_hack_state) {
> +    case 0:
> +        if (addr == VIA_REG_PCR && val == 0x22) {
> +            /* VIA_REG_PCR: configure VIA1 edge triggering */
> +            v1s->timer_hack_state = 1;
> +        }
> +        break;
> +    case 1:
> +        if (addr == VIA_REG_T2CL && val == 0xc) {
> +            /* VIA_REG_T2CL: low byte of 1ms counter */
> +            if (!via1_is_toolbox_timer_calibrated()) {
> +                v1s->timer_hack_state = 2;
> +            } else {
> +                v1s->timer_hack_state = 0;
> +            }
> +        }
> +        break;
> +    case 2:
> +        if (addr == VIA_REG_T2CH && val == 0x3) {
> +            /*
> +             * VIA_REG_T2CH: high byte of 1ms counter (very likely at the
> +             * start of SETUPTIMEK)
> +             */
> +            if (!via1_is_toolbox_timer_calibrated()) {
> +                v1s->timer_hack_state = 3;
> +            } else {
> +                v1s->timer_hack_state = 0;
> +            }
> +        }
> +        break;
> +    case 3:
> +        if (addr == VIA_REG_IER && val == 0x20) {
> +            /*
> +             * VIA_REG_IER: update at end of SETUPTIMEK
> +             *
> +             * Timer calibration has finished: unfortunately the values in
> +             * TIMEDBRA (0xd00) and TIMESCCDB (0xd02) are so far out they
> +             * cause divide by zero errors.
> +             *
> +             * Update them with values obtained from a real Q800 but with
> +             * a x3 scaling factor which seems to work well
> +             */
> +            stw_be_phys(&address_space_memory, MACOS_TIMEDBRA,
> +                        MACOS_TIMEDBRA_VALUE);
> +            stw_be_phys(&address_space_memory, MACOS_TIMESCCB,
> +                        MACOS_TIMESCCB_VALUE);
> +
> +            v1s->timer_hack_state = 4;
> +        }
> +        break;
> +    case 4:
> +        /*
> +         * This is the normal post-calibration timer state: we should
> +         * generally remain here unless we detect the A/UX calibration
> +         * loop, or a write to VIA_REG_PCR suggesting a reset
> +         */
> +        if (addr == VIA_REG_PCR && val == 0x22) {
> +            /* Looks like there has been a reset? */
> +            v1s->timer_hack_state = 1;
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (old_timer_hack_state != v1s->timer_hack_state) {
> +        trace_via1_timer_hack_state(v1s->timer_hack_state);
> +    }
> +}
> +
>   static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
>   {
>       MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
> @@ -896,6 +1003,9 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
>       MOS6522State *ms = MOS6522(v1s);
>   
>       addr = (addr >> 9) & 0xf;
> +
> +    via1_timer_calibration_hack(v1s, addr, val, size);
> +
>       mos6522_write(ms, addr, val, size);
>   
>       switch (addr) {
> @@ -1008,6 +1118,9 @@ static void mos6522_q800_via1_reset_hold(Object *obj)
>       adb_set_autopoll_enabled(adb_bus, true);
>       v1s->cmd = REG_EMPTY;
>       v1s->alt = REG_EMPTY;
> +
> +    /* Timer calibration hack */
> +    v1s->timer_hack_state = 0;
>   }
>   
>   static void mos6522_q800_via1_realize(DeviceState *dev, Error **errp)
> @@ -1100,6 +1213,8 @@ static const VMStateDescription vmstate_q800_via1 = {
>           VMSTATE_INT64(next_second, MOS6522Q800VIA1State),
>           VMSTATE_TIMER_PTR(sixty_hz_timer, MOS6522Q800VIA1State),
>           VMSTATE_INT64(next_sixty_hz, MOS6522Q800VIA1State),
> +        /* Timer hack */
> +        VMSTATE_INT32(timer_hack_state, MOS6522Q800VIA1State),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index c9bdb0d30e..0c9762fdf6 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -272,6 +272,7 @@ via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s da
>   via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
>   via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
>   via1_auxmode(int mode) "setting auxmode to %d"
> +via1_timer_hack_state(int state) "setting timer_hack_state to %d"
>   
>   # grlib_ahb_apb_pnp.c
>   grlib_ahb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" size:%u data:0x%08x"
> diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
> index 422da43bf9..63cdcf7c69 100644
> --- a/include/hw/misc/mac_via.h
> +++ b/include/hw/misc/mac_via.h
> @@ -74,6 +74,9 @@ struct MOS6522Q800VIA1State {
>       int64_t next_second;
>       QEMUTimer *sixty_hz_timer;
>       int64_t next_sixty_hz;
> +
> +    /* SETUPTIMEK hack */
> +    int timer_hack_state;
>   };
>   
>   
Reviewed-by: Laurent Vivier <laurent@vivier.eu>


