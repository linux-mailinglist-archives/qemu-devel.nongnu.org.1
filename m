Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070E7A4BEE
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:23:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiG5M-0004PK-Lb; Mon, 18 Sep 2023 11:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiG5I-0004O8-9R
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:22:48 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiG5E-00032h-Dz
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:22:48 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c0179f9043so11926531fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695050559; x=1695655359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yfS8iyi4+OI+d6tZLyPgliq5D4W1CU9ToYYkjTc2too=;
 b=cYHgzaYwfzpBfoBPrtyslt0V54rhbzEjr/vmJ3A++xpEr47H1VFBPQnh3lsLZcfu8f
 NxlY6+Vjqa2AfEWvKBaDcvfH9EkaB7GCjbYDyfsKJHWSLe11wDc56CYS673EtMVajmZ2
 EYbuIGV5faJI5RFKOq/131Q75iqjgnqrIye20ZpJZJqKr/Md/qkqIZTJKG08gDHQsUdc
 2NdEtDNtRExU1/ATbVp3KTtvQUy416NR6gnR1I3s2TJVuHt1/dVuNo28sNsrAWR7XeVN
 aiVYCwXSUq6oQQ/I2NR+aN/CLYxul8ONIhT0okuQUfIFUjP1c0m02cBPg3pYGfAwroi2
 L9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695050559; x=1695655359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yfS8iyi4+OI+d6tZLyPgliq5D4W1CU9ToYYkjTc2too=;
 b=sr49w4odk7JCMceVc3L1lTSrtLgzcSHxXc5hrfe3qEglY6qen4jJ0X35/3ZYKmaeuY
 RFzXy3LXcXueRFAoW9R76hX/yc1KwY1huavovavNJ8OJrwj1il7I1Aa+QEtM0n3ChhU7
 EApDN2b6yn9KPGpE5zLlbMx60ob2um3zBJRBik3UvICOXcJIAyi3vOmNNTeNZSw5stZn
 i57Cqqj927l7nVuFG3U2I2gpjKrdkSSqo/UNG0PzAL9JEGJpmloKltH91Wtyzgm16nE5
 Nt4ObGZhMqBhwyHGrJOZhUj65LXDeseo+EC3fF7GHwzHDR+vK1FWfjD/Wb+xKYf8aPbd
 SE+Q==
X-Gm-Message-State: AOJu0YxV1CRxd5D1UrWHaUKryIk9+14Mqa7p4pVmqUBpHo10tCPsyvfE
 TM97VwonXqXuH4J7FJuEVkdGwA==
X-Google-Smtp-Source: AGHT+IGOZPMUAIKfAAn9hS6FOq8oE3lT4xRAwtOM8O1W9kN6Gi7Mx+7ihUL6TOgWoBbEg4XHbJuRiA==
X-Received: by 2002:a2e:a98d:0:b0:2bf:ee56:f72e with SMTP id
 x13-20020a2ea98d000000b002bfee56f72emr6971318ljq.26.1695050559245; 
 Mon, 18 Sep 2023 08:22:39 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 mh25-20020a170906eb9900b0099297782aa9sm6567335ejb.49.2023.09.18.08.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 08:22:38 -0700 (PDT)
Message-ID: <d1326804-2bca-3b06-250a-3ca3a8038d1c@linaro.org>
Date: Mon, 18 Sep 2023 17:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] hw/sd/omap_mmc: Do not reset SDCard until being fully
 realized
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, Alessandro Di Federico <ale@rev.ng>,
 qemu-arm@nongnu.org, Luc Michel <luc@lmichel.fr>
References: <20230918101736.23905-1-philmd@linaro.org>
 <20230918101736.23905-2-philmd@linaro.org>
 <CAFEAcA89z1vCwDzzB_GjbUBtcOCz4vU7r_zC4nMmunp5BGVWxA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA89z1vCwDzzB_GjbUBtcOCz4vU7r_zC4nMmunp5BGVWxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/9/23 13:00, Peter Maydell wrote:
