Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 315267460E2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMap-0005ol-Ge; Mon, 03 Jul 2023 12:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGMak-0005oT-U9
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:39:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGMaj-0007nR-5V
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:39:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so38681235e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688402395; x=1690994395;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiZheLpwNmDSPb4knFjoSaP+cF3qjrBpVM/dKhWdaNY=;
 b=CaTmuV43b1rt3ggD2KLBT4sgcnlIHaDyCMzuR7d1afuyL2KoP9h5QPMHT0JF9ELpfO
 uPJq8hrrYGRf2rdyh3rG1OfFMHHzfMtYx/UF+9v8JzHJamD1TFF+LFwpSC2nQhrkx6y7
 6UlbbrdwC9O3GLOdfxFxf6qHJQ+v1oUtgyO/kFeMD05E55Zc/tU3O9+geMQo5AKlZxAy
 Fk2HmTU5D2JacWwvy2fS6p32ZUveSsBQDCkv3qylVoDBJKjp95dh8D9FFKD9KXGT4mW3
 MMY/O1ZVJA6e5oGETU4+KPB32Q74dNYDetFp7MrRW6YcED1W235VExBnXI51mgW4Lszt
 xB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688402395; x=1690994395;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PiZheLpwNmDSPb4knFjoSaP+cF3qjrBpVM/dKhWdaNY=;
 b=MPM0lKFkkIx7Jd6knxr1dXL89IhQEmzSsrRUaE2WYT05zoKzVGMGdZg1EuwtzRVxKJ
 tTbYxPCsw3eyjzDxoGtWeXlp9VwwrpX542EJ8AG/8XZDuOiUXXafiIcmd9aCcBCt+xX3
 oEaY1hpATJ2Lyj8YavnxKVlU4RYS4IyD2TxFzFbEXyF8IEVNK0de76iEb/FhrV3D6ZJy
 5DG/NrR424Qj8UIP5+VnaHcHoKZ1g1c5SMPEvgx12kA5lK2YDV30IbSy9rdSKpXukdB6
 Nh8EKfQFN92WW7QRKMYV2T4wxunumZzFb/JHEke+/XJInR1g9Pn4bMJnJ7SZTqhpdDoS
 czVg==
X-Gm-Message-State: AC+VfDyv8NKyJJDP1INpA7Jdua7/Mo4HXxdXDBrEv/qz6gLLpD+57wKZ
 ZQvHnnpcHNtD21fTVBjXrDBbX86ytnJl5ci2Ruc=
X-Google-Smtp-Source: ACHHUZ7SCnM72YagSYV1fWbd5kkrbcn4TIzWFBDsejHUfl1/TJhX6VynniC/rcX1sXNwR0A2v6IXYg==
X-Received: by 2002:a05:600c:4196:b0:3fa:ef97:1fa5 with SMTP id
 p22-20020a05600c419600b003faef971fa5mr14704699wmh.6.1688402395478; 
 Mon, 03 Jul 2023 09:39:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a05600c214e00b003f605566610sm14800258wml.13.2023.07.03.09.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 09:39:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 896391FFBB;
 Mon,  3 Jul 2023 17:39:54 +0100 (BST)
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
 <20230625212707.1078951-5-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v3 04/10] linux-user: Implement envlist_appendenv
Date: Mon, 03 Jul 2023 17:38:55 +0100
In-reply-to: <20230625212707.1078951-5-fufuyqqqqqq@gmail.com>
Message-ID: <87ilb1gd9h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
>  util/envlist.c         | 61 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
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
> diff --git a/util/envlist.c b/util/envlist.c
> index db937c0427..635c9c4fab 100644
> --- a/util/envlist.c
> +++ b/util/envlist.c
> @@ -201,6 +201,67 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
>      return (0);
>  }
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
> +        return (EINVAL);

No () around the EINVAL needed here.

> +    }
> +
> +    /* find out first equals sign in given env */
> +    eq_sign =3D strchr(env, '=3D');
> +    if (eq_sign =3D=3D NULL) {
> +        return (EINVAL);
> +    }
> +
> +    if (strchr(eq_sign + 1, '=3D') !=3D NULL) {
> +        return (EINVAL);
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

We really should add something to tests/unit/test-env to check the
various operations work as expected.


>  /*
>   * Returns given envlist as array of strings (in same form that
>   * global variable environ is).  Caller must free returned memory


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

