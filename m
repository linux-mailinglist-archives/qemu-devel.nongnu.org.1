Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E9973573A
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEIH-00032S-B0; Mon, 19 Jun 2023 08:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBEI8-0002xm-Hf
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:47:33 -0400
Received: from st43p00im-ztbu10063601.me.com ([17.58.63.174])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBEI6-0004hM-2V
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1687178841; bh=FFzNkptbgATmjC8nSalWyxoHI2Uv/48+gwf1Mj1XpNc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=R2Epj7EoSbw5yV/9PaQDUkEmO71OGF8i11BzHPQNunZ1b2Eo1O9YOhSFu2wdWt88x
 m/qp8aSB1qvFdlCl/j4RTnGN1qt7c1OhJr2f+RTtuiC+4VnQy0/q4CZ6whgXd0r1FO
 tZiswPv4ClIgw6dyzGIMGGpaNrvnVAsyHCdXIJwa57yfFGH2JAIyxrDEpplOWrysOm
 xgrKcgrsD9efwk4Y+j6fVdMWyPu7IepARr4v7/nyCMbM0PdTLOYtecFmf1XxiAdxj5
 /iMJkEziYU9kvz0WQM4AwF0dINKrrmDvrRd3fyndMj5jcKrmnOzafTd6eXouqKnP1I
 p3lE/PXMU7t+g==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com
 [17.42.251.41])
 by st43p00im-ztbu10063601.me.com (Postfix) with ESMTPSA id 3D74A8C0370;
 Mon, 19 Jun 2023 12:47:18 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230607043943.1837186-13-clg@kaod.org>
Date: Mon, 19 Jun 2023 14:47:06 +0200
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <955C217E-FE0F-41E2-8E97-9AFD8C4A0DBE@ynddal.dk>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: KfUQjuliEM0WDdCSrfLwHNo4IWUPdXss
X-Proofpoint-ORIG-GUID: KfUQjuliEM0WDdCSrfLwHNo4IWUPdXss
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 clxscore=1030
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306190117
Received-SPF: pass client-ip=17.58.63.174; envelope-from=mads@ynddal.dk;
 helo=st43p00im-ztbu10063601.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sorry, if this has already been acknowledged, but I couldn't find it on =
the
mailinglist.

This commit seems to break compatibility with macOS accelerator hvf when
virtualizing ARM CPUs.

It breaks the VM on boot-up with the message "ARM CPUs must have both =
VFP-D32
and Neon or neither". I haven't looked into what VFP-D32 and Neon are, =
but the
same VM worked on earlier versions of QEMU.

It can be reproduced with the following:

qemu-system-aarch64 \
  -nodefaults \
  -display "none" \
  -machine "virt" \
  -accel "hvf" \
  -cpu "host" \
  -serial "mon:stdio"
qemu-system-aarch64: ARM CPUs must have both VFP-D32 and Neon or neither


If you fix/work on this issue in a separate thread/patch, you can add
reported-by, so I'll automatically follow and help test it:

Reported-by: Mads Ynddal <mads@ynddal.dk>

=E2=80=94
Mads Ynddal

> On 7 Jun 2023, at 06.39, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
> Cortex A7 CPUs with an FPU implementing VFPv4 without NEON support
> have 16 64-bit FPU registers and not 32 registers. Let users set the
> number of VFP registers with a CPU property.
>=20
> The primary use case of this property is for the Cortex A7 of the
> Aspeed AST2600 SoC.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> target/arm/cpu.h        |  2 ++
> hw/arm/aspeed_ast2600.c |  2 ++
> target/arm/cpu.c        | 32 ++++++++++++++++++++++++++++++++
> 3 files changed, 36 insertions(+)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d469a2637b32..79f1a96ddf39 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -916,6 +916,8 @@ struct ArchCPU {
>     bool has_pmu;
>     /* CPU has VFP */
>     bool has_vfp;
> +    /* CPU has 32 VFP registers */
> +    bool has_vfp_d32;
>     /* CPU has Neon */
>     bool has_neon;
>     /* CPU has M-profile DSP extension */
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 1bf12461481c..a8b3a8065a11 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -316,6 +316,8 @@ static void aspeed_soc_ast2600_realize(DeviceState =
*dev, Error **errp)
>                                 &error_abort);
>         object_property_set_bool(OBJECT(&s->cpu[i]), "neon", false,
>                                 &error_abort);
> +        object_property_set_bool(OBJECT(&s->cpu[i]), "vfp-d32", =
false,
> +                                &error_abort);
>         object_property_set_link(OBJECT(&s->cpu[i]), "memory",
>                                  OBJECT(s->memory), &error_abort);
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5182ed0c9113..74fe6ae78192 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1275,6 +1275,9 @@ static Property arm_cpu_cfgend_property =3D
> static Property arm_cpu_has_vfp_property =3D
>             DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
>=20
> +static Property arm_cpu_has_vfp_d32_property =3D
> +            DEFINE_PROP_BOOL("vfp-d32", ARMCPU, has_vfp_d32, true);
> +
> static Property arm_cpu_has_neon_property =3D
>             DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
>=20
> @@ -1406,6 +1409,22 @@ void arm_cpu_post_init(Object *obj)
>         }
>     }
>=20
> +    if (cpu->has_vfp && cpu_isar_feature(aa32_simd_r32, cpu)) {
> +        cpu->has_vfp_d32 =3D true;
> +        if (!kvm_enabled()) {
> +            /*
> +             * The permitted values of the SIMDReg bits [3:0] on
> +             * Armv8-A are either 0b0000 and 0b0010. On such CPUs,
> +             * make sure that has_vfp_d32 can not be set to false.
> +             */
> +            if (!(arm_feature(&cpu->env, ARM_FEATURE_V8) &&
> +                  !arm_feature(&cpu->env, ARM_FEATURE_M))) {
> +                qdev_property_add_static(DEVICE(obj),
> +                                         =
&arm_cpu_has_vfp_d32_property);
> +            }
> +        }
> +    }
> +
>     if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
>         cpu->has_neon =3D true;
>         if (!kvm_enabled()) {
> @@ -1672,6 +1691,19 @@ static void arm_cpu_realizefn(DeviceState *dev, =
Error **errp)
>         return;
>     }
>=20
> +    if (cpu->has_vfp_d32 !=3D cpu->has_neon) {
> +        error_setg(errp, "ARM CPUs must have both VFP-D32 and Neon or =
neither");
> +        return;
> +    }
> +
> +   if (!cpu->has_vfp_d32) {
> +        uint32_t u;
> +
> +        u =3D cpu->isar.mvfr0;
> +        u =3D FIELD_DP32(u, MVFR0, SIMDREG, 1); /* 16 registers */
> +        cpu->isar.mvfr0 =3D u;
> +    }
> +
>     if (!cpu->has_vfp) {
>         uint64_t t;
>         uint32_t u;
> --=20
> 2.40.1
>=20
>=20
>=20


