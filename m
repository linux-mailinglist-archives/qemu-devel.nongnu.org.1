Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508BCAAC835
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 16:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJPA-0007nN-NI; Tue, 06 May 2025 10:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOw-0007XV-CK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:06 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJOt-00015f-Gq
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:36:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso38916695e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542161; x=1747146961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyLIfZxsmVP3PFHnzyMGQ582LpuVqxOjXPbqGRHcLQU=;
 b=HFDtun/8jXOYX7SIcNQbZUPbhvpaWSXMQxwieaCQ825Buw4OHi6ZhFwFJQweMGAX1Y
 xz0QaLDao9XZrMLRoJfnvDKiuUnBruIwHOptHYaiod1LFGr75U2l7tbF5EA/XCgR+kr1
 oMi8hwGYSWTn91phlrhaCSvax3hQytCNUFB+3I/HELW7KZcyRSHXetNpjY7NfKCGeZ92
 omWwERv9TViJPsINElowJttmrCh1RkXhxAJJfNV3lezVUwbWDNFHVg83piHax8KUgS1H
 oQ3kUjBH9f+WucBHlvfxkTUmodQ9uJ79LPWc379isTVAcgMPQdcG8g+R9rbl8ihRcrF7
 z4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542161; x=1747146961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyLIfZxsmVP3PFHnzyMGQ582LpuVqxOjXPbqGRHcLQU=;
 b=qeGXZNvV/9N9FSkmB5zmWSgRMp1bz++JWwPspM9wjJtJfl2Fe65Da9UK6gGTyscc1y
 EaV0vJw1YVAWortrN4Wfx4ltBR0Zsa7UA/1h1qhkn4zq57/rk/NLC/eEJVSs73cYjmop
 BioyFgs0qcC/zLVw1mVDewbQu3jPpnSNQacFBFhWXM1SW2IfVKHoyZx7P/FgBmwkP289
 oX2T1INfgah4geFZemfQk36eMf4djB0pd+W97tb4yL8J7IVSXukMdm2ebf6X3pxb7srn
 2+vsaK16tdmf2aqgWXxXXQA1H4rdY/pmz+3ljnyN574reXsl4Qb7KjjHV6ne95TqwX89
 QR+Q==
X-Gm-Message-State: AOJu0YxHIMsgHQJMhVTqk1Ie/ODlJQ4itrkNCYS660W8Djim1gT87dQt
 Br7sQAzX6HvTfYwrWAtZsWWgRpUHjwIMVUAIt7e5YRWl3mWuksy+R3M+OkvzH79FIgCtfwD8ATx
 N
X-Gm-Gg: ASbGnct59rgJKIntEe6WwIv7GXAJuhKZjimo7vmlkpXveo+eRjJ8++zAmwPI8pUXyzt
 cjjLyegDHQd65Tgv3PSxVBWJWEFJMukcR5q31h1AQn1Dju2OqUYRhWTlk52c9sIh9/x5Cr+aPmy
 YO+rn7Epb3pBt2Y2ucC1EyOWZAcuxi/Wvx2vzSE9VXFgr9Pd6fdxcZAduRTEs1dnm/wTVnwvYMg
 d3hHUZDAMFS4h4sHrh5hsd1HF5WuJwnWj4m65RpUHdhVm7TMiqHM7YvnSAcd84/4FQva6cXVsQv
 b/suWsKvnqs+8b8ftOVGVrFdc7JpX/rrXAqxkdvZYPKfEmpyDUO8wQsKNPQogEgnOcvqjq8g4Y+
 jUT4av0rFUBnK/enmWuzu
X-Google-Smtp-Source: AGHT+IFacNYDFOm/bPeW17T9oXnwwCRhK0gwy3utXs3fd64bnWyFXBX2Yprcv/w5/+pODgDny1BiBQ==
X-Received: by 2002:a05:600c:1d8d:b0:43c:e9d0:9ee5 with SMTP id
 5b1f17b1804b1-441bbedbc36mr154773025e9.18.1746542161365; 
 Tue, 06 May 2025 07:36:01 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17017sm14123872f8f.92.2025.05.06.07.36.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/22] hw/hyperv/vmbus: common compilation unit
Date: Tue,  6 May 2025 16:34:59 +0200
Message-ID: <20250506143512.4315-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250424232829.141163-4-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hyperv/vmbus.c     | 2 +-
 hw/hyperv/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index b147ea06d87..961406cdd6a 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -19,7 +19,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/sysbus.h"
-#include "cpu.h"
+#include "exec/target_page.h"
 #include "trace.h"
 
 enum {
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index f4aa0a5ada9..c855fdcf04c 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
-specific_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
+system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.47.1


