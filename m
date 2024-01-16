Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7282F256
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 17:21:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPmBA-0007xT-Tn; Tue, 16 Jan 2024 11:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPmAo-0007v5-4w
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:20:22 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPmAm-0001Tx-78
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 11:20:21 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3606dd96868so54117775ab.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705422018; x=1706026818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMx2L1+o6Lxao8lN2+Iy4S7RzUqY4Zi08OgW0aT2u7o=;
 b=zQQElSSC44sn70nZo9jswMuMz17YZ2RXiekV7AjMjLVviMlGRXghQ/KtZyltWtxgee
 9rVH3ECi1qFLcP0d3MZFl7uTqzQmALQYmXCUzh2AO4p1Oo9/R+TOjudrpwqCUtjrkJbq
 5WAgTfKtp2bOFnVuLWV9KV26bHd6AJ0iKrLv9sfmO082SlFJgZPj7MFAIiQtxfZ2YIxK
 P8HUY4DgUYwTzgv4ht3JUD0YoGk1DAtDD+gyqEE93THl2nIvRRr2ckAZ43xZihhm5KbV
 lshr9g8k1aNc2gL0HY8UdfizYPJioaa80YEwgfpfexLJA0TdE8gbSUlsXQ+DieCh5fJI
 V/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705422018; x=1706026818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMx2L1+o6Lxao8lN2+Iy4S7RzUqY4Zi08OgW0aT2u7o=;
 b=sYBYHK8zv3Atxr5gNB3hkrMt7dKxVfAuX9rWoD9oaoYajDZMrW3hcHbR+RuJ5ChICB
 aEhlQz7bsJoutTVBLD93mqOkfGg4Yr0VJoCntx7dlyearLmVogENw/8t22XD5A+R/rli
 PiyVFRR+zIvj9ze6lWwgE/6f8JHoulidIRucXelKFeCEqkJoHjEuv5irkbi6EQdx0CQV
 d++s1US+fXpwoLLe6MdiDRb/UZUa0hpuv24uqj+6zeon0owf8T70oSBJmhqw90LAsyeJ
 oUWcCqyfbJc+4bRPWC0NEDkIjjldwqoPpbLr3hiHxd8lNTCKiCuuIxwp8fKaif3e2iIF
 7Ccg==
X-Gm-Message-State: AOJu0YzddViAD76lLM/nsR9/l50SfHbBPUnpJxkW94psBX4aDHbbx39h
 xI59mATw5v+dzqmTVlpIrZ/wrx+u0qfUeS20qzZUoNyC4yo=
X-Google-Smtp-Source: AGHT+IEQ5OV5BIC2q15KsebeioDvRsWyXEhHD2P4ji6M5ruw5D6eMht9npmzQDIi+yPPSXRTNWXcAQ==
X-Received: by 2002:a05:6e02:510:b0:361:923b:d79e with SMTP id
 d16-20020a056e02051000b00361923bd79emr510337ils.85.1705422018354; 
 Tue, 16 Jan 2024 08:20:18 -0800 (PST)
Received: from [192.168.1.102] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a056e02128100b0035fea0268bcsm3607268ilq.28.2024.01.16.08.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 08:20:18 -0800 (PST)
Message-ID: <7a73231a-d7ae-4abe-9bca-e8e295a5f70d@linaro.org>
Date: Tue, 16 Jan 2024 17:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] hw/arm: Prefer arm_feature() over
 object_property_find()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
References: <20240110195329.3995-1-philmd@linaro.org>
 <CAFEAcA9c58iVvgW4wnNT1H3tzsdYbxyU-kT7bJP=A3E+B-t7PA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9c58iVvgW4wnNT1H3tzsdYbxyU-kT7bJP=A3E+B-t7PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12c.google.com
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

On 13/1/24 14:36, Peter Maydell wrote:
> On Wed, 10 Jan 2024 at 19:53, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Since v2 [2]:
>> - Dropped "Simplify checking A64_MTE bit in FEATURE_ID register"
>> - Correct object_property_get_bool() uses
>> - Update ARM_FEATURE_AARCH64 && aa64_mte
>>
>> Since RFC [1]:
>> - Split one patch per feature
>> - Addressed Peter's review comments
>>
>> [1] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd@linaro.org/
>> [2] https://lore.kernel.org/qemu-devel/20240109180930.90793-1-philmd@linaro.org/
>>
>> Based-on: <20231123143813.42632-1-philmd@linaro.org>
>>    "hw: Simplify accesses to CPUState::'start-powered-off' property"
>>
>> Philippe Mathieu-Daudé (14):
>>    hw/arm/armv7m: Introduce cpudev variable in armv7m_realize()
>>    hw/arm/armv7m: Ensure requested CPU type implements ARM_FEATURE_M
>>    hw/arm/armv7m: Move code setting 'start-powered-off' property around
>>    hw/arm/armv7m: Always set 'init-nsvtor' property for Cortex-M CPUs


> The first part of this is fine and reasonable cleanup, but I
> continue to disagree about the later parts. What we want to do is
> "if this property is present, then set it", and that's what we do.
> Conversion to "if <some condition we know that the CPU is using to
> decide whether to define the property> then set it" is duplicating
> the condition logic in two places and opening the door for bugs
> where we change the condition in one place and not in the other.
> Where the <some condition> is a simple "feature X is set" it doesn't
> look too bad, but where it gets more complex it makes it IMHO more
> obvious that this is a bad idea, for example with:
> 
> -        if (object_property_find(cpuobj, "reset-cbar")) {
> +        if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
> +            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {

For that we could add helpers such

   static inline bool arm_feature_cbar(CPUState *cpu) {
     return arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
            arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
   }

and use it in the target/ code where we register the property
and in the hw/ code where we set it.


Anyway I'll wait to see how Kevin's effort is going before
insisting with this series.
Do you mind taking the cleanup patches (1-4) meanwhile?

Thanks,

Phil.

