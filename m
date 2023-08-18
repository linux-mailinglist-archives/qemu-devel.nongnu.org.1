Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24242781151
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31Z-0008Af-BU; Fri, 18 Aug 2023 13:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31X-0008A5-RJ
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31V-0007y0-LE
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso9448735ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378752; x=1692983552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6UB9ulXi57KJ9LgPss7vEG9zn+ZrgirznyOZ1XFlP64=;
 b=OQVa88hB63QMu+lzD8vZouFOliYx8O8WiCzqzSdSIVI4VYTHD9ipAgfJsxMxTVSfO/
 SKv7MPOinIGcUEaIufPBF8KE4/Rxghhk4G1Uost77jwjp18d0UPP1a2jfSkBL+NIDjea
 nEs2Qj1S+kwpGeQ+eBwyOev48Ey7PIVXn8C+TjrPl+HTC1R8ZjNXAXegjAU8a4Qbrnbr
 Y0L2P5YcNwIwdvmV8e6aiOKHF/acaqOf82jGoecEW+c7OvBVAL6LPnM/TS6ohFdWpS+w
 QaCwAJcucflzwDceaYXUZjVI5Eh1Ct1ATk9diGNDt/P6kEbG+CG0kHvcMJaFb8XaeRjx
 Uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378752; x=1692983552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UB9ulXi57KJ9LgPss7vEG9zn+ZrgirznyOZ1XFlP64=;
 b=h6SAeyP4IeDfWgfSv+OKFO7QHOZKSQr2QMI8JE9L3vy3Uw6zPxKwJhxUzETmP7R3PP
 kPFX1tXGEfkGmsDmOkfiTpBXGmI7EEfaXYvIWSiCaqVm3kZJbQwP1TtvvlTJqLuMgL/B
 O27/HFKvGGwobuVAOKGZf1bGEHKcyj4yGhbRqEO9hRr5eu+gxiQSAlzy1WrEuRkbYHEW
 Brp9vNc5Spj55tqUbL/6MWM2x3Bndv1amxxjGn61TaCfakbosxnR6eVsyks6Z3r/RlNu
 ja5jWTBSDB6fwnLdmeXJlXtWqQ+bUUnVbwjtxnZ3hVBJPsRm5+JmBs5P7qbDQmr6R8v2
 5x+w==
X-Gm-Message-State: AOJu0YxR4a9CF9o1JrPG6mfiQPdQTmCTpFBqOlU8ut312hLJ91IuYqq0
 NzodpF/GY4NdaWQpMi008rPwP+7SSTOj1eBrtfM=
X-Google-Smtp-Source: AGHT+IFkHHFGla2PBSBpZias4dCn23pwvwMkdoMK/P1IBJK7qL5gqtpr1g9Jw+ys0hoS9J2IjMMIRw==
X-Received: by 2002:a17:902:e88f:b0:1b0:f8:9b2d with SMTP id
 w15-20020a170902e88f00b001b000f89b2dmr3652501plg.29.1692378751944; 
 Fri, 18 Aug 2023 10:12:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/33] linux-user: Adjust SVr4 NULL page mapping
Date: Fri, 18 Aug 2023 10:11:56 -0700
Message-Id: <20230818171227.141728-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.

We really should be attending to this earlier during
probe_guest_base, as well as better detection and
emulation of various Linux personalities.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ccfbf82836..9865f5e825 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3749,8 +3749,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
                and some applications "depend" upon this behavior.  Since
                we do not have the power to recompile these, we emulate
                the SVr4 behavior.  Sigh.  */
-            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
-                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
+                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+                        -1, 0);
         }
 #ifdef TARGET_MIPS
         info->interp_fp_abi = interp_info.fp_abi;
-- 
2.34.1


