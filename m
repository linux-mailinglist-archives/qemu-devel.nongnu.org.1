Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F14C7BCE3E
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 13:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpS9F-0001Mu-R0; Sun, 08 Oct 2023 07:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpS8m-0001Gt-9q
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:40:09 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpS8j-0003kP-Ei
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 07:40:08 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so597313266b.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 04:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696765203; x=1697370003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PHyZw8M3Co9g34IdglSurJQr6kNWCVZJqi2zvIZuYBs=;
 b=noG4N7RDxU+guYJ46jkGP1zj6rpcptuU7y4CHT8Y9RCl59K4m8NGqAE7zFnlc19s/8
 cxYUq/F7F/cGgOeYHtgsMfhwuKxteuQ6gOnnWHVoNsxuaSJD8Gv46MTR2Ufm2vD+uvkC
 A7NE2x6Z7OTXVufWiVZlSwYZ4+41hfeNIAYby2g14+BsFLciHz7IdRF49i0aiEQY74N8
 Hl6t0jWB9M5lncK/Jwf5v6fnWaPOPDuBUYHZnFpiEnjeUTmGvuKg9XL78dRiyCplDhlQ
 oz0QFmHo0Pbe7u4x/dU3Q+Eppervrb9q/4BbnKrRQs/Kv7z1LXgQG3j6995vw2nfJkS1
 audA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696765203; x=1697370003;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHyZw8M3Co9g34IdglSurJQr6kNWCVZJqi2zvIZuYBs=;
 b=aeb0ukv2Wp2ZnXjjseOq/uqrcGxUJxLJk7FoJK1axZwwS+dOqzT9y1bZ0kcq6pajqk
 R0pehOr9vtp4a1VtOQqElP49SzUDIw4/tOBEQw4sNhchM7ymn5yl6F4YZFEMIOMzKr07
 TC0EsDigtS1hGBCk1SVdwwt+0d53hZTmovdI5DhVXfP7hiTclZftNK/4OkoSwumePYXY
 eGV4qgT3zxGSTvTzPsekX8pgmr24cP/5ZoYV8jfkiUZ157I/WK5md7zfzm1inrMzEyxf
 6PuHauO7hryt+/Zp5I8HvLQaF/IQuggO+iFQog2P+C8hbFEBo4JlLT88wUjf4Bpm2JD7
 Kaww==
X-Gm-Message-State: AOJu0YzUY/ue32zlxccuHNiMz3ZXYlCojrZ9h/2r3HpCKuP+QPSQ/m7f
 Boz/nJvRRbKy2S14waNXe5vG9wHktgukeW+HNsE=
X-Google-Smtp-Source: AGHT+IEEhOThnVE1CyKH8MTJ1SuBk/r56kNyeOzITcuWzrDSKtSSmFEy6gujXjLZUhUMyj7pXrmJ0Q==
X-Received: by 2002:a17:907:7f26:b0:99d:ddae:f5d4 with SMTP id
 qf38-20020a1709077f2600b0099dddaef5d4mr13924056ejc.44.1696765203568; 
 Sun, 08 Oct 2023 04:40:03 -0700 (PDT)
Received: from m1x-phil.lan (4rc44-h01-176-171-215-42.dsl.sta.abo.bbox.fr.
 [176.171.215.42]) by smtp.gmail.com with ESMTPSA id
 m15-20020a1709066d0f00b00982a352f078sm5332223ejr.124.2023.10.08.04.40.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Oct 2023 04:40:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] migration: Use g_autofree to simplify
 ram_dirty_bitmap_reload()
Date: Sun,  8 Oct 2023 13:40:00 +0200
Message-ID: <20231008114001.95348-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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
---
 migration/ram.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 982fbbeee1..4cb948cfd0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4164,11 +4164,11 @@ bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
     /* from_dst_file is always valid because we're within rp_thread */
     QEMUFile *file = s->rp_state.from_dst_file;
-    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
+    unsigned long *le_bitmap = NULL;
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


