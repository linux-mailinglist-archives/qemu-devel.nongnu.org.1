Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A97E7F54
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VgU-0001cx-On; Fri, 10 Nov 2023 12:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1r1VgS-0001QH-DI
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:52:44 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1r1VgQ-0007Er-OP
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:52:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso18988875ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699638761; x=1700243561;
 darn=nongnu.org; 
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:from:to:cc:subject:date:message-id:reply-to;
 bh=130gBMZvGIr7bPTqZI3xW+pcuS2cho3AwDsNQVHhX+o=;
 b=r7yrZkiZyhRvbiMNjavoDkUrxJPyVdtHTEHo8djHCynnaJeVG6DzzIjVs/ANRM8bOE
 QroIN0nciujNIoeEDrExbPAwZl0aIUBjHPA3X3x4vU7MlBIaULBYh7UiFrDIa+VlZ7sA
 bk+saV0qCC9W5tJ8C9NtfD4/Cd2WQwg2p1qwniYvqsbJ1N1Akgk9eza/91A0ybBb4wPe
 JLHhXByBDKDUnXSjD+lsXZhzOJ23d0sOb/03/mVUavZImOcDoRxEnyjYgXKMeaftCiBk
 9KmDSAlBjhblSsL5RA/GxpeT4FKHoB8ywU4BXHaGnOjW7C9hQELpDJnlLdbfbunPg4Uv
 461A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699638761; x=1700243561;
 h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
 :subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=130gBMZvGIr7bPTqZI3xW+pcuS2cho3AwDsNQVHhX+o=;
 b=REyS20WCL5oy0Q6yUkU+XZGaaIhx0IdOuqkCcUbmkW1fAXwVtCMumTFi1e11WRf3z0
 /Xpk3k4rwrhXFLsohWcPf8qHAeQEot7VJa908OsZE3ae//c//aekfXRhDWMHcZGmUDIV
 oRSOkdvqrpKLR9vdDo6GNAsKijVHnF17Q+3pejHR3fwltRrPTIdOWtZP29hIhR6ASCtp
 vktOW2AQlMpskRZbnkmqOEqLx7WRRFxDvCDMOpPLh9VXNMwmlXXrlo9xXP5rTrcoCgTH
 ry4taYEoF47WjOcjL8YwbWZcDuLrA+heRW4wpoM8lDOSYIsOgG59OhJfNcMUBYsNVPV9
 pnnQ==
X-Gm-Message-State: AOJu0YxY8d66PxjfhoIsXANxoVptXShZ2TCJGIXTPrbF9uRSVw8Il9wU
 wjD3HqHyRBrFDYG9wPOwRd4Xtg==
X-Google-Smtp-Source: AGHT+IG7fddcgU3uZMlZL2tzKTKUardGv15YljhK6dWerhgSAItNGgugwaoYG+vpVzbqIX+dZ5VmBQ==
X-Received: by 2002:a17:902:ccca:b0:1ca:7086:f009 with SMTP id
 z10-20020a170902ccca00b001ca7086f009mr10439062ple.61.1699638760898; 
 Fri, 10 Nov 2023 09:52:40 -0800 (PST)
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 jb17-20020a170903259100b001c9c8d761a3sm5627111plb.131.2023.11.10.09.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 09:52:40 -0800 (PST)
Subject: [PATCH] linux-user/riscv: Add Zicboz block size to hwprobe
Date: Fri, 10 Nov 2023 09:37:16 -0800
Message-ID: <20231110173716.24423-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 armbru@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=palmer@rivosinc.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Support for probing the Zicboz block size landed in Linux 6.6, which was
released a few weeks ago.  This provides the user-configured block size
when Zicboz is enabled.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 65ac3ac796..7caacf43d6 100644
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
2.42.1


