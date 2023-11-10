Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31B7E7D7B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 16:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1TaB-0007lS-AD; Fri, 10 Nov 2023 10:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1Ta8-0007kb-S1; Fri, 10 Nov 2023 10:38:04 -0500
Received: from mail-westus2azlp170110001.outbound.protection.outlook.com
 ([2a01:111:f403:c007::1] helo=CO1PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1Ta6-0004go-EG; Fri, 10 Nov 2023 10:38:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7bVMJPEu+FPhiSnD14fCMp2YH6odPlLutPw2XR4dabdOR1YLfc4SUDr/YCX7vbjdNBQNZCXHRnevC/Aq3R7p53LyhBpQorygMcGZyeTEMa5PW2jBQsRHNENEr1GK/dLkDm25+q67/sPEhNmaxEwRHdAFw9lbnKZDYw3vr/a/vS7Kyb7EYiou5c1FKbhRW8/UPdmYzxs4Tu90gWOsJRj/Z1oHweBlH4Y7qSq978eDtDXkNqOqNgHZjpYeFK+JzgrSopwoig1D6E04ynRgvHiLl5HwLKBP3YjFQG+xwWHNNBMHuvCX+c0m9IsTPOQzLgaBf96LZrfZcvxWslyv0yf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkN6/GO0t13niS4Lv/TG6pFWh2cqR/Sc+hxf14Hss/Q=;
 b=Wk+8gJTgYkKr3ITmh1lvZfZuZft+2Xo63+G7vllp9R5XVw9fn28LOIHV8tV60qWk0NyDjtJiVqQ1UnSI5Q38Oe9ABEyI6XkOo8AGmTsHB/2xMfA09lItct1RmI6znXsHprg5BC3iOh9/5idPtn1Cmg4wCbaW4U1+iTcM9p2nz4yZ8brhe6RD3/OOt7HKn7tl6pNJnJOEOn55h1ylVJzYWrRVsMWSeGlqAB5sGL+QY98zgELfVkC5ETNW99hqSdP9rP+8t3NuuBa6Uhb0zSXoApJ/kUJOCONhDaPKwBPRawWzqkSrSGH0DTUrRUaRcPL3ztL/OOoA1hyq6CRW+eXRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkN6/GO0t13niS4Lv/TG6pFWh2cqR/Sc+hxf14Hss/Q=;
 b=GXdydQP4VnMCAoFJRebYPwDeKEiZsPtG1aVClMKRiZRiIQBnXDTuVvt4paaiySzblRz2RkeIJXH+hpxtuO6+OiJyYRlIN46OxW0sakPLUBKpVq1377/aBpliC8C49jBsFgp8yjKsYqPY6HZqVW6cC3p1bNvx9lIrpNdbi5DQUJa47dTXmSu7ctMhskoA+fLFRWirXXrprE4nGWrBipLcHsfBm63magqvQ43lcAfO84B6eYItQ9t1g/Ais0xvj8TTmqMl+vyADo+YnHFor8ZrmjHZcGGwGcgiFVQQGPR33AGscnoAfTQmOOmvfXN3xf3iDEk+v4pFF2LP2sIIlOzLyg==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by DM4PR05MB10196.namprd05.prod.outlook.com (2603:10b6:8:180::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 15:37:57 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 15:37:56 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH v5] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaE+t978RdhJF7Z0e5h5bd+vwZsbBzr0F5
Date: Fri, 10 Nov 2023 15:37:56 +0000
Message-ID: <SN6PR05MB5837CB36DC040A4222172C949DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58378D2FFC111C3C8482CA3A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58370F778E36797C833A020E9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
In-Reply-To: <SN6PR05MB58370F778E36797C833A020E9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [SMRfSjs93mPmKATkbm4wqdY0o7+TlYtR9rdSE2j9uQUZxGfVqinlb5zQjzAQhL15]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|DM4PR05MB10196:EE_
x-ms-office365-filtering-correlation-id: 52c24bfa-d43d-45dc-63fd-08dbe20302fe
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dGOmscwKuH3t80OixSceEpUqBS/cOV+UWg5kM8jr80fZ7Gd1yLQ9gEtRQiqaSwP+HYGtNr3m/V94pDUXd8Jzj82LySKwDI15WopFiLAjQ/97ZefRbAJRGm96YBmfD4Z7MMZjs5/Dci+nYnDgw2SY4cwcA2UbPwFeH5iCO9V6/SSOD7W4nchKMvLIfLw7tTq1nM6iak9Fcw20f0QUXgdo4bqZlUF1OcVUyWZ7fibYKN7rgFCx+32N1fm2H7uYc3iqjLVJXY+pGMhA5k40Pf1RsI1/J9/8GPT7rB7Et70FRAxdb2YThM9HOVEyBv1aYv9vZ8NCCTFZqBIT5DkWpv8Yl4RYqurVQnwsru3HgX+tDAZEqfjzd6FO6whdQLFbahY0eg88tFX+Y31ldf2prD0oM9WsXaDDQu3hd5Br9ISF9TJ0wl8UhI8hCZocGI5kQOESsLe3aZpCu+CaCJb+TepmfWCAu7jqkrzwXcZdAF1GP8DIaD5TSAm5ikzVc5II9aPZf9oTKReQcr5W/99MjmIrQHxaCx1aCWWDbWSLPAg6z0yyrlocQyOitovbl8BkIRvDt6VH/oVLlrdDTnhXt+yjOJ8k1gfmHsW6AvKYGLoL4sI=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/FjgfIGHp253HSW+e5EdhwnVLjPynVStSKFtcDGV8LmYVYYR5pJU2oY/Os?=
 =?iso-8859-1?Q?it95fuGH5FMpQiM1BQ3bLk+GTIgJnsS3/D8czVGpG42z9oZKzO5yG5D2UE?=
 =?iso-8859-1?Q?jiAeGQdyJKSWgTXMJ1pM+9uzx7f1PqeLsxjJvY6G0pBnhOjG9M/GffS4M/?=
 =?iso-8859-1?Q?evXqFHlO68E2orVXr684VDxOEm1fpUiAApcRQ1FoNfte7xVSvux+MUIdrH?=
 =?iso-8859-1?Q?X+Auj+Z/0EV7J2C7MX5r/9hMFjqV+l7j9f/bdjLATISkG+hwCN0hU8CYh1?=
 =?iso-8859-1?Q?ZB0EKp8Ql/gVrjSnjA3R3kHVIyNQz6nsKDAdpnDzQYxmjTIH2XyD//FkRj?=
 =?iso-8859-1?Q?QAy6dYfz4Vz1mafQqLW2CBd6BA7rfNXTCx0Dbz++egOJRDjUbdDJx+mztW?=
 =?iso-8859-1?Q?Jtu+GADb5GE+iV9HUtpDmM95svBhy3Fm58nFB11m6J2j4YfENzqIZ6Hy4J?=
 =?iso-8859-1?Q?mAoBaLXP3voPjhWJoThUaoGD3eW2nDkGz9riCPbg28UE3/rYye9tipZK1B?=
 =?iso-8859-1?Q?AYQErpgOt7aIvqbw0fewIU2jOC7/VFNW/48lkVvmU7/zYHzHbr9DDS6Gsl?=
 =?iso-8859-1?Q?ix2n5nVolcCbd2JIxN2ZfuXxDIPqlJa5EoTZiNxM8RKH0Sy8M7S6NwB9DR?=
 =?iso-8859-1?Q?p/H0RiNsEK/ije72IQCfgPtPVO3UHVwezEFDOR6Jxo7jJzWkuRljl5VxD4?=
 =?iso-8859-1?Q?TCBiBtLV/lgwI3PMJ+VFYmy6d9IVWzapkEPUIv6iLR2XaaMsAs4ubAvnqN?=
 =?iso-8859-1?Q?KOAqSxPKzr7RaWv70Vfgpon3CXsOo6sMS+MjKx3xBZjjAuirZVcj+6GjXe?=
 =?iso-8859-1?Q?lTncg1xA6cn2czgu2doaCMscuJ+2U7xnf6B1dpjGNjIT1iatGccZdFn5j+?=
 =?iso-8859-1?Q?pEb55JYGBVSxG3xCeH6sv8s94muM1eOWgStcW8v+1qH2H+7/mvXcJxz3Aa?=
 =?iso-8859-1?Q?uAu+dE+3jK2e578MNSPhV2lGMHsU/q2U4OCXv7/UaGOAuPdWJVU0mVLR7l?=
 =?iso-8859-1?Q?V0vHlApR3SBaPmtJXdWq4jJaPSKu150NtZjHKAgKr//gIRp8ToMw2Y4cEp?=
 =?iso-8859-1?Q?uHht1xmg7QL0KKZID1Hz/E0OZ34eX66udjdi3PHN9jPNiXLv8F5CHJaFxc?=
 =?iso-8859-1?Q?oYJ/LPp1vHO+DJ7XevCSZKvh0vsYLNZI+jFzsw0aeaqGlmXXi9W7b9Zq7D?=
 =?iso-8859-1?Q?+4eehb1cJu71JewbR9AJoaDaOWehgxLX3Qh+zZ+Yfd2LutarR54AxkSsHO?=
 =?iso-8859-1?Q?DegAdijrRE04r4q6/Bn4bmNv9rvHUCG7mp4/G4JAsDdbSPGLz4Ig2U/7nL?=
 =?iso-8859-1?Q?DReTIp5JZqjz9YBYOmUjOawFQBfghNq1qHQdmb5tFoDY3dk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c24bfa-d43d-45dc-63fd-08dbe20302fe
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 15:37:56.5782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB10196
Received-SPF: pass client-ip=2a01:111:f403:c007::1;
 envelope-from=john_platts@hotmail.com;
 helo=CO1PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The patch below fixes a bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2=
=0A=
macros in target/ppc/fpu_helper.c where a non-NaN floating point value from=
 the=0A=
source vector is incorrectly converted to 0, 0x80000000, or 0x8000000000000=
000=0A=
instead of the expected value if a preceding source floating point value fr=
om=0A=
the same source vector was a NaN.=0A=
=0A=
The bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in=0A=
target/ppc/fpu_helper.c was introduced with commit c3f24257e3c0.=0A=
=0A=
This patch also adds a new vsx_f2i_nan test in tests/tcg/ppc64 that checks =
that=0A=
the VSX xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcvspuxds, xvcvdpsxws, xvcvdpu=
xws,=0A=
xvcvdpsxds, and xvcvdpuxds instructions correctly convert non-NaN floating =
point=0A=
values to integer values if the source vector contains NaN floating point v=
alues.=0A=
=0A=
Fixes: c3f24257e3c0 ("target/ppc: Clear fpstatus flags on helpers missing i=
t")=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1941=0A=
Signed-off-by: John Platts <john_platts@hotmail.com>=0A=
---=0A=
 target/ppc/fpu_helper.c         |  12 +-=0A=
 tests/tcg/ppc64/Makefile.target |   2 +-=0A=
 tests/tcg/ppc64/vsx_f2i_nan.c   | 304 ++++++++++++++++++++++++++++++++=0A=
 3 files changed, 313 insertions(+), 5 deletions(-)=0A=
 create mode 100644 tests/tcg/ppc64/vsx_f2i_nan.c=0A=
=0A=
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c=0A=
index 03150a0f10..4b3dcad5d1 100644=0A=
--- a/target/ppc/fpu_helper.c=0A=
+++ b/target/ppc/fpu_helper.c=0A=
@@ -2880,20 +2880,22 @@ uint64_t helper_XSCVSPDPN(uint64_t xb)=0A=
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
     *xt =3D t;                                                            =
     \=0A=
+    env->fp_status.float_exception_flags =3D all_flags;                   =
     \=0A=
     do_float_check_status(env, sfi, GETPC());                             =
   \=0A=
 }=0A=
 =0A=
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
@@ -2962,6 +2965,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc=
_vsr_t *xb)             \=0A=
     }                                                                     =
   \=0A=
                                                                           =
   \=0A=
     *xt =3D t;                                                            =
     \=0A=
