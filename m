Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B127F3D78
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:39:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwK-0002d1-L6; Wed, 22 Nov 2023 00:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwI-0002cf-TH
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:19 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwH-00079S-E6
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:18 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5c210e34088so3549283a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631495; x=1701236295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxh52+uqUUCPtjqonG3n7Vsa43uouYVZK9c3z+2Lb9A=;
 b=iva0MZ9hmk/xr01emJZLJLLUSFl5YFrqdPsNmtokFq+vGO2Q34/jalTTiJAZLCVB4J
 2Vf0VN8tFfJK8UpySGrnoCpW1C9sVBA627w8GMxd+5CQwhkMzd8GQ9kD/AJa2AvG2aTW
 1cuelNxCXOrOXUOTq3dbOz2/cG8k+ejgIIoLMpyI7UZdt6yD57i/+/hFb4A66wF8vMMz
 XNVHqZohp+4Icg3RmBd5aj011vr9sUca9atnkWYWBW2vdITJiKvqbptUl87AkctBuTr1
 sF9S7rm6gEc2+6vlVzAnxJGHCrzo5XRhFa4S1VcjSOgXfc83nsW79sdd/hq7tGzbQ/sh
 Iksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631495; x=1701236295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxh52+uqUUCPtjqonG3n7Vsa43uouYVZK9c3z+2Lb9A=;
 b=tU/puKyfMDlQz5HCvaMdmqGbPVT19JaY9+gx5KROVIkgTvNbvAT0GSOx/PAo4atQYx
 4iKvUk25AEelpcvcP7T+6rVrh6uhyL08WYlLiegFqWrwc0Ei9ddFRQGzp2sCCqtBohsg
 72VukrYd0y2gS9+KqcEPRmM+w2xqrjiSIkrdAdgQ98aQsyG/PNIh56KIBaN92/cDHeTR
 z5YAVYdqUg45xxNU/iRTmxRBXl3itmsdMXEy+35kNby3cA3CoiTRI5HtEupGJ3PEZb1+
 2OkSzHhmorxDuNraxYoovUQoGb4GP/vQ5YZrP/xoVsnSoibBgpUsGDFoGAflm5MvZ0q2
 LYHg==
X-Gm-Message-State: AOJu0YzuAWoMrOrLXMHrXpy7uVZJQ2ap+qMd9jLX/7F+npcof39XhjXQ
 Lr6C24BYX2/7W+swBmnWVNt0Wvc0crO04g==
X-Google-Smtp-Source: AGHT+IGux0ihwEiMPSKRjeV84kqLPtKwv33ReX6MVxcu674vCgZ1awGgWuiSTPyGQGfCl9CS9l5gtg==
X-Received: by 2002:a05:6a21:2c83:b0:189:bde9:9cb0 with SMTP id
 ua3-20020a056a212c8300b00189bde99cb0mr1131981pzb.27.1700631495600; 
 Tue, 21 Nov 2023 21:38:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Palmer Dabbelt <palmer@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 1/6] linux-user/riscv: Add Zicboz block size to hwprobe
Date: Wed, 22 Nov 2023 15:37:55 +1000
Message-ID: <20231122053800.1531799-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
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

From: Palmer Dabbelt <palmer@rivosinc.com>

Support for probing the Zicboz block size landed in Linux 6.6, which was
released a few weeks ago.  This provides the user-configured block size
when Zicboz is enabled.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231110173716.24423-1-palmer@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 16ca5ea7b6..e384e14248 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8808,6 +8808,8 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
 #define     RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
 #define     RISCV_HWPROBE_MISALIGNED_MASK        (7 << 0)
 
+#define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
+
 struct riscv_hwprobe {
     abi_llong  key;
     abi_ullong value;
@@ -8860,6 +8862,10 @@ static void risc_hwprobe_fill_pairs(CPURISCVState *env,
         case RISCV_HWPROBE_KEY_CPUPERF_0:
             __put_user(RISCV_HWPROBE_MISALIGNED_FAST, &pair->value);
             break;
+        case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
+            value = cfg->ext_zicboz ? cfg->cboz_blocksize : 0;
+            __put_user(value, &pair->value);
+            break;
         default:
             __put_user(-1, &pair->key);
             break;
-- 
2.42.0


