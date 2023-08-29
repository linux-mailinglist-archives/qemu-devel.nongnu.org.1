Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A21CA78C974
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:17:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1Nh-0004pI-Iy; Tue, 29 Aug 2023 12:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NU-0004nG-Fx
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb1NM-0004OM-E9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:15:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40078c4855fso42862305e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693325731; x=1693930531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=DpwcIjKm/Se76BIRTXWEvwjIqhZbcgDN0FFtXqaYm9rkSU6rtYsTMUL7YyZRHtx3//
 Q5jSjKwbV/GRtd7wGWCB8mR8iH0pPcVIukQGRsUW3+pv0Hv0p0qrHXY8aNQDX7l7MRfi
 WDx8htSXGg4z5EQo/0wMfVPeiJb5l14PDywO1F2i5N043MlCQBYgnK2Z2oqz9Mb3K5/Q
 BrvaCu+lKdesyNMNfifaxXfz10UfhySEiXWW6xNh6LkHm+OeFXcECH1duZ4x/pEQYk+w
 jYERSJkXQUlbxUZ1t4UGbGBXgm00D9qAspAB93mHPLGgw5Uy4rg8Nb73zg7G3bMrGk93
 lVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693325731; x=1693930531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4cgTwYKmgY5S8ywczpvEN/MK3kalEN3O1n5Lxh3nkA=;
 b=MqkRkmwuzfdXgP7sgk8+kdZCoHWt3xH+zKMDkJARtqyO+lInyNwxaOw6LJUyQoXFPz
 RbFkgRi6B7pa6YTnh13ELDHbfQgcK4Ctl6O8KfUIAIczf6Y8urxPVOMuOimy+t/c8xZv
 ESjGIohtHerUnCfAp7TaS0a+yRS32eUUfFm076q3/KX7whtM3hDPLK3S92n9bcvEZkTc
 E+kKGGXMsX1nZ6FirNv1J68epLZgU8MOtkQk51QOOdt+ipbjPyYITawLN+yoWoWb9wq8
 0IupG75YksAC8uSCsN9PLGmrTkATNeCz+OP82oas9VVD2t+K9/aVdIazBFOBK9FMwvE5
 B58Q==
X-Gm-Message-State: AOJu0YylVYfG1IMVZW7Y37lFPxj39rc8WxH9bgIfXhJRJR7kwzRztCyZ
 ZdMKlFN62pMLRf2mYNBnDmfnJA==
X-Google-Smtp-Source: AGHT+IHrIyDmNCtrRpbpasUc+8f99zfhRd97Nv4lyUprL+BeGtXx5R3t+sqXNaF4Lc/rPCiXQp7Ggg==
X-Received: by 2002:a1c:f304:0:b0:3fb:e4ce:cc65 with SMTP id
 q4-20020a1cf304000000b003fbe4cecc65mr21255098wmq.25.1693325730869; 
 Tue, 29 Aug 2023 09:15:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c228d00b003fefd46df47sm17577554wmf.29.2023.08.29.09.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:15:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8F0CE1FFBE;
 Tue, 29 Aug 2023 17:15:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Juan Quintela <quintela@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 03/12] tests/tcg: remove quoting for info output
Date: Tue, 29 Aug 2023 17:15:19 +0100
Message-Id: <20230829161528.2707696-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829161528.2707696-1-alex.bennee@linaro.org>
References: <20230829161528.2707696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


