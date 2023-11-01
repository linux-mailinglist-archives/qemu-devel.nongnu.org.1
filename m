Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE97DE167
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 14:18:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyB6a-00039X-B5; Wed, 01 Nov 2023 09:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qyB6Y-00035X-Gc; Wed, 01 Nov 2023 09:17:54 -0400
Received: from mail-centralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM4PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1qyB6W-0003xt-Bh; Wed, 01 Nov 2023 09:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a83fFDWJx5YtOPcTCzRwHHqNAhWo6Fpd25B5lDnsAFLGV23Mo+dX0ohx36Jh9GmvdC5J6tVQGLHpJQUXgx+CmF2VGfLkG9GJMPqHHfIZJN/PJDkaevQYDpeyI4AOQ5Q8W7DshRmrvCc/IXVMxHgqQ9TOPDHqZV+f+i5KAApaCiPDj4YPjM9vkoHLwa3noOAD2ALsx+BS1ydpP6TDROYZ1/IMSisqZlaqSQb3iFUAtWoLUnifEDRlj8tJBcHN8vtDkfkQsGwIghumFtQah5I+V5pGIrDxaFXT2VoRBG54RrIqOTrrtf+lNvqtdR95XV6Ggu6utQ9aKX9BJMoeT2JMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8IyNzTiZHZkZgeGLtBgYI15jnU8RxZFzsIrf+AnII4=;
 b=NQ1JzBwUZA0K/IfQeQMu9MtYJPu5+oFJSEv9/meymS5shB4bAVUghNsF/xx+x4RIcewbD0DEYTnQe+uR2Q8Iz4m0Fkf3IvFFjYWtdyIrHY2HLDOHPWYznl+GwOxFGl6uPybZmjx+zuZofJITHdzhvz5AX4QRE5Dxv1ZiRprYSmzEQNXmKTgKDnc4siZGf26WmT13HjaMovQk0NIEsjzcKejqnlY93Ga5Do0lkH5smeiU6N4iQZJZtqEFLMPtOXXy6v1ROwZh1XBkPlIiwPdBQzoYRDk2MQS/uxcCfQTf0jJjpr6gbnVxgogyhL+uR8pxw6kOAfTwAjjh06MaovrKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8IyNzTiZHZkZgeGLtBgYI15jnU8RxZFzsIrf+AnII4=;
 b=jwIC0kwCxo2odFyir4+v99dp2VtHd6Hd4nKnmK92BbJLyjlcRqknH/B5mSvxLZoVpr9jcA5bC63XBxIfhjnZwjVMlxItBcpnxe9g9SgetyToAk8yNeYmYttkgypTPLqOi54/aS9jIosEp/dhGpoBrdmyUXuAAm/dHKhen8nyYI/jxMnMUpRlfLVr9h+htJZm9Wj7XOYZ8EzytuAoN8+fi5SdNJviir0N+5hubNpjpXh0A5IVdMzRuIS1UuRWbSfGeyZ70dc/4ZHxXdmSZOLeOnbfOGzyBNLdSqzPT8I9aOTJ7uo6X6bntG0x0Y/2aa+20NTej4lyd5hk9HnWJNtthg==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by SA1PR05MB8692.namprd05.prod.outlook.com (2603:10b6:806:1cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 13:17:48 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 13:17:48 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH RESEND] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH RESEND] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaDMWbcVgJ7+yYFk+PqNP1wbMvFw==
