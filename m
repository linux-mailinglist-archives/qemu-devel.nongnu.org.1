Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5055738E30
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:08:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dn-0000If-0M; Wed, 21 Jun 2023 14:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dk-0000Hk-Lq
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dj-000763-4T
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a426e4f4bso7438591a12.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370778; x=1689962778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIcLXVZ1P4eESfDPnK8hdQxHboll0WqA+NOgMyREFDE=;
 b=MQxifKFsRidFX5VzOFd6bl/r8fvNcAn7m2u+zgqtkCU9Xzu1GnIezqqSR+E9x/K1G9
 pEILnq4Diq6XWkc9cocGXvRGIk1BBAn1YoCkivboDZ9kB9QTAQk0bA6l76/0t6wtGtsM
 k3ltu+VZWDP4Gj56NgrjI27uyTUbTvXq0lmb6hxzw1NwACRQkQm6rVFQrQ138HSfkWA4
 XDt0JRbFQbc9AKUWHCfj0bGoLeaLmoDJvVuXcL/Bf4wG8NTROODN8UdvY2TsPSPVwVBb
 bkwJ9pirw/PLPLuAt5uU11lP21Y0k3jlLlLw+CVcy7LG42bp7rCnS/RVCwR7SLw4i5FG
 KMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370778; x=1689962778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIcLXVZ1P4eESfDPnK8hdQxHboll0WqA+NOgMyREFDE=;
 b=JJhfcOofNQyW79zvJhJ15KFaep3gdMoaIS4szCpTeQ7x0cOQIDUhFAjcjlA9bH9rig
 yDgTXlDvXJNLfeyCSkZ0T3DexzIEz6VkvjLQNJ4g0KyF74B/N/mslKvZarrQJdH1ahUi
 NxYpMvKHE02xctP94r/LKI3kAxYgSP+YLNBAziVzpa+ZzWC1cSkY3dPkZ4pM94SO8b++
 4G3RKMNdXIAgKDFhydF2rR8kFiK1pJnz33A+hfq6HLpeiDdlkP2cqBVGE9qbw3dhMxjb
 K7mmIGinEcOlqR2EgsQykbpeANt9DonUuacgfAilSViojj4l03n0puq+VcegD9+1hvnW
 eA/w==
X-Gm-Message-State: AC+VfDyEkhSgNKq+mYYfbM5CBmaI4lVKehtkJ6FK7MnaJoROx3dq3hOl
 DWQlacGb++vL1BLydDnz0XTyFvEnKPvoLnjAY2KOYJh9
X-Google-Smtp-Source: ACHHUZ6dDsPPBeXSg293o98jTuIbUOM9vIOU6nDNZWxN9gV96Y6Ow9fEXNCQBiHkua2djfXXq8DjwA==
X-Received: by 2002:aa7:d743:0:b0:51a:532a:a81 with SMTP id
 a3-20020aa7d743000000b0051a532a0a81mr7168418eds.21.1687370777862; 
 Wed, 21 Jun 2023 11:06:17 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 8/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9
 WRASI
Date: Wed, 21 Jun 2023 20:06:07 +0200
Message-Id: <20230621180607.1516336-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52a.google.com
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

We incorporate %asi into tb->flags so that we may generate
inline code for the many ASIs for which it is easy to do so.
Setting %asi is common for e.g. memcpy and memset performing
block copy and clear, so it is worth noticing this case.

We must end the TB but do not need to return to the main loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ab7054d4eb..fcc1054943 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4147,10 +4147,14 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 tcg_gen_andi_tl(cpu_tmp0, cpu_tmp0, 0xff);
                                 tcg_gen_st32_tl(cpu_tmp0, cpu_env,
                                                 offsetof(CPUSPARCState, asi));
-                                /* End TB to notice changed ASI.  */
+                                /*
+                                 * End TB to notice changed ASI.
+                                 * TODO: Could notice src1 = %g0 and IS_IMM,
+                                 * update DisasContext and not exit the TB.
+                                 */
                                 save_state(dc);
                                 gen_op_next_insn();
-                                tcg_gen_exit_tb(NULL, 0);
+                                tcg_gen_lookup_and_goto_ptr();
                                 dc->base.is_jmp = DISAS_NORETURN;
                                 break;
                             case 0x6: /* V9 wrfprs */
-- 
2.34.1


