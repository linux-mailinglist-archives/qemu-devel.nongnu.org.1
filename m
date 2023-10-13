Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ABE7C7FE4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD62-0001tF-Fj; Fri, 13 Oct 2023 04:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5m-0000Xe-OE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5j-0007ln-HO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so21829735e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184014; x=1697788814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JP0m4kbkqjcck8FcaQcw6QAO0qLBFbXhjnEKYPmqWSE=;
 b=geF4zFHg2GuIEq7JJ9RAUZPTrJxSX74Kyi1gjJ4qEkCS5Cx0MlgpUkuWJC8GgjNz3D
 dU0gVtUnoGVDIS+DypuZmc+GDFAh7yfNY5QN9wm9uC9hRGs4m8OyM6E7RdB2p4kgYONE
 LuDxMygg1xq1juLD0G2vsBHfRAbzWE4GNNPkfWFS7UHn5IZo47g4iompwEMGWaXHapA6
 4+nw7NOyw9PsndAFl5tnWK9WoBRZMIbThJF4m4DKjvZuWSOzjhycg8Uw/QKG7Zm/SJ4F
 kig+dfbPasWDK36YSO10WCEi2gb42tbxlpYxbEkRLxm2jGab7qKQiMY2OrR+3F16kuVH
 fORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184014; x=1697788814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JP0m4kbkqjcck8FcaQcw6QAO0qLBFbXhjnEKYPmqWSE=;
 b=VBVPwnRQjJ80HTI2usvCRnjYqZU5tfTyLZA7zdK5K3NWN7zbKvIJFqBZWCWPZVP+pB
 OteJIJFUyuEkfF2Mgpmbwn+eoG9aSFRiQY0CVIKmGnhm1Z4z99ZQ622rP+GUlTjxym8K
 UB7nzROrMCB2BJHD92kgbPQj6pdHOwBYZ135vFwMK6Q3J60jY2+BeNmagVulKpnjzzyP
 ghF1RaDrkac8k4TEt/Za/d01vT4aW0n/HNx2owcxG+aV6kDlYDXBmBXmd9kL6VtjB0zD
 hUGIVYBurxCutK2MPcyBZ4OEqIEiyDWngtaCy+o5GqFgXA845DSbpSh8iApAtdQRXdBf
 2jrA==
X-Gm-Message-State: AOJu0YyYJjD3c7zdrFgRHjosda5kLsnR7g9Gvfh36d9hmChTSQxzvJgB
 uQi1cYqx7ZvOG5jVjD0tSYoIeqTuvbZx1+xNqco=
X-Google-Smtp-Source: AGHT+IFpQov2Z+PnQw1qV7j5X7q3FBfhxM8v2kSpy78dbDuRCBCDVsXYBAsFq21D+JqvZ/16Bd0ftw==
X-Received: by 2002:a05:600c:1e11:b0:407:5a7d:45a8 with SMTP id
 ay17-20020a05600c1e1100b004075a7d45a8mr7505773wmb.31.1697184013753; 
 Fri, 13 Oct 2023 01:00:13 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:13 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [RFC PATCH v2 76/78] qemu-img.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:43 +0300
Message-Id: <1fa27adce69e97741ff59dd909f957cf9a5d3525.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6068ab0d27..df2457a6fe 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1870,63 +1870,63 @@ static int coroutine_fn convert_co_read(ImgConvertState *s, int64_t sector_num,
 static int coroutine_fn convert_co_write(ImgConvertState *s, int64_t sector_num,
                                          int nb_sectors, uint8_t *buf,
                                          enum ImgConvertBlockStatus status)
 {
     int ret;
 
     while (nb_sectors > 0) {
         int n = nb_sectors;
         BdrvRequestFlags flags = s->compressed ? BDRV_REQ_WRITE_COMPRESSED : 0;
 
         switch (status) {
         case BLK_BACKING_FILE:
             /* If we have a backing file, leave clusters unallocated that are
              * unallocated in the source image, so that the backing file is
              * visible at the respective offset. */
             assert(s->target_has_backing);
             break;
 
         case BLK_DATA:
             /* If we're told to keep the target fully allocated (-S 0) or there
              * is real non-zero data, we must write it. Otherwise we can treat
              * it as zero sectors.
              * Compressed clusters need to be written as a whole, so in that
              * case we can only save the write if the buffer is completely
              * zeroed. */
             if (!s->min_sparse ||
                 (!s->compressed &&
                  is_allocated_sectors_min(buf, n, &n, s->min_sparse,
                                           sector_num, s->alignment)) ||
                 (s->compressed &&
                  !buffer_is_zero(buf, n * BDRV_SECTOR_SIZE)))
             {
                 ret = blk_co_pwrite(s->target, sector_num << BDRV_SECTOR_BITS,
                                     n << BDRV_SECTOR_BITS, buf, flags);
                 if (ret < 0) {
                     return ret;
                 }
                 break;
             }
-            /* fall-through */
+            fallthrough;
 
         case BLK_ZERO:
             if (s->has_zero_init) {
                 assert(!s->target_has_backing);
                 break;
             }
             ret = blk_co_pwrite_zeroes(s->target,
                                        sector_num << BDRV_SECTOR_BITS,
                                        n << BDRV_SECTOR_BITS,
                                        BDRV_REQ_MAY_UNMAP);
             if (ret < 0) {
                 return ret;
             }
             break;
         }
 
         sector_num += n;
         nb_sectors -= n;
         buf += n * BDRV_SECTOR_SIZE;
     }
 
     return 0;
 }
-- 
2.39.2


