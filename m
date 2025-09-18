Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A1B18B4A
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 10:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7Tv-0001F5-Lb; Sat, 02 Aug 2025 04:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rm-0007TQ-5X
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:30 -0400
Received: from p-east3-cluster3-host8-snip4-10.eps.apple.com ([57.103.86.83]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rk-00055i-Gx
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:29 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 185251800115; Sat,  2 Aug 2025 08:18:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uAK2JGD17JBPBJY0OV3B6ARqLAA1c242C6w8DU8xlGk=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=GYDEVKDbUtgXB0M0lwXNBWxJ+uLG89Lyk/qULhunYlCRt3WKKQ0B5WiaTkdhGhczq4UeuwBxnyfIJ2loyibTCb4v5chhwxN2Lo3E1fV7elK3kzAxg1KugxaMUTOTZGhyUhHuTLNxe4tieK3s7o+Hr8WNlthhTNjSUjjEnU4PYprZd44Aidre6R7xx4ZA//fFz7fZ0DhevlXYH3IWfbMpHcU2QqGR1iVHZ3KmcfzUwC3rApGy+F67Pc8TwwOMt+LipkF0SH47Mfp7zsT+TPOUy9Bpc62v3394Jb3qoTVcNZEDdLM5eaqTu8XppF/puZVeqZfot8JBoT5jo7bILmsm5g==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 7B8E2180015A; Sat,  2 Aug 2025 08:18:22 +0000 (UTC)
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
Subject: [PATCH v3 09/14] target/arm: cpu: mark WHPX as supporting PSCI 1.1
Date: Sat,  2 Aug 2025 10:17:55 +0200
Message-Id: <20250802081800.76030-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bjg7Su-cNr4q7sKZbaxsD4WLGgBTASsU
X-Proofpoint-GUID: bjg7Su-cNr4q7sKZbaxsD4WLGgBTASsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MCBTYWx0ZWRfX4GT24wo9Pev3
 JbB9fnbhwYUx1CNb7ofrStCDvcARBuP499/YWdv4m1CZezbijUxtwDF2mM6qN+9ql/uytjZsOcs
 h9SeodL3OuVZU0DZU7yZGP/VoGFqOw9LBt8HahH0z4Rv7xPoj7wDSDkWm8sT55i4agZN6GWFwIL
 HbR3kPOLHZm3Qzs/eN55Q/DYLVY3Ri8bK6xx1cIvZEcWvvBzLi4YCNtsGuRqBJWSaYJy6vLLEu3
 7/oNGGnguQWiqpG8ok0Qjm85J55mJM9DH/tPXPdVNnae8yZ7rNtiiacPnp/DwhnN4dx/VSc2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1030 mlxlogscore=900 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508020070
Received-SPF: pass client-ip=57.103.86.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399..3b69c9786a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1496,7 +1497,7 @@ static void arm_cpu_initfn(Object *obj)
     cpu->psci_version = QEMU_PSCI_VERSION_0_1; /* By default assume PSCI v0.1 */
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
 
-    if (tcg_enabled() || hvf_enabled()) {
+    if (tcg_enabled() || hvf_enabled() || whpx_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
     }
-- 
2.39.5 (Apple Git-154)


