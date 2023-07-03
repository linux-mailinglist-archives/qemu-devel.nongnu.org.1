Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4674625C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 20:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOGI-0005Pk-Tw; Mon, 03 Jul 2023 14:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGOGH-0005PZ-16
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:26:57 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGOGF-0007MB-Ad
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 14:26:56 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fbb281eec6so2071110e87.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 11:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688408813; x=1691000813;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ma3mia25UJ4wvtLBcluVor33HLoM7mUGPR3M7lrjj5Y=;
 b=Zx6X9BsHvHz6ZvpDp/HNrnHltzp/QIIsIXy51YM54yiRtkVeUvjUaMdP5ePQAm7ESn
 kvacng0gVI5Ry6nCvSNttuPdZyxq0FD8buuge14VYF6sli1r6slJpM8JP0Q0Aivvlf6Z
 C/Qd8UAI/BuC8uTyYxVOB4Tki4UxR3EoxtLc9dV0gIpiwmAYHa4qq4PP8xqlUvG9GYIF
 fNOwsNoteBLQ++MZRGmzSoeW96in4YZ3bQaJMJ614QIrK1JfeXAeNOdDrynBSiQH2PUQ
 0gS1wFSj4YPMWpPb+d8HSTQ1+l1RbQvhrA9/GRwS8qWVLO8Mw/alv91RtyqF3qPgUqHi
 g/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688408813; x=1691000813;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ma3mia25UJ4wvtLBcluVor33HLoM7mUGPR3M7lrjj5Y=;
 b=QPAVQjJMz0FwnsUJNO4XpCGnxcIj8DNiqtxmBeRjiTAaGjAAxy06RP3lDW0oGauNxf
 NvVReNzZTyC9m2KpKb/LpaNY57SK5JSzAC/EGomfcyP2ocY0KC9Gf6VZwR5T9xzq68UA
 5z2I+zJlSair81vamK/t/KVHMuqVbrep85BKCLniYqiigAy4O2NF5JEPmfZ6c782rRSm
 2pfdIPT/5GqTAoM1bsOI2NU/B4PaS/VBSWxqPjN8Ya9yqMxrNusYNhlW13xM22M4iTAj
 eNQwiFXH4wVu3vBkKKBrgVxdK+HslVn5goq5jMPq3ieRaBdbBF6jAtw32rvlV/DSBA+2
 ZRhg==
X-Gm-Message-State: ABy/qLZBCXWe5zuesGejucRukjSURvzQXuZ+rO6yxwITuvQ2hCWxVsGZ
 OD3OXRqn34Fqn5JdF6p48l7fRg==
X-Google-Smtp-Source: APBJJlFUvy4rkjD1pDsZnOOpu5x2/+mB3lrX0435xF3iTQT8/95sXy5adTjRjbfzSBFZoeQpyZg4ng==
X-Received: by 2002:a05:6512:20d0:b0:4fb:8ca8:c6e5 with SMTP id
 u16-20020a05651220d000b004fb8ca8c6e5mr6561533lfr.21.1688408813166; 
 Mon, 03 Jul 2023 11:26:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adfe303000000b0030fd03e3d25sm26271167wrj.75.2023.07.03.11.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 11:26:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 529BB1FFBB;
 Mon,  3 Jul 2023 19:26:52 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-6-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [RFC v3 05/10] linux-user: Implement native-bypass option support
Date: Mon, 03 Jul 2023 19:21:47 +0100
In-reply-to: <20230625212707.1078951-6-fufuyqqqqqq@gmail.com>
Message-ID: <87edlohmvn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

> This commit implements the -native-bypass support in linux-user. The
> native_calls_enabled() function can be true only when the
> '-native-bypass' option is given.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  linux-user/main.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 5e6b2e1714..98e31c77d5 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -60,6 +60,13 @@
>  #include "semihosting/semihost.h"
>  #endif
>=20=20
> +#if defined(CONFIG_NATIVE_CALL)
> +#include "native/native-defs.h"
> +
> +static const char *native_lib;
> +bool native_bypass_enabled;

This bool feels redundant if we can check for a non-null native-lib. You
could certainly expose a function though:

bool native_bypass_enabled() {
     return native_lib ? true : false;
}

?

> +#endif
> +
>  #ifndef AT_FLAGS_PRESERVE_ARGV0
>  #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
>  #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> @@ -125,6 +132,7 @@ static void usage(int exitcode);
>  static const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;
>  const char *qemu_uname_release;
>=20=20
> +

rm whitespace

>  #if !defined(TARGET_DEFAULT_STACK_SIZE)
>  /* XXX: on x86 MAP_GROWSDOWN only works if ESP <=3D address + 32, so
>     we allocate a bigger stack. Need a better solution, for example
> @@ -293,6 +301,18 @@ static void handle_arg_set_env(const char *arg)
>      free(r);
>  }
>=20=20
> +#if defined(CONFIG_NATIVE_CALL)
> +static void handle_arg_native_bypass(const char *arg)
> +{
> +    if (access(arg, F_OK) !=3D 0) {
> +        fprintf(stderr, "native library %s does not exist\n", arg);
> +        exit(EXIT_FAILURE);
> +    }
> +    native_lib =3D arg;
> +    native_bypass_enabled =3D true;
> +}
> +#endif
> +
>  static void handle_arg_unset_env(const char *arg)
>  {
>      char *r, *p, *token;
> @@ -522,6 +542,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +#if defined(CONFIG_NATIVE_CALL)
> +    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypa=
ss,
> +     "",           "native bypass for library calls in user mode only."},
> +#endif
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>=20=20
> @@ -826,6 +850,18 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>=20=20
> +#if defined(CONFIG_NATIVE_CALL)
> +    /* Set the library for native bypass  */
> +    if (native_bypass_enabled) {

Then this could be:

  if (native_lib && g_file_test(native_lib, G_FILE_TEST_EXITS)) {

Or maybe better:

 if (native_lib) {
    if (g_file_test(native_lib, G_FILE_TEST_EXITS)) {
       .. setup ..
    } else {
       fprintf(stderr, "can't open %s\n", native_lib);
       exit(EXIT_FAILURE);
    }
}

> +        GString *lib =3D g_string_new(native_lib);
> +        lib =3D g_string_prepend(lib, "LD_PRELOAD=3D");
> +        if (envlist_appendenv(envlist, g_string_free(lib, false), ":") !=
=3D 0) {
> +            fprintf(stderr,
> +                    "failed to append the native library to environment.=
\n");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +#endif
>      target_environ =3D envlist_to_environ(envlist, NULL);
>      envlist_free(envlist);


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

