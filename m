Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CB800D2F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94ZD-0003Zy-Lj; Fri, 01 Dec 2023 09:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Yz-0003ZC-WD
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:18 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Yy-0002Xp-Du
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:17 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50bc36725bbso3210417e87.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701441134; x=1702045934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzQsYOZx1lby/03o6yhLAnKTrunXv93oPFAjodmUZ7Q=;
 b=mGNXZeGt4LleZsRH7SVt8Q7wjSqera5hWc063YxmTU+nEbsPen88n1h/SbUw88OQm/
 UxXn+aLHtTtynu8NZf6WyhNrXahAOe1tva4cozSwozUkraZ/7YmPCWmulVFCEsN38d7R
 c83VVsbPnsEFTlxshnlj+my8t6Np5jZGjB9a6VWTHJ3yrnPU0sNr312uO9zzrMECBWXU
 6Jt5Ncebw6O8YzUB2o8Gf5G2blMp0PGGiSr497AImY0s2pJn+wr7pfmBPK7hpLoyGTeO
 kjC5ikBXWxlok9I8XXKVAC3sC8b+68ePGaQ3aA4jHADRJqjmvgm4vIfW9apwJ7N/+4Xy
 L2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701441134; x=1702045934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzQsYOZx1lby/03o6yhLAnKTrunXv93oPFAjodmUZ7Q=;
 b=wgFv4OCigTzvTEHoZW8AAp2UgC5wbtUBYjkWPWPj9jsd5byed58WqdLzakfaLIpu0O
 xgryiyBuOlSflLNZ83TY3xkoImAqsh7Pf2ni6upR7KWgLylw5A11MpLRUbz3yHb2C72w
 VR+aiGlj3idnh8IL08X0om9xeaCj2xVHg9E6wMEwHk8xQNGqlM7cydn9NKn8Q0QZ3FHI
 AZtcbEwEEPslkZsKLH88HrWIsA/tBMJyyG0gqoFWGGfsmEJNocxS7iytfpJ80U/Gk5Ta
 uId7WEOpKfuvegWbK9uu+iQNd5zbRdaM15OUyALPUS4yvwZorCu9fMNOzlqixuh60Zdf
 EJQQ==
X-Gm-Message-State: AOJu0YyKoqyoBWi0qg52H2JQxZf+WFgdjbA/CIr3hw14sE5M2ncxFLf0
 yhB2GUyhS7cmcSflLnG8Uxi2C2+zJngutAkt1QQ=
X-Google-Smtp-Source: AGHT+IGxNtCUIXiaeul22hFkOioPcdXpn+nN/fti0ygrW7t/+DOLxnpEWtcg8NiaYZKBjrk5iX+fQg==
X-Received: by 2002:a05:6512:1598:b0:50b:d763:fe35 with SMTP id
 bp24-20020a056512159800b0050bd763fe35mr1096852lfb.80.1701441134581; 
 Fri, 01 Dec 2023 06:32:14 -0800 (PST)
Received: from m1x-phil.lan ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a056000114900b00332e8dd713fsm4350612wrx.74.2023.12.01.06.32.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Dec 2023 06:32:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 2/2] target/arm/kvm: Use generic
 kvm_supports_guest_debug()
Date: Fri,  1 Dec 2023 15:32:01 +0100
Message-ID: <20231201143201.40182-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201143201.40182-1-philmd@linaro.org>
References: <20231201143201.40182-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Do not open-code the generic kvm_supports_guest_debug().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm64.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 3c175c93a7..031d20ad92 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -32,13 +32,8 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 
-static bool have_guest_debug;
-
 void kvm_arm_init_debug(KVMState *s)
 {
-    have_guest_debug = kvm_check_extension(s,
-                                           KVM_CAP_SET_GUEST_DEBUG);
-
     max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
@@ -1141,7 +1136,7 @@ static const uint32_t brk_insn = 0xd4200000;
 
 int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
-    if (have_guest_debug) {
+    if (kvm_supports_guest_debug()) {
         if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0) ||
             cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1)) {
             return -EINVAL;
@@ -1157,7 +1152,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
     static uint32_t brk;
 
-    if (have_guest_debug) {
+    if (kvm_supports_guest_debug()) {
         if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
             brk != brk_insn ||
             cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
-- 
2.41.0


