Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2371A77E87C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2d-0002LH-Lh; Wed, 16 Aug 2023 14:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2b-0002Km-3o
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:45 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2X-0003gC-K8
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bdcb800594so26909765ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209680; x=1692814480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k/dj6N9E+0jkaseus+SrmWswgP+JZzh/61nYmUDIMo=;
 b=xsavGthWJfPmf7wY17BG/sRbOU/PcrmVAX5O/SkOpAQVfbqz1tOd8FvHVLzKWTQ8+E
 KKKDYv/yxSpADkDEeiYoRpcjZWNhxiAfDREjAUjfsPHFaA6/T+9m01br8EIi+8Bk6HxH
 cmkbve2JpA6j5SMtrLxzs7LhwQw47hFo++cZyk4YHmrnb7Ylbnx1he8nmca28uECPsla
 kV+aCkbKCyclZ2qNXNHg6ge3Q7o/q+MRIhyIn95A8u4nhrEHuwMmnMryUgPO/yusMtbm
 Q8hICjUje4umNTgO3IVv8eHYCTmuyev/Hd7U79ABxx+b1ETdTtgQJbWK+0ZCpKfhWkbx
 rPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209680; x=1692814480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9k/dj6N9E+0jkaseus+SrmWswgP+JZzh/61nYmUDIMo=;
 b=XyDUZafpcRLADUvZQq7PBEq/3hELoD4OO6o47gvAplnwPqw0qK8dCoFbcLCRqU4lyC
 byW9vDA4Qj9PnJegpsBkP1r71EvCmbEVDVyEGgnqfOhDeG2mQ2kq5FXxvxP651C/KKjr
 z8pEfA0ddlAlC1GhBx0pd5b8IoDChKL35Ei8iDk5zsx/p3sg7JeFQSxFgABYP85JLoPj
 RefzbzXyCT//XG/ucwLyaijiileyQUnjtNXUCQVG/oMsmPDZ4lIBdsD85aAj/LsmppDV
 yQhFx2eMWdkqIgdrBzu7097govLypdT5bJKfd2J8kSWmPJoeeprlGUmrAnS7W8VNEAER
 ydYQ==
X-Gm-Message-State: AOJu0YygPh5qpZ0Ii4oZnz4d+2aqhT3LpYe4nBY5AvCblVt4Xei3XzzU
 /4MbEWPA3rUS48tLE5ylwzOrGDTEKhOeq9V1eSo=
X-Google-Smtp-Source: AGHT+IGg87w4CCRhoIe+O9RvCph+Fh5Xu2rb3xDDc39MgDBBcaair7fbr6XXj9XeCYVk9Cfb0Meadg==
X-Received: by 2002:a17:903:246:b0:1be:3d5:ef6e with SMTP id
 j6-20020a170903024600b001be03d5ef6emr3134272plh.32.1692209680376; 
 Wed, 16 Aug 2023 11:14:40 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 1/6] util/selfmap: Use dev_t and ino_t in MapInfo
Date: Wed, 16 Aug 2023 11:14:32 -0700
Message-Id: <20230816181437.572997-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use dev_t instead of a string, and ino_t instead of uint64_t.
The latter is likely to be identical on modern systems but is
more type-correct for usage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/selfmap.h |  4 ++--
 linux-user/syscall.c   |  6 ++++--
 util/selfmap.c         | 12 +++++++-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/qemu/selfmap.h b/include/qemu/selfmap.h
index 7d938945cb..1690a74f4b 100644
--- a/include/qemu/selfmap.h
+++ b/include/qemu/selfmap.h
@@ -20,10 +20,10 @@ typedef struct {
     bool is_exec;
     bool is_priv;
 
+    dev_t dev;
+    ino_t inode;
     uint64_t offset;
-    uint64_t inode;
     const char *path;
-    char dev[];
 } MapInfo;
 
 /**
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9353268cc1..074262b3ac 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8160,13 +8160,15 @@ static int open_self_maps_1(CPUArchState *cpu_env, int fd, bool smaps)
             }
 
             count = dprintf(fd, TARGET_ABI_FMT_ptr "-" TARGET_ABI_FMT_ptr
-                            " %c%c%c%c %08" PRIx64 " %s %"PRId64,
+                            " %c%c%c%c %08" PRIx64 " %02x:%02x %"PRId64,
                             h2g(min), h2g(max - 1) + 1,
                             (flags & PAGE_READ) ? 'r' : '-',
                             (flags & PAGE_WRITE_ORG) ? 'w' : '-',
                             (flags & PAGE_EXEC) ? 'x' : '-',
                             e->is_priv ? 'p' : 's',
-                            (uint64_t) e->offset, e->dev, e->inode);
+                            (uint64_t)e->offset,
+                            major(e->dev), minor(e->dev),
+                            (uint64_t)e->inode);
             if (path) {
                 dprintf(fd, "%*s%s\n", 73 - count, "", path);
             } else {
diff --git a/util/selfmap.c b/util/selfmap.c
index 4db5b42651..483cb617e2 100644
--- a/util/selfmap.c
+++ b/util/selfmap.c
@@ -30,19 +30,21 @@ IntervalTreeRoot *read_self_maps(void)
 
         if (nfields > 4) {
             uint64_t start, end, offset, inode;
+            unsigned dev_maj, dev_min;
             int errors = 0;
             const char *p;
 
             errors |= qemu_strtou64(fields[0], &p, 16, &start);
             errors |= qemu_strtou64(p + 1, NULL, 16, &end);
             errors |= qemu_strtou64(fields[2], NULL, 16, &offset);
+            errors |= qemu_strtoui(fields[3], &p, 16, &dev_maj);
+            errors |= qemu_strtoui(p + 1, NULL, 16, &dev_min);
             errors |= qemu_strtou64(fields[4], NULL, 10, &inode);
 
             if (!errors) {
-                size_t dev_len, path_len;
+                size_t path_len;
                 MapInfo *e;
 
-                dev_len = strlen(fields[3]) + 1;
                 if (nfields == 6) {
                     p = fields[5];
                     p += strspn(p, " ");
@@ -52,11 +54,12 @@ IntervalTreeRoot *read_self_maps(void)
                     path_len = 0;
                 }
 
-                e = g_malloc0(sizeof(*e) + dev_len + path_len);
+                e = g_malloc0(sizeof(*e) + path_len);
 
                 e->itree.start = start;
                 e->itree.last = end - 1;
                 e->offset = offset;
+                e->dev = makedev(dev_maj, dev_min);
                 e->inode = inode;
 
                 e->is_read  = fields[1][0] == 'r';
@@ -64,9 +67,8 @@ IntervalTreeRoot *read_self_maps(void)
                 e->is_exec  = fields[1][2] == 'x';
                 e->is_priv  = fields[1][3] == 'p';
 
-                memcpy(e->dev, fields[3], dev_len);
                 if (path_len) {
-                    e->path = memcpy(e->dev + dev_len, p, path_len);
+                    e->path = memcpy(e + 1, p, path_len);
                 }
 
                 interval_tree_insert(&e->itree, root);
-- 
2.34.1


