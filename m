Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C845F743CBA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4u-0007nN-9K; Fri, 30 Jun 2023 09:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4s-0007mD-1O
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4q-0003TO-EF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so2061328f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131339; x=1690723339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3pB3AzQ33HXE3XP6riFkr6cxMvSqstuDeeeDRipPQQ=;
 b=IQc/4aLOMArBLv54JuARcDL8HB95+V5k+cLwQXmCpW8vNZAfMqs8sCcpu0ZXEBAyqI
 RIgrEYYbtbeY6CP4A4Lvtju/DYCIsu2fqY3cZjwYUvZMzE/0+H2Pwe+dBrXCyPxEucHr
 3oSqtBiz6Z2U7UvpGQpGDjSlQ5+0K86nMQsgP7hw3D4meFEj56VOxcs33XUduhflP5Hf
 xMLiFk335BKzFIXCVv5jSPqk46lpBDvMnUwV+HGFPEfdmnhT19ERsHdGrw2GLeTO6b9Y
 6/+g1sVt1Gte9BFsv+8N0bX/YmxvpBRUDq49xi1KUSsYalaz6LZeEz+z0EygaRUW/+ry
 ZU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131339; x=1690723339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3pB3AzQ33HXE3XP6riFkr6cxMvSqstuDeeeDRipPQQ=;
 b=lLqtORaxEzs9SDx/hXOo3bK5z+etjCV0IPj9vgMMTetdlTBJ/RA5PUXKSnd+bq4DKP
 ZG5vSgWK/xAXr2esUP2jirrZJ8E12ho6q8aqGS3H8wes5Ehibq/YaREzMemGimqhOxBI
 2JYJB92PuceTDb9sbgZMw5rt/VjM0N6/6fY8fPxXRFWdcvuq8YhAggqJO0HrytLHQFF+
 xRKhP2P+6J6Gq/sU7YqBPE6X8J2BudpmPqtEwwDVUf3hZyOZoeYvCCTS6rDUq/uzBCT4
 cy88/j5uZyYrcjjkXLhn0ilmFEyOwK0W4vYRyulwyojp+UHWgECaTDWz2bKtlteN6IB+
 Sn3w==
X-Gm-Message-State: ABy/qLYQNmw2+blV1i+9WGvhjKy2XGPwEnF6e7GxXypsgJ16K6wyPW5C
 s1n8urNmKBE76jFsItwNkDlIgp0HYnxUze2KScE8DQ==
X-Google-Smtp-Source: APBJJlEXwZacrEmeINGS2CqMKlmZ6CY5KnogZpNsd06av+bJve8G7/D60YatxRh0GjlHHC4I6DN9mA==
X-Received: by 2002:adf:cf07:0:b0:313:f4ff:30e9 with SMTP id
 o7-20020adfcf07000000b00313f4ff30e9mr2451156wrj.53.1688131339131; 
 Fri, 30 Jun 2023 06:22:19 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 23/24] linux-user: Remove can_passthrough_madvise
Date: Fri, 30 Jun 2023 15:21:58 +0200
Message-Id: <20230630132159.376995-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Use page_check_range instead, which uses the interval tree
instead of checking each page individually.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index e6463ecd8d..a2bef1ebe6 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -898,23 +898,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     return new_addr;
 }
 
-static bool can_passthrough_madvise(abi_ulong start, abi_ulong end)
-{
-    ulong addr;
-
-    if ((start | end) & ~qemu_host_page_mask) {
-        return false;
-    }
-
-    for (addr = start; addr < end; addr += TARGET_PAGE_SIZE) {
-        if (!(page_get_flags(addr) & PAGE_PASSTHROUGH)) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
 {
     abi_ulong len, end;
@@ -964,9 +947,8 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      *
      * A straight passthrough for those may not be safe because qemu sometimes
      * turns private file-backed mappings into anonymous mappings.
-     * can_passthrough_madvise() helps to check if a passthrough is possible by
-     * comparing mappings that are known to have the same semantics in the host
-     * and the guest. In this case passthrough is safe.
+     * If all guest pages have PAGE_PASSTHROUGH set, mappings have the
+     * same semantics for the host as for the guest.
      *
      * We pass through MADV_WIPEONFORK and MADV_KEEPONFORK if possible and
      * return failure if not.
@@ -984,7 +966,7 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
         ret = -EINVAL;
         /* fall through */
     case MADV_DONTNEED:
-        if (can_passthrough_madvise(start, end)) {
+        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
             ret = get_errno(madvise(g2h_untagged(start), len, advice));
             if ((advice == MADV_DONTNEED) && (ret == 0)) {
                 page_reset_target_data(start, start + len - 1);
-- 
2.34.1


