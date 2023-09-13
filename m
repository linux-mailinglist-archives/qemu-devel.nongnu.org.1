Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F30FF79E862
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPMQ-0000Fu-RU; Wed, 13 Sep 2023 08:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPMM-0000Fi-VT; Wed, 13 Sep 2023 08:52:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qgPMK-0002fv-FH; Wed, 13 Sep 2023 08:52:46 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DCmIdX002134; Wed, 13 Sep 2023 12:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JFdAoZpG7kJe+tONFGzdX2de8ZPGmb9oqjP1/j2Z4fQ=;
 b=Ya/YFJX97icuSiQSJUNHpRxmgYYerKqlvJ2YuMAOlPm7tHHTirczEm0cJVuOGHTQKZHw
 VV6sHvFK6SIshuTl00e0bblzXwPFxe3TGXyemDWfLuDt9Sxn6cSg0Dw+ydWL9IdJaeIX
 KVHVDLeyq7Wkh7Rk/q9kYxk4wfMnAFnkczqdMC1eKMnBorXpawU7ZHxnOvIgqutrknNr
 EDkFK1B+SlXqfs0k4hooQbh1MBDRPZw+K8097GwHZnUdHVo1rRx8mflBnQl2h+hzlXCC
 +gDUBVwGI5IaPECgK5ujw6HHo426hwlgun/VjP6o5B5MGusyixQLaVZ+nkmhOtkrl7sK EA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3d2v0t55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:52:41 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DCh1je017219;
 Wed, 13 Sep 2023 12:52:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3d2v0t4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:52:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DCdLkJ012083; Wed, 13 Sep 2023 12:52:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyuc3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Sep 2023 12:52:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38DCqdpa39780766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Sep 2023 12:52:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8B085804B;
 Wed, 13 Sep 2023 12:52:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35D0158055;
 Wed, 13 Sep 2023 12:52:39 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Sep 2023 12:52:39 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v3 1/1] tpm: fix crash when FD >= 1024 and unnecessary errors
 due to EINTR
Date: Wed, 13 Sep 2023 08:52:27 -0400
Message-ID: <20230913125227.504709-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913125227.504709-1-stefanb@linux.ibm.com>
References: <20230913125227.504709-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3r2drJ9BzgYiZJMj7LqdlyhrZFpShL15
X-Proofpoint-GUID: x8gJyDx4H0IAAlrXbC87qR8W7Wqdz2Nv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_06,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130101
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace select() with poll() to fix a crash when QEMU has a large number
of FDs. Also use RETRY_ON_EINTR to avoid unnecessary errors due to EINTR.

Cc: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2020133
Fixes: 56a3c24ffc ("tpm: Probe for connected TPM 1.2 or TPM 2")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


