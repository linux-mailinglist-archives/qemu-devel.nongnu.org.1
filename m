Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2787D59EF
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvLWl-0001zC-EJ; Tue, 24 Oct 2023 13:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qvIWN-0008Q1-19
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:36:39 -0400
Received: from mail-westus2azolkn19012036.outbound.protection.outlook.com
 ([52.103.10.36] helo=MW2PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qvIWK-0002mv-SX
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 10:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEDOnRYuK4vbrtF4+lcWHNXU3lMazYhwQLJ96oc/Krtkorf0J5v24hYsNt3zEYodWMvAYFLDJVvXUoMzVB+baTMsmn/yV4EV42ufOvjc39q3WTILxwCgkUApi84mTQ/pQyWOJeH1jA0VodZLyqP4civJaEfpJcCKs434xfzR0gLyYN3VAYyCyDDv6kZUr2LkobaG9wzuszD+4jq4PQkiqt8ePPSFUgigp0c+SGMKWfYczsSGL1Qf8a89r9rN8rpcXtd/t8rNJAWH5j/e0D2h/CZ1uRhncAcARtLmEqyQjciulgS+Y0ySG6SkRQU+wTGRAeJBaTVQd0n1ug1BABc6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wZ1gDLrzS7qPvJTW/StAVikTmWy5YjB5GDS3qDDgCw=;
 b=U7EGNfGCOGGwGTEfDnmLKGTKzW2QTjXMkhcrb88NrvXCF6JzPA6Hm1UDBsXoNjQKqlWzLQ5d9SKCLdu7gSBPiDFJP8VaH6HqQGFh341vryujMiNI6VV6Wc9oDLwFH78bi1GTO4V3L7UU8Q120fXGEYU47TPYo3r1AKsJMjxxJBqHWDt8xKjqyxROdIeOC2vTTWdqtz79QaBZQlKk/9whZ6PoCsAJ7P2MNP8StFK8YyUim9xRrgVqwZMjW0z2R7NeQap7mec6ip0zNYijEHe+Gqa3ztDD/Si+WMTKRsgXYyt+/yt5+4BciMGd3wwF5wmmLmwfDckYtLG++gVFpM4DMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wZ1gDLrzS7qPvJTW/StAVikTmWy5YjB5GDS3qDDgCw=;
 b=dki9/LW+zpuRQMN1zvsnSYucEpsqwecKkeIKAiAfrUIIacZECVgDFLPxCNRv6w2nfdo0DhYcJGbVfbeAYN4jEUccuj3sALkqIkH0INML5Rumgu1xJMBCOUEdleiIQ2M2L6kXzhX10yC1jwWA18ckeU8nWXVPQRvSunuF1xC/ActVvvPb9Z5xZlN1iD0nCQYQMowX90qZWXHI5os/1v9dbmN99i5SL+TjDasip0GleYtD+7FcljCeDXd9NS+NrZR3im1BPz6/Oz1Vm5NRXr4LqWEov0PRxFSnXUotx18fN+KDp2gL3mOKJgqZZmaqMbaV/rpAYi7ch4V57m2Hqqa3pQ==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by PH0PR05MB7768.namprd05.prod.outlook.com (2603:10b6:510:2b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 14:29:59 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::8173:b78d:ab2f:e010]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::8173:b78d:ab2f:e010%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:29:59 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaBoOQeT3DB0E5hkqJk36Bpmg0Lw==
Date: Tue, 24 Oct 2023 14:29:59 +0000
Message-ID: <SN6PR05MB58376086F8599576F035A54B9DDFA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [xCG1V8sQrucBxljFkxKMey48AXhWr7mCQBSqPg+CCWvZrTOWyH0ktnXaxFFdCIQz]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|PH0PR05MB7768:EE_
x-ms-office365-filtering-correlation-id: b95a7bdf-1b51-480a-ce8c-08dbd49db3c7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9saliswdT06XLM3kwhc1jTAbS3PlXtfC9hTar6RvGcYQQGGIxQsLseLh/KCuMjPhYRPtXooMZSWhFPDujgsjkKQRPl39peayg/QGNsbBP6ZKsKn6UIxOZiNTEKq3tEFBNOzh72K64niHmEJnOca/dNoK3yK6liTsXchvtJeAg/hLdcjTRlgxMNSuNAG3xRZSx5cak0YT2hu8DxTiOz3tJy8jprIOCDIGkCFdetZS0EWZO2VAun6CUXBv1ckhvj20EmrBrSFwd9rtWDo9bu5BGygHZH9pP9ZfPajDwWWmQUZodwbehJt+VGMpqCIVbzRXiMLioI2ru3FkgpylmFCbJ6W5Z7+PFu4JrGYshz2JlfjE8m4/8exwf8smeybDyQj3P5j55qLHPRUBLuBPtl9YJvB8/YOK2Gf5U9PiCTKVnA7VBE4xev/dp1UUKsq65eY+wLG+/S3xi8xI80KNRDgRnobmgb2g2xbrDyOT26VegfLVhpotMM5Wm4AnUy1ZQwKp1eu71FcPdfLBa9NkGTjFUPDdYO4QgYt9AV0Vyzq++01x/WRuE7ZI1591R/0UdW+w5tUKvjqElwt/+11eSeKpiWB9gArbaiyRFtfUUX/tNrg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b8MFvP5WJPNibqAT5IAGiRNolg2YKCHPeGagmVXXt67lmi+bCmrH4VYpRg?=
 =?iso-8859-1?Q?L8eP9Rb5tw4gtUJG3IAIRtNaGhhUvoMZX66dvuiS/6GrxgP6jTOFV+Bxx/?=
 =?iso-8859-1?Q?VzNZ0HAz4fIK5k6pTE4h+9iKNl7o1nm+ec7jk5peBQAsL7Wpp6We2HGWaC?=
 =?iso-8859-1?Q?KodySDgb1JyDEToFYj71c/WbsQih3bc1yn8R6SOe2xiOOxeuQC3RDIvYdA?=
 =?iso-8859-1?Q?bSefGZII8mBSpR/R+WYhQ69ixgSBdla+ZY0+kzfdu5hD7VCzHYL4bfeb6t?=
 =?iso-8859-1?Q?loxFifUUIyRwjul9XaWnLGf3Clds2v6xp7DLjQ4XF4zVsdqQcm3OwkYJcJ?=
 =?iso-8859-1?Q?JmD5Lujw8TQ0u73C77Onjf9T0oOhDysrsW/DUu7OsmRnTDyZVxlTAJ09QB?=
 =?iso-8859-1?Q?52wc7dVr5sQeSKAFOYxfzWiArnHhsM0vYY1mPZGA6vGVxEjTHjTLXasd00?=
 =?iso-8859-1?Q?e7nWp1EslCdccXDSIGaAGj+1pz0qb3p6Qb/TWdg+czOPiKGRE6Znqv5a4A?=
 =?iso-8859-1?Q?4LuH5sfSNIeSyrHpt3zYTjV/5/f5lEBpXJfohcd9Pyi2MRIWLuqMmZyuQy?=
 =?iso-8859-1?Q?3pLgmJeLk+zNeLL/4KfZg6t+Y5Wrsi86As2KCYaJlxsOXHSE0000gWBsKs?=
 =?iso-8859-1?Q?5Cm3GGEq/xRCTjKq3x4kxK/quYqZMzIQVL7bm7x9xwnTbkRujRlU8TFal8?=
 =?iso-8859-1?Q?hMydzYTV0f1YIqo0j13n0bRPEZOU4+1IXiNx4Dx/ea6Kyytt+p/Olg8L87?=
 =?iso-8859-1?Q?CcWHLKv5VjvH1v2S/ui0oF7/a2Kce1++NGciOFji2X4bXMdichPIP5CfgV?=
 =?iso-8859-1?Q?Ywea/A3nlhchDbJwko5XTQWvWsFity+pCyLLqEiwXM9sbvkNIAdZKhqRcm?=
 =?iso-8859-1?Q?BKhenLV+1EeVUx8Ackm2GbkCPjD7I03I28GdMrHz3+eYhbbDBV3qG6hT1b?=
 =?iso-8859-1?Q?kaOo+xdurmXqMj2W1mdAZzqvCEhdC6W+xMMMUDFF5gC8VwOzxzojTMLUxC?=
 =?iso-8859-1?Q?L5JRBFmuOjiSmsagwWzfmMxtXPDlhFQCG1xJ1qYiJXWiMbBRyiy1yI+aOu?=
 =?iso-8859-1?Q?UuUq/GRRkRYHpVIr5j9O0mTV2qmslSlEHdPY3sFfOuagWrksyhc4qjUyY9?=
 =?iso-8859-1?Q?keyH8USifzpApDFtJBVJI1CZ65qgk9rS734EPiR2mkw4g9yTAEo7lgoeVe?=
 =?iso-8859-1?Q?uW4seuZlqZjcjHVW2iZt+nKUTQpkA0ZoTHy8zase3+Y9YpHFmcifzoNnyc?=
 =?iso-8859-1?Q?SuT0kKuqMiFhzUe9iFSXjZC6Z40RsJXsaawfp9/mbXNY9TDC7eFDDP1Hxr?=
 =?iso-8859-1?Q?hpv7Hd7ml9Rl0qHGMvsDdMTkhw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b95a7bdf-1b51-480a-ce8c-08dbd49db3c7
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:29:59.3869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7768
Received-SPF: pass client-ip=52.103.10.36;
 envelope-from=john_platts@hotmail.com;
 helo=MW2PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Oct 2023 13:48:29 -0400
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
 macros in target/ppc/fpu_helper.c where a non-NaN value is incorrectly con=
verted to 0, 0x80000000, or 0x8000000000000000 if a preceding converted flo=
ating-point value was a NaN value.=0A=
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

