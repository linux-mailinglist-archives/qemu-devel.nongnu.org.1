Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4214E7D56D6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:45:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJai-0007Vg-74; Tue, 24 Oct 2023 11:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJac-0007UV-Vl
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:45:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJaS-0008KA-Rp
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:45:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32d9b507b00so3377308f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698162293; x=1698767093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBQV+Znfqq0iykntFXna5gOoS1tcsrwNvKmiq3UKMqk=;
 b=aCGStyykHfZGNH+LeAsw5qSFqAcg+GUttrOpUD6U+QEll38flUGeM1a1n9vpQv7dNo
 wu+eFWC9c62OeD62Z+VzYi4ider8zSa1c1tMC35bTPZ7iFmUd/EwEfsHQxb0GsHekDnF
 vgCscJcOfGBSltE4YcRUiskWoj1InkPL2J7hqLSXSpgCIH6c+u9G49yO3LYYBZ2dtsv+
 B/x44pFjdZ/eTzVq2dXe48d8EKMB1X74KR0c8kdUuO73yfNPfqcezaNPLqaXp3vGA1WN
 ol3VNYMs9TbO8DtxLS6GjSymx5lNTRB+V2GVr8GkCZ4SYPIHxmCalMPRH/yRrz+7y/LS
 3iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698162293; x=1698767093;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sBQV+Znfqq0iykntFXna5gOoS1tcsrwNvKmiq3UKMqk=;
 b=vB/MiOl4iGrk4J8++B9ZSSuNCz7GvUqF8CQdH0CWS/UPwod+Q6/cvbiFFw5+SFrz4A
 dHuCBwpa755hltES9Kb9TliAgH7EhfFp2kZH5EJrQ4xPhFR4aF1NAoxXEIzV1I5ay2nv
 OVg1fL3LOHNZIXSYS5ibOL4BQSR3dxYZuDMMvmKZAVqMGpmuAvgf4k+gNfBmhxZLPtcb
 csyicOI0GZfoIXsJHWRLMw3vhDVcefKWxjeKCh5uYj0PbfYF+SD1+9kG6iWQ8gI4Tzr1
 j59aaP3MCanJxRDiQ5yVh/8ZjZpvB3j0P/xUxx53oMV8e1Y7Yzmom0oJkdO+sxWo9ikP
 TTug==
X-Gm-Message-State: AOJu0YzAdv0EAenmn9yLcbbmpNlAV9MZs2DAHz1w96dzxHA89Ds1e5Cl
 5k1WqP1R6gfQT+SNDxJwLIi8ug==
X-Google-Smtp-Source: AGHT+IGL48SY6hKufqUhaTzRDU/9Gk54/ib8FjihWGzv1M4kp4I8aSaJNI7qF+OkNWD5KXHJdZeptg==
X-Received: by 2002:a5d:410f:0:b0:32d:8185:9c15 with SMTP id
 l15-20020a5d410f000000b0032d81859c15mr8980740wrp.49.1698162293293; 
 Tue, 24 Oct 2023 08:44:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o15-20020adfcf0f000000b00327de0173f6sm10102486wrj.115.2023.10.24.08.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:44:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5240E1FFBB;
 Tue, 24 Oct 2023 16:44:52 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
 <20231019102657.129512-15-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 14/18] gdbstub: Expose functions to read registers
Date: Tue, 24 Oct 2023 16:41:57 +0100
In-reply-to: <20231019102657.129512-15-akihiko.odaki@daynix.com>
Message-ID: <87y1fs10uj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> gdb_find_feature() and gdb_find_feature_register() find registers.
> gdb_read_register() actually reads registers.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/exec/gdbstub.h |  5 +++++
>  gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 346151d0f2..308b5c266a 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -74,6 +74,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *=
builder);
>=20=20
>  const GDBFeature *gdb_find_static_feature(const char *xmlname);
>=20=20
> +int gdb_find_feature(CPUState *cpu, const char *name);
> +int gdb_find_feature_register(CPUState *cpu, int feature, const char *na=
me);
> +
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> +

Can we try to add kdoc comments to the new external facing APIs please.
I should have mentioned that for previous cases as well.

>  void gdb_set_stop_cpu(CPUState *cpu);
>=20=20
>  /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index fade023559..0b64b93960 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -490,7 +490,36 @@ const GDBFeature *gdb_find_static_feature(const char=
 *xmlname)
>      g_assert_not_reached();
>  }
>=20=20
> -static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
> +int gdb_find_feature(CPUState *cpu, const char *name)
> +{
> +    GDBRegisterState *r;
> +
> +    for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {
> +        r =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +        if (!strcmp(name, r->feature->name)) {
> +            return i;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +int gdb_find_feature_register(CPUState *cpu, int feature, const char *na=
me)
> +{
> +    GDBRegisterState *r;
> +
> +    r =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
> +
> +    for (int i =3D 0; i < r->feature->num_regs; i++) {
> +        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
> +            return r->base_reg + i;
> +        }
> +    }
> +
> +    return -1;
> +}
> +
> +int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>  {
>      CPUClass *cc =3D CPU_GET_CLASS(cpu);
>      GDBRegisterState *r;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

