Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30699709A9D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:55:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01QZ-00070f-Hy; Fri, 19 May 2023 10:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QX-000709-By
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01QV-0003Gx-UT
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRIzHJtQJ7HpA10667EVr72jRlizLm0GWgvFozTLp40=;
 b=OmzNgpwkkq8zbf2bIIHs25D0SLZdrQcu3qOLyXFjfi6ZL6LvelO9Ys3aMe6n9eFlBjB3KQ
 JVYqvHP/EpdTaSDIfhU9KOX1TWHNldfyVkJiv1xP6idvjQdyaZ/ubpPHrPQwziYGocHS5Q
 HfQaSPA9Em2Vb+uo9bch7LUnH2T+OqM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-aRpN0gqkNFmuojEGPWDecw-1; Fri, 19 May 2023 10:49:49 -0400
X-MC-Unique: aRpN0gqkNFmuojEGPWDecw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af1ed9514bso9184391fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507788; x=1687099788;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRIzHJtQJ7HpA10667EVr72jRlizLm0GWgvFozTLp40=;
 b=awUZAYmrYplbZehovGSPpUdim/d1+2vbiSG3hiFX8sCQLb5LwjB4NY5TRttLTq6N1O
 /ImNUySDpegQg4ua57q6qxM8Qov5ESkwllO1tEzi5sRlHdQkfbbRQHcyujDH6ROfgrKu
 SP9UjFn/NxGgl8JTjVkAfe7e8tYXzqgTfehUhLMr7LhkyjakJlfLz27ZWRGx25lRgV2f
 ZZ3V76SeH5UY4TQ25jYDqnKTyFLnSocE1SZK/jtfjbE+ICnKogFqB2tkbwWG0zTLCcAT
 aGdjJRqOyFRFMRpvw0MaMV7XvfT52EcdRWFskTL0sOkpbqgU7c7OjmxZz+IsEMk7WJLz
 K6Ag==
X-Gm-Message-State: AC+VfDx4xlGCeVDaRTGz8rIQ+b99lbBkVTQGFvb2l6MDYX3LHXQg7Y/z
 NsfqfuCIPNSl15QEVo4rrieAnpEygeFcn7qVyau6gJ+8ujD3aqusF1r4R6YbhCzFJl8ZFCR8oDt
 HA4SxUQiZfURWPqjeN8PI9rVXDqfvNwUY3EFrUgAx13lxStBqy0klxtNdy0aNysH65pdV
X-Received: by 2002:ac2:485c:0:b0:4f2:40dd:e2cf with SMTP id
 28-20020ac2485c000000b004f240dde2cfmr850802lfy.55.1684507787948; 
 Fri, 19 May 2023 07:49:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75DCQVoeaWOvT0MknfmWM9sAQdeMgKnBwv7tprv/81SWe28d45CA6WNvBHRAg0LumxCkmgBQ==
X-Received: by 2002:ac2:485c:0:b0:4f2:40dd:e2cf with SMTP id
 28-20020ac2485c000000b004f240dde2cfmr850786lfy.55.1684507787552; 
 Fri, 19 May 2023 07:49:47 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 l6-20020ac25546000000b004f37a541f0csm553711lfk.270.2023.05.19.07.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:49:46 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Hao Zeng <zenghao@kylinos.cn>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 02/40] hw/cxl: cdat: Fix open file not closed in ct3_load_cdat()
Message-ID: <71ba92f3488b64bd5c81e2872c56e88cea21bb95.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Zeng <zenghao@kylinos.cn>

Open file descriptor not closed in error paths. Fix by replace
open coded handling of read of whole file into a buffer with
g_file_get_contents()

Fixes: aba578bdac ("hw/cxl: CDAT Data Object Exchange implementation")
Signed-off-by: Zeng Hao <zenghao@kylinos.cn>
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Jonathan Cameron via <qemu-devel@nongnu.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
Changes since v5:
- Drop if guard on g_free() as per checkpatch warning.
Message-Id: <20230421132020.7408-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-cdat.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 137abd0992..056711d63d 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -110,29 +110,18 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     g_autofree CDATEntry *cdat_st = NULL;
     uint8_t sum = 0;
     int num_ent;
-    int i = 0, ent = 1, file_size = 0;
+    int i = 0, ent = 1;
+    gsize file_size = 0;
     CDATSubHeader *hdr;
-    FILE *fp = NULL;
+    GError *error = NULL;
 
     /* Read CDAT file and create its cache */
-    fp = fopen(cdat->filename, "r");
-    if (!fp) {
-        error_setg(errp, "CDAT: Unable to open file");
+    if (!g_file_get_contents(cdat->filename, (gchar **)&cdat->buf,
+                             &file_size, &error)) {
+        error_setg(errp, "CDAT: File read failed: %s", error->message);
+        g_error_free(error);
         return;
     }
-
-    fseek(fp, 0, SEEK_END);
-    file_size = ftell(fp);
-    fseek(fp, 0, SEEK_SET);
-    cdat->buf = g_malloc0(file_size);
-
-    if (fread(cdat->buf, file_size, 1, fp) == 0) {
-        error_setg(errp, "CDAT: File read failed");
-        return;
-    }
-
-    fclose(fp);
-
     if (file_size < sizeof(CDATTableHeader)) {
         error_setg(errp, "CDAT: File too short");
         return;
@@ -218,7 +207,5 @@ void cxl_doe_cdat_release(CXLComponentState *cxl_cstate)
         cdat->free_cdat_table(cdat->built_buf, cdat->built_buf_len,
                               cdat->private);
     }
-    if (cdat->buf) {
-        free(cdat->buf);
-    }
+    g_free(cdat->buf);
 }
-- 
MST


