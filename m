Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9B821638
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:00:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3F-0003JV-84; Mon, 01 Jan 2024 20:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3C-0003IQ-Uu
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:38 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3B-00070z-Cg
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:38 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6dc36e501e1so2061727a34.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160716; x=1704765516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IenBg9AYpQ9l8BWTXQNXUpU41uv7QpRC4SvYweV2rAA=;
 b=aHzGquAaP6EDXNCYSTqyeVL+f302JMwrg8MA6cvZGw2VP1HBpIQaUmWnOO5JHzaqfP
 VELLgej4Pa1QR88LyjvsCkrGovmtKJVCH1TglKVXTxgKiH71e5rB4FyqXw03I7/RqjsD
 MkkpTezNZ/Lvl/QAeIeTiehnM8fsX0UyR3UJJwlR2IiUu4YI8JL+tEG73r8V8A2SnL8w
 rbvv0V6CYR21yArDUVd/g3NjvwFSabD0WSI2OcaMnOnETc4y2BE0CBrgoTG5usqH1xeA
 LqAcByKLGlErVFMv4ykchM2oUJSdB526h9KzMOielUES32JbkiQ2t61pmcAXDxUosR/+
 UcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160716; x=1704765516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IenBg9AYpQ9l8BWTXQNXUpU41uv7QpRC4SvYweV2rAA=;
 b=CBziCHg9ag/wBbw+ei5rGEsXKntA6wy7HjE2WtVh3dLfwR0BhStWlYnTnr3oqYotkr
 HVSWSjj/EZFAGT/0gNSFxCC4QjZzznbh0X7oYJ04iRGaqvWXJ2EKHiXEHKOAzd/JNlf9
 aB5ZDZ0ptwMCmWZnTQpoDEFvK39cpDguHvKOxWDuGGfKnc/G9R6QOSlAtmbpENCZvzwQ
 YiQvZl9ZPnT0LwsYRgANLZsiyNXGoWYL/0wZpkjLRQF8EcCGskhl8KmffACgdUQnMt8A
 xhEEe8oyjGxFqLPlYQzwqWQTDXujB3S9aAncJgvYHO/NfgIWNx8tJ8vc6tDFK33TlnOF
 rDeg==
X-Gm-Message-State: AOJu0YyIzWS/o04zT6MQhHv6/B0dphhdHEk4flBobfQyqeqosGzj3bbq
 6nq5xGV4oaRGW+mJwcZPGDLhEJu8P7VV21pDHLe2a3vAJMY=
X-Google-Smtp-Source: AGHT+IFY7cP+etaBoInOV0rV0/F+0wH7ONollLCvAkA25enL46XrY8TBqRlXNgCIgZNhQIV0ZyPcDA==
X-Received: by 2002:a9d:4b16:0:b0:6dc:54:f52a with SMTP id
 q22-20020a9d4b16000000b006dc0054f52amr8654884otf.4.1704160716169; 
 Mon, 01 Jan 2024 17:58:36 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/33] migration: Remove qemu_host_page_size
Date: Tue,  2 Jan 2024 12:57:46 +1100
Message-Id: <20240102015808.132373-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Replace with the maximum of the real host page size
and the target page size.  This is an exact replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/ram.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 8c7886ab79..aa3109fca3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2936,7 +2936,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
-    int ret;
+    int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
         return -1;
@@ -2951,6 +2951,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel = f;
 
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     WITH_RCU_READ_LOCK_GUARD() {
         qemu_put_be64(f, ram_bytes_total_with_ignored()
                          | RAM_SAVE_FLAG_MEM_SIZE);
@@ -2959,8 +2965,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
             qemu_put_be64(f, block->used_length);
-            if (migrate_postcopy_ram() && block->page_size !=
-                                          qemu_host_page_size) {
+            if (migrate_postcopy_ram() &&
+                block->page_size != max_hg_page_size) {
                 qemu_put_be64(f, block->page_size);
             }
             if (migrate_ignore_shared()) {
@@ -3794,6 +3800,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
     int ret = 0;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = migration_incoming_postcopy_advised();
+    int max_hg_page_size;
 
     assert(block);
 
@@ -3811,9 +3818,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
             return ret;
         }
     }
+
+    /*
+     * ??? Mirrors the previous value of qemu_host_page_size,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     /* For postcopy we need to check hugepage sizes match */
     if (postcopy_advised && migrate_postcopy_ram() &&
-        block->page_size != qemu_host_page_size) {
+        block->page_size != max_hg_page_size) {
         uint64_t remote_page_size = qemu_get_be64(f);
         if (remote_page_size != block->page_size) {
             error_report("Mismatched RAM page size %s "
-- 
2.34.1


