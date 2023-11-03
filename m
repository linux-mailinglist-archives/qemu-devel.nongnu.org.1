Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368D17E0256
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 12:46:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysbl-0001fU-70; Fri, 03 Nov 2023 07:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qysbi-0001fI-T3; Fri, 03 Nov 2023 07:44:58 -0400
Received: from mail-westus2azolkn19012036.outbound.protection.outlook.com
 ([52.103.10.36] helo=MW2PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qysbh-0003Er-4k; Fri, 03 Nov 2023 07:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph7cl9sfBRzHzKPAAFhb9kHCyhx++ay43erzKHcQCRXy4kdqMZfLGLYEqPSxer5YBmOeu6C8XEFs0sM7gHPue3fV2XlbJdQO6EWUMQpAW+bdanQPrdAZH/vOJwsWGY4iu8O+HpLSiHNTXfMAltrBtVhHkPuzI2mFqwy0v2pwLtBkrdvgvQEDW6xEZcR0sSndrtkOeJC8Ker3iyIeVfrdDhyw0TaDpuB7X8ftm+CMyz4Pj5eDKVfFjA7kqNCe1Vcm6LjtP3bSeGeGAzYsl9InUpUuiQl49HquE5q/l+1dXFBw5R4jfMhbn9bgU1Fw+EBDDhE+HaRm6qF2wOLluly+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx+d0JU/O6+LRUfNSUxkR4edFsYrSI5M4sDFj/UOvy4=;
 b=nDoNNKPLoGwb5l0eZ2u8+EHESP0ChOWsotGY+oVGaXfhrrOwYhi9nvkD5voVqkApC9X7fpJ7vyVkZ1lkXqzeTL50MLGHd8AOpwxUpM5Db5ZakWpPEaZ8m8rtmC5GCtQdceXkji0iyTiz4LDQjNghs3l5je6yhEpVBXY7aM4zpdAfmQQBhAVW7A4KVnR679O9/ls+QrdK34EPpqDzkPAixQcoYKiCRgJAOxnTyly0iJaoDqL/1X5/9r73kyh/1/wJ2QjYA6MqhCT5T+W7y+O/RG0cz0DP96YfFk5Cj/hZCptzmF4Q/LnxqqDSJLW8mTDTiygAAqsUGMSDkYlRahhzYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx+d0JU/O6+LRUfNSUxkR4edFsYrSI5M4sDFj/UOvy4=;
 b=AKySOIt0QIYDQw98pZGkfGQSXOGVfUJ6lbYS2/AyUS37PGopJivtKseAxWdwM4SW8UodZ+knWL9rrTPgaXkcNFXcRRBkUXmQ1drZ6o5scohchYT6nGfoCsQFwr4LK7If3InY72u78+Nm0owDpNv3Md8EDES5qoTYvhI1BBjDTVBFXd7NPtytrwtObMxuZZp9u0YoeyUAH82pOPjOUuqqjZbLlviexyF+/qmd6d9QuJ8pe8aKMCB9A75uqstjZ8t/ESaB9b7qQxjLJlcaQJ0Foo89Ig6jU1ezCdfOM3yQ2UMp/MCGExLKAgSDo1aoinrKdWTYSK73TB/QC6AA3lxAzw==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by PH8PR05MB9989.namprd05.prod.outlook.com (2603:10b6:510:1c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Fri, 3 Nov
 2023 11:44:37 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 11:44:37 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2 RESEND] [PING] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT
 and VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH v2 RESEND] [PING] target/ppc: Fix bugs in
 VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaDksfFzZyFVqlb0aeBEe+rk83Ig==
