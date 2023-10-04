Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4A57B7B64
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxqg-0001Qa-KZ; Wed, 04 Oct 2023 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqW-0000dQ-Cw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqN-0007Of-ME
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406650da82bso17572715e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410415; x=1697015215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmcEZ4BojpksyjPshqc9VPV/X5+Y6Dg/MjyjckpWMK8=;
 b=MCrcRibS4vd8xD/2AU7y+351I2H/eoRinypn3OMtJC4i22796r1PSBk8kCHmqHI7Xo
 SFak2AeI6jkPJslPDUBbmYcOftzCUz3NQtFUBMR17DGTLojZTsIVjSzLS8zuLRDZHru2
 5eIxXJ59rOuhXpjmU6VkezFcWTMAH9h04NaoeiyZCdsfopUjx6ckF7IJF0N94BVZdkZF
 BaAGCLyriZePNSNrnFjo3GfYLv+ZuKAHmbhC4XabtdVH90WziQb03wnf9M74LgD5j1Ja
 Ma5igiPrPHOxSkXKgjq7WHkIntFprWy93QO85CWi3NPHIp0FHahuI6jbuUlukpa2nYYw
 5FvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410415; x=1697015215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CmcEZ4BojpksyjPshqc9VPV/X5+Y6Dg/MjyjckpWMK8=;
 b=KZB89DpkLupsB8Dgrza4PZrhZ7WKzmkuWT+7bzkNjo73XqL52Z5Q8fPVpSw7EIS81y
 cYxW2r8ITBWu9QrO8YLXGeEp+9XyxvhFkdKtZvWIVZmmfOun29voYZQV9pg8wAu71tSb
 ofqcUKBfvRiQjMTaFFDErQpmMcT0xzO8xzvnlKSzSxjbiJJOrTRrVAJZ2VHjLKYhWaHH
 ENFiX7VLhvdCzqwSW+VyVB58WJuhnsVcgDgucjQcNBlVEmhWncXPzabwmjmf5S12rhjH
 gzcEWhiJn2QgK+cGNDGHQcRcpmQIhwUlxY8qaabvwlyd439SRDUAEhZWQrBh52zhGBry
 mgVg==
X-Gm-Message-State: AOJu0YyFDNT9hP7UAWMOE9mtmp71J6laemZ8V+96/EeqeRhzoXrIfc19
 KNrXrFhoskKMfXykWk70aMUeN/DwRiPW/5mwU80=
X-Google-Smtp-Source: AGHT+IG2Qp9D4txq6Vut8bSAu4M/hP80xeIR9GNeroRhR/JZMY+iDCpDBkAH6DQNFsl+bQZmpXXLRA==
X-Received: by 2002:a5d:5591:0:b0:323:1d06:38e5 with SMTP id
 i17-20020a5d5591000000b003231d0638e5mr1656889wrv.55.1696410415277; 
 Wed, 04 Oct 2023 02:06:55 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 bl40-20020adfe268000000b003233b554e6esm3528654wrb.85.2023.10.04.02.06.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:06:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 04/13] fuzz: Correct invalid mentions of 'softmmu' by 'system'
Date: Wed,  4 Oct 2023 11:06:19 +0200
Message-ID: <20231004090629.37473-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/fuzz/fuzz.h | 4 ++--
 softmmu/memory.c        | 2 +-
 tests/qtest/fuzz/fuzz.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 21d1362d65..7da0bc3d7e 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -49,13 +49,13 @@ typedef struct FuzzTarget {
 
 
     /*
-     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
+     * Returns the arguments that are passed to qemu/system init(). Freed by
      * the caller.
      */
     GString *(*get_init_cmdline)(struct FuzzTarget *);
 
     /*
-     * will run once, prior to running qemu/softmmu init.
+     * will run once, prior to running qemu/system init.
      * eg: set up shared-memory for communication with the child-process
      * Can be NULL
      */
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 234bd7b116..fa1c99f9ba 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3638,7 +3638,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
 }
 
 /*
- * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
+ * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
  * the fuzz_dma_read_cb callback
  */
 #ifdef CONFIG_FUZZ
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 3bedb81b32..9b9c9f9c36 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -207,7 +207,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
         fuzz_target->pre_vm_init();
     }
 
-    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
+    /* Run QEMU's system main with the fuzz-target dependent arguments */
     cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
     g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
                            getenv("QTEST_LOG") ? "" : "-qtest-log none");
-- 
2.41.0


