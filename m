Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351C7362E5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 06:56:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBTOX-0000WM-VF; Tue, 20 Jun 2023 00:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTOV-0000Vw-B7; Tue, 20 Jun 2023 00:55:07 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBTOS-0007cO-PL; Tue, 20 Jun 2023 00:55:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-55380677566so1849818a12.3; 
 Mon, 19 Jun 2023 21:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687236903; x=1689828903;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMd6yp5vpGS/POry+/bhO6iWGCmcWB5WpPcNROav2hM=;
 b=RBdBQpUj881V6KxgM7mUciiVQ6pONIC9G17ti+XENtNBEREfR1wKxyyyvJkR9EkTH5
 aGQ7Q7/V3lea7sf7yesCS27DcBV1clfHbQSABILCuAA9yIDXR3kK6oe6kJhA4C0K4lCU
 fFPAEdSVywU9dwQ4V6YNDssjhg0asZAa2th5uOVqY2nkYjxExE3d4XNSe/XzIe/T4Mxa
 xjP6REkf19croBdW6gAjfXSBDPPMTjWkYYMi5J88NvQ5ek3GF3ZP93MYAFokW+bi/j6/
 JxIYyC91468KRapsFYeJTtTYN2eiE2nZNfPjMCDB04XHKINFUV8xcLkikE/Gme26apYv
 t8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687236903; x=1689828903;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qMd6yp5vpGS/POry+/bhO6iWGCmcWB5WpPcNROav2hM=;
 b=jlQChvqLc8hMZLJ7ndiI7eJz94bcGVx1igbJO2Ok1wgo+WpCMOYCn2M9qGDL0lqNCB
 Tnj1qtuuUgzfy5vY2s58Mya6PdIej63Hvm1m5nC5zSR0JanTAHwAOAI3xcxXmiKxQ3D6
 zrza68nn74XDyThCmZ6OIgNhZRQc2zqPUENh7zx4CvOSc3Kv+87SEpffQ+Qzx20q/0wI
 /GJ83ksFTWo3C1BgJlFr0ei6bErV3cMw+Bybhx4TXgz2sMKUoy9gq9W2Xyh7mjUbzf3f
 C7Hxjihp1kk3VaPdS+nbbmP8ccjnZrOzh3JMzN8cYEo1nsAgFj9vP+HOikF9aTp136HY
 vR8g==
X-Gm-Message-State: AC+VfDx0GYIArs0WVh+3XFCXUN578MioOPtSdwqe3E4uuOfy7fnHNJ/y
 /nvYCV83S4kX4DhY3lNqMH0=
X-Google-Smtp-Source: ACHHUZ6/Sw4DRp/i9VcHlBljMY1UxbJMmkRb6gQDWj+P6sSjdcawyEKauLl72q9obxkskS8RMNgf1g==
X-Received: by 2002:a05:6a21:7894:b0:121:b736:ee81 with SMTP id
 bf20-20020a056a21789400b00121b736ee81mr3474859pzc.8.1687236902418; 
 Mon, 19 Jun 2023 21:55:02 -0700 (PDT)
Received: from localhost ([1.146.127.111]) by smtp.gmail.com with ESMTPSA id
 q17-20020a170902b11100b001aaf2e7b06csm611286plr.132.2023.06.19.21.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 21:55:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 14:54:55 +1000
Message-Id: <CTH7K9C9NBYT.95N3SHH7RQ7I@wheely>
Subject: Re: [PATCH v3 04/14] target/ppc: Use env_cpu for cpu_abort in
 excp_helper
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <455daa044e616caddb87dec33074f29196a1b560.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <455daa044e616caddb87dec33074f29196a1b560.1686868895.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
> Use the env_cpu function to get the CPUState for cpu_abort. These are
> only needed in case of fatal errors so this allows to avoid casting
> and storing CPUState in a local variable wnen not needed.
>

Eh, this is still replacing less typing with more. It's normal to
define these things up front of a function especially when used
multiple times. 'cs' should be as instantly recognizable as env
when looking at code so my preference is to keep it as is.

