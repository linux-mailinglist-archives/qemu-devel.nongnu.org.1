Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AFB776469
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlSn-00053r-Tu; Wed, 09 Aug 2023 11:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTlSl-00053Q-P4
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:51:07 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTlSk-00071b-2E
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:51:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-317744867a6so17366f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691596264; x=1692201064;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+dif+GT8wBdIzKIRtXzL5kS3BIRSBm8PjdMulAt0Z8=;
 b=es7b2S9SjiPFmWltx115jWh2NqhmWqkaszA/G0IhzlUfDtkntrNvMOr0RafxV5J7vI
 +JLOYP9UJm/6KhXkCt58QJGbdtcN1UE1ALILj4pdo8OY+NWNpRKeO5jQcKOWZKiyzNWb
 ndDuUHDJHF2VM7ft5QrMF39KCMhOkuP/wZtT5FKh2FMcQ7eYVcz54ZxaGSbNmfBRvlBT
 lbnvPRUE6PRX/r74ZfTtoCFQGl2qHav6dRPafuOcXLKADf2tbqWDsvtB+yLicTCJ2nYg
 BzOLbErzS9dHdVFWvbABaUA8S1vgsqEkrpg2K5Z9S0PYFZS/Jhq1PxemmGQEGV5QXEYc
 SsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691596264; x=1692201064;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f+dif+GT8wBdIzKIRtXzL5kS3BIRSBm8PjdMulAt0Z8=;
 b=UwRPLPTsQXuMNHEHl6VEeXBsr1G95e9ES13/Wsvw6qQdnZTuwFF1O2vPPH/DLOj8VW
 wya6mxQlshAXH7RsoG+GXgZJD7UNpSWHYD598HVv18QlX5qx9BEBYvAt6JhZV7XbcBpx
 grQlLVYrX3vN/jRPArPR/h4pCnhnK8x4y4ZJOm2cfvJYyo+2TqZe0LFAEJzR6NhxAYKq
 wFayWidx22brAxbVCkQ7bIT5kn4pnC5Woi/o4yK4mWpfzvhymS7nNz19Qzh5ZsmoVL0b
 YjUShLfYqOFjhNP+KRc6ic8+3N2uDotoToEe7fx4VYbc0SBBfvVQ58BOJ4EcB7UZF7Nv
 /g7w==
X-Gm-Message-State: AOJu0Yw2Js2g1NWrwqxFqtTOS//I8BLJTnq4xWs7mevOLPAdhzK02X3T
 ExKQtQLbmTV98dxEcHPyRa+/pg==
X-Google-Smtp-Source: AGHT+IEmPNwti7l4OfRZq4n8hEntqBc4Rjrk3NjSD+mc8MTyWa3veMPRSYVhNqPpcz4q+UUZKbcH3A==
X-Received: by 2002:adf:f608:0:b0:317:7441:1a4 with SMTP id
 t8-20020adff608000000b00317744101a4mr2344187wrp.29.1691596264182; 
 Wed, 09 Aug 2023 08:51:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c211200b003fbb0c01d4bsm2331657wml.16.2023.08.09.08.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:51:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 703D91FFBB;
 Wed,  9 Aug 2023 16:51:03 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-5-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [RFC v4 04/11] linux-user: Implement native-bypass option support
Date: Wed, 09 Aug 2023 16:47:26 +0100
In-reply-to: <20230808141739.3110740-5-fufuyqqqqqq@gmail.com>
Message-ID: <87h6p843ko.fsf@linaro.org>
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> This commit implements the -native-bypass support in linux-user. The
> native_calls_enabled() function can be true only when the
> '-native-bypass' option is given.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  include/native/native.h |  9 +++++++++
>  linux-user/main.c       | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 include/native/native.h
>
> diff --git a/include/native/native.h b/include/native/native.h
> new file mode 100644
> index 0000000000..62951fafb1
> --- /dev/null
> +++ b/include/native/native.h
> @@ -0,0 +1,9 @@
> +/*
> + * Check if the native bypass feature is enabled.
> + */
> +#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
> +extern char *native_lib_path;
> +#define native_bypass_enabled() native_lib_path ? true : false
> +#else
> +#define native_bypass_enabled() false
> +#endif
> diff --git a/linux-user/main.c b/linux-user/main.c
> index dba67ffa36..86ea0191f7 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -60,6 +60,11 @@
>  #include "semihosting/semihost.h"
>  #endif
>=20=20
> +#if defined(CONFIG_NATIVE_CALL)
> +#include "native/native.h"
> +char *native_lib_path;
> +#endif
> +
>  #ifndef AT_FLAGS_PRESERVE_ARGV0
>  #define AT_FLAGS_PRESERVE_ARGV0_BIT 0
>  #define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
> @@ -293,6 +298,17 @@ static void handle_arg_set_env(const char *arg)
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
> +    native_lib_path =3D strdup(arg);

Although we never free this the coding style states:

  Because of the memory management rules, you must use g_strdup/g_strndup
  instead of plain strdup/strndup.

We do still have a few legacy strdup's to eliminate from the code base
though.

> +}
> +#endif
> +
>  static void handle_arg_unset_env(const char *arg)
>  {
>      char *r, *p, *token;
> @@ -522,6 +538,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +#if defined(CONFIG_NATIVE_CALL)
> +    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypa=
ss,
> +     "",           "native bypass for library calls in user mode only."},
> +#endif

You can drop " in user mode only" because this help text will only show
up on linux-user binaries with support for native bypass.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

