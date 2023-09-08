Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B717984F8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeY15-00087y-G9; Fri, 08 Sep 2023 05:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeY13-00087a-GG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:43:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeY0w-0002RQ-T8
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 05:43:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so2517684a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694166176; x=1694770976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kjtbdeFHy9NqP3lr9y/kVawUVwgRKm1AXBg/GDQaIjw=;
 b=TTO54Z21yiNjwLrWAlEU27ivucIDvmOXFyc/6yhpQ1m8vhL+47UTHClKjd4Z1VOGaT
 RemvPcSS8zNvrqG7xDyQnYwIIiguE3FUa3RkyI+1ya5Qlfep8LoPwBiJZ8MQuq8Nkj9Q
 PkJqa429DDGXcBzJpKFaGj3PLch5usptHJB0wfZPGfemB2FF+LEPIpBoAgKpJiPmH4+V
 IIsX5OnsfHcHunG5pTDTF5N1+nUmlROF/NnbOp5HqmqZOUTDM+LmVIrl3sOfP2rweBEa
 +MmNvJknlrtbO68i8cIx6LbW5LqpAhGLsthmuWwqLN0YLTLIuJXxu95bVeyFe3/bt9kI
 PGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694166176; x=1694770976;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjtbdeFHy9NqP3lr9y/kVawUVwgRKm1AXBg/GDQaIjw=;
 b=ElXDN2beWfs2yv0HZWG4DMI1sRiS0gaJIsOx1A9est6jlzkiKweg+VWX+392Y86H8T
 0uPPZYiJwMOHRuR1Zwhm9Nfs3mTCbCo6KJuPVbhGmP9Qj7+KWJiO+hAhuF5c1J0uazAq
 5oLH4WvKL3CUam03oSSrQtPoRHeJb1OrHjiEauZ+QMkqRUuO+SEvY7eYrAXS7kl4+25S
 MuUGuUHDh0UgLD7Yx1fxTP4LXhMifJNEF33HrLkPxCVi0IuWiY+0yQPFBqEkUBScuus4
 Ci+d5dqDk+5qPFGRaz4wQgw5cUh0RkPsoHiw6EsutPuuWq5pdo3D+CHHPL2Lli6ZTL3n
 sVrQ==
X-Gm-Message-State: AOJu0Yxkezz94irIkHKpp6b9Vc5PiyVgYF4KPv7KssB3puaGsig5hVQA
 Ezxka8HFeIuCcNkP9cYtGOVXRA==
X-Google-Smtp-Source: AGHT+IECLdPkxz9EKYaw4MyoWbpjMoK2w2c+RvquIOehOXIPFN8YSZUmyLwm/Qyr1UGR5oL3Xe/nvQ==
X-Received: by 2002:aa7:cb52:0:b0:52a:46a7:4597 with SMTP id
 w18-20020aa7cb52000000b0052a46a74597mr1435852edt.33.1694166176192; 
 Fri, 08 Sep 2023 02:42:56 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a50ec82000000b0052a48f4065esm800922edr.39.2023.09.08.02.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 02:42:55 -0700 (PDT)
Message-ID: <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
Date: Fri, 8 Sep 2023 11:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
 <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/9/23 08:54, Mark Cave-Ayland wrote:
> On 07/07/2023 09:29, Philippe Mathieu-Daudé wrote:
> 
>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>> This determines whether the Apple Sound Chip (ASC) is set to enhanced 
>>> mode
>>> (default) or to original mode. The real Q800 hardware used an EASC 
>>> chip however
>>> a lot of older software only works with the older ASC chip.
>>>
>>> Adding this as a machine parameter allows QEMU to be used as an 
>>> developer aid
>>> for testing and migrating code from ASC to EASC.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>>>   include/hw/m68k/q800.h |  1 +
>>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>>
>>> +static bool q800_get_easc(Object *obj, Error **errp)
>>> +{
>>> +    Q800MachineState *ms = Q800_MACHINE(obj);
>>> +
>>> +    return ms->easc;
>>> +}
>>
>> Is the getter useful? Otherwise:
> 
> Isn't it a requirement? Otherwise I can see that if we decide to 
> enumerate machine properties (similar as to how device properties appear 
> in "info qtree") then it would be impossible to display its value. 
> Certainly at the moment we consider that adding an object property to an 
> underlying struct effectively makes it "public".

Just FYI this is not a requirement, per "qom/object.h":

   /**
    * object_property_add_bool:
    * @obj: the object to add a property to
    * @name: the name of the property
    * @get: the getter or NULL if the property is write-only.
    * @set: the setter or NULL if the property is read-only

I'm not sure when we want a write-only QOM boolean property, so I
genuinely ask, since I agree introspecting QOM object fields from
the monitor is helpful.

Regards,

Phil.

