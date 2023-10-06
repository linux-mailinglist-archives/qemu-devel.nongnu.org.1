Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7E07BBC49
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 18:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qonGV-0006co-M2; Fri, 06 Oct 2023 12:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qonGL-0006W3-K1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 12:01:16 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qonGK-00008a-01
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 12:01:13 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79fe8986355so89442339f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696608069; x=1697212869; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QqqquCfSDFfg92L0+J0JKRZg4IQoRB6PDgQiQM6LZnM=;
 b=ExoeRM4AyJK3YKiOmGQO8qQUDy3pNeFB4JT8V5aodylTja4UYYB/GI33zejFNJSObg
 4RIxtKLXn7vh2Pg3XQR/l8WeMGdMr0c/ToYeO2DEDMwRSa1bA9+7pjH65FLiBwFVH7XS
 ixz8tw31h0YRquLu87is8wpYOnyXp9EjrDcHUKSXfLWBpqWbPlM2znCWlKOGKh9+QYnd
 J3niLrWpcCGBRS0tqiv0XFt/MzUlaKA4Ud/HorPnCdHiZcc2rf4irXDd5lTmt4ieI9tb
 vEY7ireXB3gh/l6P1ETFmtjXhWCrG1z+nGQXfPFtauIq+c7M1pG8ctwvSK1TzfO8Om00
 vaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696608069; x=1697212869;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QqqquCfSDFfg92L0+J0JKRZg4IQoRB6PDgQiQM6LZnM=;
 b=sfJDsP/OpMFiFoCHO1+ga+Ep2FSBgStsDnBQeALaQn0tygBughkFI5m38oJHwD5aZs
 cdxkg1a333jD3o5uhjjsxV2EghIhNQ5qT32hFPc+Tc8e8U5UoxDRv/D6RacVaECZ0GCz
 VAQZ5Nh8wK6DVhNSbbDHbRN5mMqot4/PFXUISGUbWvCGqkI4yoVbGhmPRaSXSmcsh5n1
 5TOPfgzTxp+rLdKwwnobOaHqv0Umd7zVwbhkPtGpVqVTOYyVQIPAF7u6MlLoLa7w/3QS
 wIjvvstpOnVR79Meg/Lhs/pBdZZScHpcZu+TcZU6wEG1YhVM0Znjefgoi/B6czfsKSg4
 2YPQ==
X-Gm-Message-State: AOJu0YwpKC1idFNNYNkVUIrZ5SRKTy2qPU1eiv92Fd+LNohrCLvQUBGy
 GqpiRI2OM65P5jAogQWhJM4=
X-Google-Smtp-Source: AGHT+IGQJ74vKwKaP/syO8nnPvy2HV+GaZFBPj26QC3mwWFWCIGHeKqdBhOzZsCRISC7w5tvh+RE5A==
X-Received: by 2002:a6b:90b:0:b0:79f:e707:8813 with SMTP id
 t11-20020a6b090b000000b0079fe7078813mr8804112ioi.4.1696608069100; 
 Fri, 06 Oct 2023 09:01:09 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:582b:6312:c6b:a6f0])
 by smtp.gmail.com with ESMTPSA id
 gs4-20020a0566382d8400b0042acf389acesm461776jab.71.2023.10.06.09.00.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Oct 2023 09:00:39 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <armbru@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <peter.maydell@linaro.org>, <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
In-Reply-To: <20231005222206.2784853-4-bcain@quicinc.com>
Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Date: Fri, 6 Oct 2023 10:00:35 -0600
Message-ID: <316e01d9f86e$401f62b0$c05e2810$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJv0F5Exw0TPnXaZfUwlO9P/EDe8gDs17xJrwnTElA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Thursday, October 5, 2023 4:22 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; armbru@redhat.com; =
richard.henderson@linaro.org;
> philmd@linaro.org; peter.maydell@linaro.org; =
quic_mathbern@quicinc.com;
> stefanha@redhat.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com
> Subject: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
>=20
> The typedef `vaddr` is shadowed by `vaddr` identifiers, so we rename =
the
> identifiers to avoid shadowing the type name.
>=20
> The global `cpu_env` is shadowed by local `cpu_env` arguments, so we
> rename the function arguments to avoid shadowing the global.
>=20
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/genptr.c                 | 56 =
++++++++++++-------------
>  target/hexagon/genptr.h                 | 18 ++++----
>  target/hexagon/mmvec/system_ext_mmvec.c |  4 +-
> target/hexagon/mmvec/system_ext_mmvec.h |  2 +-
>  target/hexagon/op_helper.c              |  4 +-
>  5 files changed, 42 insertions(+), 42 deletions(-)
>=20
> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c index
> 217bc7bb5a..11377ac92b 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -334,28 +334,28 @@ void gen_set_byte_i64(int N, TCGv_i64 result, =
TCGv
> src)
>      tcg_gen_deposit_i64(result, result, src64, N * 8, 8);  }
>=20
> -static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int
> mem_index)
> +static inline void gen_load_locked4u(TCGv dest, TCGv v_addr, int
> +mem_index)

I'd recommend moving both the type and the arg name to the new line, =
also indent the new line.
static inline void gen_load_locked4u(TCGv dest, TCGv v_addr,
                                                                  int =
mem_index)


>=20
> -static inline void gen_load_locked8u(TCGv_i64 dest, TCGv vaddr, int
> mem_index)
> +static inline void gen_load_locked8u(TCGv_i64 dest, TCGv v_addr, int
> +mem_index)

Ditto

>  static inline void gen_store_conditional4(DisasContext *ctx,
> -                                          TCGv pred, TCGv vaddr, TCGv =
src)
> +                                          TCGv pred, TCGv v_addr, =
TCGv
> + src)

Ditto

>      zero =3D tcg_constant_tl(0);
> @@ -374,13 +374,13 @@ static inline void
> gen_store_conditional4(DisasContext *ctx,  }
>=20
>  static inline void gen_store_conditional8(DisasContext *ctx,
> -                                          TCGv pred, TCGv vaddr, =
TCGv_i64 src)
> +                                          TCGv pred, TCGv v_addr,
> + TCGv_i64 src)

Indent

> -void mem_gather_store(CPUHexagonState *env, target_ulong vaddr, int
> slot)
> +void mem_gather_store(CPUHexagonState *env, target_ulong v_addr, int
> +slot)

Ditto

> -void mem_gather_store(CPUHexagonState *env, target_ulong vaddr, int
> slot);
> +void mem_gather_store(CPUHexagonState *env, target_ulong v_addr, int
> +slot);

Ditto


Otherwise,
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