> On Mon, 18 Sept 2023 at 11:17, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We shouldn't call QDev DeviceReset() before DeviceRealize().
>>
>> Since the OMAP MMC model is not QDev'ified, it has to manually
>> call the SDCard reset() handler. This breaks QDev assumptions
>> that DeviceReset() is never called before a device is fully
>> realized. In order to avoid that, pass a 'realized' argument
>> to omap_mmc_reset(). All cases are explicit manual resets,
>> except in omap_mmc_write() where we expect the sdcard to be
>> realized.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/omap.h |  2 +-
>>   hw/arm/omap1.c        |  2 +-
>>   hw/arm/omap2.c        |  2 +-
>>   hw/sd/omap_mmc.c      | 21 ++++++++++++---------
>>   4 files changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
>> index 067e9419f7..d331467946 100644
>> --- a/include/hw/arm/omap.h
>> +++ b/include/hw/arm/omap.h
>> @@ -808,7 +808,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
>>   struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
>>                   BlockBackend *blk, qemu_irq irq, qemu_irq dma[],
>>                   omap_clk fclk, omap_clk iclk);
>> -void omap_mmc_reset(struct omap_mmc_s *s);
>> +void omap_mmc_reset(struct omap_mmc_s *s, bool realized);
>>   void omap_mmc_handlers(struct omap_mmc_s *s, qemu_irq ro, qemu_irq cover);
>>   void omap_mmc_enable(struct omap_mmc_s *s, int enable);
>>
>> diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
>> index d5438156ee..3afeba6f86 100644
>> --- a/hw/arm/omap1.c
>> +++ b/hw/arm/omap1.c
>> @@ -3728,7 +3728,7 @@ static void omap1_mpu_reset(void *opaque)
>>       omap_uart_reset(mpu->uart[0]);
>>       omap_uart_reset(mpu->uart[1]);
>>       omap_uart_reset(mpu->uart[2]);
>> -    omap_mmc_reset(mpu->mmc);
>> +    omap_mmc_reset(mpu->mmc, false);
>>       omap_mpuio_reset(mpu->mpuio);
>>       omap_uwire_reset(mpu->microwire);
>>       omap_pwl_reset(mpu->pwl);
>> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
>> index d5a2ae7af6..ef9b0dd60a 100644
>> --- a/hw/arm/omap2.c
>> +++ b/hw/arm/omap2.c
>> @@ -2253,7 +2253,7 @@ static void omap2_mpu_reset(void *opaque)
>>       omap_uart_reset(mpu->uart[0]);
>>       omap_uart_reset(mpu->uart[1]);
>>       omap_uart_reset(mpu->uart[2]);
>> -    omap_mmc_reset(mpu->mmc);
>> +    omap_mmc_reset(mpu->mmc, false);
>>       omap_mcspi_reset(mpu->mcspi[0]);
>>       omap_mcspi_reset(mpu->mcspi[1]);
>>       cpu_reset(CPU(mpu->cpu));
> 
> These are reset functions registered via qemu_register_reset().
> They should be OK to assume the SD card is realized.
> This matters, because this is the only place that the SD
> card will get reset -- as the comment in omap_mmc_reset() notes,
> the SD card object isn't going to be plugged into any bus, so
> it won't get auto-reset when the simulation starts, and these
> reset function are the place that does the manual reset.
> 
>> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
>> index edd3cf2a1e..3c906993eb 100644
>> --- a/hw/sd/omap_mmc.c
>> +++ b/hw/sd/omap_mmc.c
>> @@ -287,7 +287,7 @@ static void omap_mmc_pseudo_reset(struct omap_mmc_s *host)
>>       host->fifo_len = 0;
>>   }
>>
>> -void omap_mmc_reset(struct omap_mmc_s *host)
>> +void omap_mmc_reset(struct omap_mmc_s *host, bool realized)
>>   {
>>       host->last_cmd = 0;
>>       memset(host->rsp, 0, sizeof(host->rsp));
>> @@ -314,11 +314,14 @@ void omap_mmc_reset(struct omap_mmc_s *host)
>>
>>       omap_mmc_pseudo_reset(host);
>>
>> -    /* Since we're still using the legacy SD API the card is not plugged
>> -     * into any bus, and we must reset it manually. When omap_mmc is
>> -     * QOMified this must move into the QOM reset function.
>> -     */
>> -    device_cold_reset(DEVICE(host->card));
>> +    if (realized) {
>> +        /*
>> +         * Since we're still using the legacy SD API the card is not plugged
>> +         * into any bus, and we must reset it manually. When omap_mmc is
>> +         * QOMified this must move into the QOM reset function.
>> +         */
>> +        device_cold_reset(DEVICE(host->card));
>> +    }
>>   }
>>
>>   static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
>> @@ -556,7 +559,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
>>           break;
>>       case 0x64: /* MMC_SYSC */
>>           if (value & (1 << 2))                                  /* SRTS */
>> -            omap_mmc_reset(s);
>> +            omap_mmc_reset(s, true);
>>           break;
>>       case 0x68: /* MMC_SYSS */
>>           OMAP_RO_REG(offset);
>> @@ -613,7 +616,7 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
>>           exit(1);
>>       }
>>
>> -    omap_mmc_reset(s);
>> +    omap_mmc_reset(s, false);
>>
>>       return s;
>>   }
>> @@ -643,7 +646,7 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
>>       s->cdet = qemu_allocate_irq(omap_mmc_cover_cb, s, 0);
>>       sd_set_cb(s->card, NULL, s->cdet);
>>
>> -    omap_mmc_reset(s);
>> +    omap_mmc_reset(s, false);
> 
> These calls from omap_mmc_init() are probably safe to remove, but I
> don't understand why they result in our resetting a non-realized
> SD card object. In both cases, the call happens after we call
> sd_init(). sd_init() both creates and realizes the SD card, so
> it should be realized at the point when it gets reset.

