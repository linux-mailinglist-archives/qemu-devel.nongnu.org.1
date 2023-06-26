Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4C273E3B7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoLK-0002Gu-4s; Mon, 26 Jun 2023 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJs-0000Jh-DU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJo-0002qx-8g
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa99f6a482so9341055e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793994; x=1690385994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BF7bvq7+IWyfrCATWCi++Znx31JboqJ4DiKQyx+7chM=;
 b=QJtsI0YoM1zi5GJ+e9o3k82EsN0zhR2WsTTHY1w2skhLXe93SCHglAxXUi5s86Cd4q
 3M9BfiYrR5K7olPqLiwBBCGmX1pN+2WXfJobAk7hBe7QRCg+C5yTS+7LEPjW9eu4oz68
 r4sS1BcPJk5QGNc6kwGnYP7YwFxxL9qQx729BEfOKF0P8yWrwi+0ux3tvsUfKQTBrfsx
 0qydIvY+DuDOeWvBTGFYMFtb3n0kfgDI/gqxxLGVZXNB0OTNxtC4SpTwWqp0upqEW1cw
 9OMgSC3iIX4FzKzHhX9V6r87ITzCdAjM9oykIYuq9drlXUW12QaH20ftPG81oif9WC3H
 0ZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793994; x=1690385994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BF7bvq7+IWyfrCATWCi++Znx31JboqJ4DiKQyx+7chM=;
 b=aQAhRfxtBjjGU32iIJWAN3eDzI4Dnw/kScPcIqA3wRHiNthdIZefL/aD8EXoMW2gdV
 TSSfHyun5+BfhtZ5YWUt4TYvJ0wlXCCwRSdkTOlsetmqJ39FTDwwDzF87TOt8+Xk1VRG
 DjirYDWT+p9IXHc/gyFfT39Hd0uMYX1qS/qm1tOOo6iqD7ghMLLwHKvI96s3Bj9PFpX6
 I6XezVPCwRT5MPrGoAciI1jUqWWlwqs0FkTfCXyqeelzey/jexOI3/kPF3FbZaYBPey0
 0HdK3IN8Zsd68Ozq8wGnKtIUJyzgpn6exnxTa6doYUADBje+dOQoC4myhIi1YqTInncC
 sLHw==
X-Gm-Message-State: AC+VfDzrK69291K1cEOWSVCqw1T6zzBZdDyNGSWtSdnOXfnfYlE/gONW
 WySQ+ko8eBJenvIGddQaUZxsQh9UU35CZtMhsfTPfhsL
X-Google-Smtp-Source: ACHHUZ7E3Q+wZgku3fhBHVY1sWqs6DRPXDX0AUsj+16HbEWxeaiLWyt/y0H56LVSCzaxI0zbplbLJw==
X-Received: by 2002:a05:6000:181b:b0:313:f783:2627 with SMTP id
 m27-20020a056000181b00b00313f7832627mr1082679wrh.35.1687793994584; 
 Mon, 26 Jun 2023 08:39:54 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/22] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Mon, 26 Jun 2023 17:39:36 +0200
Message-Id: <20230626153945.76180-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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


