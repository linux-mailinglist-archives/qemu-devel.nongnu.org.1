Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6C78F723
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp6-0006X5-OB; Thu, 31 Aug 2023 22:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp4-0006W6-V3
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:46 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp2-0001Q1-Ov
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:46 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5657add1073so949916a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535023; x=1694139823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG0I5fdtJkgseX4CxGvr61fKZ2D6UQ2yfGBN0aVfn4c=;
 b=OaqZ7RvdwfUgVnBPAXgX2gbRR5X20w33zuXsfwfhRYKEnf9q+OMFWmuGWs3M45swX0
 TxC7P8woxBI2S73dvbSJAtkiak6yyhUj08CDFFFGTJ2jgrzE/5jrmSeGfla5O7jjSfAt
 TraQbnqswZTWWPOtzC4m+IK0RwOaFU3BKWptYwYrtNIzI2iGlw9cSQ1jsSD+ynpwbVfd
 wGN5VaLs48SW/2TlvfTyl0DTJhZiVA0a1nHN76bahaPQtiru9fARjabi3Jjyf8rfcv4h
 eScrKewSSlf//kevFCdqr5XuhpzYxV0huYyQH4gXYp2S5Z0xruHbWHkPWsgddJ2XBVSi
 iGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535023; x=1694139823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG0I5fdtJkgseX4CxGvr61fKZ2D6UQ2yfGBN0aVfn4c=;
 b=gVa0j75EOcBkpVe8L4+HJ8hxKTGw+SuEZlKZKaIL57Bb6J+IMJi0FPQbD3TUmyKIVC
 /GlFaKp8yDZIkK1aBn5iorRIIaEfYXIDxa9xuvfo50HNFQttZH0+3cK3uoPjC3OU1Z0I
 5bZYOtXLRKpcrlR2B4hnDCovfVRcC6zp66G7jXr2osCWh0JuvpPFlqvAmUwo3iujk+C1
 I2gafRq1Mx7k7AoWUMtJLu/vnhs2gq3xEnF3fWajvEmXV74SvfYZuzEMtzg7EyjFrXwq
 rLTTRAPnkDq7gMY6G+keJtHLY1GODUXi2/aGGYj/2BEDOp4lVxK3jRI1heE5kna++n4A
 FY7Q==
X-Gm-Message-State: AOJu0Yz1ex+7MO6LsymFcQ6fG0XoQOdJ6/BAthTCoTegsd06BC86W2rQ
 nYbvQG28R4/mvVDOiLk9dte6Ddwc05o1zzhSs3c=
X-Google-Smtp-Source: AGHT+IG25jrrzI1Ttgu16lzhCPYyM3NpDIaki3TDguCUFDAjAxmpdV5vLR97xZ2cPHQ7MScRx4DsNA==
X-Received: by 2002:a05:6a20:1451:b0:13f:de94:fb97 with SMTP id
 a17-20020a056a20145100b0013fde94fb97mr1798744pzi.27.1693535023497; 
 Thu, 31 Aug 2023 19:23:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 13/33] softmmu/physmem: Remove qemu_host_page_size
Date: Thu, 31 Aug 2023 19:23:11 -0700
Message-Id: <20230901022331.115247-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 softmmu/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..6f963ea127 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3472,7 +3472,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
          *    fallocate works on hugepages and shmem
          *    shared anonymous memory requires madvise REMOVE
          */
-        need_madvise = (rb->page_size == qemu_host_page_size);
+        need_madvise = (rb->page_size == qemu_real_host_page_size());
         need_fallocate = rb->fd != -1;
         if (need_fallocate) {
             /* For a file, this causes the area of the file to be zero'd
-- 
2.34.1


