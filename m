Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FAA96FFCA
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Sep 2024 05:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm1T-0004ZY-3S; Fri, 06 Sep 2024 23:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzh-0003oo-BY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:13 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzd-00054g-EQ
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2053525bd90so25433845ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679206; x=1726284006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=QYAW5wBcQ7oxEc7QHMFVZsuiHsW/JFJtAoFToz6l/1afmMZkLTHZlj9nfRPYr4qYmt
 uaujb78IsUa49Kxd+6aohGeV9JyYHXqIgIW0D/uTucsZj7zUXYy13XSxmFFsVjtesYm1
 /+9wkASJx59K7pls3mRqRdjtBXnT3Q/hJ5Nbg9PL/DeBiPd48R/8gBKxZSsrBg7L2SEU
 zQbhWzG+8z/UQwjbZWxnv//wyvbDbulX1SouEl3nwo/U/+fEW+yB8AVr0yxZW3i3OU/z
 5HGtgqM0N0kVH50MunebpnSLbBr/OpNg4/6bRYkBL13g7k7Cbgd4O/tI2WCVXVZ2ZXYL
 zRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679206; x=1726284006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/upld7cTqaC/atkB+nu7yGsbOxCVGK3zsoQHBJP0niw=;
 b=Yl77tx/CKAaK2l5pG66CMUiPGCu9CevR81880QCAX50X7D9nMurbnuKjaVqll2UndP
 FQ3p4xFCd9ahYUQWINp1YzHgIYfq1YJquCCgKpuBzCw3hXeJxzrUH49Hr7xcXzOsUog9
 5jCVS7lkj9glMS/j/r4pD8VpANSMHlGy7+mJO5X4HvxDXXodK2EiA0sKqHZXhVEna/Xs
 GRnC4amNOw19G5BDd5qnVNismPc9nVYIZ+CRpgcbwAGLl1XEq2tU6lNq6Pt2ZhwtPEyG
 ENwcedvCWX2L3U1eqpp5+O4p/FMhXnzIDfseblZ2aA8Kokh5BZHxOvZe3Z2iId7cFKV5
 RShQ==
X-Gm-Message-State: AOJu0Yw6aAR2IpobIAVmxposLJy22OZbjLgOnxj/L+PyKc0hgT1Yxgiy
 ZS0QlKqMhJ9wJ4eF6y6Vx0Dr8OgBt/PKmVWjyqiy3DNgL14vSw6utVTF7495
X-Google-Smtp-Source: AGHT+IGB7xNqc3MfaWGRRCOsaA/d3TWIQr6mHUy1htNj95nzFsdXUTEOEcLzMKPl3zhgZ8rZMD3QCA==
X-Received: by 2002:a17:903:230b:b0:205:80e7:dcab with SMTP id
 d9443c01a7336-206f04e1b4cmr52801235ad.18.1725679206626; 
 Fri, 06 Sep 2024 20:20:06 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:06 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 11/17] bsd-user: Define RISC-V system call structures and
 constants
Date: Sat,  7 Sep 2024 13:19:21 +1000
Message-Id: <20240907031927.1908-12-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x632.google.com
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

From: Mark Corbin <mark@dibsco.co.uk>

Introduced definitions for the RISC-V system call interface, including
the 'target_pt_regs' structure that outlines the register storage
layout during a system call.
Added constants for hardware machine identifiers.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/target_syscall.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 bsd-user/riscv/target_syscall.h

diff --git a/bsd-user/riscv/target_syscall.h b/bsd-user/riscv/target_syscall.h
new file mode 100644
index 0000000000..e7e5231309
--- /dev/null
+++ b/bsd-user/riscv/target_syscall.h
@@ -0,0 +1,38 @@
+/*
+ *  RISC-V system call definitions
+ *
+ *  Copyright (c) Mark Corbin
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef BSD_USER_RISCV_TARGET_SYSCALL_H
+#define BSD_USER_RISCV_TARGET_SYSCALL_H
+
+/*
+ * struct target_pt_regs defines the way the registers are stored on the stack
+ * during a system call.
+ */
+
+struct target_pt_regs {
+    abi_ulong regs[32];
+    abi_ulong sepc;
+};
+
+#define UNAME_MACHINE "riscv64"
+
+#define TARGET_HW_MACHINE       "riscv"
+#define TARGET_HW_MACHINE_ARCH  UNAME_MACHINE
+
+#endif /* BSD_USER_RISCV_TARGET_SYSCALL_H */
-- 
2.34.1


