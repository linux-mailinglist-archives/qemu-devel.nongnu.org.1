Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA572C5FC
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hcq-0001Yg-6L; Mon, 12 Jun 2023 09:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hcF-0001HV-DC
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:29:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hcC-0003v1-Pk
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:29:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f730c1253fso32191695e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686576584; x=1689168584;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAMQoHZxfYMqcnfieTtCppnl0NUwfjitoGqUvmdMOvk=;
 b=Z7ngyV80G/HZBUnADXDwohHvUjxCTV+W9gP3gh/T0eQ6mtPBEsEjjXtMNPn9OviORp
 ZkrH/y/Ofm7BtigUL5oAVUF/BKXdF68SbSC0l4j3bxZJH7e3a/7ahHe2SuhG6Q9xELbS
 rjGX9UMT9d1VIzdIiRcntri1fAPD0qf/Tja87oO1dsoi6/Ej4cyeE01A+OW9PkEZt2Pu
 q3dXvGiIq+/En392SyzJYbwhCgGp/a02IjnMfnuESXisnNU+iPPUAJxS5tMxX8CNZ74z
 inXao+rbo9yz1LGZgyIYkHte/97hYnx0Ha6wwgy8W4N32BD8W/zWZis1XDmp/eJIChFv
 X3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686576584; x=1689168584;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jAMQoHZxfYMqcnfieTtCppnl0NUwfjitoGqUvmdMOvk=;
 b=NPFdsEkhPPb9g9mm+ViWE7eXcxIbefqY7+7BLZURQ6AyZY1VcIxhzyHQvd1DzLW3gB
 gD4QKS0l0L8I9N1nPDijRnoZGaKaqvK86a6J1oLQlCX8Z14HF0HM0stgrJ/9cAPRjGOL
 64JMXMUjOr5U7OfE3b7fC2H84y6QhmXG0BSHQpnSKBi9nCOK90BJeIC722vDwoq8MyJj
 QNvrpEK7sygyTLWJGsuSLI2Bb+PT2KygOxwoPXCog0tpLQSvxh/Om0UCMrHA2DvqUO0m
 e8KVnhftA+63vljiJxeHuXYmMrxXZZ/gbPavCgyr5PA+0seAsplSRmoZVUefK5lqmX30
 vd7w==
X-Gm-Message-State: AC+VfDziGCMFwu4Qgjv3A+Nh2HLZ8PvjRnTvvz1SUiYOSUz0EVr6BXDi
 fGGLqGb9Ly9akahAkMFMjpmfJQ==
