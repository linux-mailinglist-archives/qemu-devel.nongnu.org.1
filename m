Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF567409A3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:13:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPLr-0003H4-Hr; Wed, 28 Jun 2023 03:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLZ-000358-Jg
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEPLW-0005JZ-P1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:12:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fba64d9296so16738555e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687936329; x=1690528329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+S50E060p2wRKa6d7oX/BgtDJRjqc9miMeLpdV3uig=;
 b=zkmsGb0X7l0Dj8Fhgc6CO4g56Rf4e/fdUIv5q1QgVGdaBq+zSWYnrT2Fx6go6+w+K/
 TNDVFxdzOnXPWTzPDBvCA2kge6aHWXjeO4RzIrxY0Vl7dU3NHBIYVK/wdfpqaoRsAVXV
 mSkBsFoJlmTUDu0HkAm6TJWw5IKFwp7eHJ4xEtccbOzaxPBB926whPQGdHzVac7NvajT
 AbmHB9+iUbo9UHqqTBt4eIrR/ge2XLnTkhoFZyOLlKPx/4XEcYN32gnqb8z6xQ8OvMTO
 hesuaZ/vgiONoUaFL1eYHhM45qPTx8BIyVT54CEDPF3S90bd5kfjsy48l3tT7HnXdrDu
 axdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687936329; x=1690528329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+S50E060p2wRKa6d7oX/BgtDJRjqc9miMeLpdV3uig=;
 b=In2h0EC3gae4ERg47GRLxDwS+0aA3qGvhRjY3FOHspY1KKIHdCvBB/yVwN2+31r97r
 bZb4Pmxh/KhB7vRFE50UiMx/DHg7auT01R5VM08p6ACtPia5/eQ/kvD2AOlcGWJ/TVKf
 GmS0nK308pn48wP+LwVel3PEbuXiros1cBPnL/UDrqXNGRYVPyrWg/Qv1NcVKw1HcEut
 uT/nmrNDVjRJTry6gVox0VMT5fUBMNy0ISnosRTT7mlZns1eshHLAe14qyytaLhcLCoq
 jzjr0Ph7IHqcxxWeEwPF3MYEHQwOz50P0lFDBIM9v4Ms9ObZT5bbXgH7NaIhyABzCYAr
 0SCg==
X-Gm-Message-State: AC+VfDwRQ9LKQkD/0kGUu8+yfCFEmBnYIVFfzAsX6HHFDQoCCB4kBdlL
 TXztroMdmsYyP0a+i9AQOxvPG+pJwBuSsWEkyLjEcnu1
X-Google-Smtp-Source: ACHHUZ7pVB24lJBIiIDI2+zX/79eBzPK2tOvGD+LODayRiPIBIgRolog/qngC6dtgxJozbzKKvf5dw==
X-Received: by 2002:a05:6000:50a:b0:313:eeb3:c57a with SMTP id
 a10-20020a056000050a00b00313eeb3c57amr6839341wrf.15.1687936329416; 
 Wed, 28 Jun 2023 00:12:09 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm4908667wrv.107.2023.06.28.00.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 00:12:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 6/8] target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
Date: Wed, 28 Jun 2023 09:12:00 +0200
Message-Id: <20230628071202.230991-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
References: <20230628071202.230991-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

This is for a plain indirect branch with no other side effects.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d7b569d910..17afe98523 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5058,7 +5058,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         gen_check_align(cpu_tmp0, 3);
                         gen_address_mask(dc, cpu_tmp0);
                         tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC;
+                        dc->npc = DYNAMIC_PC_LOOKUP;
                     }
                     goto jmp_insn;
 #if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
-- 
2.34.1


