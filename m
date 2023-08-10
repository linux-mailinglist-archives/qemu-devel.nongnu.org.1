Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D325777C56
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iW-0005Mf-Hd; Thu, 10 Aug 2023 11:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iT-0005Ix-AJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iO-0003Dc-9t
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe1e1142caso9558845e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmxc9TJQtQlM8I+f5bFmXe4lR5ba4YtE7Jx4G0eSh04=;
 b=KTm/eMyYMcfCStyXPMlT3wIrKdqn2tDLrbSelspxoYaR86IqMb6OvwmbeofPPGIIxI
 JqYfLGycRwO8HCknAa+wMouAmESw3hu6U48jODFIIM/kOUIcxcVUyS835h1vz7OhaHQP
 AeLsjXA6FPjRKJsigaW96QX0NUXbhdtewilm1y/PzHzKrDS1uBnD9q8WfNxxknJeTLaD
 city+j2sTQWEQGHPhrq8kFUfLqvZCpaEzWLdzL6umgU3rXDlX7I7TtyJ8GXIKixrUW5b
 bkv+suj3rc2GjhPBIXU2iaSQJlkp7E9PNrGSVC0LD7/za1GdCpT4swuN3AR6dJav3Ekv
 mYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681802; x=1692286602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmxc9TJQtQlM8I+f5bFmXe4lR5ba4YtE7Jx4G0eSh04=;
 b=O/q5D8pGfkGjOTP0jm2J3/5WFv5C2UT6TFWDgPAW6rWtMsj/CRw0+zbdJ5MLcPiR34
 0OhHPwrdFvLR/7Z8TclMaXLDuZbZj/RdvFw2DYySkeFi9SF/cs5S4JzKJC30Z/dFv8yE
 3qc3ptgZ8dlu0Lz4LrBgizA/xpeoIVzeukxlGUfmba4rMFvQ/baEibFb8A1UKZozfGjB
 ED567fQlQeE7FTtdvP35tYCMn36yrfzlEs6QdJ/gloS78O4OkBWchEUEhMAUP2h9Ytma
 aTPkNJrdXR9THR9DZUEUuCni1diiNlyHsb+qz194Xk9tiuj1rZwZeVoQGa5EtSqvJMsM
 Pyyg==
X-Gm-Message-State: AOJu0Yx9mtSj1KNJoXGhYTOK65KNlt2azP9MP4ZH3x4DRLMwbMMou1RD
 qlzEcPCsDKIYG5oopNJzBqIMVg==
X-Google-Smtp-Source: AGHT+IFp3SkCcDewiY+23eMVUel+KrzuVgulQSEjwf/nFisRzKhi8GtaNdGfmQVGGvmxeFtvkyEU1Q==
X-Received: by 2002:a7b:c7cc:0:b0:3fb:b3aa:1c8a with SMTP id
 z12-20020a7bc7cc000000b003fbb3aa1c8amr2286118wmk.16.1691681802192; 
 Thu, 10 Aug 2023 08:36:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a1c4b0a000000b003fe2f3a89d4sm2510343wma.7.2023.08.10.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 121F01FFBE;
 Thu, 10 Aug 2023 16:36:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 3/8] tests/tcg: remove quoting for info output
Date: Thu, 10 Aug 2023 16:36:35 +0100
Message-Id: <20230810153640.1879717-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

This avoids ugly multi-line wrapping for the test on non V=1 builds.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target                  | 2 +-
 tests/tcg/multiarch/system/Makefile.softmmu-target | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 617f821613..75347ebe70 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -14,7 +14,7 @@ AARCH64_TESTS=fcvt pcalign-a64
 fcvt: LDFLAGS+=-lm
 
 run-fcvt: fcvt
-	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
+	$(call run-test,$<,$(QEMU) $<)
 	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
 
 config-cc.mak: Makefile
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index 7ba9053375..a051d689d7 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -37,10 +37,10 @@ run-gdbstub-untimely-packet: hello
 		--qemu $(QEMU) \
 		--bin $< --qargs \
 		"-monitor none -display none -chardev file$(COMMA)path=untimely-packet.out$(COMMA)id=output $(QEMU_OPTS)", \
-	"softmmu gdbstub untimely packets")
+	softmmu gdbstub untimely packets)
 	$(call quiet-command, \
 		(! grep -Fq 'Packet instead of Ack, ignoring it' untimely-packet.gdb.err), \
-		"GREP", "file  untimely-packet.gdb.err")
+		"GREP", file untimely-packet.gdb.err)
 else
 run-gdbstub-%:
 	$(call skip-test, "gdbstub test $*", "no guest arch support")
-- 
2.39.2


