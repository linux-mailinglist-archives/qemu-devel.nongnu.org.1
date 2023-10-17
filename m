Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7027CBB06
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNp-0003Ru-SB; Tue, 17 Oct 2023 02:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNV-0002oI-4B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:30 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNS-0004gZ-Aj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:28 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6c6504c9ac5so3712008a34.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523385; x=1698128185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VRWKpUsXoRjx6DL0w+41fc0NNohJYrIqmxDkszKvZ8=;
 b=YSHcoL+jlqCf7TFXd6UmzlmRkhdOyVxMlTID9b+Dlq1ZtU9g7370Pzb6fY/87R1Ur7
 tXpvWiBv+0BlQ8BUfEqIPqnodMb6xrG16Z4u0n6U4QUNf4GZIS1UINHoVBRc0dHVhVjA
 xPelHnA9mI/V80Yt/fjOZuKrnhvbMAyUzFPivOC6+uooXyyE4Wwly9g+KrbttTbry+Ub
 7eOcMTgxOonY1V+0jIjfOW+zaFag9SiA4ubfkzM09Xm3tzLr+wrHaNYg5sy00cz7fO2p
 Lef3MmCjJq5IMIPM70CRTdhz+k4MIjttte2k/iID7mKI+CneDMcfLqpjBP0jJ1/9mv14
 YIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523385; x=1698128185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VRWKpUsXoRjx6DL0w+41fc0NNohJYrIqmxDkszKvZ8=;
 b=CoPAZ9SNonhOXXgNR6TI/ZN1UQDs3EfiIWR3RTRcOE/6yY7AkfHYZb0vBwTQJvMSFJ
 taOEDxZwGNb87y1slafmXdisRlXGuNFSUV3pAhKKuVE+zKdcUq+u5WeaKAUzaJCAnOiG
 4kxMfmelc3d1+PJIblpKa6roPMXdwrxB9PnbOQyTgGXXaqIOYq5PhlbtNUJ5rmwIp5vu
 4Rzyes7OuexEFuqC8BbJhu3am66mwisKmoddPjRjphVPapfQzocqKfT8cTAjZfCnV7h9
 qwyKNxak2AqogUc63WrulP2XJZkG2re4M35yjb9xKzR27sq5ezAddcnLa7tvTChXINuk
 6Qhw==
X-Gm-Message-State: AOJu0YwPIq7DNAJ1alh9HD3tkpI4b9IObXotHWspBerkNeUA2a3xXujh
 hA8ZVn3wVfxtBT+HiQz7CXfYoO2drNtEQ7JfArg=
X-Google-Smtp-Source: AGHT+IFLotT38jh6iaPo9Nmikrwww2wbkvNvvRmQjRZyh6BDWp47ZNw5h8UyyMshRb8sqKkKM6hx2w==
X-Received: by 2002:a9d:6d9a:0:b0:6b8:807b:b50 with SMTP id
 x26-20020a9d6d9a000000b006b8807b0b50mr1469061otp.22.1697523385133; 
 Mon, 16 Oct 2023 23:16:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 47/90] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Mon, 16 Oct 2023 23:12:01 -0700
Message-Id: <20231017061244.681584-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Perform one atomic 16-byte operation.
The atomicity is required for the LDTXA instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 48 +++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eed0fbadf9..16b024fab7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2537,11 +2537,27 @@ static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         return;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_ld_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            tcg_gen_qemu_ld_i128(t, addr, da->mem_idx, mop);
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE load, so must swap
+             * the order of the writebacks.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_extr_i128_i64(lo, hi, t);
+            } else {
+                tcg_gen_extr_i128_i64(hi, lo, t);
+            }
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
@@ -2606,11 +2622,27 @@ static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         break;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_st_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE store, so must swap
+             * the order of the construction.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_concat_i64_i128(t, lo, hi);
+            } else {
+                tcg_gen_concat_i64_i128(t, hi, lo);
+            }
+            tcg_gen_qemu_st_i128(t, addr, da->mem_idx, mop);
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
-- 
2.34.1


