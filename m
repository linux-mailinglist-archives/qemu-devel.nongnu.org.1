Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DD7BC081
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorct-0006Mc-SS; Fri, 06 Oct 2023 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qorcZ-0006EX-Td
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 16:40:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1qorcU-0001Ro-Pg
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 16:40:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 396KXUvY002765; Fri, 6 Oct 2023 20:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=oKyfU+IoikYzKlOcy50ZekR0oS5L7D/+MLdTTNyNVUc=;
 b=MUZwKd+HNChHbQMUj+w0Hofrfgvbv3iSlqQD7tibnEPDBcEY/SdVwfSXIljWbJPt8b4y
 aNFCnn3r789s1up7vFLOpxY9+kFXtDHAl//c6irI3i9WXulEVFMtFqbUHkiReEuKlsoY
 zAi3kpAaRw22sBmm11ZJA51B4IHKk8aydSEcQ2Ds1QzEQqm4L+JO7Ap4mZZI4DkTaVg8
 edEe5Qgply9osymcJsHXLDUrMhBtn1gHXoPNwD1PiLLuMTKTwOBACPCSByy/N5uMnnQB
 kkIJes0sEDJ3Dehl7nflggCEOpJSd/0cZqLuugLAiSkIANSAHNQdul+akP/61Eo8Q+Xw Zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tjnddgjbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Oct 2023 20:39:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 396KdH8a013251
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 6 Oct 2023 20:39:17 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 6 Oct 2023 13:39:17 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH] hw/display: fix memleak from virtio_add_resource
Date: Fri, 6 Oct 2023 17:39:01 -0300
Message-ID: <c61c13f9a0c67dec473bdbfc8789c29ef26c900b.1696624734.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: xDAGgHlSpM6YJRF0CfNy1enxLqzFuPjm
X-Proofpoint-GUID: xDAGgHlSpM6YJRF0CfNy1enxLqzFuPjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=965 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060156
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

When the given uuid is already present in the hash table,
virtio_add_resource() does not add the passed VirtioSharedObject. In
this case, free it in the callers to avoid leaking memory. This fixed
the following `make check` error, when built with --enable-sanitizers:

  4/166 qemu:unit / test-virtio-dmabuf   ERROR 1.51s   exit status 1

  ==7716==ERROR: LeakSanitizer: detected memory leaks
  Direct leak of 320 byte(s) in 20 object(s) allocated from:
      #0 0x7f6fc16e3808 in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cc:144
      #1 0x7f6fc1503e98 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x57e98)
      #2 0x564d63cafb6b in test_add_invalid_resource ../tests/unit/test-virtio-dmabuf.c:100
      #3 0x7f6fc152659d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x7a59d)
  SUMMARY: AddressSanitizer: 320 byte(s) leaked in 20 allocation(s).

The changes at virtio_add_resource() itself are not strictly necessary
for the memleak fix, but they make it more obvious that, on an error
return, the passed object is not added to the hash.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 hw/display/virtio-dmabuf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
index 4a8e430f3d..3dba4577ca 100644
--- a/hw/display/virtio-dmabuf.c
+++ b/hw/display/virtio-dmabuf.c
@@ -29,7 +29,7 @@ static int uuid_equal_func(const void *lhv, const void *rhv)
 
 static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
 {
-    bool result = false;
+    bool result = true;
 
     g_mutex_lock(&lock);
     if (resource_uuids == NULL) {
@@ -39,7 +39,9 @@ static bool virtio_add_resource(QemuUUID *uuid, VirtioSharedObject *value)
                                                g_free);
     }
     if (g_hash_table_lookup(resource_uuids, uuid) == NULL) {
-        result = g_hash_table_insert(resource_uuids, uuid, value);
+        g_hash_table_insert(resource_uuids, uuid, value);
+    } else {
+        result = false;
     }
     g_mutex_unlock(&lock);
 
@@ -57,6 +59,9 @@ bool virtio_add_dmabuf(QemuUUID *uuid, int udmabuf_fd)
     vso->type = TYPE_DMABUF;
     vso->value = GINT_TO_POINTER(udmabuf_fd);
     result = virtio_add_resource(uuid, vso);
+    if (!result) {
+        g_free(vso);
+    }
 
     return result;
 }
@@ -72,6 +77,9 @@ bool virtio_add_vhost_device(QemuUUID *uuid, struct vhost_dev *dev)
     vso->type = TYPE_VHOST_DEV;
     vso->value = dev;
     result = virtio_add_resource(uuid, vso);
+    if (!result) {
+        g_free(vso);
+    }
 
     return result;
 }
-- 
2.37.2