X-Google-Smtp-Source: ACHHUZ6rC53bNdVLgzZhGOaQlTaCFE99efAqv+VHZm3hoeEo0nt52M56qSZ65MhX6wXnNTwwHu3jLA==
X-Received: by 2002:a05:600c:2212:b0:3f7:865d:ce63 with SMTP id
 z18-20020a05600c221200b003f7865dce63mr6311042wml.21.1686576584455; 
 Mon, 12 Jun 2023 06:29:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a05600c290c00b003f7e653c3e3sm11475045wmd.21.2023.06.12.06.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:29:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F87D1FFBB;
 Mon, 12 Jun 2023 14:29:43 +0100 (BST)
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [RFC v2 6/6] linux-user: Add '-native-bypass' option
Date: Mon, 12 Jun 2023 14:23:04 +0100
In-reply-to: <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
Message-ID: <874jnc7qrc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  include/qemu/envlist.h |  1 +
>  linux-user/main.c      | 23 +++++++++++++++++
>  util/envlist.c         | 56 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>
> diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
> index 6006dfae44..865eb18e17 100644
> --- a/include/qemu/envlist.h
> +++ b/include/qemu/envlist.h
> @@ -7,6 +7,7 @@ envlist_t *envlist_create(void);
>  void envlist_free(envlist_t *);
>  int envlist_setenv(envlist_t *, const char *);
>  int envlist_unsetenv(envlist_t *, const char *);
> +int envlist_appendenv(envlist_t *, const char *, const char *);
>  int envlist_parse_set(envlist_t *, const char *);
>  int envlist_parse_unset(envlist_t *, const char *);
>  char **envlist_to_environ(const envlist_t *, size_t *);
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 5e6b2e1714..313c116b3b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -125,6 +125,8 @@ static void usage(int exitcode);
>  static const char *interp_prefix =3D CONFIG_QEMU_INTERP_PREFIX;
>  const char *qemu_uname_release;
>=20=20
> +static const char *native_lib;
> +
>  #if !defined(TARGET_DEFAULT_STACK_SIZE)
>  /* XXX: on x86 MAP_GROWSDOWN only works if ESP <=3D address + 32, so
>     we allocate a bigger stack. Need a better solution, for example
> @@ -293,6 +295,13 @@ static void handle_arg_set_env(const char *arg)
>      free(r);
>  }
>=20=20
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)

CONFIG_USER_ONLY is a pointless check as by definition this file is
user-mode only.

> +static void handle_arg_native_bypass(const char *arg)
> +{
> +    native_lib =3D arg;

canonicalise the path and maybe verify it exists/is accessible?

> +}
> +#endif
> +
>  static void handle_arg_unset_env(const char *arg)
>  {
>      char *r, *p, *token;
> @@ -522,6 +531,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)

see above re CONFIG_USER_ONLY.

> +    {"native-bypass", "QEMU_NATIVE_BYPASS", true, handle_arg_native_bypa=
ss,
> +     "",           "native bypass for library calls in user mode only."},
> +#endif
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>=20=20
> @@ -826,6 +839,16 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>=20=20
> +    /* Set the library for native bypass  */
> +    if (native_lib !=3D NULL) {
> +        char *token =3D malloc(strlen(native_lib) + 12);
> +        strcpy(token, "LD_PRELOAD=3D");
> +        strcat(token, native_lib);
> +         if (envlist_appendenv(envlist, token, ":") !=3D 0) {
> +            usage(EXIT_FAILURE);
> +        }
> +    }
> +
>      target_environ =3D envlist_to_environ(envlist, NULL);
>      envlist_free(envlist);
>=20=20
> diff --git a/util/envlist.c b/util/envlist.c
> index db937c0427..713d52497e 100644
> --- a/util/envlist.c
> +++ b/util/envlist.c
> @@ -201,6 +201,62 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
>      return (0);
>  }
>

I think adding this function should be a separate commit. It would be
nice to add some unittests for the functionality while we are at it.

> +/*
> + * Appends environment value to envlist. If the environment
> + * variable already exists, the new value is appended to the
> + * existing one.
> + *
> + * Returns 0 in success, errno otherwise.
> + */
> +int
> +envlist_appendenv(envlist_t *envlist, const char *env, const char *separ=
ator)
> +{
> +    struct envlist_entry *entry =3D NULL;
> +    const char *eq_sign;
> +    size_t envname_len;
> +
> +    if ((envlist =3D=3D NULL) || (env =3D=3D NULL)) {
> +        return (EINVAL);
> +    }
> +
> +    /* find out first equals sign in given env */
> +    eq_sign =3D strchr(env, '=3D');
> +    if (eq_sign =3D=3D NULL) {
> +        return (EINVAL);
> +    }
> +    envname_len =3D eq_sign - env + 1;
> +
> +    /*
> +     * If there already exists variable with given name,
> +     * we append the new value to the existing one.
> +     */
> +    for (entry =3D envlist->el_entries.lh_first; entry !=3D NULL;
> +        entry =3D entry->ev_link.le_next) {
> +        if (strncmp(entry->ev_var, env, envname_len) =3D=3D 0) {
> +            break;
> +        }
> +    }
> +
> +    if (entry !=3D NULL) {
> +        char *new_env_value =3D NULL;
> +        size_t new_env_len =3D strlen(entry->ev_var) + strlen(eq_sign)
> +            + strlen(separator) + 1;
> +        new_env_value =3D g_malloc(new_env_len);
> +        strcpy(new_env_value, entry->ev_var);
> +        strcat(new_env_value, separator);
> +        strcat(new_env_value, eq_sign + 1);

See other comments about string functions.

> +        g_free((char *)entry->ev_var);
> +        entry->ev_var =3D new_env_value;
> +    } else {
> +        envlist->el_count++;
> +        entry =3D g_malloc(sizeof(*entry));
> +        entry->ev_var =3D g_strdup(env);
> +        QLIST_INSERT_HEAD(&envlist->el_entries, entry, ev_link);
> +    }
> +
> +    return (0);
> +}
> +
>  /*
>   * Returns given envlist as array of strings (in same form that
>   * global variable environ is).  Caller must free returned memory


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

