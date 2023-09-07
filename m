Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE1B7972BE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdQ-0003NO-TN; Thu, 07 Sep 2023 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd6-0002sw-Sz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd2-0007JG-B1
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSTq9iC4n1L9oUzK6f1smjHpV+ZLU2lzqzefWCqatbA=;
 b=cUYpHGF0fJP9gXBSAgZaBqlWLbTEPYtMXV1HGTYUnkbf+qHmBr1fX3GVf6QEhXbVlPGsGm
 U3C++BKnuYcdVgfZgJ+pINXWa3u2SjWwjxOLl3UtriCXghvc5i19hSa3Q507l7H83edVDX
 j4ZlOsn9TNw1nCpJWrsbE4mW7MdeEG0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-WgfwpV59Pzu4chMVsdFb8g-1; Thu, 07 Sep 2023 09:00:51 -0400
X-MC-Unique: WgfwpV59Pzu4chMVsdFb8g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-500a10289e3so961091e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091648; x=1694696448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSTq9iC4n1L9oUzK6f1smjHpV+ZLU2lzqzefWCqatbA=;
 b=QVf5oKXbqf5qMwLzMwFpn7Hq05YKXqZyzia8mvRqYILOpzMkicyCVGtb8ZbwfVq0ub
 16EBDgq+wC5/JlpK8NtwUkCYHdaY2s80gUlxnyVff7IoVDrO3NIzDIwvgEw94cH4d7L9
 3cY9J3f67eAjR7D1OZsCUXBkyJbP1/delSm/6AUHhhakPyJIfOjYRfmghsoY7f+KBk6o
 uLCDyzXm3C0B6Up3Vdzx4Ycc5U+LMbCEbDQkhIC/tluiERt2HfgTN7Q9ro/NTMa32W7g
 WbwJMz+78UIjvambQR8unqVZAciEo/R3IhNR+FAusMinnG7HiNTPtUdAst+T2exy8a+Q
 HIRw==
X-Gm-Message-State: AOJu0Yx4toMistxcU9MbbbgNasnBwY1qPCCKizZMzhro57XwOOMobucQ
 JalSzkio00bl4wx9aG70qvqMF1/0L85XoX693itvZQwp12BPu9pgV0NarS/IB3WaBBU/5WxGDYQ
 pyuamiMD1dJRhXTRNkwNTkal/5PRy1iAwpqMgt0aaI8VFvgYM9WNl2AGpQtgqkQvlBjFbbTOrxU
 g=
X-Received: by 2002:ac2:4a66:0:b0:4fb:89b3:3373 with SMTP id
 q6-20020ac24a66000000b004fb89b33373mr4340762lfp.43.1694091647732; 
 Thu, 07 Sep 2023 06:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK6KQ0VsnC4tW2uPpXF50icu/Hb3NSxS5mzBkRdKCn0jWkQQGvsqy0QwdF1NYlkTIjXpiO+Q==
X-Received: by 2002:ac2:4a66:0:b0:4fb:89b3:3373 with SMTP id
 q6-20020ac24a66000000b004fb89b33373mr4340713lfp.43.1694091646549; 
 Thu, 07 Sep 2023 06:00:46 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a05600c378700b003fe4548188bsm2451233wmr.48.2023.09.07.06.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/51] contrib/plugins/lockstep: Fix string format
Date: Thu,  7 Sep 2023 14:59:27 +0200
Message-ID: <20230907130004.500601-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This fixes on Darwin:

  plugins/lockstep.c:138:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, them->pc, g_slist_length(divergence_log),
                          ^~~~~~
  plugins/lockstep.c:138:33: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, them->pc, g_slist_length(divergence_log),
                                  ^~~~~~~~
  plugins/lockstep.c:148:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, us->insn_count, them->pc, them->insn_count);
                          ^~~~~~
  plugins/lockstep.c:148:49: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, us->insn_count, them->pc, them->insn_count);
                                                  ^~~~~~~~
  plugins/lockstep.c:156:36: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     prev->block->pc, prev->block->insns,
                                     ^~~~~~~~~~~~~~~
  plugins/lockstep.c:156:53: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     prev->block->pc, prev->block->insns,
                                                      ^~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230907105004.88600-5-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/lockstep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 3614c3564c2..57748e86eb3 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -134,7 +134,9 @@ static void report_divergance(ExecState *us, ExecState *them)
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-        g_string_printf(out, "@ 0x%016lx vs 0x%016lx (%d/%d since last)\n",
+        g_string_printf(out,
+                        "@ 0x%016" PRIx64 " vs 0x%016" PRIx64
+                        " (%d/%d since last)\n",
                         us->pc, them->pc, g_slist_length(divergence_log),
                         divrec.distance);
         qemu_plugin_outs(out->str);
@@ -144,7 +146,9 @@ static void report_divergance(ExecState *us, ExecState *them)
         int i;
         GSList *entry;
 
-        g_string_printf(out, "Δ insn_count @ 0x%016lx (%ld) vs 0x%016lx (%ld)\n",
+        g_string_printf(out,
+                        "Δ insn_count @ 0x%016" PRIx64
+                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
@@ -152,7 +156,8 @@ static void report_divergance(ExecState *us, ExecState *them)
              entry = g_slist_next(entry), i++) {
             ExecInfo *prev = (ExecInfo *) entry->data;
             g_string_append_printf(out,
-                                   "  previously @ 0x%016lx/%ld (%ld insns)\n",
+                                   "  previously @ 0x%016" PRIx64 "/%" PRId64
+                                   " (%ld insns)\n",
                                    prev->block->pc, prev->block->insns,
                                    prev->insn_count);
         }
-- 
2.41.0


