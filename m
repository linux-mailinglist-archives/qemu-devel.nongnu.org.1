Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD169C0555D
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 11:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCE4u-0005hc-99; Fri, 24 Oct 2025 05:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4m-0005eK-7W; Fri, 24 Oct 2025 05:27:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCE4k-0003oy-0O; Fri, 24 Oct 2025 05:27:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NKABpL017956;
 Fri, 24 Oct 2025 09:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsPixCQuXr0a3YA1K
 wWnXXRiIgqzlv8MPMc2bZkj0yA=; b=tITmzijTLHBrLElpXJ81Cs8tTAPGNPQ9B
 KQx3k/KJJW4ghdg8Qsd9S1Wy6TkbiY09TlkG6ZJXLa38QLyOOFVM+Cl6aK/W4uFd
 krPB11eRxy/wOoW1IomXOvlL19CwM2jNok2sNTzsoZSOcFX/1OqblzryeMcaLxKF
 9utiS3GqquSxWUom4ecYYkmPI+cSjM6nOu7GPlI5fAg1ffKLcdvU9etryz1Sj6RG
 ZAXEzkY85VghjgoOlOpJ5HlaJmub44L7/y3djHr+jX9S0FJqhPPHbMg3eMdy3sQ4
 +nl4zPGtwHFK2JMH36CyTEgxe8pTshIsq2J93l5kAaj2Q/md785Wg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sekc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:05 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59O9Q1uU017649;
 Fri, 24 Oct 2025 09:27:04 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sekc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O7mOgT014663;
 Fri, 24 Oct 2025 09:27:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sjmhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 09:27:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59O9R0np31588666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 09:27:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4307E2004B;
 Fri, 24 Oct 2025 09:27:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CE6520040;
 Fri, 24 Oct 2025 09:26:57 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 09:26:57 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v9 5/6] core: Pass errp to load_image_targphys_as()
Date: Fri, 24 Oct 2025 14:56:17 +0530
Message-ID: <20251024092616.1893092-8-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024092616.1893092-2-vishalc@linux.ibm.com>
References: <20251024092616.1893092-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ibqJ_2ZknIKYZPBu2Qz5AJYy-snmToGI
X-Proofpoint-GUID: NORefj4zzPGqsJbBmjJq8g1GNdfGiXyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwKzKXDcC201e
 dGK7Szz3gw6cU81GMx83TGEAXVHAOSJk0juE02Fla+Am5m8GzasiNR0zYtcbxY9TDz3in2p4g29
 uZXb+IHwfxab8ZH6nmv60rSnFDfKrJQvN4QprExo/y1KKrhsxvJK49o68U/12Y5bA70YEifLOJm
 wKpCM5IwG7OQnMki0Ym+8CUkLE16F3TGoicgoSR3d3/tkuHV5vx39YSeM5dk04vMJDTjK1HxH7e
 wQJ8n/I/KY+cTXmMGNHynAzRG6PCZw2Et8eLDUH0pfLcGFZGQjUhJSM6ML8l7MQSHCfRUCB3S0g
 KMzf8cYkRXGZvAJaR4UlazFn3oUaXypsoa1lj4bJpgiPe9CnMGGRxovt89N9ZXVCe0ry0SyS1PF
 E63EiOFp4aZKYhNZAYZj3tDxARyWdg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb4669 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=WwcbXC5amFkfT6oAP7YA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Pass errp to load_image_targphys_as() in generic-loader and
guest-loader to capture detailed error information from the
loader functions.

Use error_prepend() instead of error_setg() to preserve the
underlying error details while adding context about which image
failed to load.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 hw/core/generic-loader.c | 7 ++++---
 hw/core/guest-loader.c   | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 6689847c33..35d4e5f4ea 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -60,6 +60,7 @@ static void generic_loader_reset(void *opaque)
 
 static void generic_loader_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     GenericLoaderState *s = GENERIC_LOADER(dev);
     hwaddr entry;
     ssize_t size = 0;
@@ -149,13 +150,13 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
             size = load_image_targphys_as(s->file, s->addr,
-                    current_machine->ram_size, as, NULL);
+                    current_machine->ram_size, as, errp);
         } else {
             s->addr = entry;
         }
 
-        if (size < 0) {
-            error_setg(errp, "Cannot load specified image %s", s->file);
+        if (*errp) {
+            error_prepend(errp, "Cannot load specified image %s: ", s->file);
             return;
         }
     }
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 59f325ad9c..dcbe8e4520 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -81,6 +81,7 @@ static void loader_insert_platform_data(GuestLoaderState *s, int size,
 
 static void guest_loader_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     GuestLoaderState *s = GUEST_LOADER(dev);
     char *file = s->kernel ? s->kernel : s->initrd;
     int size = 0;
@@ -101,9 +102,9 @@ static void guest_loader_realize(DeviceState *dev, Error **errp)
 
     /* Default to the maximum size being the machine's ram size */
     size = load_image_targphys_as(file, s->addr, current_machine->ram_size,
-                                  NULL, NULL);
-    if (size < 0) {
-        error_setg(errp, "Cannot load specified image %s", file);
+                                  NULL, errp);
+    if (*errp) {
+        error_prepend(errp, "Cannot load specified image %s: ", file);
         return;
     }
 
-- 
2.51.0