Indeed, sd_realize() is called:

(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
   * frame #0: 0x1001f047c qemu-system-arm`sd_realize [inlined] 
SD_CARD(obj=0x103b339e0) at sd.h:94:1
     frame #1: 0x1001f047c qemu-system-arm`sd_realize(dev=0x103b339e0, 
errp=0x16fdfeaa0) at sd.c:2193:19
     frame #2: 0x1001f03e8 qemu-system-arm`sd_init(blk=<unavailable>, 
is_spi=<unavailable>) at sd.c:765:5
     frame #3: 0x1001fa1c8 
qemu-system-arm`omap2_mmc_init(ta=0x104838060, blk=<unavailable>, 
irq=0x0000600001720080, dma=0x103b28c88, fclk=0x1048333f0, 
iclk=<unavailable>) at omap_mmc.c:638:15
     frame #4: 0x10033cf40 
qemu-system-arm`omap2420_mpu_init(sdram=<unavailable>, 
cpu_type=<unavailable>) at omap2.c:2487:14
     frame #5: 0x10031fe6c 
qemu-system-arm`n8x0_init(machine=0x103b1fc00, binfo=0x100dbf5a8, 
model=800) at nseries.c:1317:14
     frame #6: 0x100093d48 
qemu-system-arm`machine_run_board_init(machine=0x103b1fc00, 
mem_path=<unavailable>, errp=<unavailable>) at machine.c:1469:5
     frame #7: 0x100299fe8 qemu-system-arm`qmp_x_exit_preconfig 
[inlined] qemu_init_board at vl.c:2580:5
     frame #8: 0x100299fb4 
qemu-system-arm`qmp_x_exit_preconfig(errp=<unavailable>) at vl.c:2671:5
     frame #9: 0x10029d77c qemu-system-arm`qemu_init(argc=<unavailable>, 
argv=<unavailable>) at vl.c:3721:9
     frame #10: 0x1004df880 qemu-system-arm`main(argc=<unavailable>, 
argv=<unavailable>) at main.c:47:5
     frame #11: 0x1884b7f28 dyld`start + 2236

But then I'm getting:

     frame #3: 0x18871ce44 libsystem_c.dylib`__assert_rtn + 272
   * frame #4: 0x1006dbbe4 qemu-system-arm`device_cold_reset.cold.1 at 
qdev.c:256:5
     frame #5: 0x1004e1c44 
qemu-system-arm`device_cold_reset(dev=0x10347dde0) at qdev.c:256:5
     frame #6: 0x1001fa290 qemu-system-arm`omap2_mmc_init [inlined] 
omap_mmc_reset(host=0x10347d960) at omap_mmc.c:321:5
     frame #7: 0x1001fa1fc 
qemu-system-arm`omap2_mmc_init(ta=0x104025860, blk=<unavailable>, 
irq=0x000060000171d580, dma=0x103472f38, fclk=0x1040119f0, 
iclk=<unavailable>) at omap_mmc.c:646:5
     frame #8: 0x10033cf40 
qemu-system-arm`omap2420_mpu_init(sdram=<unavailable>, 
cpu_type=<unavailable>) at omap2.c:2487:14
     frame #9: 0x10031fe6c 
