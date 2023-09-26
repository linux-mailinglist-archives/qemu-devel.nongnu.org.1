Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD2A7AE754
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql345-0000MZ-RJ; Tue, 26 Sep 2023 04:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql33w-0000Lq-Mi
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:04:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql33v-0007lA-11
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:04:56 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MvbO4-1rcKfa3tCQ-00sh6M; Tue, 26 Sep 2023 10:04:53 +0200
Message-ID: <403b6b32-c8d6-3853-03ae-fb1144381b2b@vivier.eu>
Date: Tue, 26 Sep 2023 10:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 15/20] mac_via: workaround NetBSD ADB bus enumeration
 issue
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-16-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L63QDIzJksYYUNNZlcR2T9jRlH7/Q/JKpkCta4Psc/BWJmOQo38
 SB6i2X8iuGoKIlH4I8Yqnsfa7m8pLjHlWa6WHSuw1kteRZ4sXpYKxY7KU1ZO5RfSwBO7KVs
 5jshfJMTgqtM0R2bpum9lLlhZKCB/F4NhLd5EEnIIe4AYaGwZJysTNEiqj7dzqO38efshFe
 OCthqow+wI1yXQzyQrdbg==
UI-OutboundReport: notjunk:1;M01:P0:p8R7BU89w4U=;2ca7d/36r/IbuGD4E5yHoXTCImP
 XFqMwf1nLKYTARkrQW6iMGWnXI6DCU1okIOLnkRDhnUdqAZXTGYQ0pHH1yjYsw90Gjch7gz+2
 2joTmxJ39uMhE+WP22zdwC4HUJQ399umW0UkvfSLQ7dJnyEBGn+bNDhwyo8IvvvPErYGw5Nz/
 3gZSGWtLngYV+twP8PfnNL0gEqpXB6cKF9vqhuwqGLPPDhDbWmE7xhJsy6Uq5QyBqGlOOSgba
 /FkCZ25R/S0zEnu36rqxTW6E6AI463tIHzxiTQjyjT/1OhhEObQCp2FVeTkpOmUa9sDPnDpaJ
 RnMnbNZAAWEVOJ3Geb1U5k4+sDa+3JTxqsGodZpAODo/d58cgqhp77seWPkH80Zq0QHrRJBqG
 hVDoay3c/eASgJEpTM/cMlbprcd7fQxa7et7uNyMe57hJTl8gyW/umwlq3/4AuaP2SYVl3IGU
 mY9Ia8aFa3gMbxE0tcNZ9wXSffP3FAugVVl5GGbPKmf6NRQDE7xTE9ukVe9A8rILj8rFKu5IL
 /LdYXmx+E/X0LwAYHExgF9NIpup0PKDOaasXcBM/LOGUZzSA+4oDKmkFU5sRR2eajS+vy69oP
 sM9/faQN9fvJD0EWRQLQccJshczAOgOFzht1LgSlrkW18Rlt7IEo/NnoMHLxFmjYK7LFwgfz+
 IqbEzX/KTIkdJfu1o1Kjp6+ZEBtJfEzjyDINVQ03JXxfZahDl+wdrXPDYbRydSJBH1OGZgiq5
 o9099qqjC7FAWRlt3WkCiVUhimk/S5+oFPjt9QiyQvcLD5OUT7Yfc0COCE3FeZgyoXeBZzIOZ
 AOXaDwM9KlmfonzqU6alHRHBHsah5vG+5wPacOenF8j+O6yuXBCW/YgR2AQ6WOy+t1HYnf3pJ
 O3ugDPso+heB2bA==
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
> NetBSD assumes it can send its first ADB command after sending the ADB_BUSRESET
> command in ADB_STATE_NEW without changing the state back to ADB_STATE_IDLE
> first as detailed in the ADB protocol.
> 
> Add a workaround to detect this condition at the start of ADB enumeration
> and send the next command written to SR after a ADB_BUSRESET onto the bus
> regardless, even if we don't detect a state transition to ADB_STATE_NEW.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c    | 34 ++++++++++++++++++++++++++++++++++
>   hw/misc/trace-events |  1 +
>   2 files changed, 35 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 766a32a95d..208216aed3 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -1001,6 +1001,8 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
>   {
>       MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
>       MOS6522State *ms = MOS6522(v1s);
> +    int oldstate, state;
> +    int oldsr = ms->sr;
>   
>       addr = (addr >> 9) & 0xf;
>   
> @@ -1016,6 +1018,38 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
>   
>           v1s->last_b = ms->b;
>           break;
> +
> +    case VIA_REG_SR:
> +        {
> +            /*
> +             * NetBSD assumes it can send its first ADB command after sending
> +             * the ADB_BUSRESET command in ADB_STATE_NEW without changing the
> +             * state back to ADB_STATE_IDLE first as detailed in the ADB
> +             * protocol.
> +             *
> +             * Add a workaround to detect this condition at the start of ADB
> +             * enumeration and send the next command written to SR after a
> +             * ADB_BUSRESET onto the bus regardless, even if we don't detect a
> +             * state transition to ADB_STATE_NEW.
> +             *
> +             * Note that in my tests the NetBSD state machine takes one ADB
> +             * operation to recover which means the probe for an ADB device at
> +             * address 1 always fails. However since the first device is at
> +             * address 2 then this will work fine, without having to come up
> +             * with a more complicated and invasive solution.
> +             */
> +            oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
> +                       VIA1B_vADB_StateShift;
> +            state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
> +
> +            if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
> +                    (ms->acr & VIA1ACR_vShiftOut) &&
> +                    oldsr == 0 /* ADB_BUSRESET */) {
> +                trace_via1_adb_netbsd_enum_hack();
> +                adb_via_send(v1s, state, ms->sr);
> +            }
> +        }
> +        break;
>       }
>   }
>   
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 0c9762fdf6..db8bb2d28a 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -271,6 +271,7 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
>   via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s data=0x%02x vADBInt=%s"
>   via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
>   via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
> +via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
>   via1_auxmode(int mode) "setting auxmode to %d"
>   via1_timer_hack_state(int state) "setting timer_hack_state to %d"
>   

Did you ask NetBSD to fix their code?

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


