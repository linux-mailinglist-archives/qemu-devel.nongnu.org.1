Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4A77E4C1
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIBm-0006Ws-Ez; Wed, 16 Aug 2023 11:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWIBd-0006Vl-KE
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:11:53 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWIBZ-0006G8-Fn
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:11:53 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a3efebcc24so5637529b6e.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692198708; x=1692803508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hEU3dFmLOGxf0aPW9ITZrVwFlm7H6G41V9IogAXUhfg=;
 b=OFqOqlQoRXKD4t5nRwTaPlXEpfwku5Cw0gzzR1M919EGe0Z0LX0c4qiPMV9FejaLc3
 OOoztCVACQmIVbyPftACFo1hYVVxQpHHS0/z3R9721qSXEX44orLZpcygzXvHrxc8iE/
 7E32Kz7eANye2Ah6YPGDBNCu0uDhUJRBv8BL7Eac/VyxNqtDhE8yFd6XUo39XVjepNcr
 W2fC1Xsn12KrdWn0vPiaKvTxBhGy/N9NHWc6XiBV/P4iO9nrk/V6ThmhedOvSQtjwGcL
 pGVxa8Rt+2V250YSJQqVcT2bfWCHy4NiiZTwPpyJIjBk6LTT8jT773pszuqmS6nfXpIh
 6GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692198708; x=1692803508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hEU3dFmLOGxf0aPW9ITZrVwFlm7H6G41V9IogAXUhfg=;
 b=Xe9yOHFhv+9jur9EZYLomj12MY+YD3NPh9td+LPESQV4HkEmKLLmDyevPbK9vhP4JS
 snzKXD752z5ULUE/WXjICktH2H3yUT1uD8sAl01b17csD2YHx65AFrbMOHciSx0aYkCm
 QoevBC8JQpyfnwqfM1jLjysTqGK0UDHNcpQpddDFjiOf2VY7WypO2D6X933utwYlwCqp
 KaZGVh/bEB81F4vSQ75inLHNJk9ACh1FLxVJ7mvkoIf/+xXYXDP9ZOIUc5QF1jIOTeEG
 xeUq7DBwUKrApXK5n4XKkQHW6GG5IkAsdSLs3LaYBYRjoNEQ4Zi1pc6SUd4+l9iAMBGW
 W1yg==
X-Gm-Message-State: AOJu0YztnGunukG0hFtm9LMV9qFQ047etF7q4xvgdu0xlUm46dX1RaVR
 BdE7TzPBFNbwnPN0SDX8WDdY1w==
X-Google-Smtp-Source: AGHT+IHYO1WNOfWm/5h18/YpTTaV11QaqcX4jo99s1nzLeeMnAL7r6TQ0+INirHDbb67ZYs11pMGgA==
X-Received: by 2002:a05:6808:200f:b0:3a4:8590:90f2 with SMTP id
 q15-20020a056808200f00b003a4859090f2mr3342939oiw.47.1692198708388; 
 Wed, 16 Aug 2023 08:11:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a639e0a000000b005633311c70dsm10919319pgd.32.2023.08.16.08.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:11:48 -0700 (PDT)
Message-ID: <5fb9ec6f-f8b5-4cf3-8179-ebb496b06862@daynix.com>
Date: Thu, 17 Aug 2023 00:11:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/24] target/arm: Fill new members of GDBFeature
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-16-akihiko.odaki@daynix.com>
 <87350lr7p8.fsf@linaro.org> <f41aae27-8538-46b5-93fa-67de41602077@daynix.com>
 <87r0o3ni57.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87r0o3ni57.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/08/17 0:03, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/08/14 23:56, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> These members will be used to help plugins to identify registers.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    target/arm/gdbstub.c   | 46 +++++++++++++++++++++++++++---------------
>>>>    target/arm/gdbstub64.c | 42 +++++++++++++++++++++++++-------------
>>>>    2 files changed, 58 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>>>> index 100a6eed15..56d24028f6 100644
>>>> --- a/target/arm/gdbstub.c
>>>> +++ b/target/arm/gdbstub.c
>>>> @@ -270,6 +270,7 @@ static void arm_gen_one_feature_sysreg(GString *s,
>>>>        g_string_append_printf(s, " regnum=\"%d\"", regnum);
>>>>        g_string_append_printf(s, " group=\"cp_regs\"/>");
>>>>        dyn_feature->data.cpregs.keys[dyn_feature->desc.num_regs] = ri_key;
>>>> +    ((const char **)dyn_feature->desc.regs)[dyn_feature->desc.num_regs] = ri->name;
>>>>        dyn_feature->desc.num_regs++;
>>>>    }
>>>>    @@ -316,6 +317,8 @@ static GDBFeature
>>>> *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
>>>>        DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
>>>>        gsize num_regs = g_hash_table_size(cpu->cp_regs);
>>>>    +    dyn_feature->desc.name = "org.qemu.gdb.arm.sys.regs";
>>>> +    dyn_feature->desc.regs = g_new(const char *, num_regs);
>>> AIUI this means we now have an array of register names which mirrors
>>> the
>>> names embedded in the XML. This smells like a few steps away from just
>>> abstracting the whole XML away from the targets and generating them
>>> inside gdbstub when we need them. As per my stalled attempt I referenced
>>> earlier.
>>
>> The abstraction is strictly limited for identifiers. Most plugin
>> should already have some knowledge of how registers are used. For
>> example, a plugin that tracks stack frame for RISC-V should know sp is
>> the stack pointer register. Similarly, a cycle simulator plugin should
>> know how registers are used in a program. Only identifiers matter in
>> such cases.
>>
>> I'm definitely *not* in favor of abstracting the whole XML for
>> plugins. It will be too hard to maintain ABI compatibility when a new
>> attribute emerges, for example.
> 
> No I agree the XML shouldn't go near the plugins. I was just looking to
> avoid having an XML builder for every target.

Oh, I see. It's done in v4 with patch "gdbstub: Introduce 
GDBFeatureBuilder".

> 

