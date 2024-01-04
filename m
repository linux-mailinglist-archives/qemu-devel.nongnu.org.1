Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BA78244B3
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 16:11:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLPN3-000864-R7; Thu, 04 Jan 2024 10:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPN1-00083V-Le
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:55 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPMz-0000Bp-9n
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:55 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-360576be761so4557905ab.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 07:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381052; x=1704985852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAQCA2+L8S+5OKFmSgZPF3WL7XCVJOyD3jGB9qjlr1Q=;
 b=hkjGzeJpNGkEOIIAGY3CHOAI290gLWjiguhDqEqnrXmKFlUMOd0Aeqc0NV8E2t4Vou
 ibfTAOEGD3uBrOJEuMFGtY4JoHTM6K/ADNj7/XpX3cr6mxMcxldegICoEIppFoTVHtLE
 /Hhb0MWqZnWyJM5Nh3GZFO4+klk1/7PLduWP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381052; x=1704985852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAQCA2+L8S+5OKFmSgZPF3WL7XCVJOyD3jGB9qjlr1Q=;
 b=uMm41ZSTpViLSmYIUYWdB8LYDRLeSjisdbwYwHc2dE/8V+EYH7SpcB191OWvidfMvw
 OEd/XLWRucytGocH8/cauNCM4cqGCfn58pwkS9N1t860+3qYB1EajrhP5It451cI2byP
 qXXySTKZERe1AkKIZOk7GzNJNmRbXtnigedq66Rv+LaD4FuiVFW7f9UOZ0t7nn0Bqi1Q
 gGNZ7v7iLAut722ce/FoWTGFtsR85yk+DnRFDkMz1+rttk7KukJDcXg66DdzbGRam1rz
 BOQS66eTZcQQ+MNW4beQyo4Rl7CDEIeDwVxjGOi/19fZj2y3DbYdS0lxU+U5z8x/hI2D
 W5cw==
X-Gm-Message-State: AOJu0Ywa6ci4l9ybPaoIcDSbX603DVqa3QpMhzzbOP8zXwMW3YAET/xu
 ooW1yH8viZEm06FLMioGS1VgzN5vmufm
X-Google-Smtp-Source: AGHT+IHKGtjhho94H8XlnF5DxIDBQI5UgRF5OICVleGRtK1i58J6OfSiw9pqYrEh0W7htYlJzoE8Dw==
X-Received: by 2002:a05:6e02:20eb:b0:360:142:3fec with SMTP id
 q11-20020a056e0220eb00b0036001423fecmr359057ilv.6.1704381052163; 
 Thu, 04 Jan 2024 07:10:52 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 7/7] x86: qemu: Enable truetype fonts
Date: Thu,  4 Jan 2024 08:10:42 -0700
Message-Id: <20240104151042.695717-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=sjg@chromium.org; helo=mail-il1-x12a.google.com
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

Enable this feature to provide a larger font choice and more attractive
menus. Expand the ROM for x86_64 to 2MB to make space for the font.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Move 'Avoid unbinding devices in use by bootflows' to another series

Changes in v3:
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 79cdb0bddb2..f084f8e2989 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -81,6 +81,7 @@ CONFIG_SPL_DM_RTC=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 9bcf06c137f..b0d397bae08 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -58,6 +58,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
 CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
 CONFIG_FRAMEBUFFER_VESA_MODE=0x144
-- 
2.34.1


