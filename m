Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84F908ACB
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jun 2024 13:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI562-0000PE-TR; Fri, 14 Jun 2024 07:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI55z-0000Og-K2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:27:51 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI55x-0003uq-O7
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:27:51 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a6f3efa1cc7so538075366b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364468; x=1718969268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZ1h6BeOohe7AYMx72y+6B8RNjrQAIM6siTTy4NaYy8=;
 b=CQLFz979cSTb6nyn6unxNpFFbNN8lyy+pYj5vnej4VvzFFnLBUH+CI5X8VAAhf+AU9
 9DFDYfChrQc15AWIu7D3KBFAouHFVfUOhYs9T3a6slAKL0rstLFtGffLo1hxCMGFS9GR
 HsEFXY/1IDKAER5mgPqhgTqKZyA5JoJkhq9tXF1KP52iAOhrGYVBStxsp2FzZo5UxapK
 Wnyy7NN4ZxEs7KJpoxY3XeF6pZVNyFghS/JC5JuXRiYHXaOsv/pThEKWKIc432d6KLwD
 aNFlIUdTTAToZdmdD4Os8qgmOTObHX6HFc9yXrvJ7Xp7CWm35YxbZVeQ/fhP5+uq4AGX
 IjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364468; x=1718969268;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZ1h6BeOohe7AYMx72y+6B8RNjrQAIM6siTTy4NaYy8=;
 b=jhcE2qaBejKk2/gK/eL9HFanMUL596U4pHvQcNUjGoih1Exdhm+BCp/+AHw4VqZVhw
 AB3js55K22vmcDfMbck5rzryNMcZGA/M4bi/l3apAbeBaO/pRxvEclb/fnPvsCC1umMK
 J2bz4wfWa8/ZonIu+0cuV/DKhgJkdUYzmrCPPTy1nacaBa7Vt4zHdQeR9yytQj8zd4WU
 WIOnuWiRmPWquScoLFNRBFk6Dyue6Sd0Lfp001Ej13b6AVI0eQLryEznN0hd5TrQp7cq
 5CAk8njEf5y4Dxg4S2ijVyoNqadFby8N/9o1GWioiE7guKCaFhjncd8CMlIPwlgXFzJY
 /98Q==
X-Gm-Message-State: AOJu0Yxu3JVeOMmgZv8rTg1WtncjUiw5JaxbKSo8+WBXs+WxMf0p7maF
 2qaHksuup9N0dCYWclq41yFBL+xzRrj2o/On7j+qHH4W8OGUmLHMO/1P4iias/o=
X-Google-Smtp-Source: AGHT+IGQayWjKf5trJ9U0Jnxm11j2RgPipDfBvSQLzDeG5ptbUKQZeMrguty6KprQLb5lCk52PUIhA==
X-Received: by 2002:a17:907:971f:b0:a6f:1464:e1ef with SMTP id
 a640c23a62f3a-a6f52474275mr451967566b.31.1718364467847; 
 Fri, 14 Jun 2024 04:27:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed34b0sm174327766b.101.2024.06.14.04.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:27:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 299675F794;
 Fri, 14 Jun 2024 12:27:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 3/9] gdbstub: Add support for target-specific stubs
In-Reply-To: <20240613172103.2987519-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:20:57 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-4-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:27:47 +0100
Message-ID: <871q4zvk5o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Currently, it's not possible to have stubs specific to a given target,
> even though there are GDB features which are target-specific, like, for
> instance, memory tagging.
>
> This commit introduces gdb_extend_qsupported_features,
> gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
> to extend the qSupported string, the query handler table, and the set
> handler table, allowing target-specific stub implementations.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  gdbstub/gdbstub.c          | 59 ++++++++++++++++++++++++++++++++++----
>  include/gdbstub/commands.h | 22 ++++++++++++++
>  2 files changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 9ff2f4177d..e69cc5131e 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1609,6 +1609,12 @@ static void handle_query_thread_extra(GArray *para=
ms, void *user_ctx)
>      gdb_put_strbuf();
>  }
>=20=20
> +static char *extended_qsupported_features;
> +void gdb_extend_qsupported_features(char *qsupported_features)
> +{

Maybe g_assert(!extended_qsupported_features)?

> +    extended_qsupported_features =3D qsupported_features;
> +}
> +
>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
>      CPUClass *cc;
> @@ -1648,6 +1654,11 @@ static void handle_query_supported(GArray *params,=
 void *user_ctx)
