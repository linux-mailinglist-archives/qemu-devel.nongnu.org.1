Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAC723378
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 01:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6JDf-0002g3-2k; Mon, 05 Jun 2023 19:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6JDT-0002fQ-PS
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:02:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6JDR-0001PE-VK
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 19:02:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f7a8089709so17596605e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686006139; x=1688598139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3kB8pDwVkdb1VK5LW/w3G/8jYQ8BU6TjNbumjepsNRk=;
 b=WBpliMQ62X2WXLVJstOEZLbIOdNFtKOCcDyFfZdclflI9+HWY93SEHjwYMlsjBPA36
 W+lLA29J+7dT/30n7I6NLknsQssIjlg2bbVv58cJZcibkRqlx9ZiaGNmb+1OpWLDJ8aT
 hACk28+aRDNGx6p0C3tkS9rnbx+k5hwENLW1lq1R4XB+6LA2QW3PRguAj/dINBOfJFma
 a8QFJ/P/j0zb9frO7RAefKLcZ+douuj9g02CSrlByQKKFWW7QDYkkuMgY4/EMDwSmBuW
 Q8dytktX/iwwZKpJRb5NDmUuDI6rMurlE7SqlhZzRRtaofxrqMXI7SvLZpQ52UNKE7rR
 BdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686006139; x=1688598139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3kB8pDwVkdb1VK5LW/w3G/8jYQ8BU6TjNbumjepsNRk=;
 b=Tu4qtP+pVJ7zJ8VaxwtYhdWSKicRKwuoJlGfHh4MNo9G1xGRrV+4bCtBRiH3u+YsVH
 9xPnwgq2NoNq2vr+ZdPEwcjo7I6+mNp4LKHrUCoXOED6S1vZKTRsEl2KPRnIUe1HIzVb
 OLo8nxnbuChPEi1lUS4hQgC9dsEzqpsOsSWw/pmbPFpiJNSYy2rmanORLIDi8IL0/DWg
 HcGVtmHMpnKS/hoISZF3u04x2NXfKW8vWpOhZ99jax/JYqZoOb7kg4PwG1i+RxKEmOPG
 LoqlAUzJwTQ80a42SOXUCvzycVYCl1ZhNjNS8wkzbhZx8wvxK/3vMCD/605dZuIXanQr
 QvEQ==
X-Gm-Message-State: AC+VfDxOmkR50Aejm4Z35iNmK42C0kZtLjrglt+TGxIiAq9GNTEa4ZJt
 D/MtxMC37jwmJeEX1rLRwrhuCdKLEni+nYoMOvM=
X-Google-Smtp-Source: ACHHUZ7k99jbr0LYpS5uXYg/PHmVk8VmUQM1YtcTkcuTVYaSUFhToR6UQTiwlU8gGVGsHCh27IDP4A==
X-Received: by 2002:a7b:c455:0:b0:3f7:30c3:efa1 with SMTP id
 l21-20020a7bc455000000b003f730c3efa1mr389806wmi.30.1686006139389; 
 Mon, 05 Jun 2023 16:02:19 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c214d00b003f78fd2cf5esm4992067wml.40.2023.06.05.16.02.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 16:02:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] exec/cpu-defs: Check for SOFTMMU instead of !USER_ONLY
Date: Tue,  6 Jun 2023 01:02:16 +0200
Message-Id: <20230605230216.17202-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

We want to check the softmmu tlb availability, not
if we are targetting system emulation. Besides, this
code could be used by user emulation in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20230605222420.14776-1-philmd@linaro.org>

See also
https://lore.kernel.org/qemu-devel/7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org/
---
 include/exec/cpu-defs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0d418a0384..4cb77c8dec 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -60,7 +60,7 @@
  */
 #define NB_MMU_MODES 16
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "exec/tlb-common.h"
 
 /* use a fully associative victim tlb of 8 entries */
@@ -89,9 +89,9 @@
 #  endif
 # endif
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /*
  * The full TLB entry, which is not accessed by generated TCG code,
  * so the layout is not as critical as that of CPUTLBEntry. This is
@@ -133,9 +133,9 @@ typedef struct CPUTLBEntryFull {
     TARGET_PAGE_ENTRY_EXTRA
 #endif
 } CPUTLBEntryFull;
-#endif  /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
@@ -201,7 +201,7 @@ typedef struct CPUTLB {
 
 typedef struct CPUTLB { } CPUTLB;
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
 /*
  * This structure must be placed in ArchCPU immediately
-- 
2.38.1


