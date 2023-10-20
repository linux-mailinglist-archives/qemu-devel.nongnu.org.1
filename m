Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C127D16BE
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtvi6-0001xC-Rr; Fri, 20 Oct 2023 16:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvi3-0001r7-SY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:03:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtvhz-0005TU-NE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:03:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cacde97002so5696305ad.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697832177; x=1698436977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOyWTz8Kx3JTuLtJa3OcB8g3zKWOaO0uiOsmwttm3zM=;
 b=PxFumCIW2h0gt+SvPQO4uS9TD9zsZO/aR6RyCQ3nqsYKlNlJLgZpBvs71+MXfVvY/r
 a7G2S50vGzrSopyHDPgnQt0CjlkAJMpvZlV2p/bIjbjRfqb+GR375OkxGKFSOA4uIWej
 vK2H3gHaA61sYXBXjMAXMjNCzdWNDsDL3UZKrf3NUe8iv/5vBs8fWVk4EmN1J0n3js8A
 OVDdYw7CekTTMdDzvCcBjjEzKFMJchPt/BktkbWsEFtFTr7AhT+UU4hZ1N4QCduyOZyI
 ax4BletB+JEy8bv/6Sb+vfbu1TdyXGmeqpUnh1ztaRZtAPXL0qZTJmICIQHIc/JdHu+3
 E8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697832177; x=1698436977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOyWTz8Kx3JTuLtJa3OcB8g3zKWOaO0uiOsmwttm3zM=;
 b=UnqEWuuKZVadP6zRTeMG/1VwfG0Wj7Aww+mehvMuWqYwam77FoYYMP9Nc3Vx78Cdrm
 wkOR96z2tEngD2R19J0etwHuzd4bGhpFTxX2qluLVCTiQt7dAHbqzIEFQjcPmOhwgOJr
 YKoXJNJDabkC20qxlSmu48lCMPNJWBdgUmJc+cmZaDKd7XERgKoINKYL3/u69d6m/a9b
 je4KJ7stpxl3iI20CwEQD4TpPLXXVVK5egdkyYn4iNVbVWYsxc2Y3fd0I7uaFRlQBS/t
 kovi7fqIK8QWgsCx8Y81OhXCtk39QzcSoe8Rerzzqgn++9WTyQamuOgbJc3BOzz3Q6UZ
 TBXw==
X-Gm-Message-State: AOJu0YxuDzeOqnIMYBb6zxTpEQ8RUoNO899qmHTX79FwmwbWONlFBGNO
 37nHx4o99aEpE/hZ21boAfOUhIVIhsUaBrP3E8Y=
X-Google-Smtp-Source: AGHT+IHuibEbymYa7X+wcFwGb/u34XAklE8TWfsCMAykJ+zpOqllyVNYNsVpuV9n3TfS8tayMKxqLg==
X-Received: by 2002:a17:903:124e:b0:1c9:ea71:8032 with SMTP id
 u14-20020a170903124e00b001c9ea718032mr2845243plh.31.1697832176899; 
 Fri, 20 Oct 2023 13:02:56 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 b11-20020a170902bd4b00b001c9d6923e7dsm1890680plx.222.2023.10.20.13.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:02:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 1/1] docs/system/riscv: update 'virt' machine core limit
Date: Fri, 20 Oct 2023 17:02:47 -0300
Message-ID: <20231020200247.334403-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020200247.334403-1-dbarboza@ventanamicro.com>
References: <20231020200247.334403-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 'virt' RISC-V machine does not have a 8 core limit. The current
limit is set in include/hw/riscv/virt.h, VIRT_CPUS_MAX, set to 512 at
this moment.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1945
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 docs/system/riscv/virt.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
index f9a2eac544..f5fa7b8b29 100644
--- a/docs/system/riscv/virt.rst
+++ b/docs/system/riscv/virt.rst
@@ -12,7 +12,7 @@ Supported devices
 
 The ``virt`` machine supports the following devices:
 
-* Up to 8 generic RV32GC/RV64GC cores, with optional extensions
+* Up to 512 generic RV32GC/RV64GC cores, with optional extensions
 * Core Local Interruptor (CLINT)
 * Platform-Level Interrupt Controller (PLIC)
 * CFI parallel NOR flash memory
-- 
2.41.0


