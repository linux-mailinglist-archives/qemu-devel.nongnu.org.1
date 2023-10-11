Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A47C5866
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbOV-0003Wi-PL; Wed, 11 Oct 2023 11:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqbON-0003Vr-7C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:45:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqbOJ-0002pI-WA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:44:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40535597f01so65488975e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697039094; x=1697643894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6WSet9g5HqLxwyVTNBDPLtD41GxwJ8wKJ3NmP1MQxY=;
 b=qFuPqti/0SdsmYzv6emLcopNQgOa+p/V6zMzYvbj5HWlj5Va8qsv+BHZYkczR3yvRH
 xsZtRGDREfTOG6ih5tM+STDLfryRC2UH4qdJFpjNdXH5VP1CMt/f/t7z1uzcZvBULoe9
 WhN3csu/tmwDQ6N+5qme8NYedh5qJ8UO0W89sJ/qp8Qp96Jbao+naAGhmPEwEKxErr/1
 vpLXlLGvBRo9eUwm8zFUCm1o1lkHJxPQMns3rnI2M57uUHR5CWoQ7/8jZkbpxMPBAssD
 MqGtza0XcVs6xXP1+AKZBWDkwcyj1peaWBM1FZRgUH3Q89Xk8UGhGbXfTs+367sVI0SB
 +8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039094; x=1697643894;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o6WSet9g5HqLxwyVTNBDPLtD41GxwJ8wKJ3NmP1MQxY=;
 b=YhZp03P7V747dEJyCO2kKBrm6szDOAhO3aby3AGlvypLVqcfTZ6ufF6JerVFJtSW+S
 Rh+ve1+JuZVEuMvmm57HybytiFni2zBcGzH94rFd9sCN31z2a+OEmDy5EyiUmuYADGQz
 600JQY8m/DHLLgqiQ7FHNUJhhkt139Vr7Zig50RxTvpKsk6o4r7/EEvaYgnsxQcumNNa
 AOYIG8b5thViX6tS9FcV1T8cLp93Jf0obDhkJJh/xywoXm1vdP+dVW5m604yOX8ckrW6
 QroMG0XU8isgsagrUL5mgeo0WkzoC8QVLileSDbpO5ABJG/p/IrCEsmvM5/edywV1cyg
 GZBw==
X-Gm-Message-State: AOJu0YxJCWOBC39+bEznb1jgiWWazXMGK3wAnjSWHvleD/rMjbz6StBg
 w8wQOitHEbXdPIpMIO71u2gaxA==
X-Google-Smtp-Source: AGHT+IGK2UIIc02t9Ue7aTI5zPDmcnCs6J4VVPw7VkPYlzK8PiNciZuwpYwHZa48Ta1Wrj4fNm7z4Q==
X-Received: by 2002:a1c:7711:0:b0:405:959e:dc7c with SMTP id
 t17-20020a1c7711000000b00405959edc7cmr19342600wmi.30.1697039094266; 
 Wed, 11 Oct 2023 08:44:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a1c7c02000000b003fe23b10fdfsm19297358wmc.36.2023.10.11.08.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 08:44:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 623091FFBB;
 Wed, 11 Oct 2023 16:44:53 +0100 (BST)
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-7-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v9 06/23] gdbstub: Introduce GDBFeatureBuilder
Date: Wed, 11 Oct 2023 16:39:12 +0100
In-reply-to: <20231011070335.14398-7-akihiko.odaki@daynix.com>
Message-ID: <87r0m1noy2.fsf@linaro.org>
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

> GDBFeatureBuilder unifies the logic to generate dynamic GDBFeature.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/gdbstub.h | 20 ++++++++++++++
>  gdbstub/gdbstub.c      | 59 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 071021415a..d9ef2ccbff 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -16,6 +16,11 @@ typedef struct GDBFeature {
>      int num_regs;
>  } GDBFeature;
>=20=20
> +typedef struct GDBFeatureBuilder {
> +    GDBFeature *feature;
> +    GPtrArray *xml;
> +} GDBFeatureBuilder;
> +
>=20=20
>  /* Get or set a register.  Returns the size of the register.  */
>  typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int re=
g);
> @@ -44,6 +49,21 @@ void gdb_register_coprocessor(CPUState *cpu,
>   */
>  int gdbserver_start(const char *port_or_device);
>=20=20
> +void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *fe=
ature,
> +                              const char *name, const char *xmlname);
> +
> +void gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
> +                                    const char *format, ...)
> +    G_GNUC_PRINTF(2, 3);

minor nit: it might be cleaner to put this declaration before the name,
i.e.:

  void G_GNUC_PRINTF(2, 3)
  gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
                                 const char *format, ...);

but the existing code base is pretty random in where it puts these
declarations so *shrug*.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

