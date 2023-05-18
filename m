Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1D7081CA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6O-0004AU-7B; Thu, 18 May 2023 08:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6C-00048l-Tv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd67-0007vn-Hs
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f4249b7badso20004865e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414269; x=1687006269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3qgQgU0oovp++OASw0Q9fkW/XuF2+8h0xHqcmjtio2o=;
 b=PIY78DRzhDloelyVFdnDXBNoH066+cQQD70srzPuacfQ/BpVgoygWKSHW4xo3uF2r1
 GwRsDlz4ugmcWrjE6KjAfgykQXbyidmmxwJ+Gjst+IFG1fDZEvAzzssIMNn8jRD4iT4o
 Y/uWStgtb4nccBdpXD5FTqafWF54MNfG+O5oaWWAgk230iwNKol9WqJrXJMNLA2OxX0W
 wAZQbMAZM9MhBampIWsbpl04HZ8h4Ii+fId3zvX/JCBxmkWB7WeLNdQTkwo7zCLQpIzG
 S78CciOyW3VK2R+B4iwyX5m+uHGzmfZm3QNkcijkgSribOgUapeSokiZ47Erux7Gsjiw
 Umrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414269; x=1687006269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qgQgU0oovp++OASw0Q9fkW/XuF2+8h0xHqcmjtio2o=;
 b=Ypy867hss6S8m2jz6xs7PLKWmkDNXCrOmoU0GzMx3LV6NG9Vau4+FfDe/Sa10xhwEC
 SDbA38zsAuG29rgsSSBQUkcGIR1UrBGHKkhusTc6+D4GzEFHDvvpnie8vtKhXIn2Eyk5
 S43EJGg/Pkhc7iO7kgI/Om+vXzr/6KjQiEJ1JHj2RZ+myLKJurxkUjzG0R0edZflSAdN
 zY2BJe9F78W08TfXITh49y9jVdlm+1X0rSu34tT8p0577JLWCFa+FSmjcy+DcAf1IbHt
 2JdMx801WBqDMXELCakSO3GKtv+sRbJNJqizlP7rWpciOcXTu2OhYPUgi58Jo+Am6E32
 LgJA==
X-Gm-Message-State: AC+VfDzHkWvy32PsOgVOasQEab+ayNQTXWnJYnfTJIhW7sYA0/gwaIel
 zruzyegB/a+1KjxYSgDeg62+26MtU3k8APMThr8=
X-Google-Smtp-Source: ACHHUZ5wfLoreon7OriuyIdjTvadvW/fpNDugCBGEDTE2ay0YP8nZZyiR0BYVhag5PeAgUEDH+pDVA==
X-Received: by 2002:a05:600c:ad9:b0:3f4:21ff:b91f with SMTP id
 c25-20020a05600c0ad900b003f421ffb91fmr1416245wmr.28.1684414269574; 
 Thu, 18 May 2023 05:51:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/29] target/arm: Fix vd == vm overlap in sve_ldff1_z
Date: Thu, 18 May 2023 13:50:40 +0100
Message-Id: <20230518125107.146421-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

If vd == vm, copy vm to scratch, so that we can pre-zero
the output and still access the gather indicies.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1612
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230504104232.1877774-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ccf5e5beca2..0097522470e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6727,6 +6727,7 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
     intptr_t reg_off;
     SVEHostPage info;
     target_ulong addr, in_page;
+    ARMVectorReg scratch;
 
     /* Skip to the first true predicate.  */
     reg_off = find_next_active(vg, 0, reg_max, esz);
@@ -6736,6 +6737,11 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
         return;
     }
 
+    /* Protect against overlap between vd and vm. */
+    if (unlikely(vd == vm)) {
+        vm = memcpy(&scratch, vm, reg_max);
+    }
+
     /*
      * Probe the first element, allowing faults.
      */
-- 
2.34.1


