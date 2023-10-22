Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D8A7D2707
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtH-000766-Fk; Sun, 22 Oct 2023 19:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtC-00075X-Iz
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:46 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht3-0006gG-P0
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:45 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso1641873eaf.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017375; x=1698622175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJ6RCYZtqS9hM9/RkJUGxHsAy/nMvqiERtpBq5MiRjQ=;
 b=OH8rUh1ClYJuLUbU+LRh0hH66dklX5bibvgqkUs17l1QeJmkgrUVkW88v4xQqM6NQt
 963IR04hNLAwXppyOc+0MHVFuzYJgWtDflFSZlY3FyZ6R5KqkDPSq2XROczzY1zMXpTZ
 3MEWaKQwIoN4kaKjMa0DedfU64hWXdBU7pVvMqwmJvXxi3/0sWXYGDcLym27Wjcvabh2
 BLjwniQSnk6qCqc6kIbBJCwRZ4mU7o2sYHvWSRIFPgI/szQu7jOOW7x05XDMwKAh17fk
 aOGn8f5/nDjIX/qGDUDwtyQ+AehdCemDVaK9JKKCowki983nCowVPfuL8enl4jsRsMSy
 Vtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017375; x=1698622175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJ6RCYZtqS9hM9/RkJUGxHsAy/nMvqiERtpBq5MiRjQ=;
 b=v9yjbbI14hxybMAURM22MupkXjjDSXhZDl4pICBq2qvAEYN0SBLGew25dYt6fiH1BC
 fSARqPMDjMGjdf+prQoiTF9MYPPOdtVmHjB6ZD+Q/DTy8u9VoX183rJLc5Kn810J28HH
 SFNAgZTjHx3EBsRqHKRTT365yjGP8zMiKaD+N9HyHjK+1MOdtE9/ZK/xJP0m4D9+5K6J
 jEpvfRTdS65cnBSWMFyhdPXmhPwLUBpHa2U8yOfZdTnnW0pc8Ejvkif0x61zzItl6uUO
 scRVh4IJ4SbIa0Sl8iJ49BmLzl6eXv3rMTvtJymwE2TmkZOjts8PLLy5f4lqnDic8597
 gBdw==
X-Gm-Message-State: AOJu0Yy/bXKkOPjK2xLqJJ1LKx4FklbF2mHwGm2pIuugdQLEfuSWJ1g4
 6Ksn/gV55YBGf712gRx9D3N2Yzj+e7bhrX8GY5U=
X-Google-Smtp-Source: AGHT+IGFdDQbpaW/GV9XNnzYLmeQUz7lyu8IInKnYj7NNbo0wbdNzwodF0WtoIumlSg0NVqjkbzWuA==
X-Received: by 2002:a05:6871:459b:b0:1e9:de31:8000 with SMTP id
 nl27-20020a056871459b00b001e9de318000mr10717807oab.9.1698017375040; 
 Sun, 22 Oct 2023 16:29:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	qemu-stable@nongnu.org
Subject: [PATCH v5 01/94] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Sun, 22 Oct 2023 16:27:59 -0700
Message-Id: <20231022232932.80507-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

With pairs of jmp+rett, pc == DYNAMIC_PC_LOOKUP and
npc == DYNAMIC_PC.  Make sure that we exit for interrupts.

Cc: qemu-stable@nongnu.org
Fixes: 633c42834c7 ("target/sparc: Introduce DYNAMIC_PC_LOOKUP")
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..8fabed28fd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5654,10 +5654,10 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
 
+        may_lookup = true;
         if (dc->pc & 3) {
             switch (dc->pc) {
             case DYNAMIC_PC_LOOKUP:
-                may_lookup = true;
                 break;
             case DYNAMIC_PC:
                 may_lookup = false;
@@ -5667,10 +5667,24 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             }
         } else {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-            may_lookup = true;
         }
 
-        save_npc(dc);
+        if (dc->npc & 3) {
+            switch (dc->npc) {
+            case JUMP_PC:
+                gen_generic_branch(dc);
+                break;
+            case DYNAMIC_PC:
+                may_lookup = false;
+                break;
+            case DYNAMIC_PC_LOOKUP:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_gen_movi_tl(cpu_npc, dc->npc);
+        }
         if (may_lookup) {
             tcg_gen_lookup_and_goto_ptr();
         } else {
-- 
2.34.1


