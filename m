Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8457B70FB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAs-00084m-W8; Tue, 03 Oct 2023 14:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAp-00082c-6g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0001fC-Hk
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c3d6d88231so9724895ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357866; x=1696962666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBgYnkG/UUhR0Bh5p/v3uxe98ghyIsuRr/l/CO8AZ6c=;
 b=u9lLVIA4NclPLI3sHPa5yioF0FdxTGF2iPhDNXAL53dwo+mexG2nqkO6kSbIEuIqjc
 CfKJvpFighYNMgBvDXLP2mYOOVWeGotg53KLYhAcpOrnJZDXKdvvNejSEOQso12RhT59
 8cITiY7JeFVfHX/tl4ovZSUbW8wtV+AmdMBRycGTMsHDKP+h+ayWN7J0lM7lUjTxK4Q9
 Pgh6lXOmb8MhQjl3YCAG/gE6hu4gT0L7+LFstOcAPpGIZBp6FUOsevzFQq2XyXol/dJO
 09xQYktTilCcO4AzJMpWdqr0EqiSJLdw4PuEc3XVNz3idJGWiLFnhdVNURYftYj0bWq9
 W9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357866; x=1696962666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HBgYnkG/UUhR0Bh5p/v3uxe98ghyIsuRr/l/CO8AZ6c=;
 b=Iad87YVqdIJZO4X5CLSJZ9zWPldjR1Su3r+fUK/48TX+eZZ7hbRJPHCaeJ9wYFBx5E
 /105B3TUbkyL+5V0QSvTaE14ldD0jreY+GrXXwLgGRfechBw6F6C2UEwfYn26NZJw4U+
 CMda+tG6d0PjxrN1Mt6EWhP+tEiGQztkRd5+nRpvTd0wPF0rcnQEfHpAstkQG9wLFnKp
 3qmhJuudqRIQITv8XC5NQqhLJ5oQcsIezyyzjmsn4Tp6hKQzba31k6v338iauzwXR6n/
 mDHiODw0XELveuBU8cA1ZTjYSoVCPjCN9iPCorCMJyaCxVNfwC5S27ek0rAHsOggaHL4
 OIFA==
X-Gm-Message-State: AOJu0Yz6nDQmuUmGJ4t1tukhu2pTb6LgCtbSfvP/LI7hmZKnimScV73A
 YHiZIGXM8Z68miEvN7mnnXsWbMHWWGkJxU9BBos=
X-Google-Smtp-Source: AGHT+IFR+FhL++KRvXvi5N7VXVBkOBgy00GhyE/1E7TwAXxc4cKCX1J1fGHyh6uiBDTvdZQs5aAVXg==
X-Received: by 2002:a17:902:bc4b:b0:1bf:728:745b with SMTP id
 t11-20020a170902bc4b00b001bf0728745bmr332700plz.49.1696357866237; 
 Tue, 03 Oct 2023 11:31:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v17 07/16] accel/tcg: Collect TB jit statistics
Date: Tue,  3 Oct 2023 11:30:49 -0700
Message-Id: <20231003183058.1639121-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Collect items like input and output code size, guest instruction count,
intermediate ops, spills, etc.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Fei Wu <fei2.wu@intel.com>
[rth: Consolidated at the end of translation.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 6e64ae2dbe..ad4538f169 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -557,6 +557,27 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         return tb;
     }
 
+    /* Record JIT statistics, if required. */
+    if (unlikely(tb_stats_enabled & TB_STATS_JIT)) {
+        TBStatistics *s = tb->tb_stats;
+        if (s) {
+            s->code.num_tcg_ops += tcg_ctx->orig_nb_ops;
+            s->code.num_tcg_ops_opt += tcg_ctx->nb_ops;
+            s->code.temps += tcg_ctx->nb_temps;
+            s->code.deleted_ops += tcg_ctx->nb_deleted_ops;
+            s->code.spills += tcg_ctx->nb_spills;
+
+            s->code.num_guest_inst += tb->icount;
+            s->code.in_len += tb->size;
+            s->code.out_len += tb->tc.size;
+            s->code.search_out_len += search_size;
+            s->translations.total += 1;
+            if (tb_page_addr1(tb) != -1) {
+                s->translations.spanning += 1;
+            }
+        }
+    }
+
     /*
      * Insert TB into the corresponding region tree before publishing it
      * through QHT. Otherwise rewinding happened in the TB might fail to
-- 
2.34.1


