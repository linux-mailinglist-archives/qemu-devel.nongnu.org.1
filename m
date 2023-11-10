Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185137E7D61
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 16:22:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1TIl-0002ug-0z; Fri, 10 Nov 2023 10:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1TIi-0002u5-2j; Fri, 10 Nov 2023 10:20:04 -0500
Received: from mail-westus2azolkn19010002.outbound.protection.outlook.com
 ([52.103.10.2] helo=CO1PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1TIe-0000Cz-Iz; Fri, 10 Nov 2023 10:20:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpoNug4yc5w0gcr/KyKvwuT2cfFYAMdU+96BM9iScUIBULlCTG+QwxcXXFp16aVPb7omg9F3r1QVB2OtAtojNdp3rXdErYHcmy3hsoIylGpmgiOqcww9Q7ZUYhlQyh/iaGAV01N5J42NBXiXdyzUjyBMio0SEREYyuf6jWS5389uMvkfwtM2EpGIlPLyDv5Hx0ZXLd/mrsA7evbTgI6b5nxPICokCBvDCtqrqkANQSc7hS92DnQxp7eusP3qidsNuiplIl6LUTqpXQc0GeeQNCINnFfu704b4cbRJILJSqjlQSfF1Zzopk+d0bpWDtpFUbE8LmdISfZeb721/3GGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXIMu87YZ6+1Q5R7CFdS8g/xTZRfpXWVLtgWBZKpbGo=;
 b=n7X/EfUfuHPNUiQfbkrd/eDJdNmR++3/6LQtvsxnC04EHWvys7zQTuJWhbzX++/fkCnc7rmiNX4gY/EjfX0Eeqj5V0e6D9438gNWsOg/fBOAeZg6Dtn5Amx6Pq8Tp+qbOD72zJ6P0tx01wc8R/TdbxGJSYam1wmLGN8p6DOflr79LzWdrWWyaAHgNhmC7cktmpoKXtIM6mcwpIz2vfgfGaCkfeTTJBsi5J3d3fgAolUQdXXhaiUhaj0aHwyhDEwQHodx/I1FYkSJuU7s0ma1BvagHuEOr69Tl1l7XUjksm6EGwz4bQgsasgQe8c1TOI5pRgGiFU4ppltk7yUwydcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXIMu87YZ6+1Q5R7CFdS8g/xTZRfpXWVLtgWBZKpbGo=;
 b=h5TVWMSKzBbaYCzIng3azlG0h1YwTiCuvmfENiKviPN4FEc4c7HTYC80obypE7kEExrRPTv/zpSKM4RLvSudyAgJ3r8slE1Kuj+qLWDG5aQwkEF+NCyUJmwfiOuY0ahbd+UT9hff0VmCSyIcestOVayD3FnzBY7Q3Jom2zRpfMioSTuFrzBRX6dtsm3J1weBWPA2a86VXbLOG3VuAQ/ibVR87ILaV6m2sVxHQejnSyEUQSDXyPaE28ZXDOmOoBrkMYIhonzkGjksS1fSdWCDT/uOw5NFwhhV5an+JGK7WBlQHVcV96HKuJN6PGUTrmEGBf4cLxic08LNq+Ap1Wd71A==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by CYXPR05MB10483.namprd05.prod.outlook.com (2603:10b6:930:dd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 15:19:43 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 15:19:42 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH v4] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaE+lU1y+mnp/NNUqa1QAOQZ/Fdw==
Date: Fri, 10 Nov 2023 15:19:42 +0000
Message-ID: <SN6PR05MB58378D2FFC111C3C8482CA3A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
In-Reply-To: <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [SBK9mqLrYpAW0XQJ1B+74WoGFKszLHlLPMXRF8PyTOHD/dZNfZM2loNAc66yC1YJEn3XtGjjimA=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|CYXPR05MB10483:EE_
x-ms-office365-filtering-correlation-id: 282ec07a-a9f3-43f9-8059-08dbe20076ff
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VO80MMOC59Hb4mcvn6GnwXNs/7MJurhRds6Li1606y61YuJVfUE1ZiToz3DjkQljvMqcDTcH7/PK8nUl2/hmWwuJTsUAsc2IdjWNWhIjS56qyQ5BHUgNo8A124SGY84gH2j0sZ1ga0C2Qy8EzQHc9mL7SblVwD++2xSPnvHgRWUFhizwwKf2o9LcsKE/EmdRFM77dug4/kPN8Iu1abXa0C2PoNve8YfPGUstYfO97N1yUgvcFVjSpaxeJFzaEE9TDpvN7uka1ZAJq+QeP/EA4q+XpIRBSkfTfeM6CyEC3sPTZnqO6hTgTv5uH8hW6+RecdPVfvHWVHgKzP83EL3fzZCx3ml8wCQbCDahww2kFIfSAAeBMo9wfslgfxnzqVhLXQG8jHhuDN3z/FbmXoBwVdFwCOM5lxE+2s+cPhen/RkNM8mWcp587nPdMKbL8kjrX8TVDWVNC2OJzBjyMgNNFxdyJkwSTBIbohG6SK/klaXXr12/ISsAIpUCwKfnXkaZAm3o5jMIvw7GCrjCT73TMs12t9g+k96RM/uokq0JiPYV5Gd3dtA9ELcLMC3fQj/7w7h+fBpw9CYE5eV6IG6c/U7zRedeSR4aZCyTCiGkrNo=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vFCzEHlb/8oANghl0TZZ5KZfOphs0w7yFYbxN6Dysdcl7MhYTJTO36Lffr?=
 =?iso-8859-1?Q?mF743wseWyOWJnYmO+2YBFodZuCGfHmRwDBDgF8PEqXz0yNfnfoIqwDk8d?=
 =?iso-8859-1?Q?XD4jQ0TPMZHSq9Z4yWbb+SIVDavy1jwv4FyOgiKR/VhZ3FscbVpp2oEJVT?=
 =?iso-8859-1?Q?0TV/00PQGI6MhkamdG3dXZcCsSp28q2J8maP23iO5YgJGyIKrDxgq0WOst?=
 =?iso-8859-1?Q?+HyViQtkg1ofOaY8hqXTavRewidTbaer++R7R1UbM1qJ2ayOMxytKtyXCV?=
 =?iso-8859-1?Q?McR0Utz6EF9ciO07AMzuCkcTJVcz6P74AjJWn7XU/2aV0cWDGpyflS3OzX?=
 =?iso-8859-1?Q?qdD8L2aClvQhiC6solLRIIEJYXP0oAya1Yb8xODS3j6mb5F3WNZu7QaVrQ?=
 =?iso-8859-1?Q?Mz34+mKK4gHSUqqTXYomjaD0L4wtj3eCZloaUI4HjHG7c/jaNPNcEs9ZIq?=
 =?iso-8859-1?Q?jVjVLrM079uHWUYDCVH81bj3edyeenW4VpL4Mh+mYRkb+UAGbXTI2Jg7tC?=
 =?iso-8859-1?Q?tuclLanUcjau6EMo3GBuTYDjoeK/VNCmAlgArpAdsT3mOCNzvbhjI6OU+c?=
 =?iso-8859-1?Q?2T2wMUg/x1y5YnI/m8PNRP4AGsLPYrSUMAx2NFGQmMyyzCNxHpuyCYze2t?=
 =?iso-8859-1?Q?Hy6n5gGiN1SRcEhJ7qf6Rb12u9TapHlUxf0X/HQJDi1JjoMdbIYSopsmD9?=
 =?iso-8859-1?Q?OUhhKydJqv3S/4kZrCpyB1l48IGIJKrg2pHQWYsCEUgD7UvkYpRxaJXT/T?=
 =?iso-8859-1?Q?9uixHuGVlr8srneoUv2hBvep9Y0YqUj8tpiSxPB4CJIgxEuSr4/YBamGv8?=
 =?iso-8859-1?Q?SV0UqYoVGHlf1SwMfwemlBOm3K0H7PLtLaLRLyK7DkUIjXz66lqX3tmzrI?=
 =?iso-8859-1?Q?j53Xbu4uscfVgUQnJ6Ju41SBHIWGZ483eH5GsZM9j/6ouV0VwN8FYTvej3?=
 =?iso-8859-1?Q?0QoWAGnFWtRg9ONu+sUmTbuZSu/QVIy4NhYuKV0H9f1S4MPKUVRr9y05l2?=
 =?iso-8859-1?Q?EUnudtgz/x+/wlo2q9yK6CSNe6Uv4aQVj/eUVdrclC7HKzRtTtamqxQmBl?=
 =?iso-8859-1?Q?xMCZbazm0vG2fB0zm/oYEixrdNVXiQ8FqTIuJJJ5rfJTlCGR8Tl3QXCUy3?=
 =?iso-8859-1?Q?/wK/ui0TL/fJJcvMax74aTHn3BIIkqD1+ZaYx/HSdgyDTI9UwkjkBFKuQ4?=
 =?iso-8859-1?Q?97l7ElRZXuUgY2sKfXqMLe3xhaQHyk7l8B+onS3V66zRWMsAt0Hc5Zq0V7?=
 =?iso-8859-1?Q?kp6XQP87JsiOWxrgapPn4Z/IJxdvQFBzMJCgeUH2rhAHEbIlVgaA4zAy9e?=
 =?iso-8859-1?Q?UxwTZpgdJJdppknf4HQDwsc0WCOTFsJ/YjVs9tg8jI12VLs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 282ec07a-a9f3-43f9-8059-08dbe20076ff
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 15:19:42.7271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR05MB10483
Received-SPF: pass client-ip=52.103.10.2; envelope-from=john_platts@hotmail.com;
 helo=CO1PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
c/fpu_helper.c was introduced with commit c3f24257e3c0.=0A=
=0A=
This patch also adds the vsx_f2i_nan test program that checks that the VSX =
xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcvspuxds, xvcvdpsxws, xvcvdpuxws, xvc=
vdpsxds, and xvcvdpuxds instructions correctly convert non-NaN floating val=
ues to integer values if the source vector contains NaN floating point valu=
es.=0A=
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

