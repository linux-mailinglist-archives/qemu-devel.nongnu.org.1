Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDDC7E32FE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Brc-0002kH-Q9; Mon, 06 Nov 2023 21:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrY-0002j1-53
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:44 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrW-0002W0-72
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:43 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so47517045ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324238; x=1699929038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewmZlt3aEpSRew3SXCh+Hov5cGo56+82L5qjhXMQFwA=;
 b=et97qTjUw63S3nW/TwAZ65Oriwx5D9M/fT7pSbVwgnlLEDKuTRNBEhDlEv668WKeGh
 ZQFLwp7Sas24SNaFRkKyqcXwZkTYyFmaKCJv6vbK9LFAqAtOrGXNsclGGo9kZk9Xky8c
 MUM4cmkYRQSCiDqDa0H5wS1Xkf+V/L8xLgySSzAnk4q2Zq0UtXkDRc4ZRK+6V6suQlxE
 vwZa1q+MFdjn03F26zW8M06+2m1lqXFxuVd4ZiTDqbQKncne4R2fzFc1AvrqF4wPQzsQ
 50/nmy7WyhFS7EOjblPyoOPEvLU9x9lHZQJVRIoR/E3t3ztHrITAWO2cqRleTYK+V+bc
 CtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324238; x=1699929038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewmZlt3aEpSRew3SXCh+Hov5cGo56+82L5qjhXMQFwA=;
 b=BY/TApI0cO161QQui93FOswpEFg8bdOtjX6FnaocNvd12/mjwEapyteAXs3B/uKuWS
 01GFV4GUdXB+POEgotTuSvvQh8UCXHFV4cwEunQyo+Qsxr0wJAleYfekxWjBJ5qlbbeo
 vRdQ72EeFK09iGYf8Ne15ibLHxdIKzURQQr10taWUDQ5rwaiXXc6nqhqevJRlhMiMen6
 J8/WTUVkUZYP/559niyAP7exjOGBJWbXD2Pn1nVH6x9JVURvqBhK6z1c6GKfSV5FPb+s
 Kxg1y8HqulJGIjFMTyY3rh8G0vNoWZapaiJn3c506+a0hGZX2cyaJo4AfyelnQ8ehcm6
 LsRA==
X-Gm-Message-State: AOJu0YzOOakLV4nb+N3aolw88FmDF1pIB7V/24nmge5POneCuEkasneA
 /blGHRin8qVgQRbNlsEmrAGaiwFqNmd9gg==
X-Google-Smtp-Source: AGHT+IH8wuSmvkxO4ZffKIggSU3qTcJJACisyYcHsEQd9mMkKyYTui65DnZaopWf3g9CF8iH5R1beQ==
X-Received: by 2002:a17:902:f54e:b0:1cc:6b55:fc5 with SMTP id
 h14-20020a170902f54e00b001cc6b550fc5mr23086220plf.29.1699324238451; 
 Mon, 06 Nov 2023 18:30:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/49] docs/system/riscv: update 'virt' machine core limit
Date: Tue,  7 Nov 2023 12:29:08 +1000
Message-ID: <20231107022946.1055027-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The 'virt' RISC-V machine does not have a 8 core limit. The current
limit is set in include/hw/riscv/virt.h, VIRT_CPUS_MAX, set to 512 at
this moment.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1945
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231020200247.334403-2-dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