>      }
>=20=20
>      g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiproc=
ess+");
> +
> +    if (extended_qsupported_features) {
> +        g_string_append(gdbserver_state.str_buf, extended_qsupported_fea=
tures);
> +    }
> +
>      gdb_put_strbuf();
>  }
>=20=20
> @@ -1729,6 +1740,14 @@ static const GdbCmdParseEntry gdb_gen_query_set_co=
mmon_table[] =3D {
>      },
>  };
>=20=20
> +static GdbCmdParseEntry *extended_query_table;
> +static int extended_query_table_size;
> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
> +{

g_assert(!extended_query_table)

> +    extended_query_table =3D table;
> +    extended_query_table_size =3D size;
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_query_table[] =3D {
>      {
>          .handler =3D handle_query_curr_tid,
> @@ -1821,6 +1840,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[=
] =3D {
>  #endif
>  };
>=20=20
> +static GdbCmdParseEntry *extended_set_table;
> +static int extended_set_table_size;
> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
> +{
> +    extended_set_table =3D table;
> +    extended_set_table_size =3D size;
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_set_table[] =3D {
>      /* Order is important if has same prefix */
>      {
> @@ -1859,11 +1886,21 @@ static void handle_gen_query(GArray *params, void=
 *user_ctx)
>          return;
>      }
>=20=20
> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> -                            gdb_gen_query_table,
> -                            ARRAY_SIZE(gdb_gen_query_table))) {
> -        gdb_put_packet("");
> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           gdb_gen_query_table,
> +                           ARRAY_SIZE(gdb_gen_query_table))) {
> +        return;
> +    }
> +
> +    if (extended_query_table &&
> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           extended_query_table,
> +                           extended_query_table_size)) {
> +        return;
>      }
> +
> +    /* Can't handle query, return Empty response. */
> +    gdb_put_packet("");
>  }
>=20=20
>  static void handle_gen_set(GArray *params, void *user_ctx)
> @@ -1878,11 +1915,21 @@ static void handle_gen_set(GArray *params, void *=
user_ctx)
>          return;
>      }
>=20=20
> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>                             gdb_gen_set_table,
>                             ARRAY_SIZE(gdb_gen_set_table))) {
> -        gdb_put_packet("");
> +        return;
>      }
> +
> +    if (extended_set_table &&
> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           extended_set_table,
> +                           extended_set_table_size)) {
> +        return;
> +    }
> +
> +    /* Can't handle set, return Empty response. */
> +    gdb_put_packet("");
>  }
>=20=20
>  static void handle_target_halt(GArray *params, void *user_ctx)
> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
> index dd45c38472..2204c3ddbe 100644
> --- a/include/gdbstub/commands.h
> +++ b/include/gdbstub/commands.h
> @@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
>   */
>  int gdb_put_packet(const char *buf);
>=20=20
> +/**
> + * gdb_extend_query_table() - Extend query table.
> + * @table: The table with the additional query packet handlers.
> + * @size: The number of handlers to be added.
> + */
> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
> +
> +/**
> + * gdb_extend_set_table() - Extend set table.
> + * @table: The table with the additional set packet handlers.
> + * @size: The number of handlers to be added.
> + */
> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
> +
> +/**
> + * gdb_extend_qsupported_features() - Extend the qSupported features str=
ing.
> + * @qsupported_features: The additional qSupported feature(s) string. Th=
e string
> + * should start with a semicolon and, if there are more than one feature=
, the
> + * features should be separate by a semiocolon.
> + */
> +void gdb_extend_qsupported_features(char *qsupported_features);
> +

We should make it clear these functions should only be called once
(although I guess in a heterogeneous future we might have to do something
more clever).

>  #endif /* GDBSTUB_COMMANDS_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

