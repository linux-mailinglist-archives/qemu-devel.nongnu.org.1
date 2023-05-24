Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F54770F8EC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pgc-0001RR-J0; Wed, 24 May 2023 10:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pga-0001Qm-D6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1pgX-0000d5-U6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:41:56 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OCdSoR032308
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=LyMUZewBARAdqxQ2wrazrfhfVR30f4zG1AFUvyUSQ2k=;
 b=i1BnkRRfPEJhXIPB2pVMf2H3E/OjVn/5655okR+FCTvKn1zXi7J87iC10Cq6f1m6FAlj
 aHs0RPSSTxRl03YvDX3LKyyD+tTUYt72mojZMI8OTjhYifLuIrn1nswAdLG4Resz1DK9
 sYLg10sTly/7ZAAOntoe+w3WKFLaUBAagtU5gXgFw3QBiXxzNUB86lUA1QzxuGz92I7i
 lyvNvkBhrfFpIf1uAl0GtLi1MbQx7RyI0lKIq6tmLpJRKv6Zu7xVtcWmBP9V9lARQBl5
 sF5B7WmCfbRLYbWFinEEYZ6Y4QMFi7mfQbLNmHjzoUNCM/prLBlw/IYfdHrFRvAUklcZ 3g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs05sas5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:51 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34OEfo3l026643
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qpq9m0pr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34OEfogx026633
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:41:50 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34OEfno6026629
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 14:41:50 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id D4357744B; Wed, 24 May 2023 11:41:49 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH v2 2/2] Hexagon: fix outdated `hex_new_*` comments
Date: Wed, 24 May 2023 11:41:48 -0300
Message-Id: <8e1689e28dd7b1318369b55127cf47b82ab75921.1684939078.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1684939078.git.quic_mathbern@quicinc.com>
References: <cover.1684939078.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: uSVlFXvvVXGNG-UurvHerwr3BXgQKbXa
X-Proofpoint-ORIG-GUID: uSVlFXvvVXGNG-UurvHerwr3BXgQKbXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=621 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240120
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Some code comments refer to hex_new_value and hex_new_pred_value, which
have been transferred to DisasContext and, in the case of hex_new_value,
should now be accessed through get_result_gpr().

In order to fix this outdated comments and also avoid having to tweak
them whenever we make a variable name change in the future, let's
replace them with pseudocode.

Suggested-by: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/genptr.c    | 26 ++++++++++++--------------
 target/hexagon/translate.c |  2 +-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index cb2aa28a19..bcb287dd8b 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -878,9 +878,9 @@ static void gen_endloop0(DisasContext *ctx)
      */
     if (!ctx->is_tight_loop) {
         /*
-         *    if (hex_gpr[HEX_REG_LC0] > 1) {
-         *        PC = hex_gpr[HEX_REG_SA0];
-         *        hex_new_value[HEX_REG_LC0] = hex_gpr[HEX_REG_LC0] - 1;
+         *    if (LC0 > 1) {
+         *        PC = SA0;
+         *        LC0--;
          *    }
          */
         TCGLabel *label3 = gen_new_label();
@@ -897,9 +897,9 @@ static void gen_endloop0(DisasContext *ctx)
 static void gen_endloop1(DisasContext *ctx)
 {
     /*
-     *    if (hex_gpr[HEX_REG_LC1] > 1) {
-     *        PC = hex_gpr[HEX_REG_SA1];
-     *        hex_new_value[HEX_REG_LC1] = hex_gpr[HEX_REG_LC1] - 1;
+     *    if (LC1 > 1) {
+     *        PC = SA1;
+     *        LC1--;
      *    }
      */
     TCGLabel *label = gen_new_label();
@@ -946,14 +946,12 @@ static void gen_endloop01(DisasContext *ctx)
     gen_set_label(label2);
 
     /*
-     *    if (hex_gpr[HEX_REG_LC0] > 1) {
-     *        PC = hex_gpr[HEX_REG_SA0];
-     *        hex_new_value[HEX_REG_LC0] = hex_gpr[HEX_REG_LC0] - 1;
-     *    } else {
-     *        if (hex_gpr[HEX_REG_LC1] > 1) {
-     *            hex_next_pc = hex_gpr[HEX_REG_SA1];
-     *            hex_new_value[HEX_REG_LC1] = hex_gpr[HEX_REG_LC1] - 1;
-     *        }
+     *    if (LC0 > 1) {
+     *        PC = SA0;
+     *        LC0--;
+     *    } else if (LC1 > 1) {
+     *        PC = SA1;
+     *        LC1--;
      *    }
      */
     tcg_gen_brcondi_tl(TCG_COND_LEU, hex_gpr[HEX_REG_LC0], 1, label3);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index b18f1a9051..8838ab2364 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -556,7 +556,7 @@ static void gen_start_packet(DisasContext *ctx)
     }
 
     /*
-     * Preload the predicated pred registers into hex_new_pred_value[pred_num]
+     * Preload the predicated pred registers into ctx->new_pred_value[pred_num]
      * Only endloop instructions conditionally write to pred registers
      */
     if (ctx->need_commit && pkt->pkt_has_endloop) {
-- 
2.37.2


