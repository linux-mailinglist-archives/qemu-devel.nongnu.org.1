Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5CB842259
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jan 2024 12:11:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUm1e-0005uY-6J; Tue, 30 Jan 2024 06:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUm1O-0005sX-CF
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:11:19 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUm1M-0001Ld-8f
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 06:11:18 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33934567777so2983313f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 03:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706613074; x=1707217874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HcNsPRZVnTn1gnAhH6dwIkY3N9gyMgDW6nHVcrKo7+8=;
 b=o4/dzB18M6iYdJ6WHHEqh4XbRDOMn9tjjNHJyw0/tCeojp7jV+BUdfmfvfaxtNllzH
 HxZNY4BitMQgtJ848mvo97EaSzSpW6BOWqahEosDWFC7PmioZTjSIQU4NTO0egvzLvLg
 CkLBRSyjbn1kIpuv84ibyWCBBNLItk8D4MTXjYLSvWLHFY8/k0THWVsu7tnkVvX+Q4GL
 TRkbATqsswjhMXR3Yauk2zEwYzjd1WKjSWOSmoBGjaoWXgd+tDUlRetw1pWwij7hHLc+
 JF523QYB8Gimi0qOq5Lt7i8BQEZqnHPlaznoLSKprn/anwT6qJpVp+N+c0EdbOjY+mhl
 fpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706613074; x=1707217874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HcNsPRZVnTn1gnAhH6dwIkY3N9gyMgDW6nHVcrKo7+8=;
 b=Jb6iiBtkJcq40j+kmts6DGq93B60wJ35uYUUdNggp227adA6H9AgTTTZ7oL7Th7H6C
 lb0c2F5fgh3NlW6JjLcMDs6pjlgBhHT3EqNsz95QIFu1bDmTI53Cw+ZxIkEb3UaMBaDX
 dP524+dnTDtGiDxS9zlBfRYD06vHuHmSyoZu+lb1pnpaVOfrTyqzkzzPznkvdL6Zeg9r
 EuWpVociShZEeZEh609lU6mPi9PzgA0cO8dAwn/to7kjBZ1jaUOBA7QoTixhmNQm3KJW
 xIVuRe1Kn8aP0pvFa/NIiPduiisYRbw+PjpOB2CewrwLH40VUTPq4GjW/0FJohtgxdaf
 Lw9g==
X-Gm-Message-State: AOJu0YzGAMsuqeIMfehVzUX6Wi5UD4/TdrCObsGfpw9Xt/6UPmXpLaTX
 H07Z7dSTusX5h7c7vgjvscnasGr10FjDCbs4aT/j+pdGqgulvhbT3Fc0RuvFRN7ZUHqpcMW/1s+
 K
X-Google-Smtp-Source: AGHT+IHVMvs5GfvgE4RrjWYJGk3kcrKZLdzlqJzDr5uVF+yxwGHZelY7paUOkTpvNxvAf27+agnwHw==
X-Received: by 2002:a5d:45d2:0:b0:33a:f79a:96ea with SMTP id
 b18-20020a5d45d2000000b0033af79a96eamr1504223wrs.16.1706613074152; 
 Tue, 30 Jan 2024 03:11:14 -0800 (PST)
Received: from m1x-phil.lan ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfe68f000000b0033af51eafc6sm2869394wrm.104.2024.01.30.03.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jan 2024 03:11:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] target/mips: Use qemu_irq typedef for CPUMIPSState::irq member
Date: Tue, 30 Jan 2024 12:11:11 +0100
Message-ID: <20240130111111.6372-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Missed during commit d537cf6c86 ("Unify IRQ handling")
when qemu_irq typedef was introduced for IRQState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 1163a71f3c..74408c653a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1183,7 +1183,7 @@ typedef struct CPUArchState {
     CPUMIPSMVPContext *mvp;
 #if !defined(CONFIG_USER_ONLY)
     CPUMIPSTLBContext *tlb;
-    void *irq[8];
+    qemu_irq irq[8];
     struct MIPSITUState *itu;
     MemoryRegion *itc_tag; /* ITC Configuration Tags */
 
-- 
2.41.0


