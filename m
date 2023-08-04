Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A0770A56
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:04:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS1xo-00028o-2f; Fri, 04 Aug 2023 17:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1qS02y-00046R-0s
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:01:12 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.cromie@gmail.com>)
 id 1qS02v-0001RR-2t
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 15:01:11 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3492c49c649so8666645ab.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691175666; x=1691780466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zFpch+8P3tV3H5HfrDlQXc1T5jeaQVV8OZf/WDGUGCc=;
 b=EKjMW6KLlXqiudELoM4kboJ+S9E4avUoi+6m6Sf/Z3oHXQzoECAr/rhB700UOuUuiv
 l/921Om6qJG8XngSkCBHqMg5GHkLHbXzIv3PUjAsd2fKklIXo21/N3eBHqzWQMxdrDW/
 fSUMDHZJ75xGO5L5UwJOpbSn9ofuh1Dv/79KH5SlKH3PeiKxsJLRMP8rexGbHkOopkea
 Vy/5vQoSmWJSbTgXeuhm5KzxcMEIJ2AiBEv/AbuPwfbf6bq4tJ3yZ21vEl6cnmso1TQw
 BYvfaDVFJaXW2FFW4WNiGOca8Q1hVdwmf+fF7CarfqzGzYy0zrAFhMugbiasYEa/6hI0
 L3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691175666; x=1691780466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zFpch+8P3tV3H5HfrDlQXc1T5jeaQVV8OZf/WDGUGCc=;
 b=LA9Sezd0ryNuE93Mq8meiJpeO+T2RC5sT+Fy0SZR63opwGOH7YCr7XbdOggxKWDL1c
 ENTz++EBlDCHGYpyuaiRCozxCr93+3ZtETjYSRx+oGWOOaMIlsaLnXYdOe2Gc/PfqLtT
 deX+kfDkrPHEnpDGz96xQwCDns+A53Mz9CaROzXO36lfWXCmRlwEyFiHi+hsF0aKCLzr
 CBWEkWf0n1ga5eVz42kFUb/SVOUyOqKkyAYG2uBAD7SORihd4e3KOA9sdypPfYXRqtf3
 BKPs3/hnAVyyqS3HENQqWxJLwc64Dr1SFspwsmrRblMCVZs8lCfdF6bn1ANxvKKwHVqu
 KtiQ==
X-Gm-Message-State: AOJu0Ywgr/OmY9hbquNmwhnaz/jc4LF0kFWzoed+JD+TjtFqDYKuvofn
 I4QWsF8lvv/WvJ1fl3ozGUkhFkBn8vj6zw==
X-Google-Smtp-Source: AGHT+IHpb1Q4xU6qbK+YnfGS+qE+Q16JDY7S2YlRKf0CPzv6ytDTCqa//vu/JrVqo26KB96O0I3lmw==
X-Received: by 2002:a92:cdaf:0:b0:348:d0e5:dbc8 with SMTP id
 g15-20020a92cdaf000000b00348d0e5dbc8mr4191817ild.31.1691175666120; 
 Fri, 04 Aug 2023 12:01:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
 by smtp.googlemail.com with ESMTPSA id
 c16-20020a92d3d0000000b00342093347d8sm814048ilh.76.2023.08.04.12.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 12:01:05 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH] print memory in MB units in initrd-too-large errmsg
Date: Fri,  4 Aug 2023 13:01:01 -0600
Message-ID: <20230804190101.759753-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=jim.cromie@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Aug 2023 17:03:56 -0400
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

Change 2 error messages to display sizes in MB, not bytes.

qemu: initrd is too large, cannot support this. (max: 2047 MB, need 5833 MB)

Also, distinguish 2 sites by adding "it" and "this" respectively.
This tells a careful reader that the error above is from the 2nd size
check.

With MB displayed, I have to ask: is it coincidence that max == 2048-1 ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 hw/i386/x86.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index a88a126123..0677fe2fd1 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -878,9 +878,9 @@ void x86_load_linux(X86MachineState *x86ms,
                 initrd_size = g_mapped_file_get_length(mapped_file);
                 initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
                 if (initrd_size >= initrd_max) {
-                    fprintf(stderr, "qemu: initrd is too large, cannot support."
-                            "(max: %"PRIu32", need %"PRId64")\n",
-                            initrd_max, (uint64_t)initrd_size);
+                    fprintf(stderr, "qemu: initrd is too large, cannot support it. "
+                            "(max: %"PRIu32" MB, need %"PRId64" MB)\n",
+                            initrd_max>>20, (uint64_t)initrd_size>>20);
                     exit(1);
                 }
 
@@ -1023,9 +1023,9 @@ void x86_load_linux(X86MachineState *x86ms,
         initrd_data = g_mapped_file_get_contents(mapped_file);
         initrd_size = g_mapped_file_get_length(mapped_file);
         if (initrd_size >= initrd_max) {
-            fprintf(stderr, "qemu: initrd is too large, cannot support."
-                    "(max: %"PRIu32", need %"PRId64")\n",
-                    initrd_max, (uint64_t)initrd_size);
+            fprintf(stderr, "qemu: initrd is too large, cannot support this. "
+                    "(max: %"PRIu32" MB, need %"PRId64" MB)\n",
+                    initrd_max>>20, (uint64_t)initrd_size>>20);
             exit(1);
         }
 
-- 
2.41.0


