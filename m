Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E377CE7C
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvOa-0005r9-1H; Tue, 15 Aug 2023 10:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvOX-0005q4-LD
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qVvON-0006Ga-8o
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:51:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe9c20f449so20704625e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111089; x=1692715889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=BrdDVthiAHhSVisg3dOEAFtQnGdwDRYEkYBydduol8IfF9Yo2MtoCcBWVVFDqGpNQ1
 ed7VUxvzzjQ+/rl0Qim9Lced3x62P4YxyX0pkbhEjWAks1jP/5wu+jXKq6ffObXiLg4I
 YcI126Ku4r/F9pBnM76+iFdU7Bj26wAP+B+TbEavFrRXW3k8upF6cih1XhK24zPNZDOV
 qVDFZa+GdUa1AcYA4lIk7rpfMM64uclh9JYmS2BGBPVLh3qHGWtCrTAJD42drByV/rRq
 ZXhVive6SdIMq4aBuTVU2ILgB+ZZAeC34lvw2Y3cyF0oRTAlJdocR6KyBMmxibNw6Fvi
 pAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111089; x=1692715889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=CmvtIllW/G45PTM4bpckO7YBJNYDgDjLQk6PfkCwf5g8bYxB2Xh6X8OM1ABlHlG7mD
 7zcPngNUTnlqsmsF49VPKUnPr9GG1RIEbQ7u0LDRAUQdmmDBYDjvgaTbKGk1fU0LluZX
 /pqxguTaxOl0AaZuZET8KmohzVCCqlkWCvQMD4n7kDHyjXTq1+hevEV+uAJSDm7W1an+
 cwIlK6xpr5DQ+hRT5UNoqX9/NWAL0WwRWAZfsGkokWNXYgT1Ui9HOaJEo4zLlz7EkDNR
 Wi1wgfna9s/RS7AZWulINEtaWnhaLpeXX9mTl/j+C5fahLme5qjwRNmHR7M6hhQKiBbX
 NXaA==
X-Gm-Message-State: AOJu0YzxOZIqgVth3g7O6MrP5iFQ9woz7GqeAF7pZZU4naUP1tQOj8St
 9JB1ZYD63C5f3bv7HXsEWtz3rw==
X-Google-Smtp-Source: AGHT+IEaqVNKTv40OYaVMhSTLs/wh96zLbH+gIfdBKNsiJBQbJevjuOcqxdnRyYuPGY1bwvCFvgJ3Q==
X-Received: by 2002:adf:f104:0:b0:319:7a72:5d80 with SMTP id
 r4-20020adff104000000b003197a725d80mr4283559wro.51.1692111089626; 
 Tue, 15 Aug 2023 07:51:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a7bc8c9000000b003fba92fad35sm21126516wml.26.2023.08.15.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:51:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B9F01FFBE;
 Tue, 15 Aug 2023 15:51:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/9] tests/tcg: remove quoting for info output
Date: Tue, 15 Aug 2023 15:51:20 +0100
Message-Id: <20230815145126.3444183-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815145126.3444183-1-alex.bennee@linaro.org>
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
index 681dfa077c..b77bbd9b3c 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -14,7 +14,7 @@ AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
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


