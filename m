Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21A68244B5
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 16:11:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLPN3-00084r-8L; Thu, 04 Jan 2024 10:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPN0-00080x-4m
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:54 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPMy-0000Bg-In
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:53 -0500
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7bb5fda069bso23765339f.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381051; x=1704985851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuMMyoINzgyasVsmgJvWqqRoYWhwNtTQTkUs2Hh1jgE=;
 b=oeKE+Bt5vFNEc45pf/tUPV0IJM+kXPcTjgEE1Jp6cW2XolZJbTcwvgWVOMw4ltAuHU
 1XLmSvJ1e/i8lnZ+Wc0mJ5Drsi7exhPyiy1Y3N6Jbd2w/XizYb2A6dYYXsodPcpamiSC
 I5GOPsa+uQvjVRH6EVNbKmZ7ZkZYu/O20nVG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381051; x=1704985851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FuMMyoINzgyasVsmgJvWqqRoYWhwNtTQTkUs2Hh1jgE=;
 b=Ej7jNoxzg2PNWvsLLmiWOOqGy5Ee5MinvenzT5I/O4UuIgtMB2cT78EjTVUH52E7hb
 Fy2agEo2k3pBeq72jhbvXBq0zd6QjYO2tHN4Nln5njrw/sMxVRYozb58bqdfIektHX16
 KxlnCDKE+iCat46Vy70gMdDR3kcOKtxTz9UYCpigYUASHvsynAHZ2KYK+V8paVUn7oR1
 I8sm8VNJ2rFX7trI/J1kn7YoBy1vX5HV9aUvqoKgP6+vtLHt3vqYDFSbJyAJCVzmxjXA
 pDqZ7RvQGDt1kzmT7XKs3hRJFQa9VhurnfsTeAnsVaI7n9dDeRtuYu2S1j3mzep5XS5W
 uEkA==
X-Gm-Message-State: AOJu0Yzmjglq0E0a9cOJVajELt9OQhWdJ4Icfwe9H2wLDv64PReBN2Zf
 oEIi5eTW3g5t+9bFF1TAa0OcQARwlmZ3ObDvQ1d1JCRGlrvX
X-Google-Smtp-Source: AGHT+IFo2r70CszJhQXRkbPSgMxKTc6yfWpbIsalJibBOmJUapJ4euuS1cQY3ScUfCnrwiJ92gtaWQ==
X-Received: by 2002:a5d:8704:0:b0:7ba:9c04:2e03 with SMTP id
 u4-20020a5d8704000000b007ba9c042e03mr739674iom.27.1704381051365; 
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 6/7] x86: qemu: Expand ROM size
Date: Thu,  4 Jan 2024 08:10:41 -0700
Message-Id: <20240104151042.695717-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd34.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Expand the ROM for x86_64 to 2MB to make space for the font, as it is
already on the edge.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/emulation/qemu-x86/Kconfig | 3 ++-
 configs/qemu-x86_64_defconfig    | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/board/emulation/qemu-x86/Kconfig b/board/emulation/qemu-x86/Kconfig
index 01dc1d497ae..34d665a3e4c 100644
--- a/board/emulation/qemu-x86/Kconfig
+++ b/board/emulation/qemu-x86/Kconfig
@@ -21,7 +21,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select X86_RESET_VECTOR
 	select QEMU
 	select QFW_PIO if CMD_QFW
-	select BOARD_ROMSIZE_KB_1024
+	select BOARD_ROMSIZE_KB_1024 if TARGET_QEMU_X86
+	select BOARD_ROMSIZE_KB_2048 if TARGET_QEMU_X86_64
 	imply VIRTIO_PCI
 	imply VIRTIO_NET
 	imply VIRTIO_BLK
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 8b4c5aff7f6..79cdb0bddb2 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_TEXT_BASE=0xfffd8000
+CONFIG_SPL_TEXT_BASE=0xfffd4000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_SMP=y
 CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
-CONFIG_X86_OFFSET_U_BOOT=0xfff00000
+CONFIG_X86_OFFSET_U_BOOT=0xffe00000
 CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.34.1


