Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F57184D3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Mji-0005ES-7H; Wed, 31 May 2023 10:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4Mjf-0005A5-Jn
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:23:35 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q4Mjb-0002lZ-GC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:23:34 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3985f70cf1bso3471580b6e.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685543009; x=1688135009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUcoHqBo0RA5TBavH7NT5dA3iOjs4Vli/rrWzbZB0zk=;
 b=UBztMMGkRkzsefV0F+b1YDC4D9I9kVKCktNfibbNaxuQgsmiZKdHJ4vaI9V7qnFWKk
 yiFESqE1+HWVwozK+IcNZgR4PqQXSq2eZTVxvRKAFE8g9krdYA1dUllXGLcdGTPwDVdP
 puyDJwxIoIbmKUZGSPLqQt1ueUb2MxZgkP/q7lLy0UWqD7rEeIN761SBuPCfQ5oFME4R
 XxvQvKTSuxzLbzeTAeyO6Z16f57b9GIbLLEH1+sd0md5YLwSb33QpFb+YeByI/9PlD7M
 B79vCFE8AxElv79S4un874YInQdpwaMpggPfrcMFQOAQTmCnUoLRyvJmmCFh50AtvQYK
 qJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685543009; x=1688135009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUcoHqBo0RA5TBavH7NT5dA3iOjs4Vli/rrWzbZB0zk=;
 b=QYUOTTpOG40Pd4hYW6s562lU6+yxZavi55fA56fcGfV2RFd9TC+LPe2qpssuUP2vYw
 2q/IWw4iNbJKPCrfss8SXeox0z+rEvf6NlwxxaRrvytqnIEDHV1MGJKNLbJre74sWyBR
 Um4KU9VbgAL3QZaTrYmnPwg8aUsWwu8TP5qXvwj/JaUHaPd8SgIzCOdlsIbQyxqCm1/C
 h2BcMyT3Jwvvdb6uWS00kj8THJKaet1vqqHN7Rzyp5QsS7U/XkIVFf0HgwbGF/xw/zOi
 kVI40NKdTQUuO+nkQAaB/LjsvyvSKB6IE0jR7FMThEWj5wk/5ve+ovY2q1U6z/oUr83r
 FTBg==
X-Gm-Message-State: AC+VfDx6AkrBsqV/JwYG7SxZ0zSUNvN0ABGtGxbJ20vzfCtAvhyrGQ/b
 O9lFQdlOFBl7vdePS27aPQWiWA==
X-Google-Smtp-Source: ACHHUZ7tX9F2hgYZWFavsxDqE+P6QsHF4YSQAjWZvtvW89tRF64j8i7F/2Kkmjhl6+9OGJ0C6X1glg==
X-Received: by 2002:a54:4e83:0:b0:38e:b9b:a85c with SMTP id
 c3-20020a544e83000000b0038e0b9ba85cmr3264421oiy.53.1685543007676; 
 Wed, 31 May 2023 07:23:27 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 a19-20020a05680802d300b00397c07e8061sm574548oid.6.2023.05.31.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 07:23:27 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 3/3] docs/system: riscv: Add pflash usage details
Date: Wed, 31 May 2023 19:53:00 +0530
Message-Id: <20230531142300.9114-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531142300.9114-1-sunilvl@ventanamicro.com>
References: <20230531142300.9114-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

pflash devices can be used in virt machine for different
purposes like for ROM code or S-mode FW payload. Add a
section in the documentation on how to use pflash devices
for different purposes.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/riscv/virt.rst | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 4b16e41d7f..6c1d4fed3e 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -53,6 +53,49 @@ with the default OpenSBI firmware image as the -bios. It also supports
 the recommended RISC-V bootflow: U-Boot SPL (M-mode) loads OpenSBI fw_dynamic
 firmware and U-Boot proper (S-mode), using the standard -bios functionality.
 
+Using flash devices
+-------------------
+
+When KVM is not enabled, the first flash device (pflash0) can contain either
+the ROM code or S-mode payload firmware code. If the pflash0 contains the
+ROM code, -bios should be set to none. If -bios is not set to
+none, pflash0 is assumed to contain S-mode payload code.
+
+When KVM is enabled, pflash0 is always assumed to contain the S-mode payload
+firmware.
+
+Firmware images used for pflash should be of size 32 MiB.
+
+To boot as ROM code:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -bios none \
+     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<rom_code> \
+     -M virt,pflash0=pflash0 \
+     ... other args ....
+
+To boot as read-only S-mode payload:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<s-mode_fw_code> \
+     -blockdev node-name=pflash1,driver=file,filename=<s-mode_fw_vars> \
+     -M virt,pflash0=pflash0,pflash1=pflash1 \
+     ... other args ....
+
+To boot as read-only S-mode payload in KVM guest:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+     -blockdev node-name=pflash0,driver=file,read-only=on,filename=<s-mode_fw_code> \
+     -blockdev node-name=pflash1,driver=file,filename=<s-mode_fw_vars> \
+     -M virt,pflash0=pflash0,pflash1=pflash1 \
+     --enable-kvm \
+     ... other args ....
+
 Machine-specific options
 ------------------------
 
-- 
2.34.1


