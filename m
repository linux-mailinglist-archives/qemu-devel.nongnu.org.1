Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C649E7E8178
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 19:29:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1WEM-00066z-5l; Fri, 10 Nov 2023 13:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1WEK-00066C-1J; Fri, 10 Nov 2023 13:27:44 -0500
Received: from mail-eastusazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d003::] helo=BL0PR02CU006.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1WEH-0004fc-OS; Fri, 10 Nov 2023 13:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gc9kZ1s3X8Q3sqD6LYAR0RvEejMebWIuX3yz7nUEtVdFXYXt3jyhEnI+rABtgM/dxcy4VHbDtNKi68sp401nhzYd9nNriqzSjXKH0/oEZL85v4saSOLut1Wby26q/Gg5HSA/o4RcgnGf/2MBIPhlx1cXaqiuahUbB0vCYc7BYEdvuH9UgrPwdvCCUPyhoVszKn3MU259VapMtGqo7eKPzPHUMkl003S9xgh0/PmerLC5c+dloSYHXa4vPBc5TjiLv/4tV8JZ1FbWbAezynqIEhMxLsUQwTZYOSFWyqlIV2+oNna0aK5nOcCSA/68Sta6P7DULWl+qIqarbUwsQfRDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un0anCFyOXdhDbDG+9UMTSlAnqZ2ffvMQMJyZMRnVlw=;
 b=k4AzXUzLM30O9sNWF7mp7hDq1KgvJrhgMQgxO+0JXDLmB8u1gWZBBiK5St/p5eQxcFGSpdSjqruGeMxw4CMFfDZPOrssVxQJ4SuVUONmT8ebquGXHzJ23+geqHIGIll3IwK8LNuWX+v+TCwWxQG+25xS/Ut2rLfS8tu0fQztR/jXY8IQaW05PY2CmNghOiZE5QW3j38pRSVRlgIGDavn1FQApsTyWtlTzdnOEP+x9j8F1F69RD5v35SfezhMpWJInkihxn+v7r5Hq5VwQ7OIl0LGyRYp03LpY5Xa5lLTHPik1vHkp0DmXPc68dPxxOG9XBUSzaPZEjFRVovs9d41Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un0anCFyOXdhDbDG+9UMTSlAnqZ2ffvMQMJyZMRnVlw=;
 b=Ry0YOVgqjSRQlqwejuxDrONFo9HXKPVgVwJItAhsgBViezL4DbEtLLnbsHik9Kj0lk3RqkNbnbNgFS9mQ6jn0C6HW+3L41/13p0mllAXXXzMQI9vUQ5KCUAYSORl5720WZRW8POhpAIhY8wxlH51+A8jWrzdURyTN5DiCYSBmuAmepAM9QhDtMciWrd4Lt6YJOFretdH4GKhvzgoX9RjFsOBBGMusY7STz0lu4syevw9POT+S7LW7pHuFy08lkniV5cDUcH+1XukWFHQbYSDhF5zoFWKEb4ozJ0Bi98fEXzv6iWJoPtzVh1g+CohpSb5FKJoFlo18BVJM7NnlDj6wg==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by DM4PR05MB8965.namprd05.prod.outlook.com (2603:10b6:8:a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 18:27:37 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 18:27:37 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "danielhb413@gmail.com" <danielhb413@gmail.com>,
 "clg@kaod.org" <clg@kaod.org>
Subject: [PATCH v7] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH v7] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaFANGWJr1fE0XHUOzAWU66BtTKQ==
Date: Fri, 10 Nov 2023 18:27:37 +0000
Message-ID: <SN6PR05MB58370F77399C914614D4A9CE9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [fE93lYw/4MJ/NaKJ500SMML3HXyPyfEsmA+nYVvIk6lt/Q6Qsakxlr+ymN/UuEk7P65c8FARmug=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|DM4PR05MB8965:EE_
x-ms-office365-filtering-correlation-id: 124d60c4-9d6e-44c3-363b-08dbe21ab715
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wh1oni09LRVNEO8pj07MipQMsyvtcBXsyOSEUEuB8gkhU75jSApYHyteQVIUk/8eBFpoAAj/NK/mgMbSMED5BNa7qOJhMPpCxQKV5HcISz9t43C+xz0hQhvCZaH687d5d26wKVbEs38GmfOZEz+11FPTiz3t9FJzr1w5AwbB9bfHbon3ub8UaiFr0dR69gkr13DWEDFrAEKuCdNOHjb4DzMqvHzKSpfS7nM22xaEDjPkOn4aYciy3yYsh1ACvMFlcSp7rKRrNMVwe+9qO7Mob6aVM/Tf2jOuC5um49d4D69rhncYecrfsNzfup3PBxl7Flmd2YWINTjG31CMC8zFObaMLVz76Nm4s0LPiC58eGRmiSUKClTL8oqSh2p/F/G3keFgRDudbKt/noKX6iIEg8kfukCxLWkUoHQLGIn5SfTLtRLkZwbvSTald4sM4I+DSFv8Q341G9X5fMIF0Z6MuHOtC33DqaXa72kyic7ZU/Vabnsm5VLQ8Lp3Fwcikdy/TucX/yjAQi5McmsVrdvpQE8xaigu31kcaU+Ix7IV1Y+1rWi2LKa5uk8aLz/CxNbUKKIgW2wyW/uJ1IAwrbglA0PdKofaCfIGypq2ipFG1qQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4jRyA2P6dVR2BZ7GV7hmLXW3SqHjVct3tQfl+/K3zMiG7jdvRXxZLKnRYg?=
 =?iso-8859-1?Q?6ZglX27sZTQVL3gye2EBi0dcO3/itB3cMPbK9x7Du+utkYyVqurXjD7BGW?=
 =?iso-8859-1?Q?9mJ9R80Xj4z6zX40AoUoKRNLmwWGELmgHpWCrzfwv7JA6eXdga0WQ5+uHa?=
 =?iso-8859-1?Q?95mZPcZehvwCSCQpF5ZC8KZ9Vp0w3R/zCDENGMjV75w96AFH9idiixnNhE?=
 =?iso-8859-1?Q?nB7B8Gy/C+T3mzUrQHkODGuO4rlvClX+dy9rs4/yjGle0UCjzh3bHA1cTR?=
 =?iso-8859-1?Q?VK9pf7x3+e5FKTrZmCQtgHLoSR49Hc558fYWjj3qDXEZeKfpNft2E6f7iG?=
 =?iso-8859-1?Q?D0aPUfmDIuyYk2OLpGXbe79sCuPgwKwspcO3rSb+Ghcpriaj2cAF1RKcDL?=
 =?iso-8859-1?Q?4d0uxGIK0DklTw8MwmNpGTmjVjvVNzxTlZDrInI9c5SaodjuUKHhmS6TlB?=
 =?iso-8859-1?Q?kuOTpjA+DxamKmEC/eTgm+5YthduS1+8OYqOjV2i7fcXcDjfH8Nn2yLbsp?=
 =?iso-8859-1?Q?UcuggUIaJFfBVwT/uSIre4CU1vM2djNv5oFvkNRpicWvgoRocN50ctZjMD?=
 =?iso-8859-1?Q?uSWW5KNxxZJazOWki6Z28WwXtraC2Ck5WVX83VuZvd76f58SulRQDdCHuP?=
 =?iso-8859-1?Q?CFuocHP8AV42A1lh+pzcn8lT4MqRQ5yANF1kYt21iC6H4KYxrGHSdFVtOk?=
 =?iso-8859-1?Q?X4LG/ZHJqS/3N7fhTgl3HdEmPSiYyDY7SOCQ+VH910/3JcRIw6D2uQDB2+?=
 =?iso-8859-1?Q?8UezAkcd2/ozWqKw5Z5r0KquXX9ja0BVW/AXLyRwC+GoSuYkPxjcHOj9Gf?=
 =?iso-8859-1?Q?bNiBnhug37MsJ0mx+b3ee+9jr/4toFR5haJ4sByY3cAUoW9rpwnu4TVxXR?=
 =?iso-8859-1?Q?P8XokdOG4GtTJmAfn/ZjcbWwKSbwWfcKlflpPR+MHh2sbB7V8u/DQSPctg?=
 =?iso-8859-1?Q?NJnvarIvk2lx/bEBJA/guDmGJDB1OT4GllstA5rbye4eqbJ2mst+smkbnF?=
 =?iso-8859-1?Q?FsoCi75z2Xeei7x3B+qNyub70JF/sAeTU/jh8C3c9BhajgeSpjdD2DeRsE?=
 =?iso-8859-1?Q?04bi38luSdCK0CLWLBp3mqc9lxbxuWH3HVBNuyzqFwhArnpDHwlmC3QA5l?=
 =?iso-8859-1?Q?3c1j4RA8q0RsPCbly7DKvPHnc1kxDUwq6tNb3cJ24h4uuQXelL9oFLI2Vz?=
 =?iso-8859-1?Q?vD6aYJV6kfvqo+5Iitoly1gVCCD8j1tODRFsTwHK0bxamQbz7Bh7Qs00Ha?=
 =?iso-8859-1?Q?n6bfqp/hWmpauvg2Zod1koFbbwTvxdEv7PXngRjWsqbaeSC4yLlJ8WAXQr?=
 =?iso-8859-1?Q?k19AYOm0GYklb8K3Xmj13QdgAEXrboIjIAjCZeLebhTdHUc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 124d60c4-9d6e-44c3-363b-08dbe21ab715
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 18:27:37.1653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB8965
Received-SPF: pass client-ip=2a01:111:f403:d003::;
 envelope-from=john_platts@hotmail.com;
 helo=BL0PR02CU006.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 tests/tcg/ppc64/Makefile.target |   5 +=0A=
 tests/tcg/ppc64/vsx_f2i_nan.c   | 300 ++++++++++++++++++++++++++++++++=0A=
 3 files changed, 313 insertions(+), 4 deletions(-)=0A=
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
index 1d08076756..ca8b929464 100644=0A=
--- a/tests/tcg/ppc64/Makefile.target=0A=
+++ b/tests/tcg/ppc64/Makefile.target=0A=
@@ -16,6 +16,11 @@ PPC64_TESTS=3Dbcdsub non_signalling_xscv=0A=
 endif=0A=
 $(PPC64_TESTS): CFLAGS +=3D -mpower8-vector=0A=
 =0A=
+ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)=0A=
+PPC64_TESTS +=3D vsx_f2i_nan=0A=
+endif=0A=
+vsx_f2i_nan: CFLAGS +=3D -mpower8-vector -I$(SRC_PATH)/include=0A=
+=0A=
 PPC64_TESTS +=3D mtfsf=0A=
 PPC64_TESTS +=3D mffsce=0A=
 =0A=
diff --git a/tests/tcg/ppc64/vsx_f2i_nan.c b/tests/tcg/ppc64/vsx_f2i_nan.c=
=0A=
new file mode 100644=0A=
index 0000000000..a5280fa217=0A=
--- /dev/null=0A=
+++ b/tests/tcg/ppc64/vsx_f2i_nan.c=0A=
@@ -0,0 +1,300 @@=0A=
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
+    if (unlikely(test_result =3D=3D 0)) {                                 =
   \=0A=
+        fputs("FAIL: Conversion of " #SRC_T " vector to " #DEST_T        \=
=0A=
+              " vector failed\n", stdout);                               \=
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
+    for (int i =3D 0; i < 16; i++) {=0A=
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
+    for (int i =3D 0; i < 4; i++) {=0A=
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
2.34.1=0A=
=0A=

