Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B87B449E
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 01:41:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmjYk-0006xE-U1; Sat, 30 Sep 2023 19:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYi-0006ww-8B
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:40 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qmjYg-0004oe-H5
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 19:39:39 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5044dd5b561so18428325e87.1
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696117176; x=1696721976;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lLnZw8JrJfZxACNFwjppPjGwFqVUzz0U+VS935cCEJg=;
 b=EP9iWfSd9YcIiGd4H5KoCOoHOO0G5CwR8k62EBVYbESC/HMRCrcv9E5YLjEvPQw/Lx
 JwcECdqagq3I6FrsvVfqyN3vC96EgG/LM091dJrwqNE8Dg0B/gjc8nsXJv3nMoq8zO0O
 35w+SfTnspBpWPlmGJyIjOx9HZxt2UQZnyekB2xXWXnfLP+3fyKwF2Rrk40Qb1wGdh8K
 j3uKKiZLYrUABtfamkRBKUeGgURMIh39ZGeRinaeH1L/HP2vMlT/TQgUt3lbUX/jRYXt
 DPSpil4AP8vu0fqpkBMd7FyOjg1jrzxGIQlDJHM/B3TuZt0LDFYlyjjdlDe0XfAl/4g1
 Uz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696117176; x=1696721976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLnZw8JrJfZxACNFwjppPjGwFqVUzz0U+VS935cCEJg=;
 b=HLcY1GMG8GP2c3b+1f0Twdsz9AunsdDvdgNVopkAMr4gUJJObd6NRLZQd2okm/hTIK
 7fMNVSMoxEGmTGEMeScF+UQe1ErkhSE9zt7QUzQpuV+UU5PJJNxoKbCRb+xnyxeyJUg/
 j1iALpQbCQdv3voMr9KD+5pAgiIukcJ+JJtRXEdwSMCrFvRPhGfjzEuPIqI4TrPq4S4F
 w8DSWjbbd9TkMCdzrmnlKj3XHjSPtKneqy4m7Xc04fozvuGePvdewQx8fX0iQJOkiz1r
 qqBsiGCzulI1DVw3RPrOkXqlVTjxFgv86i4+2KHzVDug648op1TJ9vTLPXN1yRWwlm4i
 yxQA==
X-Gm-Message-State: AOJu0YyQS34xeKNA9cAU/EGWD0v9BcLmSVZ9gSWeknNtneBSnyhAPO98
 nvk6xCnVht8ha5+dmdVQiKEmLw==
X-Google-Smtp-Source: AGHT+IEpPI4Vgt47yCWUmx4SuHgP2ZbXv5wgNMvZ6jMHsUV12+OXRgSr/QbRJ6fZ9OZ1o89NEUIdXA==
X-Received: by 2002:a05:6512:3118:b0:500:c2d8:a2a2 with SMTP id
 n24-20020a056512311800b00500c2d8a2a2mr6070385lfb.46.1696117176370; 
 Sat, 30 Sep 2023 16:39:36 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 c19-20020a197613000000b005033948f108sm4013429lff.272.2023.09.30.16.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 16:39:35 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 2/2] elf2dmp: check array bounds in pdb_get_file_size
Date: Sun,  1 Oct 2023 02:39:22 +0300
Message-Id: <20230930233922.9969-3-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230930233922.9969-1-viktor@daynix.com>
References: <20230930233922.9969-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x129.google.com
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

Index in file_size array must be checked against num_files, because the
entries we are looking for may be absent in the PDB.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/pdb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 6ca5086f02..8e3c18c82f 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -25,6 +25,10 @@
 
 static uint32_t pdb_get_file_size(const struct pdb_reader *r, unsigned idx)
 {
+    if (idx >= r->ds.toc->num_files) {
+        return 0;
+    }
+
     return r->ds.toc->file_size[idx];
 }
 
@@ -159,16 +163,17 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
 
 static int pdb_init_segments(struct pdb_reader *r)
 {
-    char *segs;
     unsigned stream_idx = r->segments;
 
-    segs = pdb_ds_read_file(r, stream_idx);
-    if (!segs) {
+    r->segs = pdb_ds_read_file(r, stream_idx);
+    if (!r->segs) {
         return 1;
     }
 
-    r->segs = segs;
     r->segs_size = pdb_get_file_size(r, stream_idx);
+    if (!r->segs_size) {
+        return 1;
+    }
 
     return 0;
 }
-- 
2.21.0


