Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F67D6870
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 12:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvb6m-0000dR-IE; Wed, 25 Oct 2023 06:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qvb6e-0000bl-0K; Wed, 25 Oct 2023 06:27:20 -0400
Received: from mail-westcentralusazolkn19012032.outbound.protection.outlook.com
 ([52.103.7.32] helo=CY4PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qvb6b-0004Uv-K5; Wed, 25 Oct 2023 06:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbIu2GZW6k4vvTj1BXDB9vHU7ZRwqqjRJKROH8E41uOlDwdaldECERKFOEeGsP8jIv4n4If7JGURnWsMzWz2raJ+xm71BxRDpueNMAbbSLFycvqJtpjTQj8Q8D5aSeWVvwbf98fN9jHzeeZJbIZzVxb5O7FgZK4qyAhLlQNEnaeqwxelbfIyWAg79y7J7X5/mbhd9gOlirGWPjmmVrOpZ5c2OpM//36jaoHcuWalAaCem6M+Jdl1zwILyEtjILPwseJUE4/9ylgeAurMd4EtHB4SKqe6M7XRnbH0RqqFer9xOfsM3Pbilwk2B18cmb/wGglnrNnFm3kzijmH+ck93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kncy2uJazr0fjsRz66g2ZNXUcgD1bnvPykrzYG/VodM=;
 b=e30i4Oz88+EVRipkRSn0jtnQXa/10A5l0+hbfo25n6PWkkrs144PRGqa5ePTn3lLz/pZ9b006OJ2fJt/E3Id/O3OAClPr62vAo8iQfhptY/YSdR6MIh9yZmCZKvCY8jYok5Ws2p/H8f/LpsJO7btHP8Dz7MCRTbVtXADgufHgB4FhKncE74PM6Lmo5UP8G9PNztgA1NZoRG08hA06ZF6JQXLN4wORZw++yyc+BY0NaAx1wxbCSSoIdBbuF/ZzQOXfCNteR9NwqbZrKYhx7ME7ltSA9Q8d0hXc0fnPgICBM2zDAsjjI7YZDz8HXrCVvNGCsbf0oHbXarqY0whMTgzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kncy2uJazr0fjsRz66g2ZNXUcgD1bnvPykrzYG/VodM=;
 b=q/iBKBzkx9zEZM8q4Hy/psrbi7ooHoaN0Veboqdxb7sB5VSnShkkJ6ddBThivOyIYxY0ZsWeq2dNGdyN7Us6y+9tlGxwu0CweqE6Y6yQcpy8QcXHxnBOVhXNhlPIwNYoEzPYnw4pSxBjAtcH3mEYIKTzFGgtq00AeP1D3WoLH/iYkp49Uz8cf1U+Ocw6OsXi8OSNGYH6ZDu4r7lFjl2OAwEF23gnDkc/Tv2ozGO1GooxmrXMeCw6wwXDeMJHrxrzTMPllzx195BSuVitJ2Wqd6uAy8Xu4QOqMsDgZzGDDsDH8UoR5MJTHws8p7sxFQORhOTUpq195luj8sQeQM8TEQ==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by SA1PR05MB9908.namprd05.prod.outlook.com (2603:10b6:806:331::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 10:26:59 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::8173:b78d:ab2f:e010]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::8173:b78d:ab2f:e010%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 10:26:59 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH RESEND] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH RESEND] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaBygNcCeQBLozQkCNMd27T1a06Q==
