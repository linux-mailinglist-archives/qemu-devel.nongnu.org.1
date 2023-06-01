Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBF571A028
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jNJ-0000m9-9y; Thu, 01 Jun 2023 10:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4jNG-0000lv-Qq; Thu, 01 Jun 2023 10:33:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q4jNE-0000os-B5; Thu, 01 Jun 2023 10:33:58 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351CkAU6025251; Thu, 1 Jun 2023 14:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=UwyHQTTZlcVVTRI4kY8cOHgzo3ZmQLCmSW5zsn62X3s=;
 b=HxHVC5em4B6woZQhs1rSNDZ616mQCEPGleBm6S3v30tm7TX4quN0OU4fts8lJiRLWcGM
 aJ+PjZ4wFf0mxhHPokEbxtOVELbTmsGwoRntCo2xnMwTEvFHOo+vBs5IKyCk1+Tl2kS3
 K3vfrbZ1Pm1SktvTIJJdKZ0zJ+KlamWqhBx8uopqE+3YP6iet9l6ZRfzkzmjQAd00iFJ
 YPBTE5LpMXapVQl1PlkLxXLFHey/c5NwtYMCe2GEPc7ykiTpXIBOfbKh2g+ATVFqX0lV
 6A5vSuvpHiYqMjSlj8c8eSKMJ/1R/+502VJnTMcJW3cP9VkgkEMALyGOSy6326ixrx2E kA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxkbu1jap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 14:33:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351EXi72007637
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 1 Jun 2023 14:33:45 GMT
Received: from acaggian1-mac.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 07:33:42 -0700
From: Antonio Caggiano <quic_acaggian@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mark Burton <quic_mburton@quicinc.com>, Alexander Graf
 <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>
Subject: [PATCH] hvf: Handle EC_INSNABORT
Date: Thu, 1 Jun 2023 16:33:12 +0200
Message-ID: <20230601143312.69691-1-quic_acaggian@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: yN87quLyq9SqaDUXwy0Qha_t3Q0F85-A
X-Proofpoint-GUID: yN87quLyq9SqaDUXwy0Qha_t3Q0F85-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=527 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Instead of aborting immediately, try reading the physical address where
the instruction should be fetched by calling address_space_read. This
would give any memory regions ops callback a chance to allocate and/or
register an RAM/Alias memory region needed for resolving that physical
address. Then, if the memory transaction is OK, retry HVF execution at
the same PC.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Co-authored-by: Mark Burton <quic_mburton@quicinc.com>
---
 target/arm/hvf/hvf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ad65603445..6e527254b1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1446,6 +1446,18 @@ int hvf_vcpu_exec(CPUState *cpu)
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
         break;
+    case EC_INSNABORT: {
+        uint32_t sas = (syndrome >> 22) & 3;
+        uint32_t len = 1 << sas;
+        uint64_t val = 0;
+
+        MemTxResult res = address_space_read(
+            &address_space_memory, hvf_exit->exception.physical_address,
+            MEMTXATTRS_UNSPECIFIED, &val, len);
+        assert(res == MEMTX_OK);
+        flush_cpu_state(cpu);
+        break;
+    }
     default:
         cpu_synchronize_state(cpu);
         trace_hvf_exit(syndrome, ec, env->pc);
-- 
2.40.0


