Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 035667F6311
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:33:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6BhS-0005nk-Ea; Thu, 23 Nov 2023 10:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6BhG-0005Y6-Ff
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:32:54 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6BhB-0000Q1-CJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:32:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083f613272so6729135e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700753566; x=1701358366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNB0GZqw9S6CWE/ElqMrEP+EfWyAbKCG3btAwz5VLt8=;
 b=epC8PLstbxkShyalkE7MNp5ZR0ppEx49t5NgmnkNykCP3DOyGYZlcxuyNnzYyWtZNC
 3hFWU4HK7Ln/LyId3hf+D2Db+6ZZbhd+Ee1qZn8CHJY9QCZTY55mYSubjZkKUgBpVUrN
 Fn7MYMYLZuzRDDjc7XKne0x/NQoxDzPeYcCJCb1PvqhU+gFupqaK06Mc8ateATfCGsim
 upDwPB+LFsJxpfs5L+g17m83d2SunFa+0fN83gbZ+QjU/oOM3OnlXV+nHgCabq9klyN5
 ElBBoZK5xcIZUer8eqYZATm6EQso3U0pxTLBXZGzbmTxI49SY+BI6TONmD/qCgljRQ1C
 FcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700753566; x=1701358366;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VNB0GZqw9S6CWE/ElqMrEP+EfWyAbKCG3btAwz5VLt8=;
 b=WjrJXQXeJz6ono4Iv1weihi2/y+QgUlH2TjN5ShFw4XNEbgElU0mszV5HVx6sZxqAz
 hSrisS5N8lZmTXArBQIZSxTG8rRZoYN5xG7VhBM22gMbjqrqoht/YgaThTvi28hvE0Yx
 3271iicMQPklZonCJnNOTqUEyCB610w/2L6hVZcUR1LZ3t90DPWjuZCp1CIA7Hw8DyJl
 W6Vo/kZ3Enq3K3mYIRBuYSvYKyj1HrL+Euo97SkbrewWUKfnLOOso2bufRoT6eJ+ia7B
 t2Y1IGPZcUVabDKo6al7Uh5RjoznHtVPG0xPNWdcNOYvDIRvbShXdZDiJY+NLyTSq+pB
 kgHw==
X-Gm-Message-State: AOJu0YyvsehHwgsQiFpfwAIHtSVpkCOYXf/QA3iMDBtDC9PPb7i3iz46
 Aohq4yviQk6gPPKMTGIX41gSxw==
X-Google-Smtp-Source: AGHT+IEJLs3yMWCYZJ2Vv3e3synoMLyQP//ZSPAYS6tzXy68H3+uHz9/Lry1VjtL6X2Kbr5HGY8T6Q==
X-Received: by 2002:a05:600c:1ca6:b0:40b:3730:edc1 with SMTP id
 k38-20020a05600c1ca600b0040b3730edc1mr1183649wms.5.1700753565713; 
 Thu, 23 Nov 2023 07:32:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0ac300b004064288597bsm2288736wmr.30.2023.11.23.07.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:32:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0074A5F756;
 Thu, 23 Nov 2023 15:32:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9=20?= <berrange@redhat.com>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Alexander Graf <agraf@csgraf.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <4l0it.9kkxe9s135lg@linaro.org> (Manos Pitsidianakis's message of
 "Thu, 23 Nov 2023 16:56:28 +0200")
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 23 Nov 2023 15:32:44 +0000
Message-ID: <87a5r4eb8j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, 23 Nov 2023 16:35, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrang=C3=A9 wrote:
>>> There has been an explosion of interest in so called "AI" (LLM)
>>> code generators in the past year or so. Thus far though, this is
>>> has not been matched by a broadly accepted legal interpretation
>>> of the licensing implications for code generator outputs. While
>>> the vendors may claim there is no problem and a free choice of
>>> license is possible, they have an inherent conflict of interest
>>> in promoting this interpretation. More broadly there is, as yet,
>>> no broad consensus on the licensing implications of code generators
>>> trained on inputs under a wide variety of licenses.
>>> The DCO requires contributors to assert they have the right to
>>> contribute under the designated project license. Given the lack
>>> of consensus on the licensing of "AI" (LLM) code generator output,
>>> it is not considered credible to assert compliance with the DCO
>>> clause (b) or (c) where a patch includes such generated code.
>>> This patch thus defines a policy that the QEMU project will not
>>> accept contributions where use of "AI" (LLM) code generators is
>>> either known, or suspected.
>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> ---
>>>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>> diff --git a/docs/devel/code-provenance.rst
>>> b/docs/devel/code-provenance.rst
>>> index b4591a2dec..a6e42c6b1b 100644
>>> --- a/docs/devel/code-provenance.rst
>>> +++ b/docs/devel/code-provenance.rst
>>> @@ -195,3 +195,43 @@ example::
>>>    Signed-off-by: Some Person <some.person@example.com>
>>>    [Rebased and added support for 'foo']
>>>    Signed-off-by: New Person <new.person@example.com>
>>> +
>>> +Use of "AI" (LLM) code generators
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +TL;DR:
>>> +
>>> +  **Current QEMU project policy is to DECLINE any contributions
>>> +  which are believed to include or derive from "AI" (LLM)
>>> +  generated code.**
>>> +
>>> +The existence of "AI" (`Large Language Model <https://en.wikipedia.org=
/wiki/Large_language_model>`__
>>> +/ LLM) code generators raises a number of difficult legal questions, a
>>> +number of which impact on Open Source projects. As noted earlier, the
>>> +QEMU community requires that contributors certify their patch submissi=
ons
>>> +are made in accordance with the rules of the :ref:`dco` (DCO). When a
>>> +patch contains "AI" generated code this raises difficulties with code
>>> +provenence and thus DCO compliance.
>>> +
<snip>
>>> +
>>> +The QEMU maintainers thus require that contributors refrain from using
>>> +"AI" code generators on patches intended to be submitted to the projec=
t,
>>> +and will decline any contribution if use of "AI" is known or suspected.
>>> +
>>> +Examples of tools impacted by this policy includes both GitHub CoPilot,
>>> +and ChatGPT, amongst many others which are less well known.
>>
>>
>>So you called out these two by name, fine, but given "AI" is in scare
>>quotes I don't really know what is or is not allowed and I don't know
>>how will contributors know.  Is the "AI" that one must not use
>>necessarily an LLM?  And how do you define LLM even? Wikipedia says
>>"general-purpose language understanding and generation".
>>
>>
>>All this seems vague to me.
>>
>>
>>However, can't we define a simpler more specific policy?
>>For example, isn't it true that *any* automatically generated code
>>can only be included if the scripts producing said code
>>are also included or otherwise available under GPLv2?
>
> The following definition makes sense to me:
>
> - Automated codegen tool must be idempotent.
> - Automated codegen tool must not use statistical modelling.
>
> I'd remove all AI or LLM references. These are non-specific,
> colloquial and in the case of `AI`, non-technical. This policy should
> apply the same to a Markov chain code generator.

I'm fairly sure my Emacs auto-complete would fail by that definition.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