Date: Wed, 25 Oct 2023 10:26:59 +0000
Message-ID: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [C+KMecvpKe1ivGorg37oD1Rh+hXVMaIptkschsKbLGFGayORYCiIEVW69TslakRn]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|SA1PR05MB9908:EE_
x-ms-office365-filtering-correlation-id: c9734da9-6147-4224-3faf-08dbd544ebfa
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgNwuNkfgvnTYeIczP4iIHZmbXn7e/9a8PbUVnQdKUOgamoFc8lGj3kuqQcTvC10gkHwEgY+4TQ2UwqMsx0PF7YEpEWQYCUXjWZwjXnACtGfFggpQDrVIe0ezfcMzYvLNXlb3Pk3Khgp+qGVJYtMyqDGPZMq+PeevQniq+1kt1fFcUTuYgDZHGospJx7Vie45KiYBnL0XXUcZSMRCY2+MxvYsMAEjjFnX0xQaAzm3u57vDzI6Js1gf+3y1IyNjXkC+nV3e5MOCknXeWBfpRgyw2tlU773yx3Nl1oB6ndURW6Sob4lm529reS66KU/sq29eB+8MV4bAreqQXdtROSfT7jks6aW3Egj/sqLKivb/4G+APh1vRjgvSWzIRMnK2N4vQhUkk6qEOP6MUAtoxksMKeicOWC6Q9fQ6Ndus0sF7I/KklWzBCgHg6VqnvzS0XP1jvPQQIG88SiY02zZHCmEzY2QGkechHTsQVshVbzer7yKHaWI6eNRYBlXytkQ/YJnSMX7Mk/Kuxtt8mejioiWGTyiPw8Etwy+dBEdgEeUz7F8OVnvHNRqSxmMmnPe6jJInJ/lrAjs0by7yIEmDPiRJgH12shCQ4ynHbnM/7KQM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TBldUM3xlGbnS3UoOTUFH5DszQaRK/bz5O5QUijHT39VyZ4QUPOIv+UIch?=
 =?iso-8859-1?Q?671j6hlD2WHJvv9sVQlSyV1tDxE/tX+Gv5cR8g1gUzgSdm0GZ8jepiWy9X?=
 =?iso-8859-1?Q?FUZVQoMpwZ4Q1CnTvVbin1k/G+GUjCNW95KvqGnwfLJ3a5nDm73y7cWScJ?=
 =?iso-8859-1?Q?Hx3aBLlVhPWsXSntI/5NJFU4oXkV2bxbqEy1QMaJt2myAYBibvlGj7Evkv?=
 =?iso-8859-1?Q?DRm9m/cihOCX8R1QfeVJLWl746Xqm9nkxPQvSuTOZDDRIdWouWhswTcdu6?=
 =?iso-8859-1?Q?DOw9GR3pzdeIzNhP5ju8+P2wp4kg/1OMEPerGL6a/PfjyDy4M2uHHaIYyJ?=
 =?iso-8859-1?Q?VXmrbuwfZ3VSG5rzPjD+tXA//YgUxO07VDXuGPWBjCls4S2uot6N4/kiDa?=
 =?iso-8859-1?Q?iA45zCrSgB5ssvdgup+YbBhdD/FMIR//InOBn53yxxScw7wH/cEvoXsMc8?=
 =?iso-8859-1?Q?b9RaJlvE+hqqGrOilQQyAY/V9JDZnJy28sNxMTyNNC3Kd6P26xR7gFGviG?=
 =?iso-8859-1?Q?/pjfRplsYRI3iTpPGKN5o/mOlhzACTLPuQgeguqNkmbBPkw9WvjQIWuLHU?=
 =?iso-8859-1?Q?uZEkfiqSxNslw4VDn5mHQCXRbZsg13JQZf3KP22lI8gEKQ9BgjHGFu/mEM?=
 =?iso-8859-1?Q?d52kg5m1iMOJphCa22RXYiQJ2C94/fU5PXE2+7fFuizlktMEu+e4G3/78o?=
 =?iso-8859-1?Q?ZHo3ElhpZbE5ytQhmAPRjhtCOtqIe24NCkr09XkHXbObkks0QcfkbyTqz6?=
 =?iso-8859-1?Q?qIlMJYocpe68gBDMEak3ngHasXZ5VapbxZEPZc9+85oMElc9nunJ2ymEve?=
 =?iso-8859-1?Q?EKmySFsLk9gVRJozvEHzjMlLz6xrPmC/ZSo5fG61iz8b8IazvvEA33afGJ?=
 =?iso-8859-1?Q?JyDkQpAA/tViTjpZewBJWlkMMzGP7in6olfCoxS32rc0mjydbd818MhY9w?=
 =?iso-8859-1?Q?+taIq8ZMS0YCSCLlVSzXoJTHtRF6fCxgin46pzS9nX+83BzNXFXBSoDGqn?=
 =?iso-8859-1?Q?XwgfwxGh86w5uRGVqxjn2e/lAPUOw3xzIO/7wALhHblp7trxI9ut/SUPMQ?=
 =?iso-8859-1?Q?aQcp7/FmbfeBHhZsYIA5L8vaU/HtZysJFDzeJGM4OkbkYQV7MzfFzyOkyD?=
 =?iso-8859-1?Q?bcluN2UtpOTQ/PPV8dlNjtVJ37zss70aeX1oDtXRN8n54o7fWN9MbiDWf1?=
 =?iso-8859-1?Q?Y6krNGEb4FI2dWyP7FskLr6FuJSQT9M+TCicoAp+I8vWBBM911clATXAKE?=
 =?iso-8859-1?Q?WKOeYImmryyFZP8L0h6+xvQaqARevJQ0NVsjudmaBFP2e2P+V0TMQy1gBy?=
 =?iso-8859-1?Q?yOp0dXD9hNvxhjNtFzc3r/tm6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c9734da9-6147-4224-3faf-08dbd544ebfa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 10:26:59.6544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB9908
