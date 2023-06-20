Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F4737357
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBfbT-0001rM-KU; Tue, 20 Jun 2023 13:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBfbR-0001oi-2L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:57:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBfbP-0006Ex-6u
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:57:16 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31129591288so3257727f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687283833; x=1689875833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A7MUYpd3IMUWkrnEJB+E7jmX9H+oCsy5+Tonn3PKrl8=;
 b=VkZY3zp5HI8iliooA/6IA/vVETWlKpGFDBvCJO9PlMUeA3UG1c83rnXKBposIdIfrJ
 VSkwjQA6HnyBRPtRRsyZnrNkDwld+IzL2D44Z3PRkWhQtoiVVK9PC+kCu+KR9oWCM/FD
 uwvUZn9gHP/7cwrk7HyRxAmmsYlF2ehGe+xrV+cVBpGpyQ6lkj9Eom2w3I5qOQbkFimI
 QyqJDu530a5liFVcaylV1h64ZfevmpzqDhLlCU/atNZ7uL8J5B/a4LwQ84d/AJyrMWws
 2dKPw/2rztS42YzakMt4YOnauRTNSEKMuxTiB/KHY5QbW3wXD8pZh/WUK6W3SS9OLpB0
 w04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687283833; x=1689875833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7MUYpd3IMUWkrnEJB+E7jmX9H+oCsy5+Tonn3PKrl8=;
 b=djS+FyZpcTfXVIr3PP7f02iPkTB2MhQbNPzQicnOvG6Zd2HE/IIVdDlQChXPYpzOkd
 rUoQejcsIcpxx05N63RCIjvrkccgsNqnhjrtZtCOc6+nktD1eqTd1Ls5MWGnDOzEoRaB
 lRW4yUC7AaI9FfigfsaHhiaRQPi5bHanOjZQxoT1fgs7+MCoiHmKLtNndFnzKFUl2/1x
 vlCs9Z6XKPzH2PP/0GllYmi/PMH8k0cdADdFGE3vdClEu/bqeLCyFS3GfIiIsDUpfwJj
 ac7iUkaDuJhbTY0SbOH2f9EKY/loXKo9iondqfNll4XklOpYxZLLGSDS5xowcUpzxBNV
 bcSQ==
X-Gm-Message-State: AC+VfDxbP/dTmVyaE6A9PBp8J99wqwE2dhQBGito7mwS9VnakLfbonvH
 IIZCK00QXuuuo6plwx7ZcXcPKId5S8bfoaSmnls=
X-Google-Smtp-Source: ACHHUZ6ovx7rmroxBaQYFyx0/R1T0QFu3pK2yNJbzFkh9MhYeP60PlkdSPr2FwJTPmaOzLlmDRLU6g==
X-Received: by 2002:adf:f9c4:0:b0:30a:e513:d596 with SMTP id
 w4-20020adff9c4000000b0030ae513d596mr9588382wrr.43.1687283833497; 
 Tue, 20 Jun 2023 10:57:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a1-20020adff7c1000000b0030fafcbbd33sm2466195wrq.50.2023.06.20.10.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:57:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] Revert "cputlb: Restrict SavedIOTLB to system emulation"
Date: Tue, 20 Jun 2023 18:57:12 +0100
Message-Id: <20230620175712.1331625-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This reverts commit d7ee93e24359703debf4137f4cc632563aa4e8d1.

That commit tries to make a field in the CPUState struct not be
present when CONFIG_USER_ONLY is set.  Unfortunately, you can't
conditionally omit fields in structs like this based on ifdefs that
are set per-target.  If you try it, then code in files compiled
per-target (where CONFIG_USER_ONLY is or can be set) will disagree
about the struct layout with files that are compiled once-only (where
this kind of ifdef is never set).

This manifests specifically in 'make check-tcg' failing, because code
in cpus-common.c that sets up the CPUState::cpu_index field puts it
at a different offset from the code in plugins/core.c in
qemu_plugin_vcpu_init_hook() which reads the cpu_index field.  The
latter then hits an assert because from its point of view every
thread has a 0 cpu_index. There might be other weird behaviour too.

Mostly we catch this kind of bug because the CONFIG_whatever is
listed in include/exec/poison.h and so the reference to it in
build-once source files will then cause a compiler error.
Unfortunately CONFIG_USER_ONLY is an exception to that: we have some
places where we use it in "safe" ways in headers that will be seen by
once-only source files (e.g.  ifdeffing out function prototypes) and
it would be a lot of refactoring to be able to get to a position
where we could poison it.  This leaves us in a "you have to be
careful to walk around the bear trap" situation...

Fixes: d7ee93e243597 ("cputlb: Restrict SavedIOTLB to system emulation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/cpu.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ee8d6b40b3b..4871ad85f07 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -226,7 +226,7 @@ struct CPUWatchpoint {
     QTAILQ_ENTRY(CPUWatchpoint) entry;
 };
 
-#if defined(CONFIG_PLUGIN) && !defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_PLUGIN
 /*
  * For plugins we sometime need to save the resolved iotlb data before
  * the memory regions get moved around  by io_writex.
@@ -410,11 +410,9 @@ struct CPUState {
 
 #ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
-#if !defined(CONFIG_USER_ONLY)
     /* saved iotlb data from io_writex */
     SavedIOTLB saved_iotlb;
-#endif /* !CONFIG_USER_ONLY */
-#endif /* CONFIG_PLUGIN */
+#endif
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
-- 
2.34.1


