Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C824671114D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 18:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2E8h-0007eg-75; Thu, 25 May 2023 12:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2E8b-0007br-5l
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:48:29 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2E8W-00054f-8A
 for qemu-devel@nongnu.org; Thu, 25 May 2023 12:48:28 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6af6ec3df42so1719693a34.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685033303; x=1687625303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkyj2KLG0oviuwLs56Xd5gmAOMnvze9RnPy8ag66QTY=;
 b=irYZkGopA4LYtc2tI6shlDm6qhKJnMayTigxtTFNUitghFEG0pgj7hJYjPSKNAmUPV
 LDu9XRbhmw7iGtRJIYdynn1acizDyYonszEhVrf+MJ77Kz4sstY/1ZY1oVJXRfjCzYJw
 x28koR6y8XhFQVDOeQpJqOx50vb/0vS/iXujr4GqIJxzVuYXjUA7WGAWHHDJIfS+tNTe
 FFYP0e7sjG1w/ReDNqKqANFG9yV1Gfz/R+oyLvrvW0euwtDd5ez8qDEMLUqWFQq/HFpw
 qk7BbiRf+4ss+p0kIK9Akk3pX5EeIsTBTtDkEpPbUGl8ZOQZYjNJS3jgliRzEQMSRevs
 5egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685033303; x=1687625303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkyj2KLG0oviuwLs56Xd5gmAOMnvze9RnPy8ag66QTY=;
 b=QRrnwRT+WcbwMLv2wEfu4qxnd/5kTrUkf7F9chk0MKWdW+RGU37biaXaaHY+lRRFQI
 hLzhEIiMd2Gg7AboTCalKVSxn2w5HFC23X1/PQyjvI+dnZMCwoJJTGQW5OKaVkA6WSsj
 Z2mWOgeKgfzMA8Qh4I68F/7z2SOvZAownwzDl9xyC7r/r0S0i9K9iAQtGXtPI8sOymn3
 KclGFink1pC8lY8ai208dXM0c9K8yRCqCSgCgWrcrbsMImZQ93dvK42uIFls1ebnJ6fI
 eIJprn4KZIzdG1p3zjXBloaLzp3OlGEDOGj7U2xFsF9KWlOvO8XWWQaJdo1vwcqw3/tZ
 5N4A==
X-Gm-Message-State: AC+VfDzrGKhKyoPjI6lQnsTyITLwPVxPF9awAnd75PZ2H7oA2NEr2964
 YcMWj09H8bNZluveYE8P/0DDcw==
X-Google-Smtp-Source: ACHHUZ7FBlMWUXDX8uKrjksI2+oFbFEA3TNhjN7JGtGH1gp4b9ykgDtjoiGxiOLesMQxGqgNpAGJHw==
X-Received: by 2002:a05:6830:44d:b0:6af:8aa9:28b with SMTP id
 d13-20020a056830044d00b006af8aa9028bmr65900otc.35.1685033303049; 
 Thu, 25 May 2023 09:48:23 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a9d7a92000000b006af886703f2sm803905otn.37.2023.05.25.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 09:48:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 3/3] docs/system: riscv: Add pflash usage details
Date: Thu, 25 May 2023 22:18:03 +0530
Message-Id: <20230525164803.17992-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525164803.17992-1-sunilvl@ventanamicro.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
---
 docs/system/riscv/virt.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 4b16e41d7f..c3e0b7a9c3 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -53,6 +53,35 @@ with the default OpenSBI firmware image as the -bios. It also supports
 the recommended RISC-V bootflow: U-Boot SPL (M-mode) loads OpenSBI fw_dynamic
 firmware and U-Boot proper (S-mode), using the standard -bios functionality.
 
+Using flash devices
+-------------------
+
+The first flash device (pflash0) can contain either ROM code
+or S-mode payload firmware code. If the pflash0 contains the
+ROM code, -bios should be set to none. If -bios is not set to
+none, pflash0 is assumed to contain S-mode payload code.
+
+Firmware images used for pflash should be of size 32 MiB.
+
+To boot as ROM code:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 -bios none \
+     -blockdev node-name=pflash0,driver=file,filename=<rom_code> \
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
 Machine-specific options
 ------------------------
 
-- 
2.34.1