Received-SPF: pass client-ip=52.103.7.32; envelope-from=john_platts@hotmail.com;
 helo=CY4PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

The patch below fixes a bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2=
 macros in target/ppc/fpu_helper.c where a non-NaN floating point value fro=
m the source vector is incorrectly converted to 0, 0x80000000, or 0x8000000=
000000000 instead of the expected value if a preceding source floating poin=
t value from the same source vector was a NaN.=0A=
=0A=
The bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in target/pp=
c/fpu_helper.c was introduced with commit c3f24257.=0A=
=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1941=0A=
Signed-off-by: John Platts <john_platts@hotmail.com>=0A=
=0A=
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c=0A=
index 03150a0f10..d6c8583416 100644=0A=
--- a/target/ppc/fpu_helper.c=0A=
+++ b/target/ppc/fpu_helper.c=0A=
@@ -2880,19 +2880,21 @@ uint64_t helper_XSCVSPDPN(uint64_t xb)=0A=
 #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, sfi, rnan)      =
   \=0A=
 void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)          =
   \=0A=
 {                                                                         =
   \=0A=
+    int all_flags =3D 0;                                                  =
     \=0A=
     ppc_vsr_t t =3D { };                                                  =
     \=0A=
     int i, flags;                                                         =
   \=0A=
                                                                           =
   \=0A=
-    helper_reset_fpstatus(env);                                           =
   \=0A=
-                                                                          =
   \=0A=
     for (i =3D 0; i < nels; i++) {                                        =
     \=0A=
+        helper_reset_fpstatus(env);                                       =
   \=0A=
         t.tfld =3D stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_statu=
s);  \=0A=
         flags =3D env->fp_status.float_exception_flags;                   =
     \=0A=
+        all_flags |=3D flags;                                             =
     \=0A=
         if (unlikely(flags & float_flag_invalid)) {                       =
   \=0A=
             t.tfld =3D float_invalid_cvt(env, flags, t.tfld, rnan, 0, GETP=
C());\=0A=
         }                                                                 =
   \=0A=
     }                                                                     =
   \=0A=
                                                                           =
   \=0A=
+    env->fp_status.float_exception_flags =3D all_flags;                   =
     \=0A=
     *xt =3D t;                                                            =
     \=0A=
     do_float_check_status(env, sfi, GETPC());                             =
   \=0A=
 }=0A=
@@ -2945,15 +2947,16 @@ VSX_CVT_FP_TO_INT128(XSCVQPSQZ, int128, 0x800000000=
0000000ULL);=0A=
 #define VSX_CVT_FP_TO_INT2(op, nels, stp, ttp, sfi, rnan)                 =
   \=0A=
 void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)          =
   \=0A=
 {                                                                         =
   \=0A=
+    int all_flags =3D 0;                                                  =
     \=0A=
     ppc_vsr_t t =3D { };                                                  =
     \=0A=
     int i, flags;                                                         =
   \=0A=
                                                                           =
   \=0A=
-    helper_reset_fpstatus(env);                                           =
   \=0A=
-                                                                          =
   \=0A=
     for (i =3D 0; i < nels; i++) {                                        =
     \=0A=
+        helper_reset_fpstatus(env);                                       =
   \=0A=
         t.VsrW(2 * i) =3D stp##_to_##ttp##_round_to_zero(xb->VsrD(i),     =
     \=0A=
                                                        &env->fp_status);  =
   \=0A=
         flags =3D env->fp_status.float_exception_flags;                   =
     \=0A=
+        all_flags |=3D flags;                                             =
     \=0A=
         if (unlikely(flags & float_flag_invalid)) {                       =
   \=0A=
             t.VsrW(2 * i) =3D float_invalid_cvt(env, flags, t.VsrW(2 * i),=
     \=0A=
                                               rnan, 0, GETPC());          =
   \=0A=
@@ -2961,6 +2964,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc=
_vsr_t *xb)             \=0A=
         t.VsrW(2 * i + 1) =3D t.VsrW(2 * i);                              =
     \=0A=
     }                                                                     =
   \=0A=
                                                                           =
   \=0A=
+    env->fp_status.float_exception_flags =3D all_flags;                   =
     \=0A=
     *xt =3D t;                                                            =
     \=0A=
     do_float_check_status(env, sfi, GETPC());                             =
   \=0A=
 }=0A=

