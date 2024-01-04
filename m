Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938458244B4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 16:11:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLPMx-0007yr-L2; Thu, 04 Jan 2024 10:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPMv-0007wP-Qe
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:49 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1rLPMu-0000Au-35
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 10:10:49 -0500
Received: by mail-io1-xd41.google.com with SMTP id
 ca18e2360f4ac-7b7fd9e17d8so22453539f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381046; x=1704985846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk4V+RgnmIvm4289rEIMHbfKRp6GgKqVfQM6XVzmUSk=;
 b=I9/vBjj4nLyRd0Ju/0FuKWWWX8ZvMKGw0w9yZ3WyuVZ8dRUSQMfCuCxFm43Q/0cTVI
 zrpzWAce4z3GcaOsmkLSwR8oM9mELmn1ijvM1L9iBShWCw7Io5KFRdE4gB9xATStWDlB
 PF9ra11an8AfY9NDvtzNFZN1lqsqainxv+c2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381046; x=1704985846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk4V+RgnmIvm4289rEIMHbfKRp6GgKqVfQM6XVzmUSk=;
 b=VnLKME34Mv96tccnuB2TRW8hiFinBd0imJbPTvvBPKVmMV2JD5S3xA9QSdgH9xne55
 x9PFqx5pfiuVsqQ6pCOyy2L+EGL4hxrhaoRWLR0fsG8lep3HN+YRb+a54gM4lqQRh85/
 vMPmBGMufGg6BZhNukSz9hKvWGcsngM3tO8sUB3wz0seAfz29rifvkTMTA7Ct8b4JIZ5
 jLmxfDyD6BeaL2qE/VH3fYetyQoeX/HCiVhCyBiHPDxsYwVSpU3jvZKqFverN1SraIhf
 I8bkER1wvhh9nlCeoPFgi6iXXdOsQUmqx+SSiL0+GjwzpZRzSK7yxGYFTebo1L7AnDNo
 0bNQ==
X-Gm-Message-State: AOJu0YxqoMcrdulES+ugkdhIftpjZ+R5uhpRxfoMYWop8rT0UEMwBcXU
 8W4Wo2VRj7wDPyTYg+uBRVDWjk/fLb+i
X-Google-Smtp-Source: AGHT+IEqMsL1f4qAlYMsnUqwgziAjnjUGbryPAN30yCZV7UZoKgOtCzNywsHZ9CWzrAfqLqA7iEjBg==
X-Received: by 2002:a5e:de0a:0:b0:7b7:fe53:ebdb with SMTP id
 e10-20020a5ede0a000000b007b7fe53ebdbmr749099iok.32.1704381046142; 
 Thu, 04 Jan 2024 07:10:46 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v6 0/7] Resolve issues with booting distros on x86
Date: Thu,  4 Jan 2024 08:10:35 -0700
Message-Id: <20240104151042.695717-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=sjg@chromium.org; helo=mail-io1-xd41.google.com
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

This little series reprises the EFI-video fix, fixes a USB problem and
enables a boot script for coreboot.

It also moves to truetype fonts for coreboot and qemu-x86, since the
menus look much better and there are no strong size constraints.

With these changes it is possible to boot a Linux distro automatically
with U-Boot on x86, including when U-Boot is the second-stage
bootloader.

Changes in v6:
- Rebase to -next
- Move 'Avoid unbinding devices in use by bootflows' to another series

Changes in v4:
- Use a Kconfig option

Changes in v3:
- Clear the screen before booting
- Add new patch to drop unnecessary truetype operations from SPL
- Add new patch to enable truetype fonts in coreboot
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

Changes in v2:
- Add new patch to add a coreboot boot script

Simon Glass (7):
  x86: coreboot: Add a boot script
  video: Correct setting of cursor position
  video: Drop unnecessary truetype operations from SPL
  x86: Enable SSE in 64-bit mode
  x86: coreboot: Enable truetype fonts
  x86: qemu: Expand ROM size
  x86: qemu: Enable truetype fonts

 arch/x86/Kconfig                  |  8 ++++++++
 arch/x86/config.mk                |  4 ++++
 arch/x86/cpu/x86_64/cpu.c         | 12 ++++++++++++
 arch/x86/dts/coreboot.dts         | 10 ++++++++++
 board/emulation/qemu-x86/Kconfig  |  3 ++-
 configs/coreboot64_defconfig      |  2 ++
 configs/coreboot_defconfig        |  2 ++
 configs/qemu-x86_64_defconfig     |  5 +++--
 configs/qemu-x86_defconfig        |  1 +
 drivers/video/Kconfig             |  1 +
 drivers/video/console_truetype.c  | 10 ++++++++++
 drivers/video/vidconsole-uclass.c | 15 ++++++++-------
 12 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.34.1


