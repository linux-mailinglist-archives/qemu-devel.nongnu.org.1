Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D8499AEBA
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Oct 2024 00:37:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szOF7-0003P7-G5; Fri, 11 Oct 2024 18:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOF5-0003Oo-ND
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1szOF3-0006C0-0K
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:36:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BK2mIa001094
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=AKh/ciTfkR0DB
 9FoPqfvDo4YiYEmNNOru+FBQxJn2mg=; b=p4PqCVhN7l+CCkOi2cp5AE0jjXioB
 qwGkLM2L8LIGWTD745mRXI1krWyj6/kheNIaTmb5isfJcMG4UJ+H15GXWOEE0F66
 0RiXDyhVMayzZGFq48BDa1J1s8QnmJfeZO75Mx9PE4o+P6l2Rqlw7d483zKcvDCa
 YKyXbsk1YCFKfel7/h7z05QQcLLugIXU0F+jSE88LeXKoFf+uOTbIHwo1Ik1Kb2q
 edp80CvuaOSoEM5Z6wH5L2SumODHrCpwb4R8pTL8QwS8MHK6/ckQJgGOZw/QngsY
 +dA7vmtEZVjrWgslRQEhLuLUW/ziXEJdOQh+oAwFIl/OkaPWZwLEfRd3w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 427aq28fdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BMa9pi001004
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 22:36:09 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 427aq28fdg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKOIEX013833;
 Fri, 11 Oct 2024 22:36:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fssr4bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 22:36:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49BMa8NO46203378
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Oct 2024 22:36:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 119FB58053;
 Fri, 11 Oct 2024 22:36:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9225805F;
 Fri, 11 Oct 2024 22:36:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Oct 2024 22:36:07 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/2] tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
Date: Fri, 11 Oct 2024 18:35:55 -0400
Message-ID: <20241011223556.2953808-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011223556.2953808-1-stefanb@linux.ibm.com>
References: <20241011223556.2953808-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qtFpxXy-ZfBq6d-YwMQM4sDnROptewj5
X-Proofpoint-ORIG-GUID: P1du-bCxmjSAllvvCdLMypmRMe1vkFrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_19,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the new ptm_cap_n structure for getting the PTM_GET_CAPABILITY response
from swtpm. Previously only 17 bits could possibly have been set in ptm_cap
(=uint64_t) in big endian order and those bits are now found in the 2nd
32bit word in the response in the caps field.

This data structure makes it now clear that the 1st 32bit word carries the
tpm_result like all the other response structures of all other commands
do.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 14 ++++++++------
 backends/tpm/tpm_ioctl.h    | 13 ++++++++++++-
 backends/tpm/trace-events   |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 5a8fba9bde..b0e2fb3fc7 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -72,7 +72,7 @@ struct TPMEmulator {
     CharBackend ctrl_chr;
     QIOChannel *data_ioc;
     TPMVersion tpm_version;
-    ptm_cap caps; /* capabilities of the TPM */
+    uint32_t caps; /* capabilities of the TPM */
     uint8_t cur_locty_number; /* last set locality */
     Error *migration_blocker;
 
@@ -239,13 +239,15 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
+    ptm_cap_n cap_n;
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
-                             &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) {
+                             &cap_n, 0, sizeof(cap_n)) < 0) {
         error_report("tpm-emulator: probing failed : %s", strerror(errno));
         return -1;
     }
 
-    tpm_emu->caps = be64_to_cpu(tpm_emu->caps);
+    tpm_emu->caps = be32_to_cpu(cap_n.u.resp.caps);
 
     trace_tpm_emulator_probe_caps(tpm_emu->caps);
 
@@ -254,7 +256,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 
 static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
 {
-    ptm_cap caps = 0;
+    uint32_t caps = 0;
     const char *tpm = NULL;
 
     /* check for min. required capabilities */
@@ -527,8 +529,8 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err = NULL;
-    ptm_cap caps = PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
-                   PTM_CAP_STOP;
+    uint32_t caps = PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
+                    PTM_CAP_STOP;
 
     if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
         error_setg(&tpm_emu->migration_blocker,
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index 1933ab6855..ee2dd15d35 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -29,6 +29,16 @@
 
 typedef uint32_t ptm_res;
 
+/* PTM_GET_CAPABILITY: Get supported capabilities (ioctl's) */
+struct ptm_cap_n {
+    union {
+        struct {
+            ptm_res tpm_result; /* will always be TPM_SUCCESS (0) */
+            uint32_t caps;
+        } resp; /* response */
+    } u;
+};
+
 /* PTM_GET_TPMESTABLISHED: get the establishment bit */
 struct ptm_est {
     union {
@@ -242,7 +252,8 @@ struct ptm_lockstorage {
     } u;
 };
 
-typedef uint64_t ptm_cap;
+typedef uint64_t ptm_cap; /* CUSE-only; use ptm_cap_n otherwise */
+typedef struct ptm_cap_n ptm_cap_n;
 typedef struct ptm_est ptm_est;
 typedef struct ptm_reset_est ptm_reset_est;
 typedef struct ptm_loc ptm_loc;
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
index cb5cfa6510..05e30533ce 100644
--- a/backends/tpm/trace-events
+++ b/backends/tpm/trace-events
@@ -16,7 +16,7 @@ tpm_util_show_buffer_content(const char *buf) "%s"
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
 tpm_emulator_handle_request(void) "processing TPM command"
-tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
+tpm_emulator_probe_caps(uint32_t caps) "capabilities: 0x%x"
 tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
 tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
 tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
-- 
2.46.2


