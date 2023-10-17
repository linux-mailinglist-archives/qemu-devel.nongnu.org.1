Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85077CBBA1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdls-0007w3-Rr; Tue, 17 Oct 2023 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlc-0007tO-MQ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:27 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdla-0001rq-TF
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ab94fc098cso2001265a12.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524879; x=1698129679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+j4/EgNAa/NSiAxA0YoYGZzoI883LNmh9QZ4XGFq4U=;
 b=vePgWRbdLlMyYOSLY5SqD/YCi4ee6WtBQjo0xRtp6u6CPHaFw4MP48MbjObT9EoLLM
 au23WUVQVfIVixA416pujNCTPiKnVYrFMnp30bRtqgCmql1I11OEHXRYxgt0j61oocQi
 jGWAqDlxrocKrqSW6n0LN5akSD/0yNFb/IXZD0UmqcrEt52HUmJkSHC+2HVYxIITTXZ5
 eD04ngFO4M0mFfwKvVkLcUFawIjoPD8hODPAH6bWVZVCzYLHHgoxHjOJSCydRFA8pszr
 qI7wUZbY05VK0wpUxmr8oL2RIynQN8L6r8YQfPFU01mvgkTUHqGKWqca3ZDwQ/ryClDR
 HpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524879; x=1698129679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+j4/EgNAa/NSiAxA0YoYGZzoI883LNmh9QZ4XGFq4U=;
 b=GVxvFuTiLVqPrHN/FJ+6m8dMcFuKesM59dDk9o4PMdLulNGuNIEpXryNNcjrNSlN1T
 E6e9xUZ+m1bORlWenzaY5aWaRZBfIQXatv0C7A+KVLEJITjq25zpzfSH3gncWRdW45Ya
 aPeJ5aBWmWoj2iqpkuj0i238eh9d9g8YjR4k2bqZys2mCoPeILQx24Kj5mpJrsfYqog5
 3Bj9fTEWWnFWhi52gC8EpSKPRJQmat/kasEpyOuArSVFtLj3gQKRDX6oF6C/XRJQuCSE
 xlgbuMkShOH4ynk/hzHCL6kwVUBs7PqVGIFyAzfjaM8LGm8zSMwxJsZi1YUS3DHwv/ae
 RTOg==
X-Gm-Message-State: AOJu0Yy1q2uA63DO1OEAXS2X0SvOKW8QjTnNzrN5akSxMws45ygg9z17
 eVHHApZjCGg1/1oiQTXMg0yjM3OVYlnIef/XkF4=
X-Google-Smtp-Source: AGHT+IHtlH3dKG/0uWR5t7DkdZwgl+X8DCS1xgJGK/5DQ1VmgrJnpEQXQf2Ij5+5N3YsSxQwpZrreA==
X-Received: by 2002:a05:6a20:2593:b0:14d:5580:8ff0 with SMTP id
 k19-20020a056a20259300b0014d55808ff0mr1267974pzd.25.1697524879642; 
 Mon, 16 Oct 2023 23:41:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/20] target/sparc: Do flush_cond in advance_jump_cond
Date: Mon, 16 Oct 2023 23:41:01 -0700
Message-Id: <20231017064109.681935-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Do this here instead of in each caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a75f75dfb9..74a0972bda 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2317,6 +2317,8 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
 {
     target_ulong npc = dc->npc;
 
+    flush_cond(dc);
+
     if (annul) {
         TCGLabel *l1 = gen_new_label();
 
@@ -2392,8 +2394,6 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_compare(&cmp, a->cc, a->cond, dc);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2419,8 +2419,6 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_fcompare(&cmp, a->cc, a->cond);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2446,8 +2444,6 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
         target &= 0xffffffffULL;
     }
 
-    flush_cond(dc);
-
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
     return advance_jump_cond(dc, &cmp, a->a, target);
 }
-- 
2.34.1


