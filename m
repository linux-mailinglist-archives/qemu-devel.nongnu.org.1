Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7670E691
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YkJ-0000OF-OW; Tue, 23 May 2023 16:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkH-0000MT-9L
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathbern@qualcomm.com>)
 id 1q1YkE-0005UJ-FM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:36:37 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NKQb0x016616
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=qcppdkim1;
 bh=SB4agyBZ9C3rI/3K1kpfrYbO+nPO0h0dBEq762HPj3k=;
 b=dGgWDhhhunvaEuO+PfPAvg9tivvzqySuZmY2FdqiztCdf41C3H3Gy95lrRso+4Hcjbl6
 zZ3RR480cyWCTWY5TUF+s9rnIwXpexmJX4dm77blc5M1m7U2+7LdMjHA0W1oODw7/TLi
 pPsV7bCNs8UXVHrDih8ARhrzNW3qJahaOtYtMH7Tx/t0RHKWIt/Suejut5mvwc2mqZbr
 3fMs1wrKIjg0xZN1KKl3d4YNhFwhjqpQL30irJxkmAGLufI2tGHiljv2Svtl55RIX4V0
 E7/oywyhWEsQhkczOEceDQilYSIpzeR2vfivA4IXrFkG62rkiLXEd+mDIeuru6eN1fFj jw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr8qrbybt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34NKZWhS024583
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3qpq9kujbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:31 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NKZVkD024574
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 20:36:30 GMT
Received: from hu-devc-sd-u20-a-1.qualcomm.com (hu-mathbern-lv.qualcomm.com
 [10.47.235.147])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 34NKaSY0025384
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 20:36:30 +0000
Received: by hu-devc-sd-u20-a-1.qualcomm.com (Postfix, from userid 4229910)
 id BFC4E742B; Tue, 23 May 2023 17:36:28 -0300 (-03)
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: qemu-devel@nongnu.org
Cc: tsimpson@quicinc.com, bcain@quicinc.com, quic_mliebel@quicinc.com
Subject: [PATCH 2/2] Hexagon: fix outdated `hex_new_*` references in comments
Date: Tue, 23 May 2023 17:36:27 -0300
Message-Id: <eeb2d1a1d3db8c9444db20a3df01fe93faddc3cd.1684873957.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1684873957.git.quic_mathbern@quicinc.com>
References: <cover.1684873957.git.quic_mathbern@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: LKmSYAvabWmvpENzjrDOQrRHtpNqlK4-
X-Proofpoint-ORIG-GUID: LKmSYAvabWmvpENzjrDOQrRHtpNqlK4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_13,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=430 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mathbern@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Some code comments refer to hex_new_value and hex_new_pred_value, which
have been transferred to DisasContext and, in the case of hex_new_value,
should now be accessed through get_result_gpr(). Let's update these
comments to reflect the new state of the codebase. Since they are only
meant to assist developers, we can replace the old names with some
pseudocode when convenient.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/genptr.c    | 10 +++++-----
 target/hexagon/translate.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index cb2aa28a19..8d11d928c9 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -880,7 +880,7 @@ static void gen_endloop0(DisasContext *ctx)
         /*
          *    if (hex_gpr[HEX_REG_LC0] > 1) {
          *        PC = hex_gpr[HEX_REG_SA0];
-         *        hex_new_value[HEX_REG_LC0] = hex_gpr[HEX_REG_LC0] - 1;
+         *        result_gpr(HEX_REG_LC0) = hex_gpr[HEX_REG_LC0] - 1;
          *    }
          */
         TCGLabel *label3 = gen_new_label();
@@ -899,7 +899,7 @@ static void gen_endloop1(DisasContext *ctx)
     /*
      *    if (hex_gpr[HEX_REG_LC1] > 1) {
      *        PC = hex_gpr[HEX_REG_SA1];
-     *        hex_new_value[HEX_REG_LC1] = hex_gpr[HEX_REG_LC1] - 1;
+     *        result_gpr(HEX_REG_LC1) = hex_gpr[HEX_REG_LC1] - 1;
      *    }
      */
     TCGLabel *label = gen_new_label();
@@ -948,11 +948,11 @@ static void gen_endloop01(DisasContext *ctx)
     /*
      *    if (hex_gpr[HEX_REG_LC0] > 1) {
      *        PC = hex_gpr[HEX_REG_SA0];
-     *        hex_new_value[HEX_REG_LC0] = hex_gpr[HEX_REG_LC0] - 1;
+     *        result_gpr(HEX_REG_LC0) = hex_gpr[HEX_REG_LC0] - 1;
      *    } else {
      *        if (hex_gpr[HEX_REG_LC1] > 1) {
-     *            hex_next_pc = hex_gpr[HEX_REG_SA1];
-     *            hex_new_value[HEX_REG_LC1] = hex_gpr[HEX_REG_LC1] - 1;
+     *            next_pc = hex_gpr[HEX_REG_SA1];
+     *            result_gpr(HEX_REG_LC1) = hex_gpr[HEX_REG_LC1] - 1;
      *        }
      *    }
      */
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


