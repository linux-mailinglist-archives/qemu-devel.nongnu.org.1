Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BFB18B40
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Aug 2025 10:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui7Ut-0004vE-CJ; Sat, 02 Aug 2025 04:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rg-00079n-S1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:25 -0400
Received: from p-east3-cluster6-host8-snip4-2.eps.apple.com ([57.103.85.203]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ui7Rb-00053V-SM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 04:18:24 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 349FD1800157; Sat,  2 Aug 2025 08:18:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=at/Y2OtfaWvTKG4XZpa/WbQ/msA/kh54pRtcf/l0OZ8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=cleSBc8el1zVNpe3Q95bwkZdMvoMeVjcMEeZ5Y0rWFMfuYPo11saboU6MZW+1n5HKey8jwRjO2MkDgPHcR1YtxNrJxd98PKjs653INRSrDrYJwveJAgESkrtIUDGWChbXTpkqQX+4IUTNlc/9zZ7dxVtG3AMATB+Aw3sCWI74s7kYy78DGYZkYlj4AvOJwA59Y60aptiLUYtt0z0EbWlIN3VUMf9JBFYCgjBdLFPAUcr+uu5P1nH/6juLeHJnEmpB3JHSZPpVbWNSemvNhkv8FtGpOkr++631+n/Jbrq1fEGd9Ge9sG8eBMAsWbOwaAvtAsF1ts2d7wTnsU37SHMHA==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 3B5F51800148; Sat,  2 Aug 2025 08:18:11 +0000 (UTC)
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
Subject: [PATCH v3 04/14] whpx: ifdef out some x86-only code paths
Date: Sat,  2 Aug 2025 10:17:50 +0200
Message-Id: <20250802081800.76030-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250802081800.76030-1-mohamed@unpredictable.fr>
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: j7aH2gNGt3tX8N-sl7SxZ-w_LFCmmOIV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA3MCBTYWx0ZWRfX1KNllqqByg0R
 cWugMQWPb9e6KM/Gb7InzllJbQ+tepXg6PclIf8PWeuSqSy6R9FRwlyBBec4TQZpCdmap0ztgBX
 xU+InpCPMYZ2mC9oftuTTdCVKJXm/miKBUOZ70PLt95oYGbW3wtSQolRxos4yS5u2R5aBKEv4rn
 6WJ9XYSnfrLsS+axeDV8xyFwM//PNSurUD7asa6TQx8pOGIxlq00UW8Ex5+ZCQ21QX/Srm2TsvH
 Gv6Qg4TgiSIMWJqkq7/cc7pHRLG3SV5dOzFuEq0831ci+Xw9irDuLjUQgGo53Mdh2lXoZJprY=
X-Proofpoint-ORIG-GUID: j7aH2gNGt3tX8N-sl7SxZ-w_LFCmmOIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=798
 phishscore=0 clxscore=1030 mlxscore=0
 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508020070
Received-SPF: pass client-ip=57.103.85.203;
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

winhvemulation is x86_64 only.
Exception exit bitmaps are also x86_64 only
Others are just variable definitions not used on arm64.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 20 ++++++++++++++++++--
 include/system/whpx-all.h      |  2 ++
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index b5e5fda696..eeefaea329 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -41,7 +41,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef __x86_64__
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -106,11 +108,16 @@ int whpx_first_vcpu_starting(CPUState *cpu)
              * whpx_translate_cpu_breakpoints(). WHPX breakpoints must
              * now be recomputed.
              */
+#ifdef __x86_64__
             whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, i);
+#endif
         }
+#ifdef __x86_64__
         /* Actually insert the breakpoints into the memory. */
         whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, true);
+#endif
     }
+#ifdef __x86_64__
     HRESULT hr;
     uint64_t exception_mask;
     if (whpx->step_pending ||
@@ -132,6 +139,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
                      "hr=%08lx.", hr);
         return 1;
     }
+#endif
     return 0;
 }
 
@@ -238,8 +246,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef __x86_64__
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -414,8 +424,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef __x86_64__
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        abort();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -541,11 +555,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef __x86_64__
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -555,9 +569,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef __x86_64__
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index a82b083284..838a25fa75 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -8,5 +8,7 @@ void whpx_get_registers(CPUState *cpu);
 void whpx_set_registers(CPUState *cpu, int level);
 int whpx_accel_init(AccelState *as, MachineState *ms);
 void whpx_cpu_instance_init(CPUState *cs);
+#ifdef __x86_64__
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
 #endif
+#endif
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..629810b384 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,6 +3,7 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef __x86_64__
     WHV_EMULATOR_HANDLE emulator;
     bool window_registered;
     bool interruptable;
@@ -10,6 +11,7 @@ struct AccelCPUState {
     uint64_t tpr;
     uint64_t apic_base;
     bool interruption_pending;
+#endif
     /* Must be the last field as it may have a tail */
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
 };
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index e61375d554..e57d2c8526 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef __x86_64__
 #include <winhvemulation.h>
-
+#endif
 typedef enum WhpxBreakpointState {
     WHPX_BP_CLEARED = 0,
     WHPX_BP_SET_PENDING,
@@ -98,12 +99,16 @@ void whpx_apic_get(DeviceState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef __x86_64__
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef __x86_64__
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.39.5 (Apple Git-154)


