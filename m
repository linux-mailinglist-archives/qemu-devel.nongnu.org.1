Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A772151A
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 08:19:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5h3N-00011m-8a; Sun, 04 Jun 2023 02:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5h3G-0000yg-IX; Sun, 04 Jun 2023 02:17:22 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1q5h3F-0000Zb-0b; Sun, 04 Jun 2023 02:17:18 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53202149ae2so2068609a12.3; 
 Sat, 03 Jun 2023 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685859435; x=1688451435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q6Oc9HbsGS9aOcw7kOs94Xz6lCtw6ph/LAxib+oVB8g=;
 b=orSWiN2UsYQgjRrFvkAeAkTooYaZi5w2tZrJVfBaALDY2ww0DoZI6ug9tV3Bz5/+lB
 CPhY/iaxDV9Lz9cABrDcPI9JHW6t5bLrUIFQdP1PI6dvXGBpdtBw6IvL1BgKPEkTj5oy
 hsvOCA1zTcGnwyREvgz9WUZl06NlP1thHBBEojLs4H4+tY/+ZIbLRSo8dv9Gvvry+3Qf
 vNzO9wvmjWR1rsxD4IW6ErRyfDuFTMonvudk5drdZHV2kjPFSGzVcbWyQ87FMss9iP6W
 4AIry5Q0ppYSqbKy/+g8ikExAx9AkqfS47pL+rmFsBa+d8cjjZaEUvkSLoMB2q2Atwbw
 TOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685859435; x=1688451435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6Oc9HbsGS9aOcw7kOs94Xz6lCtw6ph/LAxib+oVB8g=;
 b=G+mtCOXiuG0gKGC2oy/MpXXe1EswCKSEL0sDoSn3QUBhIyJx2QPVpn4ioVh7nkqSr3
 9UIIDacttlvaziTSjv6JStuRF+XlYfzbzAhqwA5IzHxHudHp10mi8iA3TDhpKjqA7yoa
 khOvNVyRh/uHcw9HY8BFEoIWigrjOHMe9XRlcAQhRRMioXFpS6Sj9xsnFNXNP1Kpi5u0
 1bbZ84hdGbZ1N5XwH2btK/60z0XPT6v6nwoqcVpUn97fwEimHZVyaRhVGBPFcy2+jvFd
 PgQYh/IyOSUwt1lRX4RgdvBc8xicMFEyXg2YQfCGFuf5cTS/92LwH2kOc1WRs/nPicj0
 2Bpg==
X-Gm-Message-State: AC+VfDz8kVM+orMA4CuNZAqPK6DQ46QCih9nXb9n+LBPc1Mn+4NxL6gm
 u6L+hhayyJmw49GPhEbucvxrYoIfjUEWl7VI3n4=
X-Google-Smtp-Source: ACHHUZ66pLGYjhVsHd6CJ8VUpW4+D6do4YoQl8VaDxgYGj2QyfgPuMmXLFKfDLdKrBSpxbz1DETwfQ==
X-Received: by 2002:a05:6a21:108e:b0:10b:71c:20c5 with SMTP id
 nl14-20020a056a21108e00b0010b071c20c5mr1461576pzb.51.1685859434417; 
 Sat, 03 Jun 2023 23:17:14 -0700 (PDT)
Received: from fedlinux.. ([106.84.132.254]) by smtp.gmail.com with ESMTPSA id
 iw22-20020a170903045600b001afbc038492sm4075982plb.299.2023.06.03.23.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 23:17:14 -0700 (PDT)
From: Sam Li <faithilikerun@gmail.com>
To: qemu-devel@nongnu.org
Cc: dlemoal@kernel.org, dmitry.fomichev@wdc.com, stefanha@redhat.com,
 hare@suse.de, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 2/2] block/file-posix: fix wps checking in raw_co_prw
Date: Sun,  4 Jun 2023 14:16:58 +0800
Message-Id: <20230604061658.49004-2-faithilikerun@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230604061658.49004-1-faithilikerun@gmail.com>
References: <20230604061658.49004-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=faithilikerun@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If the write operation fails and the wps is NULL, then accessing it will
lead to data corruption.

Solving the issue by adding a nullptr checking in get_zones_wp() where
the wps is used.

This issue is found by Peter Maydell using the Coverity Tool (CID
1512459).

Signed-off-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0d9d179a35..620942bf40 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1340,6 +1340,10 @@ static int get_zones_wp(BlockDriverState *bs, int fd, int64_t offset,
     rep_size = sizeof(struct blk_zone_report) + nrz * sizeof(struct blk_zone);
     g_autofree struct blk_zone_report *rep = NULL;
 
+    if (!wps) {
+        return -1;
+    }
+
     rep = g_malloc(rep_size);
     blkz = (struct blk_zone *)(rep + 1);
     while (n < nrz) {
-- 
2.40.1


