Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5F7C8B92
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 18:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLJ7-0002MY-0b; Fri, 13 Oct 2023 12:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLJ1-0002Lz-QC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:46:32 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLJ0-00007J-DS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 12:46:31 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so2179675f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697215588; x=1697820388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61FQvJhQBTgnhL7lj1VgaK9n1yg8cgdcy5Q/c6QYZc4=;
 b=e0TZ4EkpkpKPrIHpNHfDNv2ux2qhlWxbyJfM4caXrwZCiOOVVQF2tbnjRD0RrXp5yT
 8SN7D3G6x4+KWgGD4iIMJkDlpj4zivxn925BzPtAhqCQheVtJGVWaHrjU5Kb7AEQfumL
 pxpuj+PmTInpyx2QsCYM77VgIHKltNMFAvwH8cgwIZD/Yjd9eeZMK+Tx6gH4yP8zziY1
 f83kqF8lUiH59s6V5jTQ8khOToCpUGnaj6mKP0WqzzcNVL7a4hEbpgs8pyFpR0NaHL+v
 qorpiiru4/Kn5166qUCsjEZNkaR7RR3Hg5gekL1tcgG60iiyf3a0agdOy/3LscR/y1uD
 haOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697215588; x=1697820388;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=61FQvJhQBTgnhL7lj1VgaK9n1yg8cgdcy5Q/c6QYZc4=;
 b=R5RNNmhFe4oc6O+1upyxMd68t/5VVxjfS7gT8Y19ZJXzikmzy3XqoZHfZ1YTu9a3wH
 rWxCbewIUuKVO+u5l+hv1oDx5ciTnnj5HCq33yU9g4j2uHQAy+YnezArMWx2jQdJEc0a
 N5srhchH3cuUGzB74PhO+ViGfL39TnVXY0nyYVSYDxzWteH2TZ0OckGu6m6eDPKgEgZC
 nQ4veReQL+nms0NFUe2Y4pl8ysPrWyuQKYnubR1HFk58NTwKdoJIRVQA8Qgc4k7unLSy
 v9UI9jdMZotz2tSAjKpm+5TBaZbulcBMALqz920jQ2spOt963JScvuPv6eHAQ/ik2m9D
 M2xQ==
X-Gm-Message-State: AOJu0Yzpc75E084J/qyjSJ/NP1GNL4bQuvCrMfQWbqLqFq42aLBzeexq
 sHzTSVMG87TsAei8W6TqZm3UnBptmk3y2+sGvJ4=
X-Google-Smtp-Source: AGHT+IFwykkWT8uxxNQhyQCueZQcZyjuWmdUXFNTt9zHiUDZWLLw79RM27FKoELQV/ho8qUzZow6Ag==
X-Received: by 2002:a5d:42c4:0:b0:32d:a0f7:40cc with SMTP id
 t4-20020a5d42c4000000b0032da0f740ccmr994532wrr.68.1697215587985; 
 Fri, 13 Oct 2023 09:46:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 dh13-20020a0560000a8d00b00327cd5e5ac1sm6595952wrb.1.2023.10.13.09.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 09:46:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 50D031FFBB;
 Fri, 13 Oct 2023 17:46:27 +0100 (BST)
References: <20231006090610.26171-1-nicolas.eder@lauterbach.com>
 <20231006090610.26171-28-nicolas.eder@lauterbach.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Christian.Boenig@lauterbach.com
Subject: Re: [PATCH v2 27/29] MCD stub entry added to maintainers file
Date: Fri, 13 Oct 2023 17:46:06 +0100
In-reply-to: <20231006090610.26171-28-nicolas.eder@lauterbach.com>
Message-ID: <87r0lylbbw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> From: neder <nicolas.eder@lauterbach.com>
>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 81625f036b..b6bc8201bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2832,6 +2832,15 @@ F: tests/tcg/multiarch/gdbstub/
>  F: scripts/feature_to_c.sh
>  F: scripts/probe-gdb-support.py
>=20=20
> +MCD stub
> +M: Nicolas Eder <nicolas.eder@lauterbach.com>
> +R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
> +F: mcdstub/*
> +F: include/exec/mcdstub.h

move to include/mcdstub

Otherwise:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +F: include/mcdstub/*
> +F: target/arm/mcdstub.c
> +
>  Memory API
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Peter Xu <peterx@redhat.com>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

