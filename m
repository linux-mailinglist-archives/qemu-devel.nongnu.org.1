Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440177F624B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6BFc-0000pt-5y; Thu, 23 Nov 2023 10:04:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r6BFW-0000l1-LW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:04:16 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r6BFU-00051h-Gr
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:04:14 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c88750e7d1so11472771fa.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700751849; x=1701356649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zb4pZE1n8XkIan6OmO19ZgzWKPysQ6m8AXvlOIgi7fM=;
 b=SVlvovxz7SatKkXGcto0fQs3ZA/ENE+K4iJmlHIUaqaM6/GTWbyC20GSgDanazxIgR
 unjI0Q+nf5ArjbBu+ZB+E+GQGf1NUub1CEFrfSint+dNi+tvyCnEDfKkeOdukW9TiTX8
 DiB0kTaavfy9dTQz71cuBG6NxI0oOEwBao3xKcB3QktuKwsvuOv91ChaCyaXszd/d0OS
 163bqbWUY3ofKGVEoJn3FUqpRvCZORnb9pKfVu7aTIUuNxKB5Hhd5I3BXSkvO3ha8NNz
 IBnl87IB6nQjQWhDuNVqTWrW62a5h7XvH0AQgRH44RmA04406c+IuPu6WU3tmwlfa7a4
 nsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700751849; x=1701356649;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zb4pZE1n8XkIan6OmO19ZgzWKPysQ6m8AXvlOIgi7fM=;
 b=bnNszYb4SN7s0kuwKKWMB+Tu54m0uDLCNtLOvNP1CcD2K7vgPkHcZkQ8ge8uoZzvhI
 keKZvYbjH/RBZQILx0As234lQNyi4g8TaMf+e9fWvcXv6owImOWP/km04iimHdrlEnAv
 4YgBSM0JKaw0Bu+NxFiLAUC8QgT4sa+cDASMq1MiAlurzqdh+toH77TcofzeEiNjdDGw
 3dFK/OGTKSYzodiTcQxPJ6sa3gMBpHkO81OMqNF87OuyBNQdomm6sHtvvkelQUo2xkWm
 sti/tJxDzb6Ce+ya3qxM4ypbcv7DTje2Va92riRp3n07Vh+oKkXTmNcOGr08OBIRV+vs
 KjuA==
X-Gm-Message-State: AOJu0Yzk6gpWOQtIkLPtHFFUyYqbJQGdA+qD629TI1wb/Oq6ZiQKfQ0m
 Ina96K8/6H2jMnjoR9Z6dfCx9z2FDZpaT0pLSD/5xg==
X-Google-Smtp-Source: AGHT+IGyJ2mS/Ob35BazdagdfXsYIUIjPdHF8bBvnBfotK/j38Gsdu7krJRP5/OeTRyyd6UD/T1ENA==
X-Received: by 2002:a2e:2a82:0:b0:2c5:16c0:6239 with SMTP id
 q124-20020a2e2a82000000b002c516c06239mr4033126ljq.51.1700751848674; 
 Thu, 23 Nov 2023 07:04:08 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c458400b004094d4292aesm2296413wmo.18.2023.11.23.07.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:04:08 -0800 (PST)
Date: Thu, 23 Nov 2023 16:56:28 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
User-Agent: meli 0.8.4
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231123092523-mutt-send-email-mst@kernel.org>
Message-ID: <4l0it.9kkxe9s135lg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
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

On Thu, 23 Nov 2023 16:35, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrangé wrote:
>> There has been an explosion of interest in so called "AI" (LLM)
>> code generators in the past year or so. Thus far though, this is
>> has not been matched by a broadly accepted legal interpretation
>> of the licensing implications for code generator outputs. While
>> the vendors may claim there is no problem and a free choice of
>> license is possible, they have an inherent conflict of interest
>> in promoting this interpretation. More broadly there is, as yet,
>> no broad consensus on the licensing implications of code generators
>> trained on inputs under a wide variety of licenses.
>> 
>> The DCO requires contributors to assert they have the right to
>> contribute under the designated project license. Given the lack
>> of consensus on the licensing of "AI" (LLM) code generator output,
>> it is not considered credible to assert compliance with the DCO
>> clause (b) or (c) where a patch includes such generated code.
>> 
>> This patch thus defines a policy that the QEMU project will not
>> accept contributions where use of "AI" (LLM) code generators is
>> either known, or suspected.
>> 
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>> 
>> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
>> index b4591a2dec..a6e42c6b1b 100644
>> --- a/docs/devel/code-provenance.rst
>> +++ b/docs/devel/code-provenance.rst
>> @@ -195,3 +195,43 @@ example::
>>    Signed-off-by: Some Person <some.person@example.com>
>>    [Rebased and added support for 'foo']
>>    Signed-off-by: New Person <new.person@example.com>
>> +
>> +Use of "AI" (LLM) code generators
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +TL;DR:
>> +
>> +  **Current QEMU project policy is to DECLINE any contributions
>> +  which are believed to include or derive from "AI" (LLM)
>> +  generated code.**
>> +
>> +The existence of "AI" (`Large Language Model <https://en.wikipedia.org/wiki/Large_language_model>`__
>> +/ LLM) code generators raises a number of difficult legal questions, a
>> +number of which impact on Open Source projects. As noted earlier, the
>> +QEMU community requires that contributors certify their patch submissions
>> +are made in accordance with the rules of the :ref:`dco` (DCO). When a
>> +patch contains "AI" generated code this raises difficulties with code
>> +provenence and thus DCO compliance.
>> +
>> +To satisfy the DCO, the patch contributor has to fully understand
>> +the origins and license of code they are contributing to QEMU. The
>> +license terms that should apply to the output of an "AI" code generator
>> +are ill-defined, given that both training data and operation of the
>> +"AI" are typically opaque to the user. Even where the training data
>> +is said to all be open source, it will likely be under a wide variety
>> +of license terms.
>> +
>> +While the vendor's of "AI" code generators may promote the idea that
>> +code output can be taken under a free choice of license, this is not
>> +yet considered to be a generally accepted, nor tested, legal opinion.
>> +
>> +With this in mind, the QEMU maintainers does not consider it is
>> +currently possible to comply with DCO terms (b) or (c) for most "AI"
>> +generated code.
>> +
>> +The QEMU maintainers thus require that contributors refrain from using
>> +"AI" code generators on patches intended to be submitted to the project,
>> +and will decline any contribution if use of "AI" is known or suspected.
>> +
>> +Examples of tools impacted by this policy includes both GitHub CoPilot,
>> +and ChatGPT, amongst many others which are less well known.
>
>
>So you called out these two by name, fine, but given "AI" is in scare
>quotes I don't really know what is or is not allowed and I don't know
>how will contributors know.  Is the "AI" that one must not use
>necessarily an LLM?  And how do you define LLM even? Wikipedia says
>"general-purpose language understanding and generation".
>
>
>All this seems vague to me.
>
>
>However, can't we define a simpler more specific policy?
>For example, isn't it true that *any* automatically generated code
>can only be included if the scripts producing said code
>are also included or otherwise available under GPLv2?

The following definition makes sense to me:

- Automated codegen tool must be idempotent.
- Automated codegen tool must not use statistical modelling.

I'd remove all AI or LLM references. These are non-specific, colloquial 
and in the case of `AI`, non-technical. This policy should apply the 
same to a Markov chain code generator.

