Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24D7409A5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLs-0003MB-Rj; Wed, 28 Jun 2023 03:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLc-00035J-BO
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLZ-0005K4-CB
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e68e99c7so5089766f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936331; x=1690528331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3UT1KaeZvhJccSr3A8+yE+k4cSqwLvN8sfpwbOlRn8=;
 b=YwUa5DvgSOhPUaagZhoANWETkLoeK+cZoHztLzJa2o045xxmiTvGQ7SC7LNmaaND6D
 nQQisFNh5tDl1VTL7rouEladkYCxQKS77Qqhsnok9bw+Saote1Z1jUvB/gdaw518ZwSs
 h33gUQbYhCsYkP4mappyxZ3E1ymJ8tfW43JNX5yhT73js1q6YCK+56MUwuR5NetiYPtH
 pSEWwo+5ZN+AqapG0P9RcfqTCCdMuOuUgx0GPX3V1YsarVz0NBoOCgAz6ZzC00QtEpAP
 OBWgn2QwfZRx8Idr6g39zlq/UQV/ZaPk3iUem1R39MOrtnSg2EDt0g8a9QfOsD0s9NYb
 KKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936331; x=1690528331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3UT1KaeZvhJccSr3A8+yE+k4cSqwLvN8sfpwbOlRn8=;
 b=MpxPSx0VmLAT42XBJesGwZVbk3mpNvgxu0GtEQou8MxtTpJs9bAscWU7EutREJwzAq
 p95oTWv6P4afgKDSQ/6pMsTW1s/4W6BCD+UdjkW2b1cTunJmbwJzryGbHDmObuKvAQB9
 wksC7uz33Xu5i/mCRJCJzLP+rGivc8QS8AlYwdrKQ+gPXc9hdgwIFsRFHVrulQ7y5Qq3
 SxFWbLP/0tL+tsgLM83Ojm3gl2TlXVQ9+ExW8RpMuU8xDkL/9lzUQ1E7uQGomdYtSGF4
 dh8K23FN8/xcgtgcUwOU//zOmBKxOX98LucMU8EzLiL5VdGKbIJo5WNGIIm7LPSMKU8l
 NBDw==
X-Gm-Message-State: AC+VfDyRrjUy5mdEGSHTSSSBqcrTaHN0EW/9AfNfNtN2uQIQ1Vlto4Wf
 LJtMo/RX/kGpDZVRjvW4K5y4FwrfBRORGcr7RZuF5kQp
X-Google-Smtp-Source: ACHHUZ7hrAqGI/CicHrQVkjUWRHIgnPKuiDBlGM+QIkBByNfC/Jt37kRvljzlgDdtkst6Ir9Pr72Eg==
X-Received: by 2002:a5d:58f1:0:b0:313:df4b:4156 with SMTP id
 f17-20020a5d58f1000000b00313df4b4156mr9814741wrd.34.1687936330777; 
 Wed, 28 Jun 2023 00:12:10 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 8/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9
 WRASI
Date: Wed, 28 Jun 2023 09:12:02 +0200
Message-Id: <20230628071202.230991-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9148e33283..bd877a5e4a 100644
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