+    env->fp_status.float_exception_flags =3D all_flags;                   =
     \=0A=
     do_float_check_status(env, sfi, GETPC());                             =
   \=0A=
 }=0A=
 =0A=
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.tar=
get=0A=
index 1d08076756..553f0b1367 100644=0A=
--- a/tests/tcg/ppc64/Makefile.target=0A=
+++ b/tests/tcg/ppc64/Makefile.target=0A=
@@ -12,7 +12,7 @@ config-cc.mak: Makefile=0A=
 -include config-cc.mak=0A=
 =0A=
 ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)=0A=
-PPC64_TESTS=3Dbcdsub non_signalling_xscv=0A=
+PPC64_TESTS=3Dbcdsub non_signalling_xscv vsx_f2i_nan=0A=
 endif=0A=
 $(PPC64_TESTS): CFLAGS +=3D -mpower8-vector=0A=
 =0A=
diff --git a/tests/tcg/ppc64/vsx_f2i_nan.c b/tests/tcg/ppc64/vsx_f2i_nan.c=
=0A=
new file mode 100644=0A=
index 0000000000..89ab997ef5=0A=
--- /dev/null=0A=
+++ b/tests/tcg/ppc64/vsx_f2i_nan.c=0A=
@@ -0,0 +1,304 @@=0A=
+#include <stdio.h>=0A=
+#include "qemu/compiler.h"=0A=
+=0A=
+typedef vector float vsx_float32_vec_t;=0A=
+typedef vector double vsx_float64_vec_t;=0A=
+typedef vector signed int vsx_int32_vec_t;=0A=
+typedef vector unsigned int vsx_uint32_vec_t;=0A=
+typedef vector signed long long vsx_int64_vec_t;=0A=
+typedef vector unsigned long long vsx_uint64_vec_t;=0A=
+=0A=
+#define DEFINE_VSX_F2I_FUNC(SRC_T, DEST_T, INSN)                       \=
=0A=
+static inline vsx_##DEST_T##_vec_t                                     \=
=0A=
+    vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(vsx_##SRC_T##_vec_t v) \=
=0A=
+{                                                                      \=
=0A=
+    vsx_##DEST_T##_vec_t result;                                       \=
=0A=
+    asm(#INSN " %x0, %x1" : "=3Dwa" (result) : "wa" (v));                \=
=0A=
+    return result;                                                     \=
=0A=
+}=0A=
+=0A=
+DEFINE_VSX_F2I_FUNC(float32, int32, xvcvspsxws)=0A=
+DEFINE_VSX_F2I_FUNC(float32, uint32, xvcvspuxws)=0A=
+DEFINE_VSX_F2I_FUNC(float32, int64, xvcvspsxds)=0A=
+DEFINE_VSX_F2I_FUNC(float32, uint64, xvcvspuxds)=0A=
+DEFINE_VSX_F2I_FUNC(float64, int32, xvcvdpsxws)=0A=
+DEFINE_VSX_F2I_FUNC(float64, uint32, xvcvdpuxws)=0A=
+DEFINE_VSX_F2I_FUNC(float64, int64, xvcvdpsxds)=0A=
+DEFINE_VSX_F2I_FUNC(float64, uint64, xvcvdpuxds)=0A=
+=0A=
+static inline vsx_float32_vec_t vsx_float32_is_nan(vsx_float32_vec_t v)=0A=
+{=0A=
+    vsx_float32_vec_t abs_v;=0A=
+    vsx_float32_vec_t result_mask;=0A=
+    const vsx_uint32_vec_t f32_pos_inf_bits =3D {0x7F800000U, 0x7F800000U,=
=0A=
+                                               0x7F800000U, 0x7F800000U};=
=0A=
+=0A=
+    asm("xvabssp %x0, %x1" : "=3Dwa" (abs_v) : "wa" (v));=0A=
+    asm("vcmpgtuw %0, %1, %2"=0A=
+        : "=3Dv" (result_mask)=0A=
+        : "v" (abs_v), "v" (f32_pos_inf_bits));=0A=
+    return result_mask;=0A=
+}=0A=
+=0A=
+static inline vsx_float64_vec_t vsx_float64_is_nan(vsx_float64_vec_t v)=0A=
+{=0A=
+    vsx_float64_vec_t abs_v;=0A=
+    vsx_float64_vec_t result_mask;=0A=
+    const vsx_uint64_vec_t f64_pos_inf_bits =3D {0x7FF0000000000000ULL,=0A=
+                                               0x7FF0000000000000ULL};=0A=
+=0A=
+    asm("xvabsdp %x0, %x1" : "=3Dwa" (abs_v) : "wa" (v));=0A=
+    asm("vcmpgtud %0, %1, %2"=0A=
+        : "=3Dv" (result_mask)=0A=
+        : "v" (abs_v), "v" (f64_pos_inf_bits));=0A=
+    return result_mask;=0A=
+}=0A=
+=0A=
+#define DEFINE_VSX_BINARY_LOGICAL_OP_INSN(LANE_TYPE, OP_NAME, OP_INSN)    =
\=0A=
+static inline vsx_##LANE_TYPE##_vec_t vsx_##LANE_TYPE##_##OP_NAME(        =
\=0A=
+    vsx_##LANE_TYPE##_vec_t a, vsx_##LANE_TYPE##_vec_t b)                 =
\=0A=
+{                                                                         =
\=0A=
+    vsx_##LANE_TYPE##_vec_t result;                                       =
\=0A=
+    asm(#OP_INSN " %x0, %x1, %x2" : "=3Dwa" (result) : "wa" (a), "wa" (b))=
; \=0A=
+    return result;                                                        =
\=0A=
+}=0A=
+=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_and, xxland)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_and, xxland)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int32, logical_and, xxland)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint32, logical_and, xxland)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int64, logical_and, xxland)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint64, logical_and, xxland)=0A=
+=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_andc, xxlandc)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_andc, xxlandc)=0A=
+=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float32, logical_or, xxlor)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(float64, logical_or, xxlor)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int32, logical_or, xxlor)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint32, logical_or, xxlor)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(int64, logical_or, xxlor)=0A=
+DEFINE_VSX_BINARY_LOGICAL_OP_INSN(uint64, logical_or, xxlor)=0A=
+=0A=
+static inline vsx_int32_vec_t vsx_mask_out_float32_vec_to_int32_vec(=0A=
+    vsx_int32_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+static inline vsx_uint32_vec_t vsx_mask_out_float32_vec_to_uint32_vec(=0A=
+    vsx_uint32_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+static inline vsx_int64_vec_t vsx_mask_out_float32_vec_to_int64_vec(=0A=
+    vsx_int64_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+static inline vsx_uint64_vec_t vsx_mask_out_float32_vec_to_uint64_vec(=0A=
+    vsx_uint64_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+=0A=
+static inline vsx_int32_vec_t vsx_mask_out_float64_vec_to_int32_vec(=0A=
+    vsx_int32_vec_t v)=0A=
+{=0A=
+#if HOST_BIG_ENDIAN=0A=
+    const vsx_int32_vec_t valid_lanes_mask =3D {-1, 0, -1, 0};=0A=
+#else=0A=
+    const vsx_int32_vec_t valid_lanes_mask =3D {0, -1, 0, -1};=0A=
+#endif=0A=
+=0A=
+    return vsx_int32_logical_and(v, valid_lanes_mask);=0A=
+}=0A=
+=0A=
+static inline vsx_uint32_vec_t vsx_mask_out_float64_vec_to_uint32_vec(=0A=
+    vsx_uint32_vec_t v)=0A=
+{=0A=
+    return (vsx_uint32_vec_t)vsx_mask_out_float64_vec_to_int32_vec(=0A=
+        (vsx_int32_vec_t)v);=0A=
+}=0A=
+=0A=
+static inline vsx_int64_vec_t vsx_mask_out_float64_vec_to_int64_vec(=0A=
+    vsx_int64_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+static inline vsx_uint64_vec_t vsx_mask_out_float64_vec_to_uint64_vec(=0A=
+    vsx_uint64_vec_t v)=0A=
+{=0A=
+    return v;=0A=
+}=0A=
+=0A=
+static inline void print_vsx_float32_vec_elements(FILE *stream,=0A=
+                                                  vsx_float32_vec_t vec)=
=0A=
+{=0A=
+    fprintf(stream, "%g, %g, %g, %g", (double)vec[0], (double)vec[1],=0A=
+            (double)vec[2], (double)vec[3]);=0A=
+}=0A=
+=0A=
+static inline void print_vsx_float64_vec_elements(FILE *stream,=0A=
+                                                  vsx_float64_vec_t vec)=
=0A=
+{=0A=
+    fprintf(stream, "%.17g, %.17g", vec[0], vec[1]);=0A=
+}=0A=
+=0A=
+static inline void print_vsx_int32_vec_elements(FILE *stream,=0A=
+                                                vsx_int32_vec_t vec)=0A=
+{=0A=
+    fprintf(stream, "%d, %d, %d, %d", vec[0], vec[1], vec[2], vec[3]);=0A=
+}=0A=
+=0A=
+static inline void print_vsx_uint32_vec_elements(FILE *stream,=0A=
+                                                 vsx_uint32_vec_t vec)=0A=
+{=0A=
+    fprintf(stream, "%u, %u, %u, %u", vec[0], vec[1], vec[2], vec[3]);=0A=
+}=0A=
+=0A=
+static inline void print_vsx_int64_vec_elements(FILE *stream,=0A=
+                                                vsx_int64_vec_t vec)=0A=
+{=0A=
+    fprintf(stream, "%lld, %lld", vec[0], vec[1]);=0A=
+}=0A=
+=0A=
+static inline void print_vsx_uint64_vec_elements(FILE *stream,=0A=
+                                                 vsx_uint64_vec_t vec)=0A=
+{=0A=
+    fprintf(stream, "%llu, %llu", vec[0], vec[1]);=0A=
+}=0A=
+=0A=
+#define DEFINE_VSX_ALL_EQ_FUNC(LANE_TYPE, CMP_INSN)                   \=0A=
+static inline int vsx_##LANE_TYPE##_all_eq(vsx_##LANE_TYPE##_vec_t a, \=0A=
+                                           vsx_##LANE_TYPE##_vec_t b) \=0A=
+{                                                                     \=0A=
+    unsigned result;                                                  \=0A=
+    vsx_##LANE_TYPE##_vec_t is_eq_mask_vec;                           \=0A=
+    asm(#CMP_INSN ". %0, %2, %3\n\t"                                  \=0A=
+        "mfocrf %1, 2"                                                \=0A=
+        : "=3Dv" (is_eq_mask_vec), "=3Dr" (result)                        =
\=0A=
+        : "v" (a), "v" (b)                                            \=0A=
+        : "cr6");                                                     \=0A=
+    return (int)((result >> 7) & 1u);                                 \=0A=
+}=0A=
+=0A=
+DEFINE_VSX_ALL_EQ_FUNC(int32, vcmpequw)=0A=
+DEFINE_VSX_ALL_EQ_FUNC(uint32, vcmpequw)=0A=
+DEFINE_VSX_ALL_EQ_FUNC(int64, vcmpequd)=0A=
+DEFINE_VSX_ALL_EQ_FUNC(uint64, vcmpequd)=0A=
+=0A=
+#define DEFINE_VSX_F2I_TEST_FUNC(SRC_T, DEST_T)                          \=
=0A=
+static inline int test_vsx_conv_##SRC_T##_vec_to_##DEST_T##_vec(         \=
=0A=
+    vsx_##SRC_T##_vec_t src_v)                                           \=
=0A=
+{                                                                        \=
=0A=
+    const vsx_##SRC_T##_vec_t is_nan_mask =3D vsx_##SRC_T##_is_nan(src_v);=
 \=0A=
+    const vsx_##SRC_T##_vec_t nan_src_v =3D                               =
 \=0A=
+        vsx_##SRC_T##_logical_and(src_v, is_nan_mask);                   \=
=0A=
+    const vsx_##SRC_T##_vec_t non_nan_src_v =3D                           =
 \=0A=
+        vsx_##SRC_T##_logical_andc(src_v, is_nan_mask);                  \=
=0A=
+                                                                         \=
=0A=
+    const vsx_##DEST_T##_vec_t expected_result =3D                        =
 \=0A=
+        vsx_mask_out_##SRC_T##_vec_to_##DEST_T##_vec(                    \=
=0A=
+            vsx_##DEST_T##_logical_or(                                   \=
=0A=
+                vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(nan_src_v),  \=
=0A=
+                vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(             \=
=0A=
+                    non_nan_src_v)));                                    \=
=0A=
+    const vsx_##DEST_T##_vec_t actual_result =3D                          =
 \=0A=
+        vsx_mask_out_##SRC_T##_vec_to_##DEST_T##_vec(                    \=
=0A=
+            vsx_convert_##SRC_T##_vec_to_##DEST_T##_vec(src_v));         \=
=0A=
+    const int test_result =3D                                             =
 \=0A=
+        vsx_##DEST_T##_all_eq(expected_result, actual_result);           \=
=0A=
+                                                                         \=
=0A=
+    if (unlikely(test_result =3D=3D 0))                                   =
   \=0A=
+    {                                                                    \=
=0A=
+        fputs("FAIL: Conversion of " #SRC_T " vector to " #DEST_T        \=
=0A=
+              " vector failed\n",                                        \=
=0A=
+              stdout);                                                   \=
=0A=
+        fputs("Source values: ", stdout);                                \=
=0A=
+        print_vsx_##SRC_T##_vec_elements(stdout, src_v);                 \=
=0A=
+        fputs("\nExpected result: ", stdout);                            \=
=0A=
+        print_vsx_##DEST_T##_vec_elements(stdout, expected_result);      \=
=0A=
+        fputs("\nActual result: ", stdout);                              \=
=0A=
+        print_vsx_##DEST_T##_vec_elements(stdout, actual_result);        \=
=0A=
+        fputs("\n\n", stdout);                                           \=
=0A=
+    }                                                                    \=
=0A=
+                                                                         \=
=0A=
+    return test_result;                                                  \=
=0A=
+}=0A=
+=0A=
+=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float32, int32)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float32, uint32)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float32, int64)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float32, uint64)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float64, int32)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float64, uint32)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float64, int64)=0A=
+DEFINE_VSX_F2I_TEST_FUNC(float64, uint64)=0A=
+=0A=
+static inline vsx_int32_vec_t vsx_int32_vec_from_mask(int mask)=0A=
+{=0A=
+    const vsx_int32_vec_t bits_to_test =3D {1, 2, 4, 8};=0A=
+    const vsx_int32_vec_t vec_mask =3D {mask, mask, mask, mask};=0A=
+    vsx_int32_vec_t result;=0A=
+=0A=
+    asm("vcmpequw %0, %1, %2"=0A=
+        : "=3Dv" (result)=0A=
+        : "v" (vsx_int32_logical_and(vec_mask, bits_to_test)),=0A=
+          "v" (bits_to_test));=0A=
+    return result;=0A=
+}=0A=
+=0A=
+static inline vsx_int64_vec_t vsx_int64_vec_from_mask(int mask)=0A=
+{=0A=
+    const vsx_int64_vec_t bits_to_test =3D {1, 2};=0A=
+    const vsx_int64_vec_t vec_mask =3D {mask, mask};=0A=
+    vsx_int64_vec_t result;=0A=
+=0A=
+    asm("vcmpequd %0, %1, %2"=0A=
+        : "=3Dv" (result)=0A=
+        : "v" (vsx_int64_logical_and(vec_mask, bits_to_test)),=0A=
+          "v" (bits_to_test));=0A=
+    return result;=0A=
+}=0A=
+=0A=
+int main(int argc, char **argv)=0A=
+{=0A=
+    const vsx_float32_vec_t f32_iota1 =3D {1.0f, 2.0f, 3.0f, 4.0f};=0A=
+    const vsx_float64_vec_t f64_iota1 =3D {1.0, 2.0};=0A=
+=0A=
+    int num_of_tests_failed =3D 0;=0A=
+=0A=
+    for (int i =3D 0; i < 16; i++)=0A=
+    {=0A=
+        const vsx_int32_vec_t nan_mask =3D vsx_int32_vec_from_mask(i);=0A=
+        const vsx_float32_vec_t f32_v =3D=0A=
+            vsx_float32_logical_or(f32_iota1, (vsx_float32_vec_t)nan_mask)=
;=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float32_vec_to_int32_vec(f32_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float32_vec_to_int64_vec(f32_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float32_vec_to_uint32_vec(f32_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float32_vec_to_uint64_vec(f32_v));=0A=
+    }=0A=
+=0A=
+    for (int i =3D 0; i < 4; i++)=0A=
+    {=0A=
+        const vsx_int64_vec_t nan_mask =3D vsx_int64_vec_from_mask(i);=0A=
+        const vsx_float64_vec_t f64_v =3D=0A=
+            vsx_float64_logical_or(f64_iota1, (vsx_float64_vec_t)nan_mask)=
;=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float64_vec_to_int32_vec(f64_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float64_vec_to_int64_vec(f64_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float64_vec_to_uint32_vec(f64_v));=0A=
+        num_of_tests_failed +=3D=0A=
+            (int)(!test_vsx_conv_float64_vec_to_uint64_vec(f64_v));=0A=
+    }=0A=
+=0A=
+    printf("%d tests failed\n", num_of_tests_failed);=0A=
+    return (int)(num_of_tests_failed !=3D 0);=0A=
+}=0A=
-- =0A=
2.36.1.windows.1=0A=

