Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3387FDBF4
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 16:51:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8MqX-0007br-R5; Wed, 29 Nov 2023 10:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8MqS-0007bJ-5X
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:51:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8MqO-000204-Au
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 10:51:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso55695225e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701273078; x=1701877878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oi840bZPsJnJDsYEmDQY5jS5eVekW5E5cE4qxTKZSpE=;
 b=NPRnP2Aa3G7aB5VslQ35ujXZ5USGCAMrvQSC9rzW6Elnpp4psGOBT2k7Pr70A7Ut7c
 oim2y0C3FrwSuK7GORPr1uNseJ/hDMMRhm9XLYdBIAGgJvXI/z3AxjJHkSo2kkPm6wWE
 cGoFyZlQcktttPaxzClx9pJrF1XULMna+Nc54hqX5PNcukBbeto00p3Rm3mlj248IlVA
 AE9W34bH7T9EZQzlXrRGATvATA/CpoaLaWqSF7BeoQIcB/lERgvY8fy5MYlV3E7WTCRf
 k8MTsQcyYdtTkBdU5l//SyucOKCDqXZJ/lImzXSR6i48oItH6UyWa/FSRiMylEQcG4jm
 WhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701273078; x=1701877878;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oi840bZPsJnJDsYEmDQY5jS5eVekW5E5cE4qxTKZSpE=;
 b=Qizg8gQJQAdqcSm5fmJC2jzKrrPpWBrKG6uk7HAPGeQn3zfIaADeGJmLdk0RtxqNDN
 pLvBvKNRs5JS02V2iPM9oAoOa/5BpyCjA7eEetqwzJUo4rJEK59yGtYtGqgXll9yovov
 ti/dM4t7cNG2YNXISpLhBgZVzhjkXFK1k78QTJiGoPPFu+1xtJz01vGd6Ln8bdQjV+pK
 wA+4NMZoGTFesO17bvvRVkBW4GlSg6vhqulEb0KVSq6C+6p1IdI74bqnFsw1snJDJXtE
 ht7O0NHnqD9FJ0UOtfCDVRe11V+RXLX2zJoz9fw6/RSxRIcxkeP0KvpBs/OrhTfPEKfT
 JXIA==
X-Gm-Message-State: AOJu0YzR9baC9G/DU+x5reICfOf2GDYvXLidDgvTogTDxc2+P7czs9fR
 pEQV4isBUEt+HTSDRE4D1k/kjA==
X-Google-Smtp-Source: AGHT+IHVKMO+WNszJ7VWWB/6jF4QzUyF2fy6LfFm3oz1np7ooZKEeSb/4zk85emyLIW3Cn/Xfvgi1g==
X-Received: by 2002:a05:600c:470f:b0:40b:37ef:3671 with SMTP id
 v15-20020a05600c470f00b0040b37ef3671mr14989844wmo.38.1701273078039; 
 Wed, 29 Nov 2023 07:51:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i5-20020adfe485000000b0033300a0b444sm9039313wrm.66.2023.11.29.07.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 07:51:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43A3D5F7AF;
 Wed, 29 Nov 2023 15:51:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 03/20] gdbstub: moving code so that it can be easier
 accessed from outside the gdbstub: fromhex and tohex functions moved to a
 cutils header. GDBRegisterState moved to gdbstub.h
In-Reply-To: <20231107130323.4126-4-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:06 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
 <20231107130323.4126-4-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 15:51:17 +0000
Message-ID: <87jzq0a77u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> ---
>  gdbstub/gdbstub.c      |  9 +--------
>  gdbstub/internals.h    | 26 --------------------------
>  include/cutils.h       | 30 ++++++++++++++++++++++++++++++
>  include/exec/gdbstub.h |  9 ++++++++-

Please split into the utils and the reg state patches as they are unrelated.

>  4 files changed, 39 insertions(+), 35 deletions(-)
>  create mode 100644 include/cutils.h
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 1e96a71c0c..c43ff89393 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -44,14 +44,7 @@
>  #include "exec/hwaddr.h"
>=20=20
>  #include "internals.h"
> -
> -typedef struct GDBRegisterState {
> -    int base_reg;
> -    int num_regs;
> -    gdb_get_reg_cb get_reg;
> -    gdb_set_reg_cb set_reg;
> -    const char *xml;
> -} GDBRegisterState;
> +#include "cutils.h"
>=20=20
>  GDBState gdbserver_state;
>=20=20
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 465c24b36e..011e6f1858 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -74,32 +74,6 @@ typedef struct GDBState {
>  /* lives in main gdbstub.c */
>  extern GDBState gdbserver_state;
>=20=20
> -/*
> - * Inline utility function, convert from int to hex and back
> - */
> -
> -static inline int fromhex(int v)
> -{
> -    if (v >=3D '0' && v <=3D '9') {
> -        return v - '0';
> -    } else if (v >=3D 'A' && v <=3D 'F') {
> -        return v - 'A' + 10;
> -    } else if (v >=3D 'a' && v <=3D 'f') {
> -        return v - 'a' + 10;
> -    } else {
> -        return 0;
> -    }
> -}
> -
> -static inline int tohex(int v)
> -{
> -    if (v < 10) {
> -        return v + '0';
> -    } else {
> -        return v - 10 + 'a';
> -    }
> -}
> -
>  /*
>   * Connection helpers for both system and user backends
>   */
> diff --git a/include/cutils.h b/include/cutils.h
> new file mode 100644
> index 0000000000..a6b8dc3690
> --- /dev/null
> +++ b/include/cutils.h
> @@ -0,0 +1,30 @@
> +#ifndef CUTILS_H
> +#define CUTILS_H

We already have include/qemu/cutils.h where I think these can go.

> +
> +/*
> + * Inline utility function, convert from int to hex and back
> + */

Becoming common util functions they could do with a little cleaning up
before wider use.

  - kdoc comment string
  - rename to be clearer, maybe:
    - hexchar_to_nibble
    - nibble_to_hexchar
=20=20=20=20

> +
> +static inline int fromhex(int v)


> +{
> +    if (v >=3D '0' && v <=3D '9') {
> +        return v - '0';
> +    } else if (v >=3D 'A' && v <=3D 'F') {
> +        return v - 'A' + 10;
> +    } else if (v >=3D 'a' && v <=3D 'f') {
> +        return v - 'a' + 10;
> +    } else {
> +        return 0;

g_assert_not_reached()? or document invalid chars are squashed to 0

> +    }
> +}
> +
> +static inline int tohex(int v)
> +{

g_assert(v =3D< 0xf)

> +    if (v < 10) {
> +        return v + '0';
> +    } else {
> +        return v - 10 + 'a';
> +    }
> +}
> +
> +#endif /* CUTILS_H */
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index f696e29477..cb70ebd7b4 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -15,11 +15,18 @@ typedef struct GDBFeature {
>      const char *xml;
>  } GDBFeature;
>=20=20
> -
>  /* Get or set a register.  Returns the size of the register.  */
>  typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int re=
g);
>  typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
>=20=20
> +typedef struct GDBRegisterState {
> +    int base_reg;
> +    int num_regs;
> +    gdb_get_reg_cb get_reg;
> +    gdb_set_reg_cb set_reg;
> +    const char *xml;
> +} GDBRegisterState;
> +
>  /**
>   * gdb_register_coprocessor() - register a supplemental set of registers
>   * @cpu - the CPU associated with registers

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

