Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B178F7CFB4A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCP-00028F-0a; Thu, 19 Oct 2023 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBp-0001rZ-9e
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBg-0001Cp-7x
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4084095722aso12277785e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722543; x=1698327343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XDLwNQSP4GKAO/ZxD0EOo3uqYEUKkTNSdvXAsFN5ifk=;
 b=E58V+jJis1EdTBnuqkOqOq24nNdCob7ubovgUhXINd0mF5AQguhZhUyuvFrprJLuYe
 y5ERFJDihNfT95/ZtQNamj/6SH0SzoTKotKD3cpEzx2g3X/1+tH+9iKBy462clZ0I/oa
 kI7WizxbTSEUfrwEum15YDMnE9exCVZj9iXX2SrQq9ESlpNeX13e+ERHdRMvNFATPSyZ
 VdZlkNiqAmBTkaK9dDbUQVhkjX06HuSvi/Pbpid9yErAjbYgB8GVhHtBlokpWky2rVSF
 cFZko5Q08xtaTHNMgP6hbCcp/LhFvbhYPGEXv9Hq4C5inH6+k2mYeEE7am+nT6Bx0nnv
 kAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722543; x=1698327343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDLwNQSP4GKAO/ZxD0EOo3uqYEUKkTNSdvXAsFN5ifk=;
 b=QrOgfBFsmOsXA+wdeAiNB/FScZFInfCM3hUCwXJ9p9TQtBrFCcJ1G9Vby31nO9T8bX
 EZhkW4+WEt1mik13+yxcSWa1yEDTzSzi30JhvY7VG5aNFwCKNuMrb21SguiaHhPEjvr4
 TQv1wzYUSFHenSiCCuUzpmk7AyRBr5FbSNHfuavPUMyD0dLgaKIe9OJHdQhdrDw4i3Se
 +rRCXBZ4RgAFCRYndJ/uM7Khh4OgPXetke/XeYo6TYLUOzpNxBNMNa8vJDxnGcwkEK6w
 BEOEUTm7njIh21Kw5jf7KBGk65EbLQ42Pt/CzzIT9QK0a7EvVqxs5/se2/ZbvLmvyzrl
 Zt+A==
X-Gm-Message-State: AOJu0YzuJQkgoldAYiyS/sCo1f21Q1bA3FQp1+GbzGMTUPtW8fiLpDZG
 PDn1qL0S+8sCLdsXHNDfIMNmmgcy4m3yJJZBsRo=
X-Google-Smtp-Source: AGHT+IEQ3G5wy0JDPP+HQnT9hRC0A+XesuhR4cuiajHWS394O7ARXnOYT5bjUZdaIehAa/3pgpSE3Q==
X-Received: by 2002:a05:600c:1383:b0:405:48ba:9c with SMTP id
 u3-20020a05600c138300b0040548ba009cmr1821138wmf.16.1697722542692; 
 Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/24] elf2dmp: check array bounds in pdb_get_file_size
Date: Thu, 19 Oct 2023 14:35:21 +0100
Message-Id: <20231019133537.2114929-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Index in file_size array must be checked against num_files, because the
entries we are looking for may be absent in the PDB.

Fixes: Coverity CID 1521597
Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230930235317.11469-3-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 6ca5086f02e..8e3c18c82f7 100644
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
2.34.1


