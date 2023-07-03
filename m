Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B323674587A
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFwh-0000X3-Aa; Mon, 03 Jul 2023 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFwd-0000Wr-LJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:34:08 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFwb-0007r3-Hu
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:34:07 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so33958945e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688376844; x=1690968844;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROQCGlSC6AnDuwaP5/t6ykOjmMWyt+Cj7Kaaz8iJcJ4=;
 b=aqUM5CPwYSj2tIlidQ/RYHrwDLl5zD3y9c5h8bv9e9THdYxkEh+laQc4cOqUuanRoG
 6GdnUX7LMSDHB69stjYJP7NW/+bNSPEKGhSho2UtpheKS1hOF3larzDQi45ijCV1O82T
 MkrZm1YNzvsydBqn8IM2QJinRdCstpKGVI5OxvzVhxjkiAo5YEHdkkp4OoDl+Kgq6tU5
 7ZDgov17/CHUdFMV3gy3FZc/9h9hI/S4BQDJLqoH1AmtS/yhFytrYhsGLR7goEJvB+Dy
 AVtIZsHOLO8L/CGC215FPGg6jvxD4Z4rCTKG5EcJqOUw/QicqizKHJpMKsD+dM1EC+VH
 gljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376844; x=1690968844;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ROQCGlSC6AnDuwaP5/t6ykOjmMWyt+Cj7Kaaz8iJcJ4=;
 b=YE7cl2VbciYJ1ccyf9+KHpyCI79St71aMXIXHdnLQNmg/eSUHT+cK6H00RMR/hpBNw
 uYEIvO4awdAFCpNqaHIj5hoJc8uebE9P0+bzHk0GOVHmPUp5HoF8DCKZ37oA6czzXLkw
 Ifw37KhDEtCHjwwLuexSAiFslGek+Z5vSN7G89CPwC43F7KoWj5zx9hL9RRqJKaevQBr
 L+Vt4gVq5HtySMz77zNbXjnwMZYvU3mTgb9UFMEIVktGyywC3p9UEgBUGCuXkJgJWePD
 9Chwa6O0c7ViAvC4fejpvMFFPMssi1sKo9o5jzo0ActG5XabKaVVaB15loGv4T/Rr1+V
 rmYA==
X-Gm-Message-State: AC+VfDyn+bVEBPOHiovQnvIKdzmVRtomx0uXek4HY3mDcZQzUMYhlXDx
 G/Ks/sZx7wvitlrnv4xvtJJdag==
X-Google-Smtp-Source: ACHHUZ46ZZAJulszVqVZCFgrsZZXyUVbMN5I2CmnpcwnBmeL5sBcPu0CJ+SpB0eFtOA36PYPbQrfhQ==
X-Received: by 2002:a5d:4244:0:b0:313:e88d:e6d3 with SMTP id
 s4-20020a5d4244000000b00313e88de6d3mr12918579wrr.14.1688376843650; 
 Mon, 03 Jul 2023 02:34:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a5d4145000000b00314145e6d61sm11191803wrq.6.2023.07.03.02.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:34:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DC0AA1FFBB;
 Mon,  3 Jul 2023 10:34:02 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-6-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/24] linux-user: Split TARGET_PROT_* out of
 syscall_defs.h
Date: Mon, 03 Jul 2023 10:32:51 +0100
In-reply-to: <20230630132159.376995-6-richard.henderson@linaro.org>
Message-ID: <87bkgtjq45.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Move the values into the per-target target_mman.h headers
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/target_mman.h |  3 +++
>  linux-user/generic/target_mman.h |  4 ++++
>  linux-user/mips/target_mman.h    |  2 ++
>  linux-user/syscall_defs.h        | 11 -----------
>  linux-user/xtensa/target_mman.h  |  2 ++
>  5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target=
_mman.h
> index e7ba6070fe..7f15cab25e 100644
> --- a/linux-user/aarch64/target_mman.h
> +++ b/linux-user/aarch64/target_mman.h
> @@ -1 +1,4 @@
> +#define TARGET_PROT_BTI         0x10
> +#define TARGET_PROT_MTE         0x20
> +
>  #include "../generic/target_mman.h"
> diff --git a/linux-user/generic/target_mman.h b/linux-user/generic/target=
_mman.h
> index 7b888fb7f8..39a650e751 100644
> --- a/linux-user/generic/target_mman.h
> +++ b/linux-user/generic/target_mman.h
> @@ -1,6 +1,10 @@
>  #ifndef LINUX_USER_TARGET_MMAN_H
>  #define LINUX_USER_TARGET_MMAN_H
>=20=20
> +#ifndef TARGET_PROT_SEM
> +#define TARGET_PROT_SEM                 0x08
> +#endif
> +

I wonder if it is worth adding some commentary at the top that this file
should only be included from the arch specific target_mman.h as there is
an implicit ordering requirement for #ifndef to work properly.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

