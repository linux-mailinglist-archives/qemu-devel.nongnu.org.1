Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5137F74D9
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:22:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6W7l-0005QB-RF; Fri, 24 Nov 2023 08:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6W7k-0005Pt-8c
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:21:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6W7h-0007yD-HG
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 08:21:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so14068515e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700832091; x=1701436891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GOkyeM2jH1GdpIo1SYMnTDDwqne+Zqb05ASn+zO5s4Y=;
 b=FO4x1yhVHfX1tRQZ/wfUjccma1nWFPu2099qyU2KykZZ/0/eJJ+QvPYK5x7e0KexCx
 b4RJndAdk/cPs91qBZkyKyNtbyIlRgPHtfip7QOCZ1eaiGgWq1IrlIRFzzUAcVM7OjrU
 1949LEjw0dis7oeWG6lWPPLRWTePwBB2bW3i7y2eFySGGSM/a/D0ChCwTyIAQDBR1Xe2
 KYUnkdkOvXv25ZOEN7guc8gIZYbeQbNenG4XYKz7+1Bq+xF6P8IEPEAP2LHLsE5uF6Tz
 Kl7SI5UH8rVke2fjsXA8OyR7in4I2Kfkr7xihaZCHD0MnJKNTbfmQPzxvBoekmB9zfa6
 GaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700832091; x=1701436891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOkyeM2jH1GdpIo1SYMnTDDwqne+Zqb05ASn+zO5s4Y=;
 b=XJKY2XpJHJMT5eJ38+KbhBbLoVtgRKkzOrnO3UQVDxWeCn3eQIF/ClyCD+tjESU3hf
 tOdMFWiLIQIA/XeyHIkUDMziw5JwUuCbfAxmFz4teV16rn4FSs8uDj+xtQ4sDvduqBwu
 F94vtjJJAh3Wlv+rd7TrZZoxBVboHAU74xNN5ZGLZTtJW0yz3lCDDzrgrijwny6X8bCR
 EiMSGd79t29g0uBpet8XhGZ5lOPjzVj4oxvWoeJm/y2lvkZpSRE9lkpZnCtw0ZilOgpc
 OozlE6468/Ql9xOECc0imHKMBGuOmpkvF1f5z1gSKP3wYC4aeUrJ5LK7LXkMenRbVhpw
 3H1w==
X-Gm-Message-State: AOJu0YzFHoAfxhC2D01xZli0GTSmZX4in/uGmLXOrCWU6PVHa+iCnQ1E
 ptcONKRYSC1cCmj4nwlwYSAdJQ==
X-Google-Smtp-Source: AGHT+IEKVmCD9UIzYkVwZnHQLofdDRJpNIPYGojMtxs0XxQNfpgNxB+L1mC8IlHFta8nI4oamQ3Kjw==
X-Received: by 2002:a05:600c:310c:b0:3fe:1232:93fa with SMTP id
 g12-20020a05600c310c00b003fe123293famr2131296wmo.22.1700832091387; 
 Fri, 24 Nov 2023 05:21:31 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c231800b0040b36050f1bsm4978142wmo.44.2023.11.24.05.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 05:21:30 -0800 (PST)
Message-ID: <ab62f61e-bf41-42d6-a2fd-d693918aef84@linaro.org>
Date: Fri, 24 Nov 2023 14:21:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2? v2 2/4] hw/arm/stm32f405: Report error when
 incorrect CPU is used
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <laurent@vivier.eu>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Felipe Balbi <balbi@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Subbaraya Sundeep <sbhatta@marvell.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Gavin Shan <gshan@redhat.com>
References: <20231117071704.35040-1-philmd@linaro.org>
 <20231117071704.35040-3-philmd@linaro.org>
 <20231124141301.5e03527b@imammedo.users.ipa.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124141301.5e03527b@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Igor,

On 24/11/23 14:13, Igor Mammedov wrote:
> On Fri, 17 Nov 2023 08:17:02 +0100
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> Both 'netduinoplus2' and 'olimex-stm32-h405' machines ignore the
>> CPU type requested by the command line. This might confuse users,
>> since the following will create a machine with a Cortex-M4 CPU:
>>
>>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>>
>> Set the MachineClass::valid_cpu_types field (introduced in commit
>> c9cf636d48 "machine: Add a valid_cpu_types property").
>> Remove the now unused MachineClass::default_cpu_type field.
> 
> Why default_cpu_type is removed?

"Since the SoC family can only use Cortex-M4 CPUs, hard-code the
  CPU type name at the SoC level"

> what if user didn't user -cpu at all?

The CPU is hardcoded, default value is not used.

qemu-system-arm -M olimex-stm32-h405 -S -monitor stdio
QEMU 8.1.91 monitor - type 'help' for more information
(qemu) info qtree
...
   dev: armv7m, id ""
     gpio-in "NMI" 1
     gpio-out "SYSRESETREQ" 1
     gpio-in "" 96
     clock-in "cpuclk" freq_hz=168 MHz
     clock-in "refclk" freq_hz=21 MHz
     cpu-type = "cortex-m4-arm-cpu"
     ...

> 
>>
>> We now get:
>>
>>    $ qemu-system-aarch64 -M netduinoplus2 -cpu cortex-r5f
>>    qemu-system-aarch64: Invalid CPU type: cortex-r5f-arm-cpu
>>    The valid types are: cortex-m4-arm-cpu
>>
>> Since the SoC family can only use Cortex-M4 CPUs, hard-code the
>> CPU type name at the SoC level, removing the QOM property
>> entirely.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/arm/stm32f405_soc.h | 4 ----
>>   hw/arm/netduinoplus2.c         | 7 ++++++-
>>   hw/arm/olimex-stm32-h405.c     | 8 ++++++--
>>   hw/arm/stm32f405_soc.c         | 8 +-------
>>   4 files changed, 13 insertions(+), 14 deletions(-)


