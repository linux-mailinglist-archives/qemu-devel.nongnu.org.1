Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D277E279F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:50:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00uX-0005Ad-2l; Mon, 06 Nov 2023 09:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00tq-0004xW-8U
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00tn-0003Cn-2i
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699282097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUoc8PMON7X3zrYkHx51gOOcmIIcI3Sptdru+zJ9W/A=;
 b=QPGJsCwiZO7hiMCZMvDUTUHlt5AN7SCP34CUFODO9af+2E4aK4Tqz21kd+VVtI/vqthtl9
 AbMwFD2arjmy1ajNqqtV0WuIO/o/HxXLotiZbYYfBczannjN9Voz2KRAeKfHlHErzrWs8d
 iEL+PoY0CB0unIElakfZsVO6adJ1Q10=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-0rz31KzsOeq4Sg3mbyXeDQ-1; Mon, 06 Nov 2023 09:48:15 -0500
X-MC-Unique: 0rz31KzsOeq4Sg3mbyXeDQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d08175882so53801866d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699282094; x=1699886894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUoc8PMON7X3zrYkHx51gOOcmIIcI3Sptdru+zJ9W/A=;
 b=dFP/qL1bsq16y9g1d8XCQ/tzvBPFw1iwcOCnId1vje7/2SFBj/Ppp3sOIBo+UA7JfV
 0hktgC62b2b97L6QQ7nd/WX7uT7SaGh2nAVk34juoeqmQz+lhpi3x1fcJRvSk2Jt/NaG
 pqV4OYBM/4mHvkyQ2QOdhrDn40jRI2yWGYjKiYW3dCPixxG2HosW8egqIkMq7OlcU1pu
 sLuAgMkh90AAPUEeB8hAUeRBP/IIs39+O7+4VP6jldZn3V5m94Fg9jdT0C5oo9L38Yc7
 mfMeOuGD2pwuJDW13pqIYywHIhkAP764/APaxTBG2Wuw/U/jRnY/Y6Cc3OvWnJzrY/8D
 NX7A==
X-Gm-Message-State: AOJu0YwPGuSm00UuhJ8lsHYA92zW2xs07QLl4BSVLLZY3bcfapwI5/+e
 Q/hdeQ0PytERY/6ajxezYwCKuzyiX1MCE2OlrX/8HJYkTfC/uNEU+FmVpjFWFbXFB3rsTJw+x8i
 FJV4fSc7tLAzMtho=
X-Received: by 2002:a0c:cd0f:0:b0:66d:6544:8eae with SMTP id
 b15-20020a0ccd0f000000b0066d65448eaemr27904812qvm.34.1699282093803; 
 Mon, 06 Nov 2023 06:48:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSEwJtMLiz1YBzNdNeEs4jVPgYHmxB8OXqlqOIwXy9nGTreeZOIOAOvlHt19mDEzjXoSCPiQ==
X-Received: by 2002:a0c:cd0f:0:b0:66d:6544:8eae with SMTP id
 b15-20020a0ccd0f000000b0066d65448eaemr27904773qvm.34.1699282093492; 
 Mon, 06 Nov 2023 06:48:13 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 e6-20020a056214162600b00671248b9cfcsm3470873qvw.67.2023.11.06.06.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 06:48:12 -0800 (PST)
Date: Mon, 6 Nov 2023 15:48:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, philmd@linaro.org,
 clg@kaod.org, imp@bsdimp.com, kevans@freebsd.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 peter.maydell@linaro.org, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com, kfting@nuvoton.com,
 wuhaotsh@google.com, nieklinnenbank@gmail.com, rad@semihalf.com,
 quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 aleksandar.rikalo@syrmia.com, chenhuacai@kernel.org, crwulff@gmail.com,
 marex@denx.de, shorne@gmail.com, npiggin@gmail.com,
 ysato@users.sourceforge.jp, david@redhat.com, thuth@redhat.com,
 iii@linux.ibm.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v4 03/33] cpu: Call object_class_dynamic_cast() once in
 cpu_class_by_name()
