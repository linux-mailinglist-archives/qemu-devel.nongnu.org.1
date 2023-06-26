Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56273EE5F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuML-0003xG-7v; Mon, 26 Jun 2023 18:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLN-0003B9-5a
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:06:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuLH-000715-AL
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:05:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso3504584f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRHf9h4G/bLvyIWMS65t7lGQ8fTomW8W7GqhcAfU7Pw=;
 b=brGcfdTz7xr3Ga32f4sU/4Z91NcHjo+pIUzY/6Vu0rneSXMf37avVqxo3Bvm8V2VgO
 5cOzTJ2T9kimhBDB6qkBA6/1DREmUNdHLCNSVSJAmndmqLIXay96EE6CdIZPL/gZccMc
 tT+/ulfdp59+yw0QyPMpDwAV10cCS+KkthQ3Rbysy4N3W15j682sSLI5+0I6gethSIU/
 ri+uePHyUJB9EbKqZAvy3iWtobjfl+oMKOrMz47FPtBjmdaStTTNXZMnU38sJfuiDUgy
 slwfYJe4kHl+jLiMeyedIIztcHjbAcV2HxmWnVgMHVQMt4EIC3Ft4J2yNk1SE2QyISXO
 GKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687817149; x=1690409149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRHf9h4G/bLvyIWMS65t7lGQ8fTomW8W7GqhcAfU7Pw=;
 b=PC3xqfCPOegBlELdrEgUjmakjm9yEAjwu2AA93n//afapJnOZEz3alFdHbDVkcpAH2
 R64EUSCBXWB9UARVKtKE1NMcHe0+8LNLNpa0ierh/qgylOYqljZlsCcSdHT/ZJXmqXj8
 JmF3ArXX6RrcoS4iYqiglFWnGkmrru9W6rOCco0qM6lXnTgnly3zOrovur+2EMmUO/YH
 hcRw5JA75vNgyv0alBsivApsHatwoOjSv3sZ5CI8v0Wn3Z2d500pp8Rg2qL9eIWoU6nH
 zlXmD60Zf34UiRPgzTYxdp0ljNGqM9QHYd4Bqw+yUr5rX3J5qvgjiIEeXeiDK3Pft7B/
 1etw==
X-Gm-Message-State: AC+VfDzYEf+s7068DHUNc9nO171VokoIt0jcYgYpnzKVNXZ7jG+RNdIQ
 byIXs/+3pCrGVdO9WzczmCSECg==
X-Google-Smtp-Source: ACHHUZ5dRwh23s0EHeLza5zqm4lzsrPXJoBYBleqls9ic+ve8UIZUShQOZrW2ytj7yN2lXO+sQV3sg==
X-Received: by 2002:a5d:4e8f:0:b0:30f:bf2e:4b99 with SMTP id
 e15-20020a5d4e8f000000b0030fbf2e4b99mr20610579wru.49.1687817149379; 
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 da16-20020a056000197000b0031274a184d5sm8519676wrb.109.2023.06.26.15.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1111D1FFD0;
 Mon, 26 Jun 2023 22:59:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 26/26] tests/plugin: Remove duplicate insn log from
 libinsn.so
Date: Mon, 26 Jun 2023 22:59:26 +0100
Message-Id: <20230626215926.2522656-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This is a perfectly natural occurrence for x86 "rep movb",
where the "rep" prefix forms a counted loop of the one insn.

During the tests/tcg/multiarch/memory test, this logging is
triggered over 350000 times.  Within the context of cross-i386-tci
build, which is already slow by nature, the logging is sufficient
to push the test into timeout.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230621111520.1390967-1-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/insn.c                      | 9 +--------
 tests/tcg/i386/Makefile.softmmu-target   | 9 ---------
 tests/tcg/i386/Makefile.target           | 6 ------
 tests/tcg/x86_64/Makefile.softmmu-target | 9 ---------
 4 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index e251a84d86..5fd3017c2b 100644
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
2.39.2