Date: Wed, 1 Nov 2023 13:17:47 +0000
Message-ID: <SN6PR05MB58371EBB7D16BE12761DDC5D9DA7A@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [9WORXxdiU6y0dX7HKkACnseYT8PcLST1dwcdNlooeV84ffR1CbZmvLGvQQhrPGmp4OwpaRWz1TE=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|SA1PR05MB8692:EE_
x-ms-office365-filtering-correlation-id: 1846d916-d888-4429-1ab8-08dbdadcf15d
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OwJ9AYM/E1iiFnpPgaispnPqRH00zk2xhoISZYCqe/UHgdfimJURFQbNEQ80d/o61E+qt7uZ3aiuxDFpP5sIFHbTOjXh9Ehq74zhtHqPHp047twd9j24xRayPLvCaEAurw3JgHzbCy/jUjMEaD5b91WLPqA+Yu1K6RaPEumylHpCwF/kUtAEr0B4bmr7QRDWN97rMMeiyqo0JKqAGLnPserCUFwNk7V29igfx2cVXwCAtMT7W8ifLqzlCWt1Yss36jetdtPvfsbH9DIT1/8GxxhrVpOgbKthyBFa1UVrQ4Z0URp3t/QBzFZ77aoKpACjaDDUeVRDP/2nSoIoiAW94ZM7yGj45Rn7uvoFqoC7oR89pn4zr1uObOHJz4iH5BxhdV8++TJE0Z2yOtcHoKs21cyAF/kFMQwAWgF8kUwpecflvkP5gGujzwt8rO3z+wZpT/dmCqs/dPXQFBpzHcokD7rv+3rVSeSDQ57pq/9EvFNRaxbLn9mmX4lD8KFY1lLqU0pZxYzP2PKl9AbUlriHvsuJiX098kDUouF53pL6HQL27HycK0X49o1u57k/JGjZkHv4L2JvO/aXVB8H3mtVXk8dJAe+5ubBQ+jGHcGo0vE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MMVgrRAA+La5d306znUbViUhWsfwwBDL6V8ltW6h0/NUraOhgffewmbGzi?=
 =?iso-8859-1?Q?r7zoOW5wdWSsrK543udL8Q3gkqwjNU0A832R5FlPTt1JziuJ/mYsiF4y9C?=
 =?iso-8859-1?Q?XjWt5LOLOayvkzG3WHtUAHs6aXyafBypTy3d7fuOFfcOscdwEr16jvuTz6?=
 =?iso-8859-1?Q?L1vDL/7Zne2090Kq52KUcAnMZZiCbMqbMuu7i9gdwFIoLRBHALxOXYSTtQ?=
 =?iso-8859-1?Q?I7w4pT62RvDHX0Ep0pOnkyRmmk0++KX63oUnRKlQB9pvSSLccOeGORAfpN?=
 =?iso-8859-1?Q?yxBjSNPWeXX7H84dP8VKsEQTiTnm0dMEmn25WfI7BvZuBToGPMXxUxE3ju?=
 =?iso-8859-1?Q?aYpaYY4eB0Mas358CIoR9M56odPAfwtUkesoA8kpeu9pN3TYklfa2ZviZR?=
 =?iso-8859-1?Q?z3ycPNizhuhHNQ5cMM8fapzlSC7HJ3nbTYwhWMEpZ5734RSJRa00JautBn?=
 =?iso-8859-1?Q?X03dIHf1LHOijfR97zFpGfFFrhcqyRFPDJvOHr/ckZXuCBuhMuXGYVdWE9?=
 =?iso-8859-1?Q?/j/m5D3sl4cYXh63lYZHgEk4vZ66tp5WsGqQvtTCnf+J7PE7apkmWJR943?=
 =?iso-8859-1?Q?5ZRFb80Zht5g6mqFfkFEEnaOe+NAHZORRUKWhrxM3NV0SCq0ZBBEuxXTEY?=
 =?iso-8859-1?Q?iM44Uq6AnmI+xwogfmQTY97c8ODcGEibgXVhXPBoeYS2OEvFVUPBwpCv0N?=
 =?iso-8859-1?Q?V923sP/wzdWVDpqJY3weqKFq5TtHkWfvhSN5C5htTYe6a/Nwh9ztqWnlDH?=
 =?iso-8859-1?Q?sNlkTA51WoxOdmfR2JgeR7o+FMqt8j1u0sB45Sv7BwsDLvIOmezaX2IlP8?=
 =?iso-8859-1?Q?UMKS6OeWDVIyi30Rj7/l+k0ZBo9s1uyisUfTdfqiBVT5m1YIo8Nvlm4KTM?=
 =?iso-8859-1?Q?t2L5zGxFDcFBwSKIA0w+tI/8Zp/faYp97AQITJCLdhXVvUvxN6jxBw201t?=
 =?iso-8859-1?Q?I5AlE+9KNw5uWwVvV38pVTWnvw3kWEJc15fPkzvj7Fb9dEQTC3Ey+PDRXV?=
 =?iso-8859-1?Q?zeT2RwH+9SwqIyf17GfqyOW0HuBIu+P5poMIABN3BueIRhl7EPCg58oGsv?=
 =?iso-8859-1?Q?oza4jMB6/NinQtZWEEJXbdEYDFkz36fAYqrub5W/aEO8jytlPZw2ol0407?=
 =?iso-8859-1?Q?nE0fvmKZEVeKLlL5HbSNx0Y/6m/MUSt5tu4iKIEUF8Sd9zfhpNQiy5Lo3W?=
 =?iso-8859-1?Q?dhBlwRY9S6mrtceRFeH4Lwosd0xylOaZpitz2AzojG3FGWkB0V52e01spu?=
 =?iso-8859-1?Q?22V45SY7dHXHS8XybOtocBOz4CuwISL3EFEzDE0dMesBf6ddl12g/BigYu?=
 =?iso-8859-1?Q?lY17CqSmiPor8vZc7DR+s2krrAzqoF95q8R13AmAJQPu72I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1846d916-d888-4429-1ab8-08dbdadcf15d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 13:17:47.9626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR05MB8692
Received-SPF: pass client-ip=2a01:111:f403:c111::5;
 envelope-from=john_platts@hotmail.com;
 helo=DM4PR02CU001.outbound.protection.outlook.com
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
=0A=
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

