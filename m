Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8877C47DF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 04:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqP5P-00084z-S6; Tue, 10 Oct 2023 22:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqP5N-00084V-Hn
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:36:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqP5M-0003Q0-1K
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 22:36:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b974955474so1058393166b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 19:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696991790; x=1697596590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WxeHwpHbPHjqlbqI9btv605RsAT7uivuI4CIajlOLdw=;
 b=Viy/noHDjzqVfBdLuDrQxBQC22Rc+TT4MaNzcIC1bJv7yOOl8CjvReHiGFAbaar2vs
 L8DmeNo7vfebefcPy4Id0+CNBpDhRr4ujua7wU1vWAmfqKv5oIHbGcsmdjCd0NODEHcQ
 M7Vby2dCzKsyIwnr3AQor0UtaoeV0plNEJEfzvYE9jSl2lkwJm/xSJysxEIX0862d+Ge
 M3HEx1ESmXCZWjU7JToATZuier/aI9BVo2VDrQbGrGGmxm84fYbEzpRL40uHtD9bh5yV
 FLDpVefaQURp4gqCM/ynsYGBw7XukiFoyHLbb5IwLH4mlTGWRfOpeu4xbhe8Fl/G3USg
 /tuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696991790; x=1697596590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WxeHwpHbPHjqlbqI9btv605RsAT7uivuI4CIajlOLdw=;
 b=mhsF6KnyimBoIeI/gtLrluDNhejP4wUZM2kV0Ih+WAnzKZ+EnG7w4/Fmv0/MaA2OpG
 yB7MJXvhjQIUROAZtigkmB8NGgtraD5UgcHB/pUxlpKXi4UB4UzuGHyAMTy5gWkR3HO9
 hkO/8O9egKf7QCaW3mzXZWHyICP9U5X8fay5e8QD+S+DSG/wtUsJfBJKumg155E6MEle
 pFx75+SAL6s0WiXajpaKGE1UJjcP2BtAGyKn7QstTreirJNEpy+bw1bjv1TRTOc+5EEz
 mscW2ps/0P9dew2iW59FUeUItT3un8ysa26vG0MzkZj+6sr+YMT/HdrLwTIPC0ffg4AH
 6tXg==
X-Gm-Message-State: AOJu0YwkvEIr9AfYfauRLrfo1sDyaxX6l8Zs9PeNbK3e2ynQJ234ipe5
 yoI9NwDqJzu5DQMxvMsUtmn4ryWqeMCAKhYCUzC9ig==
X-Google-Smtp-Source: AGHT+IEU5s/PSVdpY1AZ/4MJey3WjEIziDn6sxM16blfhJEwzIOewql1cvCZRkbZFWS/qpHXhi6Cnw==
X-Received: by 2002:a17:906:20da:b0:9ae:4eb9:e09b with SMTP id
 c26-20020a17090620da00b009ae4eb9e09bmr17988232ejc.27.1696991789707; 
 Tue, 10 Oct 2023 19:36:29 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 d21-20020a17090648d500b00997d76981e0sm9065963ejt.208.2023.10.10.19.36.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 19:36:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
Date: Wed, 11 Oct 2023 04:36:27 +0200
Message-ID: <20231011023627.86691-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <ZR7e3cmxCH9LAdnS@x1n>
v2: Do use g_autofree...
---
 migration/ram.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 982fbbeee1..a0e2ef4f1c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4164,11 +4164,11 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
     /* from_dst_file is always valid because we're within rp_thread */
     QEMUFile *file = s->rp_state.from_dst_file;
-    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
+    g_autofree unsigned long *le_bitmap = NULL;
+    unsigned long nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
     RAMState *rs = ram_state;
-    bool result = false;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
@@ -4193,7 +4193,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     if (size != local_size) {
         error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
                    " != 0x%"PRIx64")", block->idstr, size, local_size);
-        goto out;
+        return false;
     }
 
     size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
@@ -4203,13 +4203,13 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
         error_setg(errp, "read bitmap failed for ramblock '%s': "
                    "(size 0x%"PRIx64", got: 0x%"PRIx64")",
                    block->idstr, local_size, size);
-        goto out;
+        return false;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
         error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
                    block->idstr, end_mark);
-        goto out;
+        return false;
     }
 
     /*
@@ -4241,10 +4241,7 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
      */
     migration_rp_kick(s);
 
-    result = true;
-out:
-    g_free(le_bitmap);
-    return result;
+    return true;
 }
 
 static int ram_resume_prepare(MigrationState *s, void *opaque)
-- 
2.41.0


