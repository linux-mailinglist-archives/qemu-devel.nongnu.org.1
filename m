Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08481907A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:16:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWn-0001mS-RP; Tue, 19 Dec 2023 14:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWl-0001kR-Ea
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWj-0001lT-6V
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33671384e50so1164280f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013192; x=1703617992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F3MrT5q0KM6MELIuaCuVzJsIz/QtvXJBno3yclja630=;
 b=OFlced6Id5bYadrwG4hblPKgp1rWiTUa74FEN8p3z14qvyhlbbWSoBQ4BkUQqwy/4H
 abDP0O5hH8rZgLFpTIZWnKhzMxeZGPmhiOWloBN3W+ibWwsNl9ipHBkY2Cxath4VRsKE
 SQt5t7eFqByTtv2zAdZqzZeRdK7yQfKMQq2pfTZCjoAu++7PwBfT06LhxrOfWZN+697/
 I/NGOgkx5crC0xG+lLN5PGIe0gsZyZnAEJKaTZs45pFhAD1vCqAqAOVVEvBk+2xaFjHd
 lTXm9zBqxM3+aKMp0Y4bPraEVjRrSkMC8ihtSGZgPKAVTMciofUXPhsFRZGVVRYOP+Nm
 LkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013192; x=1703617992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3MrT5q0KM6MELIuaCuVzJsIz/QtvXJBno3yclja630=;
 b=rqGJUrBLrzvvhJN0ub/HUzTVBopN8EZnTDDcZx0ExCWIcmzsy3M2cwJdAz/KKPAlnG
 KVBgAY/UTwC9WwrG14VRJgE46dWGO48Q6zbolOOk+0rOkmciHf8zaugV0aoNEZ2RYyaQ
 6/Igt/9lB67XzpbAMhNFm6WmbpIj7w/tp3SfdZp7KVOo3iltkgcYUiB6on8GJlaiXx8t
 KUbMEE+3Eq/ThcMI9f558yBOsxWx9V6g8KwNylWphDsfWfij1m7MCzeVaGHErmXcTFm6
 c1X234a0apkDZIubGJuPeIhEFt38DtsSoD4e7rqTpibQhPOVbKmtTMByB+InDMgPx4dA
 O8Gg==
X-Gm-Message-State: AOJu0YyjtNklcRtBu5G3sqyaxPK7wZ8EUfUVf2OK4YorIETOBWUIjWkZ
 WplPNtejlyYlxRw/iULO8LwroiXIBktIVkVdkic=
X-Google-Smtp-Source: AGHT+IFmFnH06maRBrWiUNAIKP/yJb6hK0LMTrwiq6MAA+p8BEc5IdBZiQA4/fTeDHodtbBRopHIVA==
X-Received: by 2002:a5d:4c4a:0:b0:336:7793:6ab2 with SMTP id
 n10-20020a5d4c4a000000b0033677936ab2mr297507wrt.143.1703013191764; 
 Tue, 19 Dec 2023 11:13:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] target/arm/kvm: Move kvm_arm_copy_hw_debug_data and
 unexport
Date: Tue, 19 Dec 2023 19:12:29 +0000
Message-Id: <20231219191307.2895919-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 10 ----------
 target/arm/kvm.c     | 24 ++++++++++++++++++++++++
 target/arm/kvm64.c   | 17 -----------------
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index bb284a47de3..207b7f21b0a 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -462,14 +462,4 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
  */
 bool kvm_arm_hw_debug_active(CPUState *cs);
 
-/**
- * kvm_arm_copy_hw_debug_data:
- * @ptr: kvm_guest_debug_arch structure
- *
- * Copy the architecture specific debug registers into the
- * kvm_guest_debug ioctl structure.
- */
-struct kvm_guest_debug_arch;
-void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
-
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 696bc63e863..2898e680fc5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1021,6 +1021,30 @@ int kvm_arch_process_async_events(CPUState *cs)
     return 0;
 }
 
+/**
+ * kvm_arm_copy_hw_debug_data:
+ * @ptr: kvm_guest_debug_arch structure
+ *
+ * Copy the architecture specific debug registers into the
+ * kvm_guest_debug ioctl structure.
+ */
+static void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr)
+{
+    int i;
+    memset(ptr, 0, sizeof(struct kvm_guest_debug_arch));
+
+    for (i = 0; i < max_hw_wps; i++) {
+        HWWatchpoint *wp = get_hw_wp(i);
+        ptr->dbg_wcr[i] = wp->wcr;
+        ptr->dbg_wvr[i] = wp->wvr;
+    }
+    for (i = 0; i < max_hw_bps; i++) {
+        HWBreakpoint *bp = get_hw_bp(i);
+        ptr->dbg_bcr[i] = bp->bcr;
+        ptr->dbg_bvr[i] = bp->bvr;
+    }
+}
+
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
     if (kvm_sw_breakpoints_active(cs)) {
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 7d937e25390..ac3120adaff 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -73,23 +73,6 @@ void kvm_arch_remove_all_hw_breakpoints(void)
     }
 }
 
-void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr)
-{
-    int i;
-    memset(ptr, 0, sizeof(struct kvm_guest_debug_arch));
-
-    for (i = 0; i < max_hw_wps; i++) {
-        HWWatchpoint *wp = get_hw_wp(i);
-        ptr->dbg_wcr[i] = wp->wcr;
-        ptr->dbg_wvr[i] = wp->wvr;
-    }
-    for (i = 0; i < max_hw_bps; i++) {
-        HWBreakpoint *bp = get_hw_bp(i);
-        ptr->dbg_bcr[i] = bp->bcr;
-        ptr->dbg_bvr[i] = bp->bvr;
-    }
-}
-
 bool kvm_arm_hw_debug_active(CPUState *cs)
 {
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
-- 
2.34.1


