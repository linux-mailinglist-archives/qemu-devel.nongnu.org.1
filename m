Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7B7DF47F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:03:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYH4-0003uO-1a; Thu, 02 Nov 2023 10:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qyYGt-0003t8-S8; Thu, 02 Nov 2023 10:02:07 -0400
Received: from mail-eastusazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d003::] helo=BL0PR02CU006.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qyYGr-0002cs-Ln; Thu, 02 Nov 2023 10:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQb15NBS5LVxAlF5AMDqu/i878MlQfOdzX6iZugF71RdfBzNsu5BcqdSwX8b2GMNt8CIwiG5jKGgx2wVzSnjBbAbYN6tJHiQ79BgilbolwZuTQiJETZTAuo41Sro0dtfnCwWM3iCzreT9Qnm4tzIxH/N9dmW1eTWPwBWVua/U0ARKG6iyoQbFT1qq9Ey5xJDL7O0PIR3Dglr05T7k91BN3dKVPxDKVeJOaBfybQPtXOQocUZ2m6bhhjpWPo++nVKwr5Y2YcRHUnPQsV796Rn2yL5f6OqoeJcybHG9Lj+7kf9OGFt3/iFN05r/DATXbUPCzlP/uZPPp6y86Ubr4iOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2l9v1Kju1D5Wsay+F7sjs5CP6ZFnMhj33c4rQxqc4A=;
 b=nD8isLaoLEd+1Nq+tX6liHmHVDlr5FofFyJD7sJO8yGQ+shifhjsfIPx3bWXQ379Zn9dToolcmHAVh4y9azsJxpHevJbs2rLqrqcskrntk4qhcuQSl+ysI6NzacjX0QvaSYNq7lVKV8qzMu0Mi9Hl/HNU/fogfTnYklMs6JjFukZgGqqEy2OP49aIaG5WxUDaDgnGFzQpgLiU6YY0VpmEeM+8xTwZd/s0xe/cxqXZvoNwA/AzYqV9GidqI1VUpkvyyuITRyRkna6O0L3kw4y9dIX3jiY1TSBrBDNo8JENiskP52YkcLEgY5P07d5gLm8z49i0cZ5jDKjfCdSPA2rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2l9v1Kju1D5Wsay+F7sjs5CP6ZFnMhj33c4rQxqc4A=;
 b=KVcBouR6WHMbweR/jZZhW8+VZn55OSQyzjZSc0IogufJfkd2LbgJoGpPQAGAP8F3WmzGJ2PG4FH+4ikD6LRL/sFN5S6JlJzcKEbkjugB+kMWRA9a1smJajytp0frzY7xTmNB6eTG4AjM8y+dDLmz4uoK0PibyrlZGdPXpGtQZVwhrN6vUipX/zdCSUmVOgGCx9WpxKkGqNr1g/Y0gzOn3tM+NiVm+GnxcEDwT/j+g5UjMNKKHY8k6RKBLnoH9eaN8krXoOWPtTJBDd4cYUFvJhxWZuIE5hjnHQQFsb3YGzT2k8HWpQHJRHp8ffkc4XzWLgSl6j4gjgXFeGi5HCFyXQ==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by SJ2PR05MB10331.namprd05.prod.outlook.com (2603:10b6:a03:562::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 14:02:00 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 14:02:00 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH RESEND v3] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH RESEND v3] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaDZQIlHYyZLq6JUiV1br/e0ln9A==