Message-ID: <20231106154804.6085c2f6@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231102002500.1750692-4-gshan@redhat.com>
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-4-gshan@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu,  2 Nov 2023 10:24:30 +1000
Gavin Shan <gshan@redhat.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> For all targets, the CPU class returned from CPUClass::class_by_name()
> and object_class_dynamic_cast(oc, CPU_RESOLVING_TYPE) need to be
> compatible. Lets apply the check in cpu_class_by_name() for once,
> instead of having the check in CPUClass::class_by_name() for individual
> target. In order to make CPU_RESOLVING_TYPE visible to cpu_class_by_name(=
),
> the helper has to be moved to cpu-target.c
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  cpu-target.c           | 15 +++++++++++++++
>  hw/core/cpu-common.c   | 14 --------------
>  target/arm/cpu.c       |  4 +---
>  target/avr/cpu.c       |  8 +-------
>  target/cris/cpu.c      |  4 +---
>  target/hexagon/cpu.c   |  4 +---
>  target/loongarch/cpu.c |  8 +-------
>  target/m68k/cpu.c      |  4 +---
>  target/openrisc/cpu.c  |  4 +---
>  target/riscv/cpu.c     |  4 +---
>  target/tricore/cpu.c   |  4 +---
>  target/xtensa/cpu.c    |  4 +---
>  12 files changed, 25 insertions(+), 52 deletions(-)
>=20
> diff --git a/cpu-target.c b/cpu-target.c
> index 79363ae370..876b498233 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -250,6 +250,21 @@ void cpu_exec_initfn(CPUState *cpu)
>  #endif
>  }
> =20
> +ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_mod=
el)
> +{
> +    CPUClass *cc =3D CPU_CLASS(object_class_by_name(typename));
> +    ObjectClass *oc;
> +
> +    assert(cpu_model && cc->class_by_name);
> +    oc =3D cc->class_by_name(cpu_model);
> +    if (oc && !object_class_is_abstract(oc) &&
> +        object_class_dynamic_cast(oc, CPU_RESOLVING_TYPE)) {
> +        return oc;
> +    }
> +
> +    return NULL;
> +}
> +
>  const char *parse_cpu_option(const char *cpu_option)
>  {
>      ObjectClass *oc;
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index bca0323e9f..1024de53bb 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -147,20 +147,6 @@ static bool cpu_common_has_work(CPUState *cs)
>      return false;
>  }
> =20
> -ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_mod=
el)
> -{
> -    CPUClass *cc =3D CPU_CLASS(object_class_by_name(typename));
> -    ObjectClass *oc;
> -
> -    assert(cpu_model && cc->class_by_name);
> -    oc =3D cc->class_by_name(cpu_model);
> -    if (oc && !object_class_is_abstract(oc)) {
> -        return oc;
> -    }
> -
> -    return NULL;
> -}
> -
>  static void cpu_common_parse_features(const char *typename, char *featur=
es,
>                                        Error **errp)
>  {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 8c622d6b59..4942239b34 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2399,9 +2399,7 @@ static ObjectClass *arm_cpu_class_by_name(const cha=
r *cpu_model)
>      oc =3D object_class_by_name(typename);
>      g_strfreev(cpuname);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_ARM_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 113d522f75..a36cc48aae 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -154,13 +154,7 @@ static void avr_cpu_initfn(Object *obj)
> =20
>  static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
>  {
> -    ObjectClass *oc;
> -
> -    oc =3D object_class_by_name(cpu_model);
> -    if (!object_class_dynamic_cast(oc, TYPE_AVR_CPU)) {
> -        oc =3D NULL;
> -    }
> -    return oc;
> +    return object_class_by_name(cpu_model);
>  }
> =20
>  static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index 1cb431cd46..a5083a0077 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -95,9 +95,7 @@ static ObjectClass *cris_cpu_class_by_name(const char *=
cpu_model)
>      typename =3D g_strdup_printf(CRIS_CPU_TYPE_NAME("%s"), cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_CRIS_CPU)) {
> -        oc =3D NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index bd5adb7acd..aa48f5fe89 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -63,9 +63,7 @@ static ObjectClass *hexagon_cpu_class_by_name(const cha=
r *cpu_model)
>      oc =3D object_class_by_name(typename);
>      g_strfreev(cpuname);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_HEXAGON_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 06d1b9bb95..c6712e13f9 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -643,15 +643,9 @@ static ObjectClass *loongarch_cpu_class_by_name(cons=
t char *cpu_model)
>          g_autofree char *typename
>              =3D g_strdup_printf(LOONGARCH_CPU_TYPE_NAME("%s"), cpu_model=
);
>          oc =3D object_class_by_name(typename);
> -        if (!oc) {
> -            return NULL;
> -        }
>      }
> =20
> -    if (object_class_dynamic_cast(oc, TYPE_LOONGARCH_CPU)) {
> -        return oc;
> -    }
> -    return NULL;
> +    return oc;
>  }
> =20
>  void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index fe381cc5d3..6cd5b56d6f 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -111,9 +111,7 @@ static ObjectClass *m68k_cpu_class_by_name(const char=
 *cpu_model)
>      typename =3D g_strdup_printf(M68K_CPU_TYPE_NAME("%s"), cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_M68K_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index cc94f37e77..f7d53c592a 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -164,9 +164,7 @@ static ObjectClass *openrisc_cpu_class_by_name(const =
char *cpu_model)
>      typename =3D g_strdup_printf(OPENRISC_CPU_TYPE_NAME("%s"), cpu_model=
);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_OPENRISC_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 018bad6f82..8b4024338c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -636,9 +636,7 @@ static ObjectClass *riscv_cpu_class_by_name(const cha=
r *cpu_model)
>      oc =3D object_class_by_name(typename);
>      g_strfreev(cpuname);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_RISCV_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 47e1c272cf..8acacdf0c0 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -132,9 +132,7 @@ static ObjectClass *tricore_cpu_class_by_name(const c=
har *cpu_model)
>      typename =3D g_strdup_printf(TRICORE_CPU_TYPE_NAME("%s"), cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_TRICORE_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 5d1c090467..93e782a6e0 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -141,9 +141,7 @@ static ObjectClass *xtensa_cpu_class_by_name(const ch=
ar *cpu_model)
>      typename =3D g_strdup_printf(XTENSA_CPU_TYPE_NAME("%s"), cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> -    if (!object_class_dynamic_cast(oc, TYPE_XTENSA_CPU)) {
> -        return NULL;
> -    }
> +
>      return oc;
>  }
> =20


