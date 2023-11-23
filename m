Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6597F5F99
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 13:58:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r69HE-0001on-S2; Thu, 23 Nov 2023 07:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r69HA-0001oF-I2
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:57:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r69H8-0001P6-Ho
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:57:48 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332e58d4219so203845f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700744263; x=1701349063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3knE8/LjSy26ziegIGw8mv0xH24NpSKkqfICw7RW2o=;
 b=Xo3BwU0fY7eZDKJ1914wyIRY7kRc+mXLWoFkrutlVUDcAdPbNheTomQafDxqj3CMq5
 rTb/PXmjLdUwcshBxIfepVKtfkYBNGmH3E4h7bdqgSqtjz3xisNER6ZRhiC7dYlkYIL9
 5XRZVGMwxPmxbv/Z6UCgdJLMfUQ/uHzGv61dix2ZwYQlfXYUlfBH1OSuOiNbPK3mqAWw
 J9TqsuADUQV/keMgTdVRunrIWb6L7kpFnPhYY9ugATLiTz9zHG7VmMYWFRl9pIXIcjl6
 5hw8OPLT3hUiqOxqeVYgUexNmVQsAm1hkyflq3d683yjuIIfZLWRjQaAlEYVThPh7UQ2
 UKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700744263; x=1701349063;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G3knE8/LjSy26ziegIGw8mv0xH24NpSKkqfICw7RW2o=;
 b=WJnG3pVT3WTV+7XtlbyWNnsHSxdGCz7aItwMrRSsLivpJZX5RpwAbbEC0sl3G4gERS
 e9YCoHsrXA9n+phyFFo+C6PtWIn0R2h0ijjF9fQWip3id9pfSESdaoSc7GbokJUt/8pU
 mJOmxFbPKpAuny6qL/uIQYzkiX695wIXgzSTmc1hVUzT0V+NaIW4M/WLhz4B3O0s/4BN
 D1+2caYMAjv8ZerkmAg9wghiuf+bFOT/ATw2XFaHVH27oAcp9H6ysFkRuONH+sVRfLbL
 o0r3iwIWRa5HfgYNeU3nVCL2hhuwKJO9XypQw46RcsgBA/WXNq/6M2cyc5vgfaDPAn/z
 BExg==
X-Gm-Message-State: AOJu0YwChAKlr6eM8ivOkGiePxghhpZnjtYFajRWs0dJdYzeGLNlfETv
 XpooGdtWcsGje+m+hFttuVeawQ==
X-Google-Smtp-Source: AGHT+IH1wIhRnp5lHD1Q0Ufz6/F/Ta7dIGapsI9I2JjA3lj+PzioDu1s8EW+efdBx5BWuqKowjOzIw==
X-Received: by 2002:a5d:5986:0:b0:32d:8e54:29fa with SMTP id
 n6-20020a5d5986000000b0032d8e5429famr4190179wri.44.1700744262960; 
 Thu, 23 Nov 2023 04:57:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e16-20020adffc50000000b00332cb561c8dsm1575649wrs.112.2023.11.23.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 04:57:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4BB215F756;
 Thu, 23 Nov 2023 12:57:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexander Graf <agraf@csgraf.de>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Phil =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <20231123114026.3589272-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 23 Nov 2023 11:40:26
 +0000")
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Thu, 23 Nov 2023 12:57:42 +0000
Message-ID: <87r0kgeiex.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> There has been an explosion of interest in so called "AI" (LLM)
> code generators in the past year or so. Thus far though, this is
> has not been matched by a broadly accepted legal interpretation
> of the licensing implications for code generator outputs. While
> the vendors may claim there is no problem and a free choice of
> license is possible, they have an inherent conflict of interest
> in promoting this interpretation. More broadly there is, as yet,
> no broad consensus on the licensing implications of code generators
> trained on inputs under a wide variety of licenses.
>
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack
> of consensus on the licensing of "AI" (LLM) code generator output,
> it is not considered credible to assert compliance with the DCO
> clause (b) or (c) where a patch includes such generated code.
>
> This patch thus defines a policy that the QEMU project will not
> accept contributions where use of "AI" (LLM) code generators is
> either known, or suspected.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/devel/code-provenance.rst | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.=
rst
> index b4591a2dec..a6e42c6b1b 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -195,3 +195,43 @@ example::
>    Signed-off-by: Some Person <some.person@example.com>
>    [Rebased and added support for 'foo']
>    Signed-off-by: New Person <new.person@example.com>
> +
> +Use of "AI" (LLM) code generators
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +TL;DR:
> +
> +  **Current QEMU project policy is to DECLINE any contributions
> +  which are believed to include or derive from "AI" (LLM)
> +  generated code.**
> +
> +The existence of "AI" (`Large Language Model <https://en.wikipedia.org/w=
iki/Large_language_model>`__
> +/ LLM) code generators raises a number of difficult legal questions, a
> +number of which impact on Open Source projects. As noted earlier, the
> +QEMU community requires that contributors certify their patch submissions
> +are made in accordance with the rules of the :ref:`dco` (DCO). When a
> +patch contains "AI" generated code this raises difficulties with code
> +provenence and thus DCO compliance.

I agree this is going to be a field that keeps lawyers well re-numerated
for the foreseeable future. However I suspect this elides over the main
use case for LLM generators which is non-novel transformation. One good
example is generating text fixtures where you write a piece of original
code and then ask the code completion engine to fill out some unit tests
to exercise the code. It's boring mechanical work but one an LLM is very
suited to (even if you might tweak the final result).

> +To satisfy the DCO, the patch contributor has to fully understand
> +the origins and license of code they are contributing to QEMU. The
> +license terms that should apply to the output of an "AI" code generator
> +are ill-defined, given that both training data and operation of the
> +"AI" are typically opaque to the user. Even where the training data
> +is said to all be open source, it will likely be under a wide variety
> +of license terms.
> +
> +While the vendor's of "AI" code generators may promote the idea that
> +code output can be taken under a free choice of license, this is not
> +yet considered to be a generally accepted, nor tested, legal opinion.
> +
> +With this in mind, the QEMU maintainers does not consider it is
> +currently possible to comply with DCO terms (b) or (c) for most "AI"
> +generated code.

There is a load of code out that isn't eligible for copyright projection
because it doesn't demonstrate much originality or creativity. In the
experimentation I've done so far I've not seen much sign of genuine
creativity. LLM's benefit from having access to a wide corpus of
training data and tend to do a better job of inferencing solutions from
semi-related posts than say for example human manually comparing posts
having pasted an error message in google.

> +
> +The QEMU maintainers thus require that contributors refrain from using
> +"AI" code generators on patches intended to be submitted to the project,
> +and will decline any contribution if use of "AI" is known or suspected.
> +
> +Examples of tools impacted by this policy includes both GitHub CoPilot,
> +and ChatGPT, amongst many others which are less well known.

What about if you took an LLM and then fine tuned it by using project
data so it could better help new users in making contributions to the
project? You would be biasing the model to your own data for the
purposes of helping developers write better QEMU code?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