Thanks,
Nick

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 55 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 79f5ca1034..122e2a6e41 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -424,7 +424,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env=
)
> =20
>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
>      int srr0, srr1;
> @@ -452,8 +451,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int exc=
p)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -502,7 +501,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int exc=
p)
>              env->spr[SPR_40x_ESR] =3D ESR_PTR;
>              break;
>          default:
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -529,11 +528,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int e=
xcp)
>          trace_ppc_excp_print("PIT");
>          break;
>      case POWERPC_EXCP_DEBUG:     /* Debug interrupt                     =
     */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -548,7 +548,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int exc=
p)
> =20
>  static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
> =20
> @@ -571,8 +570,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int exc=
p)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -632,7 +631,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int exc=
p)
>              break;
>          default:
>              /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -654,8 +653,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int exc=
p)
>          break;
>      case POWERPC_EXCP_RESET:     /* System reset exception              =
     */
>          if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> -                      "exception %d with no HV support\n", excp);
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset excep=
tion "
> +                      "%d with no HV support\n", excp);
>          }
>          break;
>      case POWERPC_EXCP_TRACE:     /* Trace exception                     =
     */
> @@ -682,11 +682,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int e=
xcp)
>      case POWERPC_EXCP_SMI:       /* System management interrupt         =
     */
>      case POWERPC_EXCP_MEXTBR:    /* Maskable external breakpoint        =
     */
>      case POWERPC_EXCP_NMEXTBR:   /* Non maskable external breakpoint    =
     */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -709,7 +710,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int exc=
p)
> =20
>  static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
> =20
> @@ -732,8 +732,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int exc=
p)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -791,7 +791,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int exc=
p)
>              break;
>          default:
>              /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -832,8 +832,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int exc=
p)
>          break;
>      case POWERPC_EXCP_RESET:     /* System reset exception              =
     */
>          if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> -                      "exception %d with no HV support\n", excp);
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset excep=
tion "
> +                      "%d with no HV support\n", excp);
>          }
>          break;
>      case POWERPC_EXCP_TRACE:     /* Trace exception                     =
     */
> @@ -853,11 +854,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
>      case POWERPC_EXCP_SMI:       /* System management interrupt         =
     */
>      case POWERPC_EXCP_THERM:     /* Thermal interrupt                   =
     */
>      case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interru=
pt   */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -880,7 +882,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int exc=
p)
> =20
>  static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
> =20
> @@ -903,8 +904,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int ex=
cp)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -962,7 +963,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int ex=
cp)
>              break;
>          default:
>              /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -1003,7 +1004,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
>          break;
>      case POWERPC_EXCP_RESET:     /* System reset exception              =
     */
>          if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset "
>                        "exception %d with no HV support\n", excp);
>          }
>          break;
> @@ -1016,11 +1018,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, in=
t excp)
>      case POWERPC_EXCP_THERM:     /* Thermal interrupt                   =
     */
>      case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interru=
pt   */
>      case POWERPC_EXCP_VPUA:      /* Vector assist exception             =
     */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -1043,7 +1046,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int =
excp)
> =20
>  static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
>      int srr0, srr1;
> @@ -1080,8 +1082,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int=
 excp)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -1112,6 +1114,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int=
 excp)
>          break;
>      case POWERPC_EXCP_EXTERNAL:  /* External input                      =
     */
>          if (env->mpic_proxy) {
> +            CPUState *cs =3D env_cpu(env);
>              /* IACK the IRQ on delivery */
>              env->spr[SPR_BOOKE_EPR] =3D ldl_phys(cs->as, env->mpic_iack)=
;
>          }
> @@ -1150,7 +1153,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int=
 excp)
>              break;
>          default:
>              /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -1191,7 +1194,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int=
 excp)
> =20
>              /* DBSR already modified by caller */
>          } else {
> -            cpu_abort(cs, "Debug exception triggered on unsupported mode=
l\n");
> +            cpu_abort(env_cpu(env),
> +                      "Debug exception triggered on unsupported model\n"=
);
>          }
>          break;
>      case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable=
/VPU  */
> @@ -1205,17 +1209,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, i=
nt excp)
>          break;
>      case POWERPC_EXCP_RESET:     /* System reset exception              =
     */