Date: Thu, 2 Nov 2023 14:02:00 +0000
Message-ID: <SN6PR05MB5837F9E7772575289B986C5D9DA6A@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [j1ZHll3TByAhLiaA7ihRe2SIqxNyMy3S]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|SJ2PR05MB10331:EE_
x-ms-office365-filtering-correlation-id: 261a9c60-c5ea-41fe-0fa2-08dbdbac48b9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njUdoMcHtKt0wKZvQxtnM0yKB1n5VRJaiVIIeH1BzdgwlxY1AoPE8IXC1qEit0tE37bzeWO1bP/CCW+FUNWTy+CEqzOdijpUPb9awPXTO9YGZzVMBRiYvvGyJf9sjsfpJs0k7YTzRlcNTW7BrnQc27XE2VvRuwYzCd6cDASWvtX6fXBernSdfbzEkKLgMM1/VYZwoEDJE0Rks694mwZaoBOSnF/pBhByPDqT/VDuP0n+TfwJzq0FeuhlgURzIlcRVvRC2P7yialVSbQlUvkVfl4vgqMcjB3LqxdyoYUPkDY3EteVK2+ENgW4OGaRYsIoFYWvTxz2Rh/HKhSVysA2QtEs5rxRZaj/CmDLpE1oiJ3I1A8PFOmCXjr03tN/cbUsAeV2SfVPHq9cODxdFTbV30VGcCCCy9D+OaKSBhY2ae0rXDNlxB5knKdA2UvdEinMtIKC0Uw6DhPosQUg8zplfhQ5hFLtIsKTKo/kxQNj8GlUKejIhP13I3wLL+ZahSM3BSkY4T0Vvezg8fCLnabPlw+UwtSTCJRlQ3JrTEty29tX1NvLbCWW3oWgNSR85tOfCIxpwiUSWh/gMqyziQuhwb2mbME8hR8gtql76Nhup2Y=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?imfoIKsfeEMO8SegEeD3CvrvBA+BAxcVmuzyQ5iuhlVqlpkVZTqCR/fA2b?=
 =?iso-8859-1?Q?IPBSXIJMtBtp4+f8mvIqxz7smZgjp7omLk9wKvELNT/V5NjmYAiL9yZZKd?=
 =?iso-8859-1?Q?K+BmswjdhxwnqSI+mcOMJtdsvsHSROOXkD0XfGs4NmT4ekRKO6TAfoAM9Q?=
 =?iso-8859-1?Q?8Aq2DNxs4n70ye0AhFc0lDj7U8bACDaSrcvgDDbRoWfHp4gPcdkHLHm97s?=
 =?iso-8859-1?Q?GnQFzr/NPHmNEBIyPQGS4Aftpu/vY8JlDlO7rJo2XFhWfg98ZAc+pg4D/e?=
 =?iso-8859-1?Q?o67E2HZgfeMpMtyrchLTmF9NHsmTmJxIy2cedE3qK1afZH7GkKw1kgUPay?=
 =?iso-8859-1?Q?fqpBmLqh6jIpSQkCtXodgADlKE010NlDGNyub2SKbKZBZ7sfz2TMZkIfB+?=
 =?iso-8859-1?Q?gCVgJQmc7TtTmjc3fkOBH9t1NrDEchjY1n6TJtMaLJa1Cio3Ci0Id/yKer?=
 =?iso-8859-1?Q?LJPbATK6rOkxeUSUpKs6cgn4acF+GPb5FmHdy5fjWt4nH8RCwOghh0ecIm?=
 =?iso-8859-1?Q?J7j0E4c0To+Q2xBhGf5qul9zKESPewQqbjw4Cs6kBmHxlwYMDX369gAgS7?=
 =?iso-8859-1?Q?5Q8yTnzYCtntvNNrZeBkjCyHmeaYfx3JlaRpK9h6Qxe+WzlUXfTbHcBJa2?=
 =?iso-8859-1?Q?P3YJmwUMhVOgftCtBp4uGd+w7PLey5RLresmCAPv5T/zX0NLOf76JcMhcC?=
 =?iso-8859-1?Q?Km6KeJsbigLNfM3K0xcnBqxpD/yHZ0w8AyMrIcNXE2Nlsk43i/ZkSxDq3d?=
 =?iso-8859-1?Q?Jqkoifo8OktUsnnrgXerPaXz8KjbqtgNfBcjS2uAB5yPfRgplOi+XZOEFX?=
 =?iso-8859-1?Q?PolAoeD0WApxUeWsCHUbSgNp2KUg5jdE7cSrSk3X3bEMeF/vlqyt0hS4HG?=
 =?iso-8859-1?Q?1L93mthmHilA7KL+K8QZEe9FuLW3YJ19C+utBGEUoj3FmlvQ/dWYqa14HL?=
 =?iso-8859-1?Q?q5zd5MT6UIIL1L/mKkMgBV7WbUVHKR8hAZY8LM3v/xFt6E9uItI0Eieb+T?=
 =?iso-8859-1?Q?7h8dp6QmUD783/EKpZwJXc2JaPPIPa/rW2+hIw69EXEMZs71xvNN3Y2g/q?=
 =?iso-8859-1?Q?hR2Gq+h3wkvkt2NbTDgAL6WHHb66KU53ZBJ3HTJ7oQe3W0qC+XI/0sqYzm?=
 =?iso-8859-1?Q?qyY50cQ/tnGWvkF5qKO+zbCPOlzrGvtDZ4pn6Ae7P6wwjLt042xfL+IZv8?=
 =?iso-8859-1?Q?YFutWChRMNrkAR+tQfFJ1Rs15/zMYCc+5Flds0hYdYz3b1ljMeob/7/qV7?=
 =?iso-8859-1?Q?dYZIVvBdtUpqC2HtpaexvvaL43bkDjqomFNZj/Gf4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 261a9c60-c5ea-41fe-0fa2-08dbdbac48b9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 14:02:00.3634 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB10331
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
---=0A=
 target/ppc/fpu_helper.c | 12 ++++++++----=0A=
 1 file changed, 8 insertions(+), 4 deletions(-)=0A=
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
-- =0A=
2.36.1.windows.1=

