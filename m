Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3153C7F6307
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:31:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Bea-0004co-M6; Thu, 23 Nov 2023 10:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6BeX-0004cP-KM
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:30:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6BeS-0007nC-Cc
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:30:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso6388785e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700753395; x=1701358195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJlx0/l+/l0lXF5wXTVwJAd/EOKbj6xqiqErT7fTX4A=;
 b=QwG9EV+waa0RxBgAh5TXGsuNCktGZXwUX17RHwtYU7S4aVofF2BmQhrn9yNZcMVznP
 TG7b8dopPaW1/+BIbneQ3Sh9knA71fkAeLwDgWNWCvBNCx2GI6KbJbwlE7hx2UN8oGsJ
 zBopskJc+aLSkeo4NQZ3pVtjpBsk5fr4uSMnDtt/jvYAHJgkPbwOqV7OL/yOncEwwwJK
 vXEzXYc89vXjw66hWZi7CAcM+5/Fdxm2KQz2E1OPNe45aR1FiVSkPWuYyq/xb1pSY959
 PvNyoKdV49objuv9tCBAV4X68Lwt7JzpbON7EAqz8sNi4PqVnZTKIR/HjZoMvzM6ZkfG
 DP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700753395; x=1701358195;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJlx0/l+/l0lXF5wXTVwJAd/EOKbj6xqiqErT7fTX4A=;
 b=tdw2L3eqYXXAoFAUdk759zXeWo4gNlLRKq7Roeeoylhdw6HuObuqJQUIFRPm3oXEdN
 FABqkDt2QfHjUiAasZVAiUFigwDVIvne+506GFcxoCUFr1+QU1bbG4wVUDVnDOV+O9D4
 wCCfyEDzXCE4gmpt4sF/r+YgjgqDsq3G0ck0iLLMGe9OVhsbCS0lQrCxG1WOC5IdoAB3
 hJBDu/b+Hq2jYBVOVBJBKfhuNjBOkTgSL/4DF3m0l97B1I4lgDzq1YJwNKp824gQTYOO
 mNRn+wroPDGePczh30oEoFZGJE8So/f3Vxza2Xn4cfu+DbTlF5Zz6q4RT1S46Z7G6HuU
 /b4Q==
X-Gm-Message-State: AOJu0YyvJDXJuacc/XHjRsjcrolpclskfARFMmqUSXtf5oK/c2HwNqir
 GN/XOiu1RN6HJxRQmY4X9W3ntGsSMPfZctn0Fw0=
X-Google-Smtp-Source: AGHT+IF0/ISqhSTRdHLk1Dpzuileb5yVWPTnwo78QCpFmnXrUHLXnc2SoWOyoObJDQIhNcfe8HO1Yw==
X-Received: by 2002:a5d:588c:0:b0:332:ca7e:29cd with SMTP id
 n12-20020a5d588c000000b00332ca7e29cdmr4935236wrf.55.1700753395369; 
 Thu, 23 Nov 2023 07:29:55 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfee03000000b00332d3b89561sm1960728wrn.97.2023.11.23.07.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 07:29:54 -0800 (PST)
Message-ID: <791c81ad-e98d-4eee-9ca7-f3157977913c@linaro.org>
Date: Thu, 23 Nov 2023 16:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4l0it.9kkxe9s135lg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

On 23/11/23 15:56, Manos Pitsidianakis wrote:
> On Thu, 23 Nov 2023 16:35, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrangé wrote:
>>> There has been an explosion of interest in so called "AI" (LLM)
>>> code generators in the past year or so. Thus far though, this is
>>> has not been matched by a broadly accepted legal interpretation
>>> of the licensing implications for code generator outputs. While
>>> the vendors may claim there is no problem and a free choice of
>>> license is possible, they have an inherent conflict of interest
>>> in promoting this interpretation. More broadly there is, as yet,
>>> no broad consensus on the licensing implications of code generators
>>> trained on inputs under a wide variety of licenses.
>>>
>>> The DCO requires contributors to assert they have the right to
>>> contribute under the designated project license. Given the lack
>>> of consensus on the licensing of "AI" (LLM) code generator output,
>>> it is not considered credible to assert compliance with the DCO
>>> clause (b) or (c) where a patch includes such generated code.
>>>
>>> This patch thus defines a policy that the QEMU project will not
>>> accept contributions where use of "AI" (LLM) code generators is
>>> either known, or suspected.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)


>>> +Use of "AI" (LLM) code generators
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +TL;DR:
>>> +
>>> +  **Current QEMU project policy is to DECLINE any contributions
>>> +  which are believed to include or derive from "AI" (LLM)
>>> +  generated code.**
>>> +
>>> +The existence of "AI" (`Large Language Model 
>>> <https://en.wikipedia.org/wiki/Large_language_model>`__
>>> +/ LLM) code generators raises a number of difficult legal questions, a
>>> +number of which impact on Open Source projects. As noted earlier, the
>>> +QEMU community requires that contributors certify their patch 
>>> submissions
>>> +are made in accordance with the rules of the :ref:`dco` (DCO). When a
>>> +patch contains "AI" generated code this raises difficulties with code
>>> +provenence and thus DCO compliance.
>>> +
>>> +To satisfy the DCO, the patch contributor has to fully understand
>>> +the origins and license of code they are contributing to QEMU. The
>>> +license terms that should apply to the output of an "AI" code generator
>>> +are ill-defined, given that both training data and operation of the
>>> +"AI" are typically opaque to the user. Even where the training data
>>> +is said to all be open source, it will likely be under a wide variety
>>> +of license terms.
>>> +
>>> +While the vendor's of "AI" code generators may promote the idea that
>>> +code output can be taken under a free choice of license, this is not
>>> +yet considered to be a generally accepted, nor tested, legal opinion.
>>> +
>>> +With this in mind, the QEMU maintainers does not consider it is
>>> +currently possible to comply with DCO terms (b) or (c) for most "AI"
>>> +generated code.
>>> +
>>> +The QEMU maintainers thus require that contributors refrain from using
>>> +"AI" code generators on patches intended to be submitted to the 
>>> project,
>>> +and will decline any contribution if use of "AI" is known or suspected.
>>> +
>>> +Examples of tools impacted by this policy includes both GitHub CoPilot,
>>> +and ChatGPT, amongst many others which are less well known.
>>
>>
>> So you called out these two by name, fine, but given "AI" is in scare
>> quotes I don't really know what is or is not allowed and I don't know
>> how will contributors know.  Is the "AI" that one must not use
>> necessarily an LLM?  And how do you define LLM even? Wikipedia says
>> "general-purpose language understanding and generation".
>>
>>
>> All this seems vague to me.
>>
>>
>> However, can't we define a simpler more specific policy?
>> For example, isn't it true that *any* automatically generated code
>> can only be included if the scripts producing said code
>> are also included or otherwise available under GPLv2?
> 
> The following definition makes sense to me:
> 
> - Automated codegen tool must be idempotent.
> - Automated codegen tool must not use statistical modelling.
> 
> I'd remove all AI or LLM references. These are non-specific, colloquial 
> and in the case of `AI`, non-technical. This policy should apply the 
> same to a Markov chain code generator.

This document targets all contributors. Contributions can be typo
fix, translations, ... and don't have to be technical. Similarly,
contributors aren't expected to be technical experts. As a neophyte,
"AI" makes sense. "Idempotent code generator" or "LLM" don't :)

