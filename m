Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B89B7A4AA0
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiENn-0000AD-DY; Mon, 18 Sep 2023 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1qiAWo-0006kI-FU; Mon, 18 Sep 2023 05:26:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1qiAWm-0005zJ-Ej; Mon, 18 Sep 2023 05:26:50 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38I97Ve0024099; Mon, 18 Sep 2023 09:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OhFz2pX1CmSZOiTOuVctabsdOIT3aX8Me+CFw0mpD0I=;
 b=lL9LwU9FF6jSEoqut42A0hXbxrHwM+Pwbgp5mDi2iZNUzHOGCZTr2MoRHAn+uw0Uq5l2
 FBb3OKg3VA5GQDbVs2uAp4UsoEzrs3DUNt8ZTZwQ9Z6eLA60+pGsuFhyyw7sfvBgMdLx
 xF0z11Szb42TRJmy88U7KFzP/8Q/eAWEcriYpcEl7PimPEYInXVFn5OYm8aQJP5ueAZf
 PbmwTEgAu9eqOwxKY0Aj3vnPSO93wF+d9U+zsfgmdhoskTJVyl0mVNL+5c07svZSs8nV
 /XFcLIKTQp+SDsDk/Txom3PZSu/MnwsRsQ7Ci6aEFitOpvZ4AKCHSdXp0RwIWwK2bccb eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6hsqax3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Sep 2023 09:26:32 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38I97maH025806;
 Mon, 18 Sep 2023 09:26:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6hsqax3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Sep 2023 09:26:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38I8EoIx031259; Mon, 18 Sep 2023 09:26:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6k98f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Sep 2023 09:26:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38I9QURH62456064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 09:26:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46DEB5805D;
 Mon, 18 Sep 2023 09:26:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E50FB58056;
 Mon, 18 Sep 2023 09:26:29 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Sep 2023 09:26:29 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 saif.abrar@in.ibm.com
Subject: [PATCH] target/ppc: Update gdbstub to read SPR's CFAR, DEC, HDEC,
 TB-L/U
Date: Mon, 18 Sep 2023 04:26:16 -0500
Message-Id: <20230918092616.15398-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YFQtsyxqRZBr_8wk0xb_lAHY4RZEaqBO
X-Proofpoint-ORIG-GUID: AQZ_BjsWZqSc0OODAuHCYm9ZySu2XYAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_01,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 mlxlogscore=725 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180079
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 Sep 2023 09:33:37 -0400
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

SPR's CFAR, DEC, HDEC, TB-L/U are not implemented as part of CPUPPCState.
Hence, gdbstub is not able to access them using (CPUPPCState *)env->spr[] array.
Update gdb_get_spr_reg() method to handle these SPR's specifically.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 target/ppc/gdbstub.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 2ad11510bf..eb086c0168 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -412,7 +412,32 @@ static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
     }
 
     len = TARGET_LONG_SIZE;
-    gdb_get_regl(buf, env->spr[reg]);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val;
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        val = env->cfar;
+        break;
+#endif
+    case SPR_HDEC:
+        val = cpu_ppc_load_hdecr(env);
+        break;
+    case SPR_TBL:
+        val = cpu_ppc_load_tbl(env);
+        break;
+    case SPR_TBU:
+        val = cpu_ppc_load_tbu(env);
+        break;
+    case SPR_DECR:
+        val = cpu_ppc_load_decr(env);
+        break;
+    default:
+        val = env->spr[reg];
+    }
+    gdb_get_regl(buf, val);
+
     ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
     return len;
 }
@@ -429,7 +454,18 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 
     len = TARGET_LONG_SIZE;
     ppc_maybe_bswap_register(env, mem_buf, len);
-    env->spr[reg] = ldn_p(mem_buf, len);
+
+    /* Handle those SPRs that are not part of the env->spr[] array */
+    target_ulong val = ldn_p(mem_buf, len);
+    switch (reg) {
+#if defined(TARGET_PPC64)
+    case SPR_CFAR:
+        env->cfar = val;
+        break;
+#endif
+    default:
+        env->spr[reg] = val;
+    }
 
     return len;
 }
-- 
2.31.1


