Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70720A150F6
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 14:54:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm8-0002Xp-Px; Fri, 17 Jan 2025 08:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlu-0002U3-3W
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:26 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003l9-63
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:25 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso358460566b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121941; x=1737726741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRiHhaLYBl4Bm0h1nKMlemFfl5RZURyn+9H5B+rbcjY=;
 b=dR1vsnJksfrQFFEocKj3D7Lge1afFj46fFtF4NaPbRLOuIdghv+a/mMEwOYpeGTGfs
 +UArTt7EHBNFAPGLOkk7B8joC4b/wsjA89xU5OJZaoKDvEUtqkI+upkbwag35s+TQK6B
 mSKtv8GDDZH+iQXGV6IG9mPgXoCfjRb5B2BThVtNfpD+j47s32khYa5GTObtz4n1KpGH
 ULcxyg8cQ+0XR2EXau1SFij5blM/q0Rq6yTEW/8HhTJ0kJdvh9wH9nzTKoZAF14OAoK6
 nQyRGUHk39qceknFAPoY8J4FHoWpGEgf+9PBaxtqImaxnuvcinjUF7ne1O7QFqnvvl2X
 /QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121941; x=1737726741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HRiHhaLYBl4Bm0h1nKMlemFfl5RZURyn+9H5B+rbcjY=;
 b=Or4imgKsp2K8bGgCabnXe5JW5H/9GJOsiP0JS+vmP5Y2jzChS5WUhiHDnIqgtgI/8L
 LVvNT4gXmhdZHj06FUtfn+FekzKUgV8ptcxUGbFBpujMwAhsCq/dhGjMMyk2Yieq3EzI
 uPmBzBdlpM7tQl22FeS0IySrHc0Q8k81vhgJJzNljmkp7oV+irbtDcrncR9DCNtMnDVO
 mjgJRhge1trmTxtUWUM9gdTcnnpH+qPYMWVf72iVWhv0VWd27EWDgI9+7GZMgucDiRl9
 PcoFYtL8TvXzqaYYOuEI+712Y3ZsWuau4O8MX7snan2PWYRyHsiejOiVeb2c8dp9ImTM
 aq+Q==
X-Gm-Message-State: AOJu0YxG+eO/Qs1sWVtglK+mHzr6YQ5JJufC6vhx5C+glnY1mrU2R7xy
 REbMzfQNhYr5iE+KNwDWVS9cOeVmzf9ndCN7oz/mjN97hVrtfcRTYtmIAo8kWcQ=
X-Gm-Gg: ASbGncuKWB914mTQh8E3GdRIzHYNtiXNZElvqyGJZu2oY0NCwDer53lv95bNdxUHPdw
 ewl7NOq359Hy39OhzYNw7W3Du4pNb3ZyagsSWdredxp5S2PUCWH6F8CUgRI+Ru/r2HbP/cgZmul
 YoLV7brA+ILxXMTH76KOL/UtRxFHEWXVEYmGzwssGl9cFDra+1BHgXZxVOWvWTySDreGrUDNBzs
 AwyUvxAWwVOepXavWP+xBpjeCdJqXDiP+HU3+T7aL59cHNwsE8WKQ8=
X-Google-Smtp-Source: AGHT+IGBU2gZj62OooOyL2LwKKAxLzoLbRxHfdnv1hsAyXd4xpeAGw5ysRTw7wB9KO0geXRYWBNmkw==
X-Received: by 2002:a17:907:9408:b0:aa6:a87e:f2e1 with SMTP id
 a640c23a62f3a-ab38b4b96d0mr265629666b.56.1737121940714; 
 Fri, 17 Jan 2025 05:52:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f8afddsm172613766b.156.2025.01.17.05.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C78AB60853;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 20/37] contrib/plugins/hotpages: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:39 +0000
Message-Id: <20250117134256.2079356-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-11-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-21-alex.bennee@linaro.org>

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c7..c6e6493719 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


