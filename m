Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70721776445
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTlMR-0003aj-8I; Wed, 09 Aug 2023 11:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTlMP-0003Tz-65
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:44:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTlMN-0005jH-I0
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:44:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe5eb84d8bso25904045e9.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691595867; x=1692200667;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLTB+1VPg/WvrHLHsyG8lcGDXLT2VGB/G2e58SWtuA8=;
 b=h70SVg0SLKTSU/SACMjznT9LWvtP1bH1lAfWBEKT3YXJifCiS9uvtBaVvfPKzk7Mx9
 YqMkdvrN3ghXIR/CfxpAnrBWGxhZ8rdPBULAGIdWLIxbba/mWXA8LyMgJuUD0fBN9NhZ
 bHeCQLbIl8GWHZqan+nZ0LLEmBB5PR/A+kQm6pPsDkR6jaLv1RqOE7LIHagDuNoavNWz
 HvUOOlxkxHi4Y3XSz+BT1qC4eh6pbb59iColC5PCwzuhiz10XYJNZAcv3ZszIuA9XS71
 /mgQdhdEkPNeH2hsmeND8+YY9wIEsRsG5NyjHVgCCOu0mU/lGyd9Nno10WedAeo2bw9P
 xSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691595867; x=1692200667;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nLTB+1VPg/WvrHLHsyG8lcGDXLT2VGB/G2e58SWtuA8=;
 b=LYa6r2KOVBdGdirJdY/ombKdxBPsN2KmtR2oNmcFwvxdt/QAerNZeOfzQ1QcEp7ILA
 wprc2QNarjt/0GkHS+aUeAgq4bOz/CXjdFqFukJu222ZYrxyo0efwg2lsK3iEa4Ta9tG
 0oApk96A8R3lUXEwnQNwBzE8vArAEN4C7ciAl6PV5WDJMEJVFP021AcTKckSN0rXytZ2
 nfz1TY1eLJhwSZ+CeLuU1JAlEfJwM4h8ks/gec9I/FzYhwQ8c3PRQOhE1Q4K863+t8v4
 UIl2scUfvVQNb9m6lTR7wzxVr2TgG6CL15b2aJgMk7X8ebiKyR+el1JP/o+plUnmtxeH
 NTGw==
X-Gm-Message-State: AOJu0YwbNU6qYGhi9s472ay2olrlds8wZaTgEHpYr7JeGITgMUarm5NG
 y2QuqV+UJ8a8Qky0h38/HTDmDDho3nA9zyXtpmU=
X-Google-Smtp-Source: AGHT+IHsFPi9UWgt7ZOAGSfSU5J02PjqaUGxL+2/2A4FRa9pm6HWcLvGjie6YzkLCyW8L056nbOhBQ==
X-Received: by 2002:a05:600c:600a:b0:3fe:2b60:b24e with SMTP id
 az10-20020a05600c600a00b003fe2b60b24emr2521680wmb.29.1691595867519; 
 Wed, 09 Aug 2023 08:44:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a05600c0b4b00b003fe20db88ebsm2342480wmr.31.2023.08.09.08.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:44:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 996E41FFBB;
 Wed,  9 Aug 2023 16:44:26 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v4 03/11] linux-user: Implement envlist_appendenv and add
 tests for envlist
Date: Wed, 09 Aug 2023 16:27:49 +0100
In-reply-to: <20230808141739.3110740-4-fufuyqqqqqq@gmail.com>
Message-ID: <87leek43vp.fsf@linaro.org>
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

> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  include/qemu/envlist.h    | 13 ++++++
>  tests/unit/meson.build    |  1 +
>  tests/unit/test-envlist.c | 94 +++++++++++++++++++++++++++++++++++++++
>  util/envlist.c            | 71 ++++++++++++++++++++++++-----
>  4 files changed, 169 insertions(+), 10 deletions(-)
>  create mode 100644 tests/unit/test-envlist.c

Thanks for adding the unit test.
>=20=20
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
> +    if ((envlist =3D=3D NULL) || (env =3D=3D NULL) || (separator =3D=3D =
NULL)) {
> +        return -EINVAL;
> +    }
> +
> +    /* find out first equals sign in given env */
> +    eq_sign =3D strchr(env, '=3D');
> +    if (eq_sign =3D=3D NULL) {
> +        return -EINVAL;
> +    }
> +
> +    if (strchr(eq_sign + 1, '=3D') !=3D NULL) {
> +        return -EINVAL;
> +    }
> +
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
> +        g_free((char *)entry->ev_var);
> +        entry->ev_var =3D new_env_value;

You could probably avoid messing about with strlens if you used the
handy glib functions:

    if (entry !=3D NULL) {
        GString *new_val =3D g_string_new(entry->ev_var);
        g_string_append(new_val, separator);
        g_string_append(new_val, eq_sign + 1);
        g_free(entry->ev_var);
        entry->ev_var =3D g_string_free(new_val, false);
    } else {

Also the fact you needed to cast entry->ev_var to g_free() should have
pointed out that now we can change env entries we need to drop the const
from the char *ev_var; definition in envlist_entry.

Otherwise with those fixes:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

