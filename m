Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FC6A105B2
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 12:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFv-0005CR-Rl; Tue, 14 Jan 2025 06:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFj-00057d-AB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:35 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFg-0005Qe-H8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:35 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeecbb7309so1009896066b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854711; x=1737459511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=IcvYR/FuUi1yW7WCDOOCnfJwliJcQMahBEDhNasxqI0H+aUe3HsA+VxNkY9nbKIKOh
 FYIpt0SYeVmsjH60sM2AcKud8yq+lDt7/EmsZm7y3dGetQo+jcmIKQAfA43JLgs4Iddx
 AZS+X0GmDlRJd1FX5+V9Zz5pE9kaD9eJAg9/oM8N8/laQQNZySY3UqKJ8Nv7VTXAUiaC
 yXPdIMDfGKX393gy8axDkBy/ktdS4Wg9ENTv92NyayXx8iRyli0MpRSZAeweN2yayQyh
 xAiTJBGQStyJRyzQsY2e71rX1N1QI47NFSfbxQJ7yiPT16CJJU4HOerF/CwDAIszjwYM
 t2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854711; x=1737459511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbdq8PuzmcKgRuOS6aY93DBa464+R41QKxYxX1E5oro=;
 b=gZX2rMsUVeJhHRYeiEYQRxU5iBUfg0PlODcUegtTFzxdhg5i8pMH2nka8iU+b8Y3Ej
 gsr/uxzjcRPDimmui+Gscz607uAsunAbR3XDI8jaC+qskXtNFUsdRMxDUW1++u+JWNfm
 179BDNWVgUraE+uEWEdM6dXUAxSuyn9Z7tlR52MX719sV6Za/O9sLzJRVrsCMJtlBY9O
 RCm5AbLPRN23NOC/seliEC6F+nUaJaT0cJx6Uq7faYjQjaBfU08ri7kqU3kL4gRxl1Wc
 brvtJ+ZE2EwWKRbe1+d9IShjHWIAzO39gipgagALAZ2QyhoVjeBhSpviLmyESvtyyVgl
 il6g==
X-Gm-Message-State: AOJu0Yx+t9CXkhdqDqsBmpLOCIt+NVAVDIsG91+AzJo6GrMWqJM6+4Or
 7+KOHy0OWmfxIwjE/UoFmqj4S+JYg0X5xAqyBTRU3LMT0IZTmgyGNE+POtzukyY=
X-Gm-Gg: ASbGncvw+Nm995xiXOl8zx096kStdVu7AeOtF7oZZGlJmPuksQcPiSm2cLamNBHdicP
 +CfHOtUG2HOlY5J1DS/tp3ceA6znT6WfDIIUofEuyJs+AxRAGaPGQD12BUTmYhSTAlYfiTYSmsM
 qTVNoT8L5mkLmg9SGLuAt8M+pijZK6KyuHjHjNc/WfaPVhAi/A2vSXRK7oMf0/omnhUuyZ2zq4N
 ofcgaLw7WAH9zrwkWRT02ZnMCGasubxINtgbUYTpVOHDE6EHOz8yQ8=
X-Google-Smtp-Source: AGHT+IFvcNUZTjmsP8TbGxrBQwGNABXtfS9IckAQTWuz8uKyBtYL/VkIeaXDN4iyYFbsSnb39gPjvg==
X-Received: by 2002:a17:906:bf49:b0:ab2:b8c3:be54 with SMTP id
 a640c23a62f3a-ab2b8c3c3b4mr1832310666b.44.1736854710394; 
 Tue, 14 Jan 2025 03:38:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dc6a8sm615381066b.72.2025.01.14.03.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 170325F9F8;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 14/37] tests/tcg/plugins/mem: fix 32-bit build
Date: Tue, 14 Jan 2025 11:37:58 +0000
Message-Id: <20250114113821.768750-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
Message-Id: <20241217224306.2900490-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..d87d6628e0 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
     g_assert(offset + size <= region_size);
 
     g_mutex_lock(&lock);
-    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
 
     if (!ri) {
         ri = g_new0(RegionInfo, 1);
         ri->region_address = region;
         ri->data = g_malloc0(region_size);
         ri->seen_all = true;
-        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+        g_hash_table_insert(regions, &ri->region_address, ri);
     }
 
     if (is_store) {
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (do_region_summary) {
         region_mask = (region_size - 1);
-        regions = g_hash_table_new(NULL, g_direct_equal);
+        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
 
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
-- 
2.39.5


