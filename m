Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956E74C716
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAP-0008F8-9W; Sun, 09 Jul 2023 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAH-0008Da-03
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAE-0000Dc-CH
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:44 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso3573381f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927379; x=1691519379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfPcEEmBTn/D8MUOuhUDyuANxxowzTkGOvS1jQDZcxE=;
 b=jZp9P/D7o8LMgaIDj3ChheEh4NqrXh3fZGeczL8bTU0DnFsgAF5aAWwjY+gfNxbfj5
 7tSVtBmE5kzhDBNTCeMYmn8kzCKNXIWqrtrNFWrnyUiCi8yxjqMP+U9KUl/Ue2QVBT6o
 Sw+3Pyphmh3mlhc0ZLU1iffP+1BklmzzUNz0+7ciKLeBBIOjtS4kpn06pGNkUSBVES8V
 om/93YdEZZBv3Zh3kDEV0EeMBunOCEmnFVan36RLtw/yk8wNEAkL18oI3jmnR6hhPiLr
 aBejoYeUJKK+pnohZsHP6blF7p3aordd/1VKZ/X4N6KitSgl/KyjUwOXUHCa4UatH22a
 qIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927379; x=1691519379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfPcEEmBTn/D8MUOuhUDyuANxxowzTkGOvS1jQDZcxE=;
 b=E95twGP3RFaW3vKbqrLS7qSWY9kr5GGMF+Cm08Nk9w/Iqe90kB+EHe6JbkvkeyHcHD
 kTm1DirMIfYsbSwXmkdRVf8UVTxFojbe7D14LhijtvpNIeZqUIqfWbytfJM10FbRlhab
 G+SQvtpw9PWJoaiJJxtDEh7rdDZTdUREvpHPGYtJv/25SVxggjYA1JIfNLH0bI/E2h+o
 Acdi9+pButiZnIddc5ACWH570d94z3K7tKIdn0VRmE1Z4AcL8g3XFmafSpi1xhn1+Xyo
 RK9KCfFeCLrTLtI3ZTNYfwgZU7x9nOr+pkwghIv1rTUj8twb+YLiwk2q5mNs3J2zqbe4
 OZUA==
X-Gm-Message-State: ABy/qLYrFC1v60ah+OX39NzHf7Z+yxnK1C6+qPUwHkkNRWUvoyBHGCRT
 6D0r5fWWEgFEDMlHIinBlIOgJuAsbhxWjmj/XNd1lQ==
X-Google-Smtp-Source: APBJJlHCtbiBy9cThBQKLFZ3fXIffmD1SCj9+uvRE2NscSXTkRJpohJK0x7DBHUN2QXGHuDCLKBAVA==
X-Received: by 2002:a5d:4f0c:0:b0:314:1fd7:188b with SMTP id
 c12-20020a5d4f0c000000b003141fd7188bmr8037074wru.17.1688927379157; 
 Sun, 09 Jul 2023 11:29:39 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/45] linux-user: Remove #if 0 block in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:15 +0100
Message-Id: <20230709182934.309468-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

These definitions are in sparc/signal.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index e80d54780b..a4e4df8d3e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -547,30 +547,6 @@ typedef union target_sigval {
     int sival_int;
     abi_ulong sival_ptr;
 } target_sigval_t;
-#if 0
-#if defined (TARGET_SPARC)
-typedef struct {
-    struct {
-        abi_ulong psr;
-        abi_ulong pc;
-        abi_ulong npc;
-        abi_ulong y;
-        abi_ulong u_regs[16]; /* globals and ins */
-    }               si_regs;
-    int             si_mask;
-} __siginfo_t;
-
-typedef struct {
-    unsigned   long si_float_regs [32];
-    unsigned   long si_fsr;
-    unsigned   long si_fpqdepth;
-    struct {
-        unsigned long *insn_addr;
-        unsigned long insn;
-    } si_fpqueue [16];
-} __siginfo_fpu_t;
-#endif
-#endif
 
 #define TARGET_SI_MAX_SIZE      128
 
-- 
2.34.1


