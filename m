Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26065779681
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWJT-0000va-Jt; Fri, 11 Aug 2023 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWJR-0000uu-EH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:52:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWJP-0005q9-S4
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:52:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so13606695e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691776351; x=1692381151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0JOKxNu5pIpmtJ54GHnKMrSSPvnvsbRrAJDm0W5c4co=;
 b=iHoOQ/7ArumKkihGK17hzcTNoJsXncpDqTdkJqxsqsEW5IPrru3hxuPMnBHkncWrIy
 yMKUXYhz/UsBeirKOxtXkRWCLg/UUrvRxUI7O5kCgczixF7d5Dx8HnW96tQ1HiVoxgBf
 ovHjLw5JeyEzvs3MTmqWZcQYFUacLdkqtaBbaQ52j4GKlr9k1hm6iEvuOlcfJT44C5wJ
 HgMaoTVCOSV+SzXkapWuzYhwMYlW09ZFk2jzviYJcDMlcPbGOOszqY5UwIlI0T/kGnXw
 68HRI93QJ2tXCyTgY1R53ns8zUP85BMCwG4SJXD7nxizIXinlDc1FGJcW4qV3dRjhXap
 HiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691776351; x=1692381151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JOKxNu5pIpmtJ54GHnKMrSSPvnvsbRrAJDm0W5c4co=;
 b=EpLGmMap2DjrZWrtRWwRNT+nYijQwQetdRlxOc4PM/ie5iNXSbPU/iaVeGhc7ikwCN
 WhKI+FRfFE0Jz29cp4fRbb6Q5BCO6fVMeh2T+E8h3sNmDQXw4qTVZO4iydEsFGWBSY8O
 JXNUdbdthhFllEJv9Jr/RO0iLvw5Z2L7re9ASIekZGrAWtyW+aMPn3IBcG+o+NH+GPGA
 os3qHClnNb8sFjJB5C6XM/0P7N4+peqpiepI0pmo7cxWxNYa22rA6YBrnDiQe7iVJokq
 shShBx/MQsH2C467PKXSRn8pqxqnYf3M9ZjBV9YhHHATDiFcBi7WjJQm7i7ujr+Dq8fI
 JNRw==
X-Gm-Message-State: AOJu0Yyn/xfAS6VgLnUkPqMfMnyqZV+5KI5TC5FmbMvb0VCskjVWqfH5
 r4T4zCsQz4lEk/Su9Y9/h0/bgPFb74h88qlDEVI=
X-Google-Smtp-Source: AGHT+IFRxnGpKErHcIRQa+v9KqN0YQJ71+PJqvrE5h0gdMDlk1D1msQ4bQAaS5L4NbEy2Nes0vrdcQ==
X-Received: by 2002:a7b:c8c5:0:b0:3fe:23ec:2494 with SMTP id
 f5-20020a7bc8c5000000b003fe23ec2494mr2257712wml.7.1691776350756; 
 Fri, 11 Aug 2023 10:52:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d510b000000b0031417fd473csm6073421wrt.78.2023.08.11.10.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 10:52:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH] block/vpc: Avoid dynamic stack allocation
Date: Fri, 11 Aug 2023 18:52:29 +0100
Message-Id: <20230811175229.808139-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length array on the
stack. Here we don't expect the bitmap size to be enormous, and
since we're about to read/write it to disk the overhead of the
allocation should be fine.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 3810a601a38..ceb87dd3d8e 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -510,7 +510,7 @@ get_image_offset(BlockDriverState *bs, uint64_t offset, bool write, int *err)
        miss sparse read optimization, but it's not a problem in terms of
        correctness. */
     if (write && (s->last_bitmap_offset != bitmap_offset)) {
-        uint8_t bitmap[s->bitmap_size];
+        g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
         int r;
 
         s->last_bitmap_offset = bitmap_offset;
@@ -558,7 +558,7 @@ alloc_block(BlockDriverState *bs, int64_t offset)
     int64_t bat_offset;
     uint32_t index, bat_value;
     int ret;
-    uint8_t bitmap[s->bitmap_size];
+    g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
 
     /* Check if sector_num is valid */
     if ((offset < 0) || (offset > bs->total_sectors * BDRV_SECTOR_SIZE)) {
-- 
2.34.1


