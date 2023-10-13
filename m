Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D17C8F66
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiM-0006Bt-O4; Fri, 13 Oct 2023 17:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiJ-0006B6-HZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:55 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiI-0000Pf-2G
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:55 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57be3d8e738so1469057eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232533; x=1697837333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Lf1oGBwY3pJX34xnQEwCJVUuoDSjZ6REJp77Z6zycY=;
 b=j2LVORqluJT25coeO3MJLXG1YuUfrbPSMPfkcp/RNLf6/82RR132clMwTgP7kvLZSr
 fBIYdRwTa8zWHDSGffCUrXVfPyvQEMe7SfR/Ws4PiaYme9qSKKYtEiTvdoerwA63YO6C
 rJbFkNb2dtvDJXbaWcoU66n25IfuEALovfAVv+4Fd2/+9b/zsNHZ37h65MRXAI++84fT
 T2P2yRXWwrEqM5fSzD3ezl5A3bRdWSpLeHfxnDlFxUFn3xHXDYEnmRwX/SifulielpEy
 fDcOtnqxSlkgPiWVWtTdrGtKuCwcDWgaPy6MlY6FG8bgZML0uyMCv/ou/50leW6mZMpb
 N9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232533; x=1697837333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Lf1oGBwY3pJX34xnQEwCJVUuoDSjZ6REJp77Z6zycY=;
 b=kIB4K8mGo/q85jmTEEF1e1hf+Xo0HjSHxQploRS2GG8eG65EN/TzgiwPaBt1W5/iRU
 EVtcma5fbjX5fA/+t3eh+2QaxceWC7Q2fcwI3Sk7RLZ7Kq1IWJ2U5z+CfVlqCv0KQk4U
 2batRVsrnVm3gZQig+wAHQalCG8OvUU2DdelNynu0YDdzj9xn/g0DomHnF4u2Ps/bMiH
 1yVgqNdl+FGkEQ6nl4ylNjrZh+bid/l7MMuCc7BHVNdIbqy2wt6xWRDRPB+xI4mYBhzH
 5anDtma711qFUOwFOAw6hgbo414b0RRU6cMAKdxrXCtKllktbN39Ocf1NOx1C3v+8P6/
 xJ1w==
X-Gm-Message-State: AOJu0YxZrJc3k/aKGtSrGpW/mw7fmrdamgpzdaQlrp7mCCc+OT7peEry
 Ify20PEKJYKf6kC3KI3xxxoq4KbIWGFfSwmen6M=
X-Google-Smtp-Source: AGHT+IHb3l27K429kFTDUACTGITU1keffAFCLmXDFY95Bo7IObdHsiTCKmuLJ59ptmTz6IHDWr5I3A==
X-Received: by 2002:a05:6358:2906:b0:134:dc90:b7d1 with SMTP id
 y6-20020a056358290600b00134dc90b7d1mr34217076rwb.25.1697232532990; 
 Fri, 13 Oct 2023 14:28:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 05/85] target/sparc: Define AM_CHECK for sparc32
Date: Fri, 13 Oct 2023 14:27:26 -0700
Message-Id: <20231013212846.165724-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Define as false, which allows some ifdef removal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 59e5289693..da6503e101 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -258,20 +258,21 @@ static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 #endif
 #endif
 
-#ifdef TARGET_SPARC64
-#ifndef TARGET_ABI32
-#define AM_CHECK(dc) ((dc)->address_mask_32bit)
+#if !defined(TARGET_SPARC64)
+# define AM_CHECK(dc)  false
+#elif defined(TARGET_ABI32)
+# define AM_CHECK(dc)  true
+#elif defined(CONFIG_USER_ONLY)
+# define AM_CHECK(dc)  false
 #else
-#define AM_CHECK(dc) (1)
-#endif
+# define AM_CHECK(dc)  ((dc)->address_mask_32bit)
 #endif
 
 static void gen_address_mask(DisasContext *dc, TCGv addr)
 {
-#ifdef TARGET_SPARC64
-    if (AM_CHECK(dc))
+    if (AM_CHECK(dc)) {
         tcg_gen_andi_tl(addr, addr, 0xffffffffULL);
-#endif
+    }
 }
 
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
@@ -1327,11 +1328,9 @@ static void do_branch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
@@ -1367,11 +1366,9 @@ static void do_fbranch(DisasContext *dc, int32_t offset, uint32_t insn, int cc)
     unsigned int cond = GET_FIELD(insn, 3, 6), a = (insn & (1 << 29));
     target_ulong target = dc->pc + offset;
 
-#ifdef TARGET_SPARC64
     if (unlikely(AM_CHECK(dc))) {
         target &= 0xffffffffULL;
     }
-#endif
     if (cond == 0x0) {
         /* unconditional not taken */
         if (a) {
-- 
2.34.1


