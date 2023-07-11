Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C861874F391
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFNa-00077C-SP; Tue, 11 Jul 2023 11:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJFNY-00076e-9A
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:34:16 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJFNV-0005Xr-LN
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:34:16 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9922d6f003cso765381666b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689089651; x=1691681651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=86/jbKk9mpH7o5Ei8JC92SPbLl0aqPRLgXFSEbJBkeg=;
 b=m0nuIP7C2ZVEmvXXiK3X2uytRCQMoqsQEeDTxqwItxDBdepGjvlhfd7AD7Svb7v5sm
 Wi7v+7TOq2mth3PN1JUBqmfGXIRa2E3PshoAzQQX6flFTaO3nghAzBSxbCqRKIOEj5Jq
 LOvNJPiCktdynyk5CbthOVXMzNK4l5DawPsMxcQuudzrGF1vyauMpn5EBYmKcACc91BN
 EoeZSVrqnr1PwNlOL0KBR6ylwSnKymYyEc4yetkPoO9sWbXeyTuUUzfpEe2lYyp6av/9
 FRWtZ447LId8tu4N9rlsjajpPulLyIHAZf0CWp72vWJKXXUT6tfFxe2D044goRH9OT6Z
 YvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689089651; x=1691681651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=86/jbKk9mpH7o5Ei8JC92SPbLl0aqPRLgXFSEbJBkeg=;
 b=CfXvstE8m89w1/nyHtMrNO1L445OYxwpE5SGIzTTlxHzQqqdaEz04tPg2tn1oqBGoD
 W11cogWFVubgX4c4qulFsKpt1xKlaEgpEZAK1r3Q83MeLj/vla/GV9Iz5c0eQ5DZWNtf
 My9sotJm0fixp6QJMtclOB9s9ftFkk7zeej3HSR2f9nVVzkvXElsPpgzVkYjqiLkMLME
 ZqktO3JDB/hShjmUZGZ64ulsWIXMktsFI+3PVs0hv4CDDBA/1Pmk5x+AyHoxWoLHQPJf
 0vGm3p6AlTKUKsQ2iDLvcBkUfADEKmeNYVuh51+eCKY4fQmw8BVjXn7Cfuv7+AOPTlKE
 cuhA==
X-Gm-Message-State: ABy/qLawL2f37Gx0YnyzY6qPVhlw0mP+UXjae65gV7DZ/d8ZagP/GKod
 2wX08xgvRez5QkdQhV/Ms/P8LnhKaFQPU+zY+pg=
X-Google-Smtp-Source: APBJJlFe5fJhOfsnsXU+LKGmF/NF/OhxaQCETXQa13N9BAaY6yIh5K7kvCV65h0WuqTWjjY9thm5lg==
X-Received: by 2002:a17:907:2a4f:b0:992:5cda:69ee with SMTP id
 fe15-20020a1709072a4f00b009925cda69eemr14292596ejc.55.1689089651070; 
 Tue, 11 Jul 2023 08:34:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a170906a18800b0098e0a937a6asm1313532ejy.69.2023.07.11.08.34.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 08:34:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-8.1] linux-user/arm: Do not allocate a commpage at all for
 M-profile CPUs
Date: Tue, 11 Jul 2023 17:34:08 +0200
Message-Id: <20230711153408.68389-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
executable") executing bare-metal (linked with rdimon.specs)
cortex-M code fails as:

  $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
  qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
  Aborted (core dumped)

Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
commpage") already took care of not allocating a commpage for
M-profile CPUs, however it had to be reverted as commit 6cda41daa2.

Re-introduce the M-profile fix from commit 4f5c67f8df.

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1755
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/elfload.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d3d1352c4e..a26200d9f3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -424,10 +424,23 @@ enum {
 
 static bool init_guest_commpage(void)
 {
-    abi_ptr commpage = HI_COMMPAGE & -qemu_host_page_size;
-    void *want = g2h_untagged(commpage);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    abi_ptr commpage;
+    void *want;
+    void *addr;
+
+    /*
+     * M-profile allocates maximum of 2GB address space, so can never
+     * allocate the commpage.  Skip it.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        return true;
+    }
+
+    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    want = g2h_untagged(commpage);
+    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
-- 
2.38.1


