Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC241723117
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgS-0007rf-3K; Mon, 05 Jun 2023 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gg1-0006xc-T8
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfw-0005no-BB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:39 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso46226905ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996374; x=1688588374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NES3rUjYxvsEhP1PSaVSBmUCbjMXZRddYq+Gk3VmTrM=;
 b=tBSPMizcoq94Za5n3BEBJ4e+DEKdf7hNtEWfA2/Jv7ln7/L1EuMd8XxjZgHId5JsF+
 nVSlIqwYqgpSubvFtiBSSouiw7e1QyR87y2GSuZgYlt1kjLmI8nnQE76aHCO6V9os+dV
 p1P8XBEhUIot8qsEjH63vWSgbNpVopBntWw2aWMe3zRQoXfDW1Mr1HtCXhrskW0aXDOz
 3P2o7UPM+OGq4mbeDGYC4pXDlm6ibm3YEigj3PkbkUcf6gVzXkq57dZ9HXkKQQiKViIf
 oolcrt27O+j4ed0hhanVdywOBNpIAX05l8DiTWnXXZ7ifxY2tsPPbG676izbfd4c7clo
 IOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996374; x=1688588374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NES3rUjYxvsEhP1PSaVSBmUCbjMXZRddYq+Gk3VmTrM=;
 b=KgdxHVz07VqkZgZp4aAyrJXRI0/jSJzB6mIXdIjlZBCX3txJ8yWc3eJhcCx9jaz37X
 q5uqeQQh2tqhpekHwFfbaWaruhJ/GdOkI1ee2UmIKu/SoJZc8juh4CdPZb8zX2AK+mZZ
 5agJiFLrpNl9q2e62nSAYCEaO8Y/WzHBXx15ex9oaAjg6Cd64yHs27N34uCo8zeWOpCN
 pViCpy4h2XY9BjZfqgmWDdAj9Rz6uE3anrIYDfFjPrv5eZTl8FuF9TNlLHnUEbrLPuqN
 fET/JW7kgpdGzL0o+mG0eMWFLD57vvoZMXvjziMlqDypmwzUTaw9A3cDjiEKt1huzQ9Z
 qOwQ==
X-Gm-Message-State: AC+VfDz8KC2WnJuYwKYvH3uXqS5pmojTIOaEyuXPz/945UuhW4SVr3II
 /uOxte1D4hfJBzBin0z7Y6rDlv2MD09JVvtD//0=
X-Google-Smtp-Source: ACHHUZ6RR5yAGIXWabXhzWVSNIPcbQrwMynrzM9sM9gxSR3fNRNhLtskC+nHoUqabX6R53LQLNtm9A==
X-Received: by 2002:a17:902:f68a:b0:1a6:71b1:a0b9 with SMTP id
 l10-20020a170902f68a00b001a671b1a0b9mr11621569plg.47.1685996373913; 
 Mon, 05 Jun 2023 13:19:33 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 51/52] accel/tcg: Unmap perf_marker
Date: Mon,  5 Jun 2023 13:15:47 -0700
Message-Id: <20230605201548.1596865-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Coverity complains that perf_marker is never unmapped.
Fix by unmapping it in perf_exit().

Fixes: Coverity CID 1507929
Fixes: 5584e2dbe8c9 ("tcg: add perfmap and jitdump")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230605114134.1169974-1-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/perf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
index f5a1eda39f..cd1aa99a7e 100644
--- a/accel/tcg/perf.c
+++ b/accel/tcg/perf.c
@@ -111,6 +111,8 @@ static void write_perfmap_entry(const void *start, size_t insn,
 }
 
 static FILE *jitdump;
+static size_t perf_marker_size;
+static void *perf_marker = MAP_FAILED;
 
 #define JITHEADER_MAGIC 0x4A695444
 #define JITHEADER_VERSION 1
@@ -190,7 +192,6 @@ void perf_enable_jitdump(void)
 {
     struct jitheader header;
     char jitdump_file[32];
-    void *perf_marker;
 
     if (!use_rt_clock) {
         warn_report("CLOCK_MONOTONIC is not available, proceeding without jitdump");
@@ -210,7 +211,8 @@ void perf_enable_jitdump(void)
      * PERF_RECORD_MMAP or PERF_RECORD_MMAP2 event is of the form jit-%d.dump
      * and will process it as a jitdump file.
      */
-    perf_marker = mmap(NULL, qemu_real_host_page_size(), PROT_READ | PROT_EXEC,
+    perf_marker_size = qemu_real_host_page_size();
+    perf_marker = mmap(NULL, perf_marker_size, PROT_READ | PROT_EXEC,
                        MAP_PRIVATE, fileno(jitdump), 0);
     if (perf_marker == MAP_FAILED) {
         warn_report("Could not map %s: %s, proceeding without jitdump",
@@ -372,6 +374,11 @@ void perf_exit(void)
         perfmap = NULL;
     }
 
+    if (perf_marker != MAP_FAILED) {
+        munmap(perf_marker, perf_marker_size);
+        perf_marker = MAP_FAILED;
+    }
+
     if (jitdump) {
         fclose(jitdump);
         jitdump = NULL;
-- 
2.34.1


