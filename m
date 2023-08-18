Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70731781152
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31l-0008FI-K3; Fri, 18 Aug 2023 13:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31i-0008EP-OX
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:46 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31g-00081g-Hx
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:46 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so6939275ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378763; x=1692983563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aNsGM1lrXvwjZfK8fzxAwlxZ3vZk+R9BD/kfTxJ1kzo=;
 b=QmJnSHmAERh0B3/YwLvWptTFBOT1GwzYcz/MQ0I0LP4S1Fdrw9a3XwuSkpIZEP4jjg
 ySmkoJbjeQySUYRCxBWse1MC58y9YpXheSgVwfS/D6pGhTPXwylND6hi6PmYN9JanO3V
 EmOktTv2ut1Ld8QJuefFxUnrNE85Tjg9FxWcAiXJF5VPbjX+t/LoCXqT7NjCH2J40XU+
 RcFASXK0NJOypZQlCfQtgGQnyRurj02bUdKSEe0qPd//oQReJhCfQBt6i4aZMa3xoTvI
 Ta4AVTedtA1sbJAE3g1hLB8g3SO6fvN31i/Z8MwrMlNGuprONkpWzXDp0THk0LP11ZrI
 1yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378763; x=1692983563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNsGM1lrXvwjZfK8fzxAwlxZ3vZk+R9BD/kfTxJ1kzo=;
 b=LvpM4Udn1dnu3mNEa+Wlt47Nay5Gy+yVbM5qRA4g0GMBmyhAp+bPLFfXYRVvYyy5Y5
 qkoDlMu9ZeAP+ng3BGzNz+HLqX2bPpl3jWM1LJ38fKdN9w904xgUWV7CdEBQTkkaVgBt
 4I8IDMgGyxFWovf88dvAyum3VZKKtUoVq+vd0kqlO8Rn29q7domHO3CHb8WtDy5bz42L
 U0Vn+2xBuJDDouMAc3w3qT9lzEjMMWYpDdHtFKahGZBcqlV42HNi4MYy0dY6nMT6qeYP
 oCFMKKEMQDseR0DYmN00TDqKQ6YK2fOwJV5s1nj/aTCIctKwYHBdfvrCF43rPD/3uAzc
 iquw==
X-Gm-Message-State: AOJu0YxaLkiaSdP+fUUvSKJbUN3iLmeAvhvNsiYyKpkQZSkm4/cnpywA
 1PHXF+PmZ2VizMoiV2LBYIyqnY+rAqlHrnON+C0=
X-Google-Smtp-Source: AGHT+IHU4knB3cv5c5iiVsaSn1JTPophB2olJSmtUBiXhGzgM3Q98Ri+NuIrVdoa3V1NnAA42Xj3GA==
X-Received: by 2002:a17:902:f68b:b0:1bb:9c45:130f with SMTP id
 l11-20020a170902f68b00b001bb9c45130fmr3064503plg.69.1692378763410; 
 Fri, 18 Aug 2023 10:12:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/33] migration: Remove qemu_host_page_size
Date: Fri, 18 Aug 2023 10:12:05 -0700
Message-Id: <20230818171227.141728-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


