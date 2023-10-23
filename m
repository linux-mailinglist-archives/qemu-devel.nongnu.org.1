Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDD47D3EBE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRR-00068B-TR; Mon, 23 Oct 2023 14:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR7-0005ck-W3
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR4-0008Gg-Ao
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so2785623b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084833; x=1698689633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qq+/ocKlHxuwOLYzAnqcUyLG835LUOMki3n0K/cpOvs=;
 b=bsCcC0Sxvck583GAqCPuD772Xa9MTtQkm82jMrnyZweJyohV+oCmLuAApqA22vNwdM
 +hP6K61Dc+WXh9aHDYOXv4KeUFKOgw2F1UhmZu9ZrhmN5RYZ38trFEvJwS4laqriVjJV
 XsbjvJVsW/O9UC1d7lCqtByzUFoWLt0hX5c2JCAwFHVD3V6BATC5fFI021dcKorTfGJ4
 N/hOSvdhI3w1v0OjTYHWw+vrSkgBrzvXQ7NyNU4jEc7n5osjeScluaYQS9ZE/PVdQlrO
 eviTalKJ4mKHflhMqisYDY8r3rumSswB28KNSVhQFGuRFsWdZti0acjoCNG0mnv83+k/
 DykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084833; x=1698689633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qq+/ocKlHxuwOLYzAnqcUyLG835LUOMki3n0K/cpOvs=;
 b=nKYo7NeX0lDG2He6R0KLuqbapYCHPgVamzPhTMLTC6sFiX2JN0ZPH3dIpdhetfcchw
 2P72egwF+2/6tqXghtu1f5KGltq5j+uT5xPsCDZZ0z8TfE3uET4Ijhmv9w/nGFfZ85NQ
 lMS2tr0WADOKlRV76jqjv6uhR8BQAWGgU3ZRwsPDd2IKSzaiSiXtKgqfV3BqipDvJxcO
 H7aSYkvJHFE30hF3yavOoY6aRXtQpvOGaNMB8Hn67I1g8dXSyYYPJzR18n/VU0BOMnGP
 QN2re2fTYKLOQ6RgqDM1Od20Hh2kpnBVq5+A8KrFVeGg4QYtwXCvr+cMWwZSv10h/aNv
 nLPA==
X-Gm-Message-State: AOJu0YyL6m0R80I3k6aa8UYDRJT40+QxOUc0LKunwuSKbN3H9AAG/Y5r
 9W+25B2OGY9JPTm3AbMV/Hokyqyn2gL+PGQ5SwI=
X-Google-Smtp-Source: AGHT+IFefyQgv60OhoeVKFWEACFf/3/Rxu7G4QmTGsLgkNwlYpY7PSH5Y/3V3CgeQSRT5fgy0jECLQ==
X-Received: by 2002:a05:6a21:3d85:b0:16b:d853:90be with SMTP id
 bj5-20020a056a213d8500b0016bd85390bemr386550pzc.25.1698084832813; 
 Mon, 23 Oct 2023 11:13:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mike Frysinger <vapier@gentoo.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 25/38] tcg: drop unused tcg_temp_free define
Date: Mon, 23 Oct 2023 11:13:16 -0700
Message-Id: <20231023181329.171490-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Mike Frysinger <vapier@gentoo.org>

Use of the API was removed a while back, but the define wasn't.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231015010046.16020-1-vapier@gentoo.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 80cfcf8104..3ead59e459 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -52,7 +52,6 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
 typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
-#define tcg_temp_free tcg_temp_free_i32
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
@@ -60,7 +59,6 @@ typedef TCGv_i32 TCGv;
 typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
-#define tcg_temp_free tcg_temp_free_i64
 #define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
-- 
2.34.1