>          if (FIELD_EX64(env->msr, MSR, POW)) {
> -            cpu_abort(cs, "Trying to deliver power-saving system reset "
> +            cpu_abort(env_cpu(env),
> +                      "Trying to deliver power-saving system reset "
>                        "exception %d with no HV support\n", excp);
>          }
>          break;
>      case POWERPC_EXCP_EFPDI:     /* Embedded floating-point data interru=
pt   */
>      case POWERPC_EXCP_EFPRI:     /* Embedded floating-point round interr=
upt  */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -1278,7 +1284,6 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *=
cpu)
> =20
>  static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
>      target_ulong msr, new_msr, vector;
>      int srr0, srr1, lev =3D -1;
> @@ -1317,8 +1322,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
> =20
>      vector =3D env->excp_vectors[excp];
>      if (vector =3D=3D (target_ulong)-1ULL) {
> -        cpu_abort(cs, "Raised an exception without defined vector %d\n",
> -                  excp);
> +        cpu_abort(env_cpu(env),
> +                  "Raised an exception without defined vector %d\n", exc=
p);
>      }
> =20
>      vector |=3D env->excp_prefix;
> @@ -1408,7 +1413,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>              break;
>          default:
>              /* Should never occur */
> -            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
> +            cpu_abort(env_cpu(env), "Invalid program exception %d. Abort=
ing\n",
>                        env->error_code);
>              break;
>          }
> @@ -1469,7 +1474,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>              new_msr |=3D (target_ulong)MSR_HVB;
>          } else {
>              if (FIELD_EX64(env->msr, MSR, POW)) {
> -                cpu_abort(cs, "Trying to deliver power-saving system res=
et "
> +                cpu_abort(env_cpu(env),
> +                          "Trying to deliver power-saving system reset "
>                            "exception %d with no HV support\n", excp);
>              }
>          }
> @@ -1524,11 +1530,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, i=
nt excp)
>      case POWERPC_EXCP_VPUA:      /* Vector assist exception             =
     */
>      case POWERPC_EXCP_MAINT:     /* Maintenance exception               =
     */
>      case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception    =
     */
> -        cpu_abort(cs, "%s exception not implemented\n",
> +        cpu_abort(env_cpu(env), "%s exception not implemented\n",
>                    powerpc_excp_name(excp));
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>          break;
>      }
> =20
> @@ -1561,8 +1568,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int=
 excp)
>      } else {
>          /* Sanity check */
>          if (!(env->msr_mask & MSR_HVB) && srr0 =3D=3D SPR_HSRR0) {
> -            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with=
 "
> -                      "no HV support\n", excp);
> +            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSR=
R) %d "
> +                      "with no HV support\n", excp);
>          }
> =20
>          /* This can update new_msr and vector if AIL applies */
> @@ -1580,11 +1587,11 @@ static inline void powerpc_excp_books(PowerPCCPU =
*cpu, int excp)
> =20
>  static void powerpc_excp(PowerPCCPU *cpu, int excp)
>  {
> -    CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
>      if (excp <=3D POWERPC_EXCP_NONE || excp >=3D POWERPC_EXCP_NB) {
> -        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\=
n",
> +                  excp);
>      }
> =20
>      qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
> @@ -2118,7 +2125,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
>  static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D env_cpu(env);
> =20
>      switch (interrupt) {
>      case PPC_INTERRUPT_MCK: /* Machine check exception */
> @@ -2162,14 +2168,14 @@ static void p7_deliver_interrupt(CPUPPCState *env=
, int interrupt)
>          assert(!env->resume_as_sreset);
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interr=
upt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\=
n",
> +                  interrupt);
>      }
>  }
> =20
>  static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D env_cpu(env);
> =20
>      switch (interrupt) {
>      case PPC_INTERRUPT_MCK: /* Machine check exception */
> @@ -2233,7 +2239,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, =
int interrupt)
>          assert(!env->resume_as_sreset);
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interr=
upt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\=
n",
> +                  interrupt);
>      }
>  }
> =20
> @@ -2312,7 +2319,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, =
int interrupt)
>          assert(!env->resume_as_sreset);
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interr=
upt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\=
n",
> +                  interrupt);
>      }
>  }
>  #endif
> @@ -2320,7 +2328,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, =
int interrupt)
>  static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrup=
t)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D env_cpu(env);
> =20
>      switch (interrupt) {
>      case PPC_INTERRUPT_RESET: /* External reset */
> @@ -2417,7 +2424,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCSta=
te *env, int interrupt)
>          assert(!env->resume_as_sreset);
>          break;
>      default:
> -        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interr=
upt);
> +        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\=
n",
> +                  interrupt);
>      }
>  }
> =20
> --=20
> 2.30.9


