Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35780090E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:51:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r916N-0007NE-NX; Fri, 01 Dec 2023 05:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r916A-0007N4-LF
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:50:18 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r9167-0000s9-DS
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:50:17 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54b8a4d64b5so2234425a12.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701427812; x=1702032612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M+/x1399FgyQ1bsemMbw/0oIdLWeaxMZ0tW1YE95xP8=;
 b=VuKYiE6UrNgf+TEvVGbDBpN+NnngPx95PU7uGp/LsLHVEJPhLN6Y2PS30BnVCBYUi8
 wPlfWk7vCDCrZeT0qtuqbxe8EP1x7SB2XNPFCepasrS6bGqnbnJNeBWqOAxkEaNb13od
 zloh0twrx9iL0AWs3GUTrc9EbMgeSdO/SPV3Ghdhh3roQo4hCU79SEMsIpQFxu1mj6hu
 JS9IT9eOQxKlypmQDfRrXpophZGxLbbjbBJihEMSkJdaGcLys9dd07fIzqS9KC+CLQZE
 AcKZYqQ0vAIKRjntDO/dgxa9hxPNcGV4ppWuYBXBMOLWdJ/i0vrY6HdGvhEgz4o7aE0/
 SJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701427812; x=1702032612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M+/x1399FgyQ1bsemMbw/0oIdLWeaxMZ0tW1YE95xP8=;
 b=Z8+ExNbAQtuPzCLhhqtZnjcwagzrb3zQxng3VQ7cYLh/840/T8sHrwGgp3xSJTt75f
 SdwWixa4RK/A5US7XlxQCYZgTAVOhdSSCHdPhTCI8Wci66lU18CrFKM0Eplq2pYxu2N7
 pyLD7XI9RrE+sP0m/beYLV2JWT2cjXIk1xjdNLSZcu1MDgdFFxEGSnJ7rvMr+HDt6ewu
 /M4FRP37sBvysnbrfrlsSVyg1OAtNP9sIWECOidzcp8IOBBcqW8zfvhQoXALMIkJkhts
 d//6XOboKMWLGH+0AfZbzgVejXZsavw19cyCGiRpSDr7emqrSk0AtNKBOmDZAqwihm/e
 k0Bw==
X-Gm-Message-State: AOJu0YzqLvc9aOV0RBMmG2ACI8FWQW69RT0XtyvDtHJp7nCUV4unJvkd
 8Lv4kse5mzQ7hRCYeKGbv7tUtQ==
X-Google-Smtp-Source: AGHT+IEoNd3XbxTrFPmmQSIyj5WpMZ8l6EsZqP+gIaS/ORU3r0B2FGmV0AtiXDeDwORH7d96vCujOw==
X-Received: by 2002:a50:8e12:0:b0:54b:e6:5be3 with SMTP id
 18-20020a508e12000000b0054b00e65be3mr713226edw.11.1701427811869; 
 Fri, 01 Dec 2023 02:50:11 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 dn16-20020a05640222f000b0054c54b3ea3fsm486617edb.21.2023.12.01.02.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:50:11 -0800 (PST)
Message-ID: <6d6d75e9-c7d3-4b62-ac8e-9aa3b09005c2@linaro.org>
Date: Fri, 1 Dec 2023 11:50:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Fix shadow variable when
 idef-parser is off
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, Taylor Simpson
 <ltaylorsimpson@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng" <anjo@rev.ng>
References: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
 <36fe2c1d-4db6-498e-a7ce-da74410b4a03@linaro.org>
 <SN6PR02MB42057D4FC09929723903517AB882A@SN6PR02MB4205.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SN6PR02MB42057D4FC09929723903517AB882A@SN6PR02MB4205.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 30/11/23 21:39, Brian Cain wrote:
> 
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Thursday, November 30, 2023 2:17 PM
>> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-devel@nongnu.org
>> Cc: Brian Cain <bcain@quicinc.com>; Matheus Bernardino (QUIC)
>> <quic_mathbern@quicinc.com>; Sid Manning <sidneym@quicinc.com>; Marco
>> Liebel (QUIC) <quic_mliebel@quicinc.com>; richard.henderson@linaro.org;
>> ale@rev.ng; anjo@rev.ng
>> Subject: Re: [PATCH] Hexagon (target/hexagon) Fix shadow variable when idef-
>> parser is off
>>
>> WARNING: This email originated from outside of Qualcomm. Please be wary of
>> any links or attachments, and do not enable macros.
>>
>> On 30/11/23 19:39, Taylor Simpson wrote:
>>> Adding -Werror=shadow=compatible-local causes Hexagon not to build
>>> when idef-parser is off.  The "label" variable in CHECK_NOSHUF_PRED
>>> shadows a variable in the surrounding code.
>>>
>>> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>> ---
>>>    target/hexagon/macros.h | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
>>> index 9a51b5709b..f99390e2a8 100644
>>> --- a/target/hexagon/macros.h
>>> +++ b/target/hexagon/macros.h
>>> @@ -93,13 +93,13 @@
>>>
>>>    #define CHECK_NOSHUF_PRED(GET_EA, SIZE, PRED) \
>>>        do { \
>>> -        TCGLabel *label = gen_new_label(); \
>>> -        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, label); \
>>> +        TCGLabel *noshuf_label = gen_new_label(); \
>>> +        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \
>>
>> Fragile, but sufficient.
> 
> The fragility here refers to the fact that CHECK_NOSHUF_PRED() macro could show up in other contexts and then could shadow those?

Yes.

> We could change the macro to a function or expand the macro to take a label declared outside.  Would that be preferred?  Or are there other suggestions?

Nah, this is good enough, no need to over-engineer IMHO
(I just wanted to remark this could still bit us in the
future, and -Werror will fire).

Regards,

Phil.


