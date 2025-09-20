Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA93B8C9D7
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Sep 2025 16:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyAz-0006aI-5M; Sat, 20 Sep 2025 10:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAo-0006ZC-Mp
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:47 -0400
Received: from p-east3-cluster4-host4-snip4-10.eps.apple.com ([57.103.84.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyAn-00086k-8B
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:02:46 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 8914B1817080; Sat, 20 Sep 2025 14:02:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=PhLJzUtKf+LkD6Ec9pG9Thcy5r3gUsucKZDUxMVqHrs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=A1AbolwxSOrVlLmVbAA/4tFR6/nOM5uf4tpPXVfHz0x6ndYcAOyyrThYxk7h8t2CRxgMmtT3L1udE5RrupF+nQvlAnqoWr8acVz2UaRU5zdOc5u7/GikiTE04uHJ/n5I8SQCadB5NIKU5XxPw1qs1ER3ucum5D2jHlcANRUp10HTyTsyZckxk1DR+9lTuMh36V0QqDOMbwRVYDgeyjEHzoNRkycD7kYYuZY4QeC2WGefaMq2G03R0KYflTo1BWe6LNXjTQgCykNVUxlTb2Qbe7St9i2cfhj0gSH3Cj82Pq/p6Fe6mAwnQanbPZ7H89G6nequYTCPwZECtJ/lA0VWvQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 2FF5D18172D4; Sat, 20 Sep 2025 14:02:06 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 13/23] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Sat, 20 Sep 2025 16:01:14 +0200
Message-ID: <20250920140124.63046-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1kCwcYHxALyAWxcvWGeOKt5L23Bju8Gy
X-Proofpoint-ORIG-GUID: 1kCwcYHxALyAWxcvWGeOKt5L23Bju8Gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX//rypqGR+ZZ3
 6IscCsCP413dtyLTYRS9jUM4sVSeTuh5MWok/0OvSmdCTE1e1CuZGqYdiNeSiR2aKl4oBbjrCId
 jQ9ffZyxFUmkfJ3y9SsSBJ9TfZX42GDt+dB9Atd/yLnNtVm7Azk6I7DEDx6OxYmtbs1W27AkUkS
 55xkFroYV0JXidzXMT8CYCZ1npSRGxxAnFF1f2VJasZGoT7Em5UKL40HS61r0k2TAqC/ntcj9o5
 spVO3kDdejqRLTiazSdcANhIHgo/eBha4P4GRK1MX0ZAFyjYUr9tLuElqdm+8vYv4UZuQVKtI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=892 phishscore=0 bulkscore=0 clxscore=1030 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABCaQ/PnPyuLfW4ZHwdiAblKEVDn58xAMRycDfP/CUPNc4G37Cjny+CiI0bGNIDMrvJeky1S9sEuUclVp6Yl6U6KgYHdw065jhw7hVVoct79AxBAQvaPJ+QWDhsx+I/ctUNYxOgIzmoLh2u96DMvmZlPADWfeFrfJmdwc8VnD9gRnHVG94ycavYiPvSRPrTIBLun0hGdeLUKZCzqIUB4wpx5QDSpuNa4EkP4Ny+6/rmr+LMESHBEObiMflwnWMw7A4485phzcsiEi17sLCkS0/3upNaCJlJ7nSqWVtwrLRKIaR3tohAKx7JZ4qy6Dm5jwWdY8UU6URwbJepZc1fQwR5PBXmEsehEJF1c3X0GZ66Jee9tU2Efzv7jzNYYXbWGi0lN4EYmp4GMl2iXfywwYeYsIgyseIIauvO1OG517X+ghps9GFNlsLLcFqz02x0Z5OE5vzOlC7isHVvantcs9VStJPjMHZlMpjXoST8gAofQbI3sRVo37UzuSwxKJLzL7vgPuuWalhXVVw89599DcXWVRtrN2LbLTS5w4C+WS5Jd19E5DNO12e0tqunSVJlhsBL3mguqLCLXtH1//j3bwSPiz4pmAOUfW1OBixaiKC3xCFHOlm6YWYvkE/vYyfxaBFEQp4QTP5H3DeB91fpp/gALZPM+IfXqNpvjO3v6EqoTbP+88pFBzwf3vR4Z5Mo8y/jZNU2WN8T0ZTHhTTZMeWtAfimOg+n3ZeG0kN3F9m7Apv29Hl28Maa57xc8Yf0qCbOZr3sHnhIgaM7Fm2YSRGLZQztrK2CzUYtup+FRNhB3ddr7BOzBfbYo4NUU3lERTlT65viI+HyORQrEPy4SHs8bsrL/BTnOAYmx3BqrywAm6tIlpB1u8GF6Eg81WeQkLMv7/aBCiajzKO03z0A/YPohiSbpU+G5M92g==
Received-SPF: pass client-ip=57.103.84.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c65af7e761..5a5dcda60c 100644
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
@@ -1126,6 +1127,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


