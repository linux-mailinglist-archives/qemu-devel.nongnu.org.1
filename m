Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 352737B26C6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlxt2-0007vp-NG; Thu, 28 Sep 2023 16:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxsz-0007vL-Hp
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:45:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxsx-0000Fw-Fk
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rnKSbPwDl9z3kcC0D/vzncl1C92Wqr2qoht+x8cifZM=; b=q+uX419P/2H9SZqcSlwhAZUK6E
 62M6W3HByLdXTCcgCe6wmca57RZHcEtBu485fduPhSyVukuCbMHGGaaP0ZOv3KT8HTu0p927BeV+2
 olwMvwIT1ZHZjAr4bxjW96l0HrmnQQ32GUiM/wPJkFEPFDinb8QTZCVvV8rfkSqsSvXIr8yX+2KDP
 3rYc+hZEB1lD29mlIHdykqalcK5i84FBdzM6ACszHD8Mrz6NXgCv1nSWOiIAhlV2BrOmezSy+Pfpd
 pEsQ0zzw2zkqyuwDpFpnVGXo3LdgBjcLGzv3Gj0joQRXix/DStk/8kIW+v2UDi0I2JEMUmV3sRO/q
 OkPTI8sYizj/d0HggSxC4JT5oRrcg9aOvfyUT84uB4rQEpNCmy3L3kmY9hDNPnLo5DpDghbUQEYLS
 mJkVCtmnIZZ+8xtGUj2czpNpJAd/LX9gdSZ1zHnk9pWkwASV2yd3oGxKB4SMKLEt6zR7Gtl5Xkq3S
 2Q5lTagn7tB6WqIrBbM/39LFt+IRw4c1rI15Q6IsIdM/cqDeo7OCe+swSrrL9i5L2qQyaQdqfdTB2
 4HKumKViSF9bMHqk0YAy+KmXIPbJe4qTTUlVUYgPXNcET3m50Q8O9IzPrfvoFMfeSBC5GZtmsTArk
 QdrYXllSlvRiR6DaPwpGQRodY4CqkZEubq7xX8s3c=;
Received: from [2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxsh-00079j-1l; Thu, 28 Sep 2023 21:45:11 +0100
Message-ID: <8ee4b030-a3b2-8b1c-1bcb-691a196a3ad5@ilande.co.uk>
Date: Thu, 28 Sep 2023 21:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-16-mark.cave-ayland@ilande.co.uk>
 <403b6b32-c8d6-3853-03ae-fb1144381b2b@vivier.eu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <403b6b32-c8d6-3853-03ae-fb1144381b2b@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 15/20] mac_via: workaround NetBSD ADB bus enumeration
 issue
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/09/2023 09:04, Laurent Vivier wrote:

> Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
>> NetBSD assumes it can send its first ADB command after sending the ADB_BUSRESET
>> command in ADB_STATE_NEW without changing the state back to ADB_STATE_IDLE
>> first as detailed in the ADB protocol.
>>
>> Add a workaround to detect this condition at the start of ADB enumeration
>> and send the next command written to SR after a ADB_BUSRESET onto the bus
>> regardless, even if we don't detect a state transition to ADB_STATE_NEW.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/misc/mac_via.c    | 34 ++++++++++++++++++++++++++++++++++
>>   hw/misc/trace-events |  1 +
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
>> index 766a32a95d..208216aed3 100644
>> --- a/hw/misc/mac_via.c
>> +++ b/hw/misc/mac_via.c
>> @@ -1001,6 +1001,8 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr 
>> addr, uint64_t val,
>>   {
>>       MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
>>       MOS6522State *ms = MOS6522(v1s);
>> +    int oldstate, state;
>> +    int oldsr = ms->sr;
>>       addr = (addr >> 9) & 0xf;
>> @@ -1016,6 +1018,38 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr 
>> addr, uint64_t val,
>>           v1s->last_b = ms->b;
>>           break;
>> +
>> +    case VIA_REG_SR:
>> +        {
>> +            /*
>> +             * NetBSD assumes it can send its first ADB command after sending
>> +             * the ADB_BUSRESET command in ADB_STATE_NEW without changing the
>> +             * state back to ADB_STATE_IDLE first as detailed in the ADB
>> +             * protocol.
>> +             *
>> +             * Add a workaround to detect this condition at the start of ADB
>> +             * enumeration and send the next command written to SR after a
>> +             * ADB_BUSRESET onto the bus regardless, even if we don't detect a
>> +             * state transition to ADB_STATE_NEW.
>> +             *
>> +             * Note that in my tests the NetBSD state machine takes one ADB
>> +             * operation to recover which means the probe for an ADB device at
>> +             * address 1 always fails. However since the first device is at
>> +             * address 2 then this will work fine, without having to come up
>> +             * with a more complicated and invasive solution.
>> +             */
>> +            oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
>> +                       VIA1B_vADB_StateShift;
>> +            state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
>> +
>> +            if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
>> +                    (ms->acr & VIA1ACR_vShiftOut) &&
>> +                    oldsr == 0 /* ADB_BUSRESET */) {
>> +                trace_via1_adb_netbsd_enum_hack();
>> +                adb_via_send(v1s, state, ms->sr);
>> +            }
>> +        }
>> +        break;
>>       }
>>   }
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 0c9762fdf6..db8bb2d28a 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -271,6 +271,7 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, 
>> int value) "secto
>>   via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s 
>> data=0x%02x vADBInt=%s"
>>   via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int 
>> status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d 
>> size=%d"
>>   via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) 
>> "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
>> +via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
>>   via1_auxmode(int mode) "setting auxmode to %d"
>>   via1_timer_hack_state(int state) "setting timer_hack_state to %d"
> 
> Did you ask NetBSD to fix their code?

Not yet. I'm fairly sure this is one of those undocumented behaviour edge cases which 
happens to work since the introduction of an MCU to interface onto the ADB bus. It 
may be that the MCU detects the incorrect write sequence and manages the bus reset on 
behalf of the host for some invalid sequences, but I don't have a way to easily find 
this out unfortunately.

> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

ATB,

Mark.


