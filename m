Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D25821645
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3s-0003uR-3c; Mon, 01 Jan 2024 20:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3n-0003mQ-Hh
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:16 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3l-00076K-2f
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:59:14 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6da16ec9be4so2960039b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160752; x=1704765552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=va71e7xBlqUEdFqBnPLdQG8F1PWGxU4pyOMI1WZcB6A=;
 b=C6ST8qIzbaU42A9lEtS7ekxef0XwDsuruGRnmCpEB0JjOgKDeNkSaMWiZ57Akwf+4e
 7im0+1R86pa71KK+ism5m4vu8juewvFB/d9qrxPtRjSrBKUct5PyUpk1Jjm0oYA6RbCV
 Ii/NcEaC9WRYT1LTjUHd4oZLF9+OqSwMmPvOXEH+f9qLV9DaBxhvi7ZpGlSx0sFZv555
 Vcyh2pxt5wx6Yw6iWXlmRb8rhTSCzThAgvZ97dCvPi+reRR9kQNORtc0K7hn8SvM5C9c
 rWGU8JQXpwwlyQamBuNl08kwsYTE1IUF2Yo1nrd7y4EdobMc502WUxbHrUJmZAoYiMcb
 2jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160752; x=1704765552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=va71e7xBlqUEdFqBnPLdQG8F1PWGxU4pyOMI1WZcB6A=;
 b=qC+uwnpxE8I3eemnOM//osKQ067qzp3/MVa+3CvOs42vHwO8PHE71Ek6hRkBXje+4Y
 fzkM6w/2m/eWWdcqJHzVxeoYdoGcya3Y6TaLnyri4NSCYzZ2tp/NeMDsc+NsnFVZTyck
 LJZT8ddrLX8UA0a/0IU7rZk6SyAyrcF89geY3HmLwDBw8SbOttpS0VL9n+hzJpMERW7m
 Nl0KTYN52JsyUppbhgVeed4xS2oBdOCWlde6c3Xl8VpZh69Rwe2niYC2wRi3ENSqoK2n
 6DW/ke9x9r+vpdyxHFGZJXYJOADqFndoH1bY+aAy/HavjQIKIpShmY7+g7DDINrxh0GF
 T7Vw==
X-Gm-Message-State: AOJu0YyxKNWOlXP6UzH5ZiHMHbZrKJGjkiqo25SSYr2ZRhb3IXpgXX1b
 +0TDRfjsmeSlN6BChRczKccsVyy8IDcgs4i8YtKE7GQegRE=
X-Google-Smtp-Source: AGHT+IHxOpMw/kFulV8BXv8uvk7dhDlJoeuHsqZInbhZZWiJ7IZzzOrZpVRoSbhvLdeItmPUD7cxjg==
X-Received: by 2002:a62:8455:0:b0:6d9:8f56:106b with SMTP id
 k82-20020a628455000000b006d98f56106bmr14876576pfd.39.1704160751781; 
 Mon, 01 Jan 2024 17:59:11 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:59:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 28/33] accel/tcg: Disconnect TargetPageDataNode from page
 size
Date: Tue,  2 Jan 2024 12:58:03 +1100
Message-Id: <20240102015808.132373-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Dynamically size the node for the runtime target page size.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 69b7429e31..3cac3a78c4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -864,7 +864,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 typedef struct TargetPageDataNode {
     struct rcu_head rcu;
     IntervalTreeNode itree;
-    char data[TPD_PAGES][TARGET_PAGE_DATA_SIZE] __attribute__((aligned));
+    char data[] __attribute__((aligned));
 } TargetPageDataNode;
 
 static IntervalTreeRoot targetdata_root;
@@ -902,7 +902,8 @@ void page_reset_target_data(target_ulong start, target_ulong last)
         n_last = MIN(last, n->last);
         p_len = (n_last + 1 - n_start) >> TARGET_PAGE_BITS;
 
-        memset(t->data[p_ofs], 0, p_len * TARGET_PAGE_DATA_SIZE);
+        memset(t->data + p_ofs * TARGET_PAGE_DATA_SIZE, 0,
+               p_len * TARGET_PAGE_DATA_SIZE);
     }
 }
 
@@ -910,7 +911,7 @@ void *page_get_target_data(target_ulong address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region;
+    target_ulong page, region, p_ofs;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -926,7 +927,8 @@ void *page_get_target_data(target_ulong address)
         mmap_lock();
         n = interval_tree_iter_first(&targetdata_root, page, page);
         if (!n) {
-            t = g_new0(TargetPageDataNode, 1);
+            t = g_malloc0(sizeof(TargetPageDataNode)
+                          + TPD_PAGES * TARGET_PAGE_DATA_SIZE);
             n = &t->itree;
             n->start = region;
             n->last = region | ~TBD_MASK;
@@ -936,7 +938,8 @@ void *page_get_target_data(target_ulong address)
     }
 
     t = container_of(n, TargetPageDataNode, itree);
-    return t->data[(page - region) >> TARGET_PAGE_BITS];
+    p_ofs = (page - region) >> TARGET_PAGE_BITS;
+    return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
 }
 #else
 void page_reset_target_data(target_ulong start, target_ulong last) { }
-- 
2.34.1


