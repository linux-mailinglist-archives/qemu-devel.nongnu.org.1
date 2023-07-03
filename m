Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC1F745FD1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLS6-00060C-8C; Mon, 03 Jul 2023 11:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGLS4-0005zw-4n
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:26:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGLS2-0002tc-9x
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:26:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so51002975e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688398012; x=1690990012;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3QdkQpWgtAMU3UnThVHwJx8B3e3og9drm54nbosE3Q=;
 b=uVxWEMEyzchACiIbf+B7byGZsssK2WpR50MLrBG/JzVriYCPy0On69FMG4cQnzvXnY
 VMxKsY9bhcpFF/E4XuV1fXrRM4h8XI5vm+TjxyZJ94SY5YlzScbHkp/4hWNPbfiACZb4
 wqZt3OgpJuaUphojErTW8GgHQfnEtvsME1nvsjX8y0WP/H/BkLGAxTIsy66vRfujJSwx
 GMwQE+Q1zV6eo17YvBcH+T27jRmWSfJbKhmPrzqn0lWo85+VXtZ0Z3vUARAYUuBdLV5F
 rAdWQHGCCvtKs3Z2LK+VlwqdjUwUHrRWDUbgi8T0qoV+tFE1KGGY1vM4AAw5Gg9gImZH
 8XUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688398012; x=1690990012;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s3QdkQpWgtAMU3UnThVHwJx8B3e3og9drm54nbosE3Q=;
 b=BTgXlffbUPewZ6lwLjEU41UN8aIx4CyyZDkk79bUya+wtujefB28a8XUtl81DZlOvp
 FuxD3Z2MuoOeO/FJUfQpGaeP7e0bCPXpxkcpY0HTdw40T1COTlDkAfA3kqctZeulXbYg
 zf4LQcmZ35yGZo1g7ExuWwNaXqoqWFgIrFjWxptn5LCnmPNRmP042lTig77gbcqD4sDJ
 r/pfvPH2c/nq/iGuDThvTcQw4rwT4z+yR5Q6xIPZpo6/jc1RioZFpKe+EmvE6fORX+/D
 UNJPTY+tq2W6Mn3cEgK8k8mKguln7YEjmNnrgBX1qXP8cld4Bohi6U3KzkBCSYJ5uo5G
 iw0Q==
X-Gm-Message-State: ABy/qLY58D7zjbfFAMVWlLXWhoNO4hpf74ms46lABE90KozGRKL1DaTj
 8GGJqFQHWvffOdI69vIy3+Meng==
X-Google-Smtp-Source: APBJJlFbvSrM6lpMPvGBKFjiIbm3PIc7Fjxq/Nax2xE4FDJviAINPT56h4Td8d724vS/vLJeq3l13w==
X-Received: by 2002:a1c:f713:0:b0:3fb:d72b:b2a0 with SMTP id
 v19-20020a1cf713000000b003fbd72bb2a0mr3999575wmh.6.1688398012706; 
 Mon, 03 Jul 2023 08:26:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm21636155wmj.45.2023.07.03.08.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 08:26:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA4B51FFBB;
 Mon,  3 Jul 2023 16:26:51 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-3-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [RFC v3 02/10] build: Add configure options for native calls
Date: Mon, 03 Jul 2023 16:22:36 +0100
In-reply-to: <20230625212707.1078951-3-fufuyqqqqqq@gmail.com>
Message-ID: <87zg4dggn8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Add CONFIG_NATIVE_CALL to architectures supporting native calls.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>

I would expect this patch to be split up and merged with the enabling
patch for each architecture.

> ---
>  configs/targets/aarch64-linux-user.mak | 1 +
>  configs/targets/arm-linux-user.mak     | 1 +
>  configs/targets/i386-linux-user.mak    | 1 +
>  configs/targets/mips-linux-user.mak    | 1 +
>  configs/targets/mips64-linux-user.mak  | 1 +
>  configs/targets/x86_64-linux-user.mak  | 1 +
>  6 files changed, 6 insertions(+)
>
> diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aar=
ch64-linux-user.mak
> index ba8bc5fe3f..5a8fd98cd9 100644
> --- a/configs/targets/aarch64-linux-user.mak
> +++ b/configs/targets/aarch64-linux-user.mak
> @@ -4,3 +4,4 @@ TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarc=
h64-fpu.xml gdb-xml/aarch
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> +CONFIG_NATIVE_CALL=3Dy
> diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-lin=
ux-user.mak
> index 7f5d65794c..f934fb82da 100644
> --- a/configs/targets/arm-linux-user.mak
> +++ b/configs/targets/arm-linux-user.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.=
xml gdb-xml/arm-vfp3.xml
>  TARGET_HAS_BFLT=3Dy
>  CONFIG_SEMIHOSTING=3Dy
>  CONFIG_ARM_COMPATIBLE_SEMIHOSTING=3Dy
> +CONFIG_NATIVE_CALL=3Dy
> diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-l=
inux-user.mak
> index 5b2546a430..2d8bca8f93 100644
> --- a/configs/targets/i386-linux-user.mak
> +++ b/configs/targets/i386-linux-user.mak
> @@ -2,3 +2,4 @@ TARGET_ARCH=3Di386
>  TARGET_SYSTBL_ABI=3Di386
>  TARGET_SYSTBL=3Dsyscall_32.tbl
>  TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> +CONFIG_NATIVE_CALL=3Dy
> diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-l=
inux-user.mak
> index b4569a9893..fa005d487a 100644
> --- a/configs/targets/mips-linux-user.mak
> +++ b/configs/targets/mips-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=3Dy
>  TARGET_SYSTBL_ABI=3Do32
>  TARGET_SYSTBL=3Dsyscall_o32.tbl
>  TARGET_BIG_ENDIAN=3Dy
> +CONFIG_NATIVE_CALL=3Dy
> diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips=
64-linux-user.mak
> index d2ff509a11..ecfe6bcf73 100644
> --- a/configs/targets/mips64-linux-user.mak
> +++ b/configs/targets/mips64-linux-user.mak
> @@ -4,3 +4,4 @@ TARGET_BASE_ARCH=3Dmips
>  TARGET_SYSTBL_ABI=3Dn64
>  TARGET_SYSTBL=3Dsyscall_n64.tbl
>  TARGET_BIG_ENDIAN=3Dy
> +CONFIG_NATIVE_CALL=3Dy
> diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_=
64-linux-user.mak
> index 9ceefbb615..a53b017454 100644
> --- a/configs/targets/x86_64-linux-user.mak
> +++ b/configs/targets/x86_64-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_BASE_ARCH=3Di386
>  TARGET_SYSTBL_ABI=3Dcommon,64
>  TARGET_SYSTBL=3Dsyscall_64.tbl
>  TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml
> +CONFIG_NATIVE_CALL=3Dy


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

