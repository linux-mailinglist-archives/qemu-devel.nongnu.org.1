Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE6179DB0E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgB8O-00060I-EZ; Tue, 12 Sep 2023 17:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgB8M-0005zP-5J; Tue, 12 Sep 2023 17:41:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgB8J-000261-RB; Tue, 12 Sep 2023 17:41:21 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CLco1N011388; Tue, 12 Sep 2023 21:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NKuROFmQUwxIKylreIZ9FJea2Rtdfd8dro2rLCIBsyo=;
 b=r9rvV2t5WoIHxigb2cix72h329s63gZYDKDU5khhtnMwxjPwCMp6MPzlIREJiMFhQ3uD
 yI8Bbars/Xc04amuo/P6AIPbwH+NG8OT3B+hCZrZ8I594puHmKXyY7gXaxYUrnWTYRiN
 RIZ1Z53Q3LL/Mk94JlAQcQz0FR1RfGRnX4Lhlzt2N3tCc2FBzdu+vh30mO6d+y/tQnYd
 mCYcbdGAw6bFzfsxRe6cqTaUCDyyCb3KNE2MpmTrMVSe0txOoNvWEsJioSeC15tohlZ/
 lpESt1vi9QtdUNksG87r2svPvW+Qjuu48nqGoCL/1vc/uxFtxKqds1exMnWMiz/+/nF2 ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2yw40866-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 21:41:16 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CLfFtJ022258;
 Tue, 12 Sep 2023 21:41:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2yw4085n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 21:41:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CK6okL012070; Tue, 12 Sep 2023 21:41:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyphv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 21:41:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CLfE5N64684420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 21:41:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4C4F5805D;
 Tue, 12 Sep 2023 21:41:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 436B758053;
 Tue, 12 Sep 2023 21:41:14 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Sep 2023 21:41:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=DE=B8=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 1/1] tpm: fix crash when FD >= 1024
Date: Tue, 12 Sep 2023 17:41:10 -0400
Message-ID: <20230912214110.482744-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912214110.482744-1-stefanb@linux.ibm.com>
References: <20230912214110.482744-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E8X4zVC5VBnmOCIjxb-kLBIHdUpKF3dB
X-Proofpoint-ORIG-GUID: -TQpo7IcPbIIiGQSyQylU0gtUTJUBl8e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120183
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>

Replace select() with poll() to fix a crash when QEMU has a large number
of FDs.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=2020133

Cc: qemu-stable@nongnu.org
Fixes: 56a3c24ffc ("tpm: Probe for connected TPM 1.2 or TPM 2")
Signed-off-by: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_util.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index a6e6d3e72f..1856589c3b 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -112,12 +112,8 @@ static int tpm_util_request(int fd,
                             void *response,
                             size_t responselen)
 {
-    fd_set readfds;
+    GPollFD fds[1] = { {.fd = fd, .events = G_IO_IN } };
     int n;
-    struct timeval tv = {
-        .tv_sec = 1,
-        .tv_usec = 0,
-    };
 
     n = write(fd, request, requestlen);
     if (n < 0) {
@@ -127,11 +123,8 @@ static int tpm_util_request(int fd,
         return -EFAULT;
     }
 
-    FD_ZERO(&readfds);
-    FD_SET(fd, &readfds);
-
     /* wait for a second */
-    n = select(fd + 1, &readfds, NULL, NULL, &tv);
+    n = RETRY_ON_EINTR(g_poll(fds, 1, 1000));
     if (n != 1) {
         return -errno;
     }
-- 
2.41.0


