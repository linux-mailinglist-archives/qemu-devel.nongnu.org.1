Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C666D72F1EE
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFF-0005Ck-BM; Tue, 13 Jun 2023 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FF7-00055b-NR
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FF5-0004zm-Vh
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-652699e72f7so4752998b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705850; x=1689297850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO+1sqpCGLByRwsn5yLCX1XOZSFYO3fVw3PW0wG3ZcA=;
 b=paqUAtuvj79R8EAMWVnioJKboot+xh7soXPVOguCuyKlFE3eR4QBDZ6XOJTY32AyWM
 LCE4ktiBs/VoD+CJOPJkSu6EFnvN2U9ya2N3rH5zgUAQi+FnmM7WmzbxCzsMI/8t34vu
 TfmJ/ZpwG9YhzrVadpV8sww1EgJt7JE2ID5DjVYMQy69Tw+xQBkB99Y2Z6t1wKjDxVLZ
 gak2fG/WytoOvUpAH4dG/ULPr60VkbMghvzYGvpy7UE4/nNXPsMLCay28dsDvqs+SZn2
 JpwvXjnRg5FucTkH8at59lGdqKOtohU6ILH1onN/HGPB817fFZYOGe8xDVSQs+umakmN
 2Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705850; x=1689297850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MO+1sqpCGLByRwsn5yLCX1XOZSFYO3fVw3PW0wG3ZcA=;
 b=ZrHcYUv/EhuthjSoE5/F1trCJPJFreSBePiO/hB6UmWmT8YCBfwdkvyk02mrM80SSe
 9qYTVYmo60r0VI2dH2RL0DrHgZfGfRYOaP1tqiCoOCaaQ1HCWpFkcUtlJltmwDKC3uGP
 8Hz9ioy5EtjXQVnaJ4ilt1hTOQnsAnjgfiRvz4K82aPjVDWsGyrs8C5IJyQayEDfCiIB
 7IiWBEm7q5FPnl1XBffbgq4yy2mb5f+A/EqFrqLmsGUWlg13oUTVowRIfqoT+sEZsfFp
 HWO6Z0wMrux6LePBN1UzajrVqRX4c7QRuC9kury63ugYi7dAVmC+u0ZcCGWU9YCLADSu
 G+Bg==
X-Gm-Message-State: AC+VfDzXR0FZoFGzvoxjWJ1afTORS3Rczkidib2gQ4ZIA1hXqXHYx5xk
 EwBskCwSDslfGARZJSVsi4siXAhMPfieoQ==
X-Google-Smtp-Source: ACHHUZ7mV7BRPDeRI4sAJvcrvpeQ/slidkMdlRtw9wS6JNEOIR4wmR738phXlGDqWorbENXQJ+lPuQ==
X-Received: by 2002:a05:6a00:9a4:b0:664:2f24:5578 with SMTP id
 u36-20020a056a0009a400b006642f245578mr497229pfg.13.1686705850373; 
 Tue, 13 Jun 2023 18:24:10 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:24:09 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 54/60] docs/system: riscv: Add pflash usage details
Date: Wed, 14 Jun 2023 11:20:11 +1000
Message-Id: <20230614012017.3100663-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Sunil V L <sunilvl@ventanamicro.com>

pflash devices can be used in virt machine for different
purposes like for ROM code or S-mode FW payload. Add a
section in the documentation on how to use pflash devices
for different purposes.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230601045910.18646-4-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/virt.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 4b16e41d7f..b33f45e5b3 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -53,6 +53,37 @@ with the default OpenSBI firmware image as the -bios. It also supports
 the recommended RISC-V bootflow: U-Boot SPL (M-mode) loads OpenSBI fw_dynamic
 firmware and U-Boot proper (S-mode), using the standard -bios functionality.
 
+Using flash devices
+-------------------
+
+By default, the first flash device (pflash0) is expected to contain
+S-mode firmware code. It can be configured as read-only, with the
+second flash device (pflash1) available to store configuration data.
+
+For example, booting edk2 looks like
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<edk2_code> \
+     -blockdev node-name=pflash1,driver=file,filename=<edk2_vars> \
+     -M virt,pflash0=pflash0,pflash1=pflash1 \
+     ... other args ....
+
+For TCG guests only, it is also possible to boot M-mode firmware from
+the first flash device (pflash0) by additionally passing ``-bios
+none``, as in
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+     -bios none \
+     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<m_mode_code> \
+     -M virt,pflash0=pflash0 \
+     ... other args ....
+
+Firmware images used for pflash must be exactly 32 MiB in size.
+
 Machine-specific options
 ------------------------
 
-- 
2.40.1


