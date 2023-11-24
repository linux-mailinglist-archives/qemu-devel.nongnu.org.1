Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A197F714F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:21:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TJQ-0000Wo-Tv; Fri, 24 Nov 2023 05:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TJN-0000WV-Qs
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:21:25 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6TJM-0006Rd-1K
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:21:25 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so21552641fa.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700821281; x=1701426081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pib8s+XTgxiWyDbXXeKhEYBXdJCgT4qcZQrS2nGNeb8=;
 b=KKljhHlxh+1vEzt3WGHtmbTQnQ/ckm5STnlJO/3ZjLc837q+tCjep8ekQ9XKHtO7+3
 dhzvwqKY8wdEaD2mGVVIpnbuCIOZLZR9xT3P3XOpXhw9QqQQ2Cdcf4ahrhDe1VoSOaAO
 G1pEUIKVatNKd3U6ptNwsq0bQiPnPQQ+4Aq/Je+Hd8XL1Gz2qpRsrrCfuF3GlmqkAWG7
 MSML/jcNwbL3BZtAd0KfJRtfLrS8ZnvgvufZaxmkJQ9HET2QrJj/nLvRpXf9BeBzBYl6
 Jl+N84P2ExhheOg+zkIoBke3Jn2fbR6qEIHzwkoqpia9Zsy8HCozzCyNVswUJ49WesbU
 dGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700821281; x=1701426081;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pib8s+XTgxiWyDbXXeKhEYBXdJCgT4qcZQrS2nGNeb8=;
 b=tXHB2tupaJxh3Rrrf7qfloeGwdhb1ZNgChoveTNSGlFSo5x9P0lt1GyAEV2t1vK2KN
 gTgDxiwHMMTSO82ra637/05tZ85623sLdgOQ0vxr2WRn2asVCP1y6DdAmVzZsaCHvHMX
 wgL9G+/GDDWTCimnVTqFmPJ+V4L8+k19EAXVSSoL4auQ3iEiEQhJljMo92GVBgkpBy4h
 CeS33lUDt2dWqWdAHGFhwk1opAbz7L7XkjFPyE1gkg+vjdZkk7QKffsYvsw2wVbj+BZU
 AXPw1CQdeVSjH01bL7ZgAYQ6M41/X6A7ylnWvWkggS8pRJ3OVrrGYE46Isc4uRnWSfxF
 00XQ==
X-Gm-Message-State: AOJu0YwdhJb19hEQmoSueoxOqSgNlDzmdzJBsVyfCA3rRbNkPdaOVukh
 JR7FGxLA9HNwgINfVqiRSL13Ig==
X-Google-Smtp-Source: AGHT+IEQEXP7Zd16HF8QQ3vedsth1EtoiIfO52xFdw15QjjeICWBnox0ichw5b2kpjvioAky9UhcVg==
X-Received: by 2002:a2e:9e59:0:b0:2c6:f6eb:b396 with SMTP id
 g25-20020a2e9e59000000b002c6f6ebb396mr1332427ljk.40.1700821278515; 
 Fri, 24 Nov 2023 02:21:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c445100b0040b3d33ab55sm485049wmn.47.2023.11.24.02.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:21:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2DD25F7AA;
 Fri, 24 Nov 2023 10:21:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>,  Alexander Graf
 <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
In-Reply-To: <ZWBngLoa3ERuMxGJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 24 Nov 2023 09:06:29 +0000")
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <ZV-S1f2cK8MLNizz@redhat.com>
 <20231123172828-mutt-send-email-mst@kernel.org>
 <ZWBngLoa3ERuMxGJ@redhat.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 24 Nov 2023 10:21:17 +0000
Message-ID: <87plzzcuzm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22d.google.com
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

> On Thu, Nov 23, 2023 at 05:39:18PM -0500, Michael S. Tsirkin wrote:
>> On Thu, Nov 23, 2023 at 05:58:45PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> > The license of a code generation tool itself is usually considered
>> > to be not a factor in the license of its output.
>>=20
>> Really? I would find it very surprising if a code generation tool that
>> is not a language model and so is not understanding the code it's
>> generating did not include some code snippets going into the output.
>> It is also possible to unintentionally run afoul of GPL's definition of =
source
>> code which is "the preferred form of the work for making modifications t=
o it".=20
>> So even if you have copyright to input, dumping just output and putting
>> GPL on it might or might not be ok.
>
> Consider the C pre-processor. This takes an input .c file, and expands
> all the macros, to split out a new .c file.
>
> The license of the output .c file is determined by the license of the
> input .c file. The license of the CPP impl (whether OSS or proprietary)
> doesn't have any influence on the license of the output file, it cannot
> magically force the output file to be proprietary any more than it can
> force it to be output file GPL.

LLM's are just a tool like a compiler (albeit with spookier different
internals). The prompt and the instructions are arguably the more
important part of how to get good results from the LLM transformation.
In fact most of the way I've been using them has been by pasting some
existing code and asking for review or transformation of it.

However I totally get that using the various online LLMs you have very
little transparency about what has gone into their training and therefor
there is a danger of proprietary code being hallucinated out of their
matricies. Conversely what if I use an LLM like OpenLLaMa:

  https://github.com/openlm-research/open_llama

I have fairly exhaustive definitions of what went into the training data
which of most interest is probably the StarCoder dataset (paper):

  https://drive.google.com/file/d/1cN-b9GnWtHzQRoE7M7gAEyivY0kl4BYs/view

where there are tools to detect if generated code has been lifted
directly from the dataset or is indeed a transformation.


>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

