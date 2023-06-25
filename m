Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE173D486
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGY-0005Um-PM; Sun, 25 Jun 2023 17:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGW-0005SE-Qs
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGV-0003Pd-57
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:24 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso2267688a12.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728441; x=1690320441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45iYwMbUstRUciB1ggXmjQSsn39gdiC8XNNxy6MC88I=;
 b=axfHZCN6cfovUyRzehrK2ZD3HIFUJg0okvHzFZluLPc5KNAkhXVBPpN+clfn0ytN0o
 EBsCEHObvvGHh1SldU1cOe5YvoT8qF889TAMttsiULWNTKqLwdyMqr3zGRxH6/qEinFt
 YLOj9UI240bR4VfXoy8x+CpE7yexqfYUaGmupOTTb1ua6nfob/EB1cQdRLH2sxxNyCe3
 Y+gZxXrjRUK70eRR4KnwJI0xvtWwMqKeQDAPGyJRpH7kEX5rwx645qCJU3g4Ouo85OQw
 rs+HF2LN8PTdv3WOf0j300ads0PdPIluahmYzlItGvq3JRfyVxDKxlNErMI+/k3m+sJi
 4nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728441; x=1690320441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45iYwMbUstRUciB1ggXmjQSsn39gdiC8XNNxy6MC88I=;
 b=f3mERm+d152PJeddCl0g4fk8RshYTQOvoony0jvkX/lrWJhYAAhd3DvUnFa+/AmPMK
 j2eEQutJ1kTv5QdTTZQ/5ZMdoSA2ow0MBOzQk/yuWBnWnaBikmFDVBYRKeiZ9iU0v8KS
 8JPodYtnkMZxp28iYtoQid9UeRm13645yopvyRXUA7qJPxPbq2F5YWEQjRlJmsaCv4bl
 uyVcE7NjEeLCqrMWOLIHhN40h1iay33nRI+5OYb7lsLRu8Xuf8KeXCqIIaAZJZtR3gLv
 4SO4QkoUNv5nFBBkAqCwoxS2EIvJf4+Ye2TKUPYP9eTPY67yPHnLrtKWC/Bnltu/B45i
 7WNQ==
X-Gm-Message-State: AC+VfDxszezNCfut7KDWEvaTd3boMzC4UF0O8aUTYuZkOzPz2OPmmde/
 qLNze4fxVsIKRyiGcD0vR+0=
X-Google-Smtp-Source: ACHHUZ6eXXrHOfwftXXwxvXTAb/fhewAKoLHGmBCrg7rRWaiUON1XDPZ6Wycd5ZAG5zXG0zsafMbPg==
X-Received: by 2002:a17:902:cecf:b0:1af:cbb1:845 with SMTP id
 d15-20020a170902cecf00b001afcbb10845mr7001669plg.16.1687728441675; 
 Sun, 25 Jun 2023 14:27:21 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:21 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [RFC v3 02/10] build: Add configure options for native calls
Date: Mon, 26 Jun 2023 05:26:59 +0800
Message-Id: <20230625212707.1078951-3-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add CONFIG_NATIVE_CALL to architectures supporting native calls.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/aarch64-linux-user.mak | 1 +
 configs/targets/arm-linux-user.mak     | 1 +
 configs/targets/i386-linux-user.mak    | 1 +
 configs/targets/mips-linux-user.mak    | 1 +
 configs/targets/mips64-linux-user.mak  | 1 +
 configs/targets/x86_64-linux-user.mak  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index ba8bc5fe3f..5a8fd98cd9 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index 7f5d65794c..f934fb82da 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index 5b2546a430..2d8bca8f93 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-linux-user.mak
index b4569a9893..fa005d487a 100644
--- a/configs/targets/mips-linux-user.mak
+++ b/configs/targets/mips-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_BIG_ENDIAN=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips64-linux-user.mak
index d2ff509a11..ecfe6bcf73 100644
--- a/configs/targets/mips64-linux-user.mak
+++ b/configs/targets/mips64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_BIG_ENDIAN=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 9ceefbb615..a53b017454 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+CONFIG_NATIVE_CALL=y
-- 
2.34.1


