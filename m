Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7F178F713
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp4-0006Ve-Ib; Thu, 31 Aug 2023 22:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp3-0006VA-I3
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp0-0001PR-Sa
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so1226061b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535021; x=1694139821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNsGM1lrXvwjZfK8fzxAwlxZ3vZk+R9BD/kfTxJ1kzo=;
 b=jhxuPfKLM0bctrTZI0TS5Ky/ZcR+M0egaf74m1Lp/YmxfSDkHXlBFyV9MWk9PQAU5x
 ojEJuBYPDrojzsV7yHCp4fpj2C3698ZHmzd2QFUaYYYtc8FFYBOzRQKBDtO8Qze4jJrv
 u23sVjemRKXorXMiF/dqFFT0zA/CuxzZhIGqNj+qw2vtXaHkCdq42he8fAsHQAysUncV
 6ns2DDSfth4QrCe2LdYM3JEnBTpszKRl5f2sLM2+cwTGF+A/7gSJkVohQUp2+m7qf0Uc
 0hQH1sH88cFS0ZKOee8C+jeUOmAZmBQx+Z9/MxMozvNL4kzA38a7Y1qtFNFlXFQw2Zqn
 LhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535021; x=1694139821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNsGM1lrXvwjZfK8fzxAwlxZ3vZk+R9BD/kfTxJ1kzo=;
 b=N7J2mfaCn2oiwrkSZANCwou6xJMU/kaSy1XV0bRFuBQMNwSUJaVdGtnlpH7MsktpcH
 6NQjjF9oysPPVkx3w3bspNEyDDSvh7brjHztIBg2TC8ug07IXgNHTflqQ7daRzz7U/Du
 bqbD2PDaGfPWyjR/UFTqHCxX6Fl4GzUyRasVBFxP6s8D6X5qyJCcAzmSYeb7Z3Pj9vlo
 kNVqZNVMRsRUvVIDag/6hnqvkk4qpsuiinUcKnJe41Y1YMGl0Xbz+Qs94oItco7bVZ8A
 0StLniJytEZ7PU8q21on9boHSQcQAsqahrz8ffSrLOEQZ2RQ9/CdlKpoCWWHE+tJXis0
 +fuA==
X-Gm-Message-State: AOJu0YxzuEQleXGUDF3zXuycPN8MhPKQ1gX+hrfxb9UDpQF2I6guPw4d
 +N4NaPFi/9MPMsskAsJwi1/G7tLYFdLl/V/evGY=
X-Google-Smtp-Source: AGHT+IGyWk384MZ2BoGIFBsL4E/bg1M5GvVMoZex2JuiQmQsia9Pd2oJ8SD0UjjKYHJPQsAoSn94fA==
X-Received: by 2002:a05:6a20:1444:b0:140:61f8:53f3 with SMTP id
 a4-20020a056a20144400b0014061f853f3mr1942189pzi.21.1693535021632; 
 Thu, 31 Aug 2023 19:23:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 11/33] migration: Remove qemu_host_page_size
Date: Thu, 31 Aug 2023 19:23:09 -0700
Message-Id: <20230901022331.115247-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Replace with the maximum of the real host page size
and the target page size.  This is an exact replacement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/ram.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..1cabf935f2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3033,7 +3033,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
-    int ret;
+    int ret, max_hg_page_size;
 
     if (compress_threads_save_setup()) {
         return -1;
@@ -3048,6 +3048,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel = f;
 
+    /*
+     * ??? Mirrors the previous use of qemu_host_page_size below,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     WITH_RCU_READ_LOCK_GUARD() {
         qemu_put_be64(f, ram_bytes_total_with_ignored()
                          | RAM_SAVE_FLAG_MEM_SIZE);
@@ -3056,8 +3062,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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
@@ -3881,12 +3887,20 @@ static int ram_load_precopy(QEMUFile *f)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
+    int max_hg_page_size;
+
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = migration_incoming_postcopy_advised();
     if (!migrate_compress()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
+    /*
+     * ??? Mirrors the previous use of qemu_host_page_size below,
+     * but is this really what was intended for the migration?
+     */
+    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
+
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL, *host_bak = NULL;
@@ -3987,7 +4001,7 @@ static int ram_load_precopy(QEMUFile *f)
                     }
                     /* For postcopy we need to check hugepage sizes match */
                     if (postcopy_advised && migrate_postcopy_ram() &&
-                        block->page_size != qemu_host_page_size) {
+                        block->page_size != max_hg_page_size) {
                         uint64_t remote_page_size = qemu_get_be64(f);
                         if (remote_page_size != block->page_size) {
                             error_report("Mismatched RAM page size %s "
-- 
2.34.1


