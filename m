Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAF7A2425
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCCs-0003Rj-Ee; Fri, 15 Sep 2023 13:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCq-0003Oj-Iv
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:12 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCo-0000Lf-Ej
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:12 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-502a25ab777so3778784e87.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694797329; x=1695402129;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyhglYJ5pbQBkUGv5WkINwdsbdNBkbHZUQKyK9LQHl4=;
 b=P0IhuH8Jr002M8B4onCr+XpRgQr2u1Ijpv6VKYMA5JSwbiiSbFVZQIABT6LJisnTXD
 J90zqXGhSGoMWUtYNfTJKtq1wKCzBqrexKj4OKfQ4XC4XsUsp3S/WN1q8gfzFl0Kc+Z3
 RzvzSJpiASzjXlObjgITdD2//a+75o3PqPlUCaW2FaZttFic/ES8WW2DQnzefUaTxkze
 jfaxdgb5iEdDQdhSR9vtahLcF4T55kzR35rOuVjgTU1Lti2KrTv+aBmRlD+wk5hdHdmR
 RA6kX/nSczC+tePC8J2UHgLine8c4+Q8pYrHMBIRnkOYZ3YwzfVyBU/i3H1GBWUlL1TJ
 Hvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797329; x=1695402129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyhglYJ5pbQBkUGv5WkINwdsbdNBkbHZUQKyK9LQHl4=;
 b=H4iUQH/TEDgQT0AcYn1tyyApK0aEA1BrwSeZPl/XDtfwzq3aANQB83+556/gqyP5vG
 gnbvp0Y9mBpy85uidVDcKNKhNo+u5zD7sL/56SVFywBswFCjST06Zcio3VitPddz8i7N
 usQw0rlNhvK3ew2He3ite9DsxEXUppMNsTDxeFaGcQnSnMzs7/+fRXRQ2+hojef4q8Hz
 YClYotSPxm13Pf8Op5/CqM6SZWwtXVq/92HUdjWf8ZENM1tr6yw2X6bifUWwz1IyApSv
 TLrtSEDASE55DdWPyRLKpafH0zYVFWlnOInO4vo56/crx7NC6qxfY1Nse4DEkSpwEjNj
 Vblw==
X-Gm-Message-State: AOJu0YymlKZJR3QIf+4GD0mE7hLsVbVrH7dE5T58QMAqSDppy5N7dMRx
 0Ubo2DTlsM+H3JeOxGG7S/YaqA==
X-Google-Smtp-Source: AGHT+IF9ZwuI0AuFZD+KpwXCREmHVC9qBatbDrVLhofe/2MBYV7qELZ59PbuwNOwdo8ZxlrcLrqkqQ==
X-Received: by 2002:a05:6512:3d8c:b0:500:c4f1:6bb6 with SMTP id
 k12-20020a0565123d8c00b00500c4f16bb6mr2531377lfv.61.1694797328886; 
 Fri, 15 Sep 2023 10:02:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 u7-20020a056512040700b005009ab1992esm690431lfk.154.2023.09.15.10.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 10:02:08 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 5/5] elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
Date: Fri, 15 Sep 2023 20:01:53 +0300
Message-Id: <20230915170153.10959-6-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230915170153.10959-1-viktor@daynix.com>
References: <20230915170153.10959-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

PDB for Windows 11 kernel has slightly different structure compared to
previous versions. Since elf2dmp don't use the other fields, copy only
'segments' field from PDB_STREAM_INDEXES.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/pdb.c | 15 ++++-----------
 contrib/elf2dmp/pdb.h |  2 +-
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index adcfa7e154..6ca5086f02 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -160,7 +160,7 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
 static int pdb_init_segments(struct pdb_reader *r)
 {
     char *segs;
-    unsigned stream_idx = r->sidx.segments;
+    unsigned stream_idx = r->segments;
 
     segs = pdb_ds_read_file(r, stream_idx);
     if (!segs) {
@@ -177,9 +177,6 @@ static int pdb_init_symbols(struct pdb_reader *r)
 {
     int err = 0;
     PDB_SYMBOLS *symbols;
-    PDB_STREAM_INDEXES *sidx = &r->sidx;
-
-    memset(sidx, -1, sizeof(*sidx));
 
     symbols = pdb_ds_read_file(r, 3);
     if (!symbols) {
@@ -188,15 +185,11 @@ static int pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    if (symbols->stream_index_size != sizeof(PDB_STREAM_INDEXES)) {
-        err = 1;
-        goto out_symbols;
-    }
-
-    memcpy(sidx, (const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
-            symbols->pdbimport_size + symbols->unknown2_size, sizeof(*sidx));
+            symbols->pdbimport_size + symbols->unknown2_size +
+            offsetof(PDB_STREAM_INDEXES, segments));
 
     /* Read global symbol table */
     r->modimage = pdb_ds_read_file(r, symbols->gsym_file);
diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 4ea8925ee8..2a50da56ac 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -227,7 +227,7 @@ struct pdb_reader {
     } ds;
     uint32_t file_used[1024];
     PDB_SYMBOLS *symbols;
-    PDB_STREAM_INDEXES sidx;
+    uint16_t segments;
     uint8_t *modimage;
     char *segs;
     size_t segs_size;
-- 
2.21.0


