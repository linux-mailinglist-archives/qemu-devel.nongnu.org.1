Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E047F738241
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvoC-0004qF-Fs; Wed, 21 Jun 2023 07:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBvoA-0004ot-4f
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:15:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBvo4-0003LO-Dc
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:15:28 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-988e6fc41ccso348032566b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 04:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687346122; x=1689938122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BF7bvq7+IWyfrCATWCi++Znx31JboqJ4DiKQyx+7chM=;
 b=vmYiLm0qHYYPjSGUnOXLgzcZPAfZQ19QFYxEwaaNpfKpLfcM0cvypEwfyxsOXDwuWZ
 Z+0yq007+AfUXDqKlxhPjMEuhDQFC5Rqgrfrm265DC1VcK43MmfN39viUAhBgoBpDtbZ
 jWcW2xq8XD9tY0bt6pMYzTW8QH16Rgm5VJLmNICqZcevm9Sv2mBGpd0IzLbsHaX5BQTG
 m/brLIThkbWIkserW8RGKXpdkNUWS63ZupyircIX5MmsA5N5tT3i9rAgylWHeyKIdol6
 VC1VgDikU39GRDjtRpjAzzHjLu87uzPBDi7h4/hNuzPcGUD5uHzJLOOn6yrb++4zZVy5
 O09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687346122; x=1689938122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BF7bvq7+IWyfrCATWCi++Znx31JboqJ4DiKQyx+7chM=;
 b=EbagYXlY5JFuwH6znXtQEAvu3SvDHq3si0ln7achCewqG42uv8HM7eXDNrKm5bUmfL
 Rqy9FoMd8Zia5bOU6kszxwgHzBHPnQL3xjphgxep0ZEMwYV4+vrgObSZAXpkqFRqKajZ
 Z9/t7QdLtc/gdmtC9atccNT7jCAA/xNfzW4PPX2Hr9ZxN9EnC1rjSWrf3MN4vr778sgl
 Ik1FyEJrF7uqYJiuhumBesMOIWMB9OnqWvq2vhWioj+PQJ+vKNPLA4RkuoO48BgrfXH5
 ksJdqo1A4az3D0Kkrav8MS5NxfczGfmMu01FP9waZgXlayjh1UXToYDjEiSwAzie/FNb
 efpQ==
X-Gm-Message-State: AC+VfDz3BhupzjYXvcG0LiJrOfizNkGniTf9rSygmbCOrAmFmlQbFtq2
 xH8/B+O3CZmeyfmE2Fpny9I2sacsBs3TG/Ttuh1y5mJZ
X-Google-Smtp-Source: ACHHUZ43vZ37QKR/WlSMjG8wd4oenogmgVwWkaqgzLodthBC9C0NDXozzGiGt/TELnXCv7FAgCYodA==
X-Received: by 2002:a17:906:db0d:b0:982:80b7:ad4c with SMTP id
 xj13-20020a170906db0d00b0098280b7ad4cmr12163777ejb.16.1687346122234; 
 Wed, 21 Jun 2023 04:15:22 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 q10-20020a170906144a00b00987506c21b1sm2929972ejc.219.2023.06.21.04.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 04:15:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH v3] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Wed, 21 Jun 2023 13:15:20 +0200
Message-Id: <20230621111520.1390967-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

This is a perfectly natural occurrence for x86 "rep movb",
where the "rep" prefix forms a counted loop of the one insn.

During the tests/tcg/multiarch/memory test, this logging is
triggered over 350000 times.  Within the context of cross-i386-tci
build, which is already slow by nature, the logging is sufficient
to push the test into timeout.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/plugin/insn.c                      | 9 +--------
 tests/tcg/i386/Makefile.softmmu-target   | 9 ---------
 tests/tcg/i386/Makefile.target           | 6 ------
 tests/tcg/x86_64/Makefile.softmmu-target | 9 ---------
 4 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index cd5ea5d4ae..9bd6e44f73 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -19,7 +19,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 #define MAX_CPUS 8 /* lets not go nuts */
 
 typedef struct {
-    uint64_t last_pc;
     uint64_t insn_count;
 } InstructionCount;
 
@@ -51,13 +50,7 @@ static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     unsigned int i = cpu_index % MAX_CPUS;
     InstructionCount *c = &counts[i];
-    uint64_t this_pc = GPOINTER_TO_UINT(udata);
-    if (this_pc == c->last_pc) {
-        g_autofree gchar *out = g_strdup_printf("detected repeat execution @ 0x%"
-                                                PRIx64 "\n", this_pc);
-        qemu_plugin_outs(out);
-    }
-    c->last_pc = this_pc;
+
     c->insn_count++;
 }
 
diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
index ed922d59c8..5266f2335a 100644
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ b/tests/tcg/i386/Makefile.softmmu-target
@@ -33,14 +33,5 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
-# non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
-run-plugin-%-with-libinsn.so:
-	$(call run-test, $@, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-                  -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
-	    	  -d plugin -D $*-with-libinsn.so.pout \
-		  $(QEMU_OPTS) $*)
-
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 821822ed0c..f2ee7a4db7 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -63,12 +63,6 @@ else
 SKIP_I386_TESTS+=test-i386-fprem
 endif
 
-# non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
-run-plugin-%-with-libinsn.so:
-	$(call run-test, $@, $(QEMU) $(QEMU_OPTS) \
-	       -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
-	       -d plugin -D $*-with-libinsn.so.pout $*)
-
 # Update TESTS
 I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
diff --git a/tests/tcg/x86_64/Makefile.softmmu-target b/tests/tcg/x86_64/Makefile.softmmu-target
index 7207fee94c..1bd763f2e6 100644
--- a/tests/tcg/x86_64/Makefile.softmmu-target
+++ b/tests/tcg/x86_64/Makefile.softmmu-target
@@ -33,14 +33,5 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
 
 memory: CFLAGS+=-DCHECK_UNALIGNED=1
 
-# non-inline runs will trigger the duplicate instruction heuristics in libinsn.so
-run-plugin-%-with-libinsn.so:
-	$(call run-test, $@, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$@.out$(COMMA)id=output \
-                  -plugin ../../plugin/libinsn.so$(COMMA)inline=on \
-	    	  -d plugin -D $*-with-libinsn.so.pout \
-		  $(QEMU_OPTS) $*)
-
 # Running
 QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
-- 
2.34.1


