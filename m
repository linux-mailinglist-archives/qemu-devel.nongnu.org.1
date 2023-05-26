Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7F71264D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 14:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2WHS-0004sv-2g; Fri, 26 May 2023 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WHF-0004pX-Tp
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:40 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1q2WHA-0005Kx-8x
 for qemu-devel@nongnu.org; Fri, 26 May 2023 08:10:35 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-19f22575d89so23361fac.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685103029; x=1687695029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SMtqwocGY/rL4SvD4PKQMdaIYi1C6Pm17aeP+9/5u4=;
 b=kJI/zhw4NUdxMHIej6vzNVEPf7gRRvyFg5H7JxTMiK11j9iaJjxW07pQvwa4XT42cF
 cJyCmWeoMlBzekmRpZgG5z2aWNzZXkipSltwwb69cm2utZLiv4SmM+d7+boKCy15xWha
 RvYJBOhKfQBuZ96RemwDRRVe68cxqCMizaF3u9gDi727ycDklNQoasfIwTcWBlenEagY
 z6YIMi09pTPxdx/wdQ+Du/BeieO5FTtaiLSXc48vDSygwUXuDSdagBDG9NfLOFoUGGeG
 NCprqWwj8SNBJscbE0Mts+687y9dSifZrpiGe5321yJJHfs8tB6kq1DoAw++mtxVAuRi
 wF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685103029; x=1687695029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SMtqwocGY/rL4SvD4PKQMdaIYi1C6Pm17aeP+9/5u4=;
 b=LJl5O7qWye4TWSNfNPNtEi/Xk+xbjBNoeq1pEclSWg1cMnW8sUYB3qdCIvj+KXHA6S
 ovsfX86tImgILll8MZk6oSa/z+9rKGRMJ63HMFRbcKD6QVG93DPrybBtkR/5A/vLc4Lf
 vZc2AzMDrRhS7hdvJeCr8/Y9bQ6HoiN8erajlznTFsWW5UGNv2JIz+q3GV25Ot95mo5m
 5Uu/dQHc2PQLDt+Y/TiF2g1zRWVV15eT5evoKZs2FqtihIn2BcmmzwtWK65uZRCzhELk
 0GhjE8WR6LtgyrdQKZXCqxiWHXEhRDEFO70zZaSN3o8ggBRrpJy4ceyP5PIurnWH6lDP
 moZA==
X-Gm-Message-State: AC+VfDx941Jv5KXBg0d/DEDoUrS96ZfJiKubwAJo75j+GjWcBZi9QaVZ
 LdOaMk00Bc0bP5o0BiJbxyluDw==
X-Google-Smtp-Source: ACHHUZ7cpCdW7aitKNZrqYZkeGvRAytiuaGmC5jOv6o3OxV0mZ2UzCqSLER136w/q58uVqINqnUa4w==
X-Received: by 2002:a05:6808:45:b0:398:1eae:f773 with SMTP id
 v5-20020a056808004500b003981eaef773mr736904oic.41.1685103029702; 
 Fri, 26 May 2023 05:10:29 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.186.3])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a9d618a000000b006abb3b660a9sm1611602otk.54.2023.05.26.05.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:10:29 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 3/3] docs/system: riscv: Add pflash usage details
Date: Fri, 26 May 2023 17:40:06 +0530
Message-Id: <20230526121006.76388-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526121006.76388-1-sunilvl@ventanamicro.com>
References: <20230526121006.76388-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oa1-x36.google.com
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
---
 docs/system/riscv/virt.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index 4b16e41d7f..3e873c67f3 100644
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
 Machine-specific options
 ------------------------
 
-- 
2.34.1


