Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F7778D6AB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMaG-0001AL-Hs; Wed, 30 Aug 2023 10:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaF-00019i-6N
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMaB-0000jZ-9R
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:54:14 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso2255747f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407249; x=1694012049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7ocu0L6Gz7VaIaqOkaO8eCcLjZTZ6F0+6GPe6A31H0=;
 b=KJ6MUdJoa2eP2Wnrycw3mU+326ngTNZoxro/jQrvgdXJefVcPh479IbR61D9co7eRL
 9urY4Xww571f7s2FGEmjwn29xNm1kPmxtaw0FbvpswAoY6uAaWHln1zICeShf9RKBgFm
 /ZtzuGZLQRsrYdCnFbkhIHgtn5FnrTg73bBjC3viMyOd9BoKnIGdht7fy11UNEPnDwUN
 wR7d5+9Juk30OfoQe9EOJ72JJsRTO57WJ/C7QKZgsi+JLsq/g8UZ8Gq5jKuGnbgdUnQ9
 0XZPhVSZWYGF+OQe59dY5gkjtE2M4dNEdRaviVjLopqCQkkLIYKCaHVaOx+Vc/+dBzJm
 MgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407249; x=1694012049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7ocu0L6Gz7VaIaqOkaO8eCcLjZTZ6F0+6GPe6A31H0=;
 b=W/Aw8TiYTikr10hWRhLbpaZ2zNCXtA/uXb5ysAnzfblR1Wqf5pqU9CkvdQ/ZGKsF0y
 +0u/7e+Qpi5DfxBra6B3oOXBHDsWZQfTCqc9hw1wifQktf/ynalFDUgRFME1j7GBzq5m
 rzfbX8y1pd1rsd3jR9IVQoBGSDEceF7MBweHOn8KHOZdqzY6Ei1OSQX0I/Ja98WHgxm6
 mouDMKuMp8x123ccXqWAH6a3Nn98CQ/m7hogQSbuoG85251mNQC7oJBDBUEG/i+RhoFq
 48dszxwcloUTw0sYB2/4SgMolAY2xSVMM3WHL7RuH8BKxP/L3YqrhoMREisARs6vFyZ6
 8gpQ==
X-Gm-Message-State: AOJu0YxHLb6RK8immqtleqBH1xfemBG6LuqswnguofP96+o1LGuJttfd
 q36l+Y2G/0zThBI6G20Umq76Lw==
X-Google-Smtp-Source: AGHT+IHsuF+eBolsm6ALx4+CpiRDr+0TcgVaQl6EsyW0fAzzihtKqRMfTxJfdXXQHHp+UEMX8ckCbA==
X-Received: by 2002:a5d:595f:0:b0:317:5b32:b2c3 with SMTP id
 e31-20020a5d595f000000b003175b32b2c3mr1949401wri.6.1693407249796; 
 Wed, 30 Aug 2023 07:54:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g26-20020a7bc4da000000b003fee8502999sm2503436wmk.18.2023.08.30.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 07:54:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA9CC1FFBE;
 Wed, 30 Aug 2023 15:54:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 03/12] tests/tcg: remove quoting for info output
Date: Wed, 30 Aug 2023 15:53:58 +0100
Message-Id: <20230830145407.3064249-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830145407.3064249-1-alex.bennee@linaro.org>
References: <20230830145407.3064249-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230829161528.2707696-4-alex.bennee@linaro.org>

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


