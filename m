Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFFBE4E63
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Oct 2025 19:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RwM-0006Yg-1Q; Thu, 16 Oct 2025 13:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RwJ-0006Xr-UI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:39:00 -0400
Received: from p-east2-cluster2-host10-snip4-3.eps.apple.com ([57.103.78.76]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Rw7-0007fe-WF
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:38:59 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPS id
 8439A180016E; Thu, 16 Oct 2025 17:38:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hP9mipJJlzEp8BAG964JLQLLOKiV7YupjQ0pPg2yZ4w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=LQ/mP+dL4vmoR5+mMT20McOOgJS6/v7mOjOP4zGQ5QVRJT1K9oR5TeuYvv53KNblg5jkcGt6MX37PM7wE2ZMIZKGsOQrd5/q9H1+sDuzemYOzi2aQokzEsvp4juSsKL4YFPbZJMPD7ch0V/48I/zLiVw1Y6bZCxlfOubgJeI7D1U6KYG5RuahwFagmoRGyrhAUEvxOGNnZb9OYFpDYADQGuAvO5wEfdP5J6xJZvdjt7eblrcv34gfbC7WohQPlxQyh6uBH8Tds0PqsJn+zqehsPw49f6fWZKm0UEFQ34FRsQDzFovxNm/Nq/HbZkLXePjGrytK1DfJifeeJNSgfMPQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-6 (Postfix) with ESMTPSA id
 9C4AA180010C; Thu, 16 Oct 2025 17:38:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 08/24] whpx: ifdef out winhvemulation on non-x86_64
Date: Thu, 16 Oct 2025 19:37:47 +0200
Message-ID: <20251016173803.65764-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016173803.65764-1-mohamed@unpredictable.fr>
References: <20251016173803.65764-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyOCBTYWx0ZWRfX+5XTb8DqkP/w
 aomfMluWZrAbrKPOpHDpZuMJ9RfmvHiFbjbz17SK1VMpeCmhaJzEQrfh1ZR+bpcFi2WzN59xJrZ
 5JHALVbVCFEOt/4uUxlrMORbEm9mEABxd2OAmcHFM7GJj3FaI8DRLyvnt/qidcFvLnZqufcxzaI
 x/plseLI8BgFN07UWf8dz3mkxLEhpfU3sWeAAU3MZah8Sn8zwg57eSSwpAIGzJ4D3Zsbu291Foc
 E+QgHZ2ZoHTT8NOtOyFl135FnrhfudVKYfz48QkORndVoH9Vt4PQa9tT2eDeXXDZ8hCtEN0tw=
X-Proofpoint-GUID: OwHBBW0hubc9_F7Zm8yQkW0bZjpjpFgQ
X-Proofpoint-ORIG-GUID: OwHBBW0hubc9_F7Zm8yQkW0bZjpjpFgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=766
 clxscore=1030 phishscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2510160128
X-JNJ: AAAAAAABxHUhm1q3G6Znj6AlF1nV1EKLBkFxsC7wPJ1b+/zbqfSH+KqPFww3qdrBf1HV/N10gMrED5RZV6aPsaGdHuPHyX2aVzHkCwK//xSz5GragYlSWYhVkcdSfZUrNB3xHN7Z3BDpkr+75l5oPrkaHNzYz6wjwGwp6Fl/vq0Lr3QlHG1iAPXbyq77hG/9ALsCsLbADqDmSxwieQKxd7CMi3widk968g0vP9A1XOtAcxsy78n3mk+Ww1ZljYlFUlRF6XnvOjtW2CI3MH0uH2mYafpedv+TEZX713o3Wq6XEbS0oGzq//L5VbZ3aescJlyBWpMpSbdxKGlZEPW9bzXVJjArz8oaN9rzXMJTfNQncpkw8Ssws/xHevQqeHJPVArl3BChZiDRBRAO+o1XQLIKXHnPwAOWBPnP72lMzwWIHfAuG4gSWEYVNbi9ovuQdiOqKUj3qUiHqkCp1zmB+bkOYusBy9gXBPwarmEGwxdbpNDBFB700cS1n5HdnUcaeMfGWwl3QbdFoZjdJH7/hDd5QTYsBiDI8jjQYidumpXU+1pwWuywVnN2NTQPnGnIODEPKIolRG0IrC+el4mGjjHBbdqYvuTDYamAehRXoDDqT+JDDGQ2lwbxb/Z1wLiWzgG2VDMLTgXa5g/17Dh7E5+kaYYroVm3EDV/g01bmwdIVBAG6gII953MjbcqnbiDehPoNo95+4XxqNHzDLrvFaxe8gTZEwEpPiEsKh5T6BNMaCfSz46SBdZYgq0gzjX7bVu0SnoFmRwzWHflkeLBATuTmHWc+9elBmlSnVIklJbWeQQ/2KzS2tM/rUlN+KzBMjTLPk/cSKc5oi2P8icGg7WSFLuajuG3vz5MoXPT/r/7TGw5hW/ttrOH1tjmBx0WUhO3UmTOeCYX/GebIPrb6vcapFw=
Received-SPF: pass client-ip=57.103.78.76;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the future, we might want to get rid of winhvemulation usage
entirely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c       | 14 ++++++++++++--
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 66c9238586..95664a1df7 100644
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
@@ -236,8 +238,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef __x86_64__
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -412,8 +416,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef __x86_64__
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -539,11 +547,11 @@ bool init_whp_dispatch(void)
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
@@ -553,9 +561,11 @@ error:
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
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..7a7c607e0a 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef __x86_64__
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
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
2.50.1 (Apple Git-155)


