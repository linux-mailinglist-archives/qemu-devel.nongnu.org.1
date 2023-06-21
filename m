Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EB737E25
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtvT-0006af-R5; Wed, 21 Jun 2023 05:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBtvO-0006XE-CY
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:14:50 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBtvL-0004UW-HK
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:14:49 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso742779266b.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687338886; x=1689930886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=flknc6IAMOkvaHLJcij+gC86DpoYwTv6WZ4YwzFNM78=;
 b=ybC27lIgVb62eFQrygXuZkBNvQ1jO382ivTf/8HizlfNgyrIh10LBuWVmhKxdxzC84
 OAZ920RS5pXl/jSy4UUvBH9l4YhEMUp0U8Y60k8UjYfCG1ykBEp+d3qALosmLLVT+BJ8
 4vmnnw8euMMykpK9hoAcQYGDT0qKm3PrVz2q0c41YuLpsvkHcgQ9JAgkHst1xMBlbdTk
 WxgVTWUtzRYF4Vg+5YBKAoOYT4hE47MeoaRQxxf9ZF0I/Q8uNk+thd/esdXMoMZYf/PX
 MgUY8a8m5BGTQs3mI0cHNsPrhup1kRngVyq3piuW8CNPJctzBvejSqDc4lzFhwhkUkXK
 djmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687338886; x=1689930886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=flknc6IAMOkvaHLJcij+gC86DpoYwTv6WZ4YwzFNM78=;
 b=kQ/76hhh4hV1eDi26Av6QkEpOuiluYJC8URKqIHHBsrmZhdMqV1iEeaya42yUjmczj
 yiT+gJoJFwTzEJlxjdAocxbTjjPVEYZTznvvL2XUnbY/kyOeu2gLHSWKVxmZIh2NHxwl
 C94hUh3TG33b5ey++1apz3Np8BXuuuOoTpLbnkt6Fn98redByScEqG5ffvNgZpAKudtV
 1/3RxBdVV1CZkkszEthavj4DNv2B18dSi7EhuOxxVInxlBIKlu/6a+ahMoJK9bTorVOH
 QQVt3R5kwgDRHBiyp8H4wBs+mLQMfDOvTsPiejnRoo4+EOpm4gI0FjVeMP3SJ4/3gkTg
 LiTQ==
X-Gm-Message-State: AC+VfDwj0FYMlnx/X26xzGbsjZV5eprLix3Z3vkh8oct2ZmXEHx46XqN
 Na8V5C63pMKMSe/wYBGgvC96Uqr4NS1gHz97JVVAXu13
X-Google-Smtp-Source: ACHHUZ5c/TRzLZJcpiQji8cziEqVxMVhXYtVDAdHbbK3EbtVYkIPEe8fQKaB3xTikMZDcha+oRVRVg==
X-Received: by 2002:a17:906:58cd:b0:989:d9d:d90a with SMTP id
 e13-20020a17090658cd00b009890d9dd90amr5508881ejs.34.1687338885804; 
 Wed, 21 Jun 2023 02:14:45 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 i15-20020a170906850f00b00982cac5fbbbsm2803297ejx.62.2023.06.21.02.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 02:14:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH v2] tests/plugin: Remove duplicate insn log from libinsn.so
Date: Wed, 21 Jun 2023 11:14:43 +0200
Message-Id: <20230621091443.1187290-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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
 tests/tcg/i386/Makefile.softmmu-target   | 9 ---------
 tests/tcg/i386/Makefile.target           | 6 ------
 tests/tcg/x86_64/Makefile.softmmu-target | 9 ---------
 3 files changed, 24 deletions(-)

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


