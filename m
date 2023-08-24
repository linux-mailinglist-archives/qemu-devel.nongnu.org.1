Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD6787596
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDMi-0006Iv-LC; Thu, 24 Aug 2023 12:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMh-0006I3-0Y
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZDMZ-00086Z-MO
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:39:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so275735e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895154; x=1693499954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=N2FSmY4rJ/dqTSDHFZoCh/j6R16zlvPxpJMutkBiBOx1EIHIDkNms7NtFUsHnYtUBm
 xN693Vhd0In8k2KfMsh7929DXQNee8hkJAOXvDdCjyXQG7ec+0AldHgQe541L4pVINHA
 PPTh9hxez2WcgiV0qgCflK/X4QiSVWUfXG692Xa6zggnbf2JBhi7fTWk01VYdpNq97jF
 OHezqSYmLv2FSgKaoPY1/7MlM3ed76WoqQLRyDQB+ifLUTo9XyOo9ia+fbMkIS4KHdGB
 Nmgv/c+m2nS6WeuGbA0OKv06t5a769p/Oh2AbtTXri62UnLAK5bNkosQnLTEzzLVVTQU
 /j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895154; x=1693499954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=R4guuS36eQscv+2rMK2g67HG6RD6Gnpsbuv+KDLKYS1hJyi8Z8FUGJZVDVrltxanDF
 MbrXij7D79tXw9wKoN4g1vE+AuJXqiYSRvyeHY+9SgrzyOEex5mlxER5WxLS6Sz4894Z
 ivus0DpDXwiTpd1pgVx0QwOLSMoxy18ZDJZBLyOH1u3TmQmnIl4fPu2FGUtnx21THPWh
 jWNhZuzXIl7qrkCWVbaEFMH4Zku8Zvef6CFt4GIei85yThmy7BNEJ5OSfRbuItRHf0Jq
 E8I2r7IVxe7Fp5bFTaVjl/QNnjLeB1TW5/1azBQXCAPhkWIQSgOfTMs21OyEacc/y+ln
 Bbvw==
X-Gm-Message-State: AOJu0Yw4HcKd21K2g66PYVJqUhvP+Df2rmkXOoTt7Aj+FNevbL2VvxxU
 A6tnJ9XeU63k78kIbifeqU1diw==
X-Google-Smtp-Source: AGHT+IFpryiKJTULN+dhbV0bJ0wfsP4ywMZ10hr0bpIhbdwrvxB6tTQqgSBjKDfmbpVfonNVOtswhg==
X-Received: by 2002:a5d:4403:0:b0:31a:d49a:38d with SMTP id
 z3-20020a5d4403000000b0031ad49a038dmr12013904wrq.54.1692895154204; 
 Thu, 24 Aug 2023 09:39:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adfe586000000b0031989784d96sm22889512wrm.76.2023.08.24.09.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:39:12 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 90FB41FFBE;
 Thu, 24 Aug 2023 17:39:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 03/12] tests/tcg: remove quoting for info output
Date: Thu, 24 Aug 2023 17:39:01 +0100
Message-Id: <20230824163910.1737079-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824163910.1737079-1-alex.bennee@linaro.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


