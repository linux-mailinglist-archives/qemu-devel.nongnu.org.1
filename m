Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65039B18B3D
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 10:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7UI-0002kA-9e; Sat, 02 Aug 2025 04:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Ru-0007j1-12
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:38 -0400
Received: from p-east3-cluster5-host5-snip4-4.eps.apple.com ([57.103.86.175]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rs-00057D-FC
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:37 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 97B971800161; Sat,  2 Aug 2025 08:18:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=dSbSkPQq8ziwuUrDfcT+wVetv0JbuPGQpZU1ZgNV4oY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=Xa1DpHntTkbMnmHrLWeCboXngT5/iJITi1jJK4TBa/ne7yw9rmoxdnvfmeGUb7S914t036zI5NakITL+d2Asbjp7/jLSjV+7LJIgrI1c6W7MSmZXQbIc9IrAp+I5hxAuWqWyDDFgqedgx5ztHKFllAAIGiQh571iY01jVbdo+FKvbFbYh8AUq0cndoFo4UKsxQAdLa9uDwD09ZCAIsJoa/2Wl30OVaUYijfxRk0MdSXTDjxWITzbHueMYxLxd6ZPVk4xD3Y/pMosRtVVfvUwY8HjFc/LovzK+sn0lmrYwmjFk7rE8j9rr9dTy3BAljQXUui01SOBCpvuig2n18tyGw==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 A8ED5180009D; Sat,  2 Aug 2025 08:18:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 10/14] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
Date: Sat,  2 Aug 2025 10:17:56 +0200
Message-Id: <20250802081800.76030-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MSBTYWx0ZWRfX90zUBLTzVBOy
 JYUquMfh0UsA9oAlXLE+cjk504zeXdJ5IBElVwRRjBheUJGbdzY8Snv/uEO3+j64Gw8LCjakW0c
 ji9Hfnz0iMX8fEyY0hZ0UdogDOxuzDcdlp5Lmgb8yDwN/1c+oWKz7sQxKETMFatOoMa8j8LxFkv
 DKp2ty7g64n4mqrwnwenURqVFBV1y5D8zBZbQn3CvmpAk7lEsdZLT1/q+NZYzdWwMPZ4/zh27IM
 KHJfGwc5X4nWAPt7DSiI+jkX6CdOrl7YmblbYe+FbLDk1bK0a1n3BBMdjdfkWYWbhJFqUuwzE=
X-Proofpoint-GUID: aioGnZUk33QBwqcDg2zaDNwqrw1RPhBi
X-Proofpoint-ORIG-GUID: aioGnZUk33QBwqcDg2zaDNwqrw1RPhBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=880 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2508020071
Received-SPF: pass client-ip=57.103.86.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Windows Hypervisor Platform's vGIC doesn't support ITS.
Deal with this by reporting to the user and not creating the ITS device.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/arm/virt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 98a1c74c42..1c695c0642 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -741,6 +741,16 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
+    if (whpx_enabled() && vms->tcg_its) {
+        /*
+         * In the HVF case, inform the user that they can use the
+         * user-mode GIC if they want to have an ITS.
+         */
+        info_report("ITS not supported without kernel-irqchip=off on WHPX");
+        info_report("Disabling ITS");
+        return;
+    }
+
     dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
-- 
2.39.5 (Apple Git-154)


