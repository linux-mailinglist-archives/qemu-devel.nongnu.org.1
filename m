Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0C735D45
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 20:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBJGl-0000Pz-72; Mon, 19 Jun 2023 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBJGd-0000Os-DQ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:06:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBJGb-0006y8-A5
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 14:06:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f90bff0f27so14640195e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687197975; x=1689789975;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoWVCocjlZr1eze5kVEAOHyihtuevYkvOU0iVroPSUM=;
 b=ZFAS+UnraWT3p1STEcItq+UfkZJakyb6TbA04w4lSw8+n2i/CCb4NNo7LcnolJjaxC
 g/zYBPxm/yep6Dcz7iugcLJ5hEwEOOrUVR6fA+yWvyorzPjUj0YSK+Bx7d0zreer3+dc
 il9SPXrVWUyt/S7qnX3txBDoYlMGzWAAGj7IfiDeni8Mj9df/iC+k9WmTGQC3fqcwcDR
 ht9u0pQz4kb75rvvc9aprXzhkjXmeuzNHZtSIySAtIJpVI0xj6DYnx9rxHokkEC61hUL
 M0xRH0WuLh+KmF1DhETHhtGC6A1G96Bgj+/AHR3F+Wp36cQh3nGFJ5oTJsEE8dUfoLx+
 0VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687197975; x=1689789975;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hoWVCocjlZr1eze5kVEAOHyihtuevYkvOU0iVroPSUM=;
 b=EgiBnDMGTR9Z5G2KViy5SNUto4ERrS9k+9eyG5XGRX5ron5Y5swbknuhudbgRCO/mr
 yKcoPROb2OiiWeqifOFVGmpAvo2o2A0aSVmywvM7gPG96jJ2HzcQMwUnovadFrVJF57l
 ZO+dOguWccBCxotj+fCALbd+RmUDPR4YtJ58oR+xz9gX5H2V4HB5HjMARmMud4zC2YeQ
 cDEj/6m9GfLly/7eqF/XJJtt1oOSCx08XMh4yIWF1k7276KNtGJeV1m0B0wu/LQ80B0n
 u5y/kJiuM53+GfAG/6gTrhb9l9CR/qlhRhbUrbKTWz3BEpSSq89yIaiOh4OCtpzV3prR
 /q/g==
X-Gm-Message-State: AC+VfDyB9klYPO0eq9y2XPGUiP1gq0tFUbRJJJYhrp00KD1Jboad/XKA
 nvg8CCkyou8MzoQbvZ87gbqD3A==
X-Google-Smtp-Source: ACHHUZ6D0jPru9ebzpHIIGMbqqC89zjNx6zJoeDGXtL5alCxJbRFaHK0jOU7lw+jnV9sp5SLMbXM5w==
X-Received: by 2002:a1c:6a07:0:b0:3f9:b13b:a1cd with SMTP id
 f7-20020a1c6a07000000b003f9b13ba1cdmr1911345wmc.16.1687197975319; 
 Mon, 19 Jun 2023 11:06:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a7bc409000000b003f9b24cf881sm2796615wmi.16.2023.06.19.11.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 11:06:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6E5D11FFBB;
 Mon, 19 Jun 2023 19:06:14 +0100 (BST)
References: <20230615141315.961315-1-anton.kochkov@proton.me>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anton Kochkov <anton.kochkov@proton.me>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] contrib/plugins: add meson build file
Date: Mon, 19 Jun 2023 19:04:25 +0100
In-reply-to: <20230615141315.961315-1-anton.kochkov@proton.me>
Message-ID: <87ilbjjpih.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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


Anton Kochkov <anton.kochkov@proton.me> writes:

> Add crossplatform Meson file to build TCG plugins since
> the Makefile makes wrong assumptions about it being used only
> on Linux. Tested on Linux and macOS.

I think you should go the whole hog and remove the existing makefile
machinery. Otherwise it will be confusing to users who add new plugins
to the contrib directory.

Can the overall QEMU meson invoke this directly or will it get confused
by it being a separate project?

>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1710
> Signed-off-by: Anton Kochkov <anton.kochkov@proton.me>
> ---
>  contrib/plugins/meson.build       | 31 +++++++++++++++++++++++++++++++
>  contrib/plugins/meson_options.txt |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 contrib/plugins/meson.build
>  create mode 100644 contrib/plugins/meson_options.txt
>
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> new file mode 100644
> index 0000000000..72c4167461
> --- /dev/null
> +++ b/contrib/plugins/meson.build
> @@ -0,0 +1,31 @@
> +project('qemu-plugins', 'c', meson_version: '>=3D0.50.0')
> +
> +qemu_src =3D get_option('qemu_path')
> +if qemu_src =3D=3D ''
> +  qemu_src =3D '../..'
> +endif
> +
> +qemu_include =3D qemu_src + '/include/qemu'
> +incdir =3D include_directories(qemu_include)
> +
> +plugins =3D [
> +  'execlog',
> +  'hotblocks',
> +  'hotpages',
> +  'howvec',
> +  'lockstep',
> +  'hwprofile',
> +  'cache',
> +  'drcov',
> +]
> +
> +th =3D dependency('threads', required: true)
> +glib =3D dependency('glib-2.0', required: true)
> +
> +foreach p: plugins
> +  library(p, p + '.c',
> +    include_directories: incdir,
> +    dependencies: [th, glib],
> +    override_options: ['b_lundef=3Dfalse']
> +  )
> +endforeach
> diff --git a/contrib/plugins/meson_options.txt b/contrib/plugins/meson_op=
tions.txt
> new file mode 100644
> index 0000000000..2d76cda496
> --- /dev/null
> +++ b/contrib/plugins/meson_options.txt
> @@ -0,0 +1 @@
> +option('qemu_path', type : 'string', value : '', description : 'Full
> path to the QEMU sources to build plugins for')


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