qemu-system-arm`n8x0_init(machine=0x1033dec60, binfo=0x100dbf5a8, 
model=800) at nseries.c:1317:14
     frame #10: 0x100093d48 
qemu-system-arm`machine_run_board_init(machine=0x1033dec60, 
mem_path=<unavailable>, errp=<unavailable>) at machine.c:1469:5
     frame #11: 0x100299fe8 qemu-system-arm`qmp_x_exit_preconfig 
[inlined] qemu_init_board at vl.c:2580:5
     frame #12: 0x100299fb4 
qemu-system-arm`qmp_x_exit_preconfig(errp=<unavailable>) at vl.c:2671:5
     frame #13: 0x10029d77c 
qemu-system-arm`qemu_init(argc=<unavailable>, argv=<unavailable>) at 
vl.c:3721:9
     frame #14: 0x1004df880 qemu-system-arm`main(argc=<unavailable>, 
argv=<unavailable>) at main.c:47:5

Because this isn't a full qdev_realize() call.

Then when using:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4823befdef..db7d644fb7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -763,7 +763,7 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
      object_ref(obj);
      object_unparent(obj);
      sd_realize(dev, &err);
-    if (err) {
+    if (err || !object_property_set_bool(OBJECT(dev), "realized", true, 
&err)) {
          error_reportf_err(err, "sd_init failed: ");
          return NULL;
      }
---

I get:

     frame #3: 0x18871ce44 libsystem_c.dylib`__assert_rtn + 272
   * frame #4: 0x1006dbcac 
qemu-system-arm`qdev_assert_realized_properly_cb.cold.2 at qdev.c:320:9
     frame #5: 0x1004e1e04 
qemu-system-arm`qdev_assert_realized_properly_cb(obj=0x10337e2e0, 
opaque=0x000000000) at qdev.c:320:9
     frame #6: 0x1004e7a8c 
qemu-system-arm`do_object_child_foreach(obj=0x0000600000c0df50, 
fn=(qemu-system-arm`qdev_assert_realized_properly_cb at qdev.c:313), 
opaque=0x000000000, recurse=true) at object.c:1120:19
     frame #7: 0x1004e7aa8 
qemu-system-arm`do_object_child_foreach(obj=0x1039de470, 
fn=(qemu-system-arm`qdev_assert_realized_properly_cb at qdev.c:313), 
opaque=0x000000000, recurse=true) at object.c:1125:23
     frame #8: 0x1004e7aa8 
qemu-system-arm`do_object_child_foreach(obj=<unavailable>, 
fn=(qemu-system-arm`qdev_assert_realized_properly_cb at qdev.c:313), 
opaque=0x000000000, recurse=true) at object.c:1125:23
     frame #9: 0x1004e7ae8 
qemu-system-arm`object_child_foreach_recursive(obj=<unavailable>, 
fn=<unavailable>, opaque=<unavailable>) at object.c:1145:12 [artificial]
     frame #10: 0x1004e1d70 
qemu-system-arm`qdev_assert_realized_properly at qdev.c:327:5 [artificial]
     frame #11: 0x100093fd4 qemu-system-arm`qdev_machine_creation_done 
at machine.c:1503:5
     frame #12: 0x10029a12c qemu-system-arm`qmp_x_exit_preconfig 
[inlined] qemu_machine_creation_done at vl.c:2644:5
     frame #13: 0x10029a0c8 
qemu-system-arm`qmp_x_exit_preconfig(errp=<unavailable>) at vl.c:2673:5
     frame #14: 0x10029d77c 
qemu-system-arm`qemu_init(argc=<unavailable>, argv=<unavailable>) at 
vl.c:3721:9
     frame #15: 0x1004df880 qemu-system-arm`main(argc=<unavailable>, 
argv=<unavailable>) at main.c:47:5

> In a truly ideal world we would QOMify the omap-mmc device: it
> is the only remaining user of the legacy sd_init function...

Yeah, and I remember I told you I already did it 3 years ago :)
IIRC it was hard to just convert one device, and I wasn't sure
it was worth it. Anyhow, I'll check my backups in a pair of weeks.

Thanks for the review,

Phil.