Date: Fri, 3 Nov 2023 11:44:37 +0000
Message-ID: <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
In-Reply-To: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [Mreb5H9CkbPYP6+xcmNPr6tx1ElPus3BTlWeknxN5pjBOxQRXYlAxOGJhG9ouNomuOweeGrIxfs=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|PH8PR05MB9989:EE_
x-ms-office365-filtering-correlation-id: c299e1fb-d9a4-468a-91fa-08dbdc6241e0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ng+XYkSmBscsQRYmOK0Qlh4yE8qh1EBX9QNUJ/mNCPkD9nQes6LLY8MJXzmTr8ed3Y2iTQwB6qQMxFKFPXX0z4J/b/43KH2HjC2aCV2WHXTpKINriH9n0NZisybkcvgx9OQFk6PtW+QXCErhacztUbWmY0UyUtDzBby9p/Vaj9sTJqN5sSKZaSa+doT5qTo5t5won9vqpQ52wHMZDlpwF5oKjo3XcUOPrI3Y28nkypw42mxwQyfxlS9MFcIScpsJucBdYFazQ+U5mO5l+8ahvDfOz4WvD8d+nauWAFIUuhlW9PKacAk9/rOaRbiRlNjA2+LTb+0pZ34ohLnwEnHOSj9Dqf0CGIu3pHukoZoIZ6KXmzyTNzX8dtdND6FxcISQYIBHYcXMuUXuY8oH7r2BbJ9gBJkYU1ucc2HF0iDAd3wXxywlKNkV0X0Y0gHDK9oRn2eKpfpSUVEe2FWPBYBTkXoSzkme22CDLKZD8W0qwuQVpoey96drCQfQBGCL5R6/M4Nhon187qdWbUwiXU6VBWf5ClO8PBcel36e9r4sn8NjJNF2VEMkIKK/QpjyxW2mAjIUxrKEkT7NS/OkkPSvBpsPzY161l48yf7ETTbohG8=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sxJtGZXhco4BKvutJLpxfA65gbnw/p2hCfzpqJhRY/0WjnXFLbiQ5LnNnI?=
 =?iso-8859-1?Q?bHUa4i0IgXgYpr2kZ5OVXeILjhdrsTztxE7T0Lh6Mx8vHJTGZKEd7pWeVm?=
 =?iso-8859-1?Q?5zm7y80hYEdUs74B5Nxxf/UczxixWIoMtYPKYitSavLiHPpJYzQ+r5pvT3?=
 =?iso-8859-1?Q?py1KAIzrtI0ETOXpAoPb8xAWkYybAloIecZVeaaI6X3gG88Dw1NzvQbg6p?=
 =?iso-8859-1?Q?bKgn7Kyne1zKF0kps67q1ddJX+MrVCooTAymIiUTzcwlzWCow0BrdjQ6+N?=
 =?iso-8859-1?Q?DajKUIe4LdYwVwb8QOXchgt/+Li2KYTerJjxW/OiGxfimSPCwzGZH1r/wW?=
 =?iso-8859-1?Q?aOJHK5fOHS3JlifGI7npo1tPj+3hVY7txvu+g4CZyuu8ys6rWIfD7pnmS6?=
 =?iso-8859-1?Q?7KJmk3oW134aw+W+sUP8mpZT9hMXJY2u18NMyKNLwL29rSDZsbp5HiWDrh?=
 =?iso-8859-1?Q?J2JrJ03ruPk4aEYdYn/8GVQJk/poc0u5U3nwxx87hQEnoHC+6QU85rIkUb?=
 =?iso-8859-1?Q?89I2ujygwWo4+drshjss7T4iIj59KoJrI9UrSKhinotGnil+dv6NIjMjRZ?=
 =?iso-8859-1?Q?2gf/xMoVPFWPpAOpL34Qaq1kfBzj/KfOxSPsCH2S09LU/obLWPTKD2EbM7?=
 =?iso-8859-1?Q?Hx/gvZPb936CImuWXqELMtWksVdAvO8hclMfNJoeI28uzoJXnx6QaOooe6?=
 =?iso-8859-1?Q?z5geckFlPt0Ep7xx56GnSnFj0ALB/VPnt2glXve9/vq6H9JBM8bxjXBsk2?=
 =?iso-8859-1?Q?12+TgvB7pyfL0AbXwt8eUVaNdOTXs2ErUr1qGMgOgZkqy+tWZfpj/uPo5L?=
 =?iso-8859-1?Q?sCUlIGbGWyen+wpMWCPQc2eWuToo37XciZwtjQqGexjiokltU+bhD7uUCz?=
 =?iso-8859-1?Q?FoS60PQP3QmrYGwlGE6RFluQGuXXovueLrRV775PbqK2+8sPX8iYB6SGzE?=
 =?iso-8859-1?Q?aB5xCnHMUidgVYjTdZ9IO0+9YZQnrIdPsPNpCMwJkUicXecNHA47z03Qcv?=
 =?iso-8859-1?Q?/rHdtEbsslsAUUWblBl85XSoGs7o0ZZOqO1Z+kOvbz24z5HM1zTPz9hRko?=
 =?iso-8859-1?Q?wItDFrHnBq3kVDhBzgW+Yuhl13LkcX8tBgjOvrZKdEifVia9FJyeR2XK7S?=
 =?iso-8859-1?Q?yD8mdHYwlwXT1rc+g8Da2kJNBNq8YrYotuiHc6BdlJbfMbLHb4O/1B6Y33?=
 =?iso-8859-1?Q?ZhSZk4RAF4B3GbJHrOxpy4cBtg2MbwRrwzpldqdYmI/8QPSWb5190YJykH?=
 =?iso-8859-1?Q?F5q6gZe8x5aDevDM5vFLchDAaICUMy4Y7/ebGvODLigaTReADJEVUoBfQY?=
 =?iso-8859-1?Q?GyH0jbBgMlwJHqyD1XlBK26jcRXNVwz7QCj5xn59FmZ3ELY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c299e1fb-d9a4-468a-91fa-08dbdc6241e0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 11:44:37.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB9989
Received-SPF: pass client-ip=52.103.10.36;
 envelope-from=john_platts@hotmail.com;
 helo=MW2PR02CU001.outbound.protection.outlook.com
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
 =0A=
macros in target/ppc/fpu_helper.c where a non-NaN floating point value from=
 the =0A=
source vector is incorrectly converted to 0, 0x80000000, or 0x8000000000000=
000 =0A=
instead of the expected value if a preceding source floating point value fr=
om =0A=
the same source vector was a NaN.=0A=
=0A=
The bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in =0A=
target/ppc/fpu_helper.c was introduced with commit c3f24257.=0A=
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
2.36.1.windows.1=0A=

