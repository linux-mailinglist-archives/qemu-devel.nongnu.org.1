Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1A7A9863
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcc-0002Av-Qo; Thu, 21 Sep 2023 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcb-0002A8-8z
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcP-0007ik-DN
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso12870695e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317856; x=1695922656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yrJfngMZeFXFPS0lgWoyofdpWugV34Omj7KHLp5edtM=;
 b=ORVtK0PQKqXj5RLBh/INzryz6oC+3tRiF2rHB0koayxEp4tqXWmNLB/KF9SY4qDdeq
 3jHN0etGTZ5IeLydzCCyg5174+v1cOBaPvQa9Dkd84YOR/5TPK6FKL6xH9NgtZ2I9EFT
 9e8i7jyjYzqw8b2a1ifHQGgQPdfkHBRaxWgY5nFKjhv//dtR0JM7wvDNfiPsjcVWqyD+
 re0bfS/FAjFs/2yT0Bh2pFc7ndEn5rm5daaQlwYDZg6JCPzynWJfJBiq/igWSyuEXT5t
 nBJo0BTDVQAoDEuxaA3jEMUBuFOBTgD38PD+7cRt3nWOk1YaJImUeCB14e9T4q1/N++N
 zpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317856; x=1695922656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrJfngMZeFXFPS0lgWoyofdpWugV34Omj7KHLp5edtM=;
 b=u8jR6ynZlr/k0izne8KIcsDv0cVCYE/q4xor7f9gLm0+MW26v71t/AFK7msCNgFOW3
 wap1F6MxOH/q2NviFGzrrb4OMUcFWjMbRQmg+XWBJVwPbFyVs6UZOD/pGtw999ax7GmE
 Y9toC3amwf8RlIlRofe80zGFlCOMSyLfMfK4NChkIhVZt7QVig2F2pAjZH8paxTrrCaB
 M0h5bPJIXqecQz4nBqz/G/OJsDFBAqQbobB/CqHP79fexh/EGbeIfM0m0aHI7wu8xet0
 G9JIbjgRd0C63eJ+ztpnHyoOtD4LgmjORKV+IaRUtvSe30mfEFhts6CQT8M/iVPdIoUY
 DSpw==
X-Gm-Message-State: AOJu0YxHuH+FIMwcGVK7U0SvJ1HodpJ0axMbh8Zxr1tDXFn6Q9L4GQcL
 aAcYYToe60Y5xUyex/wvCnAN4g5daLHb0evwWrQ=
X-Google-Smtp-Source: AGHT+IErwpX7FoyOBKahkSrQqA9bj/JJ2v/g5JaSJ0Wf3616m3YoB6mNUVePR5UEddwUsOaG/INPgQ==
X-Received: by 2002:a05:600c:a381:b0:3fb:a0fc:1ba1 with SMTP id
 hn1-20020a05600ca38100b003fba0fc1ba1mr5546438wmb.35.1695317856170; 
 Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/30] elf2dmp: rework PDB_STREAM_INDEXES::segments obtaining
Date: Thu, 21 Sep 2023 18:37:20 +0100
Message-Id: <20230921173720.3250581-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Viktor Prutyanov <viktor@daynix.com>

PDB for Windows 11 kernel has slightly different structure compared to
previous versions. Since elf2dmp don't use the other fields, copy only
'segments' field from PDB_STREAM_INDEXES.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230915170153.10959-6-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.h |  2 +-
 contrib/elf2dmp/pdb.c | 15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 4ea8925ee82..2a50da56ac9 100644
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
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index adcfa7e154c..6ca5086f02e 100644
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
-- 
2.34.1


