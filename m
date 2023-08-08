Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D078F7740DB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDi-0002j9-Ef; Tue, 08 Aug 2023 13:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDf-0002W3-8c
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDd-0003af-Hc
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb724cso37655215e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514603; x=1692119403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V12SEFgO7V2wqeQzkvP82FVnLLqFe5FtytN409qLtJs=;
 b=IdCUv0PRRDTdLG5rl1utGgc7wL7tGk4jZfVCKp2lOh09mktLkkmwsmI30grtJqZccw
 o2eUIGGqPzDFXILQ5IuQ0w0U4/mSMBC0I55DmrMPmklyspYl+3TtyfEzw4i2YHnJRqjp
 acx/nMZdgvqIxKrcd84poL4MG4itmRyO0dqUgHjgIv+02gRY7EkxEbw8dXtvASYfL3nA
 +kNjNHT9nxD28jsHaH4mVxt9gYervRnAUU2yLD5kS2jG7sYT5QKrxyMxbgVtRj3SMenu
 ToY7xPOVSlzvTmIjMBY1mFLRWjUvxJVHbobbIlNV+jk/cdGoHTWEzdMjPVKpXkcIdG32
 30ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514603; x=1692119403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V12SEFgO7V2wqeQzkvP82FVnLLqFe5FtytN409qLtJs=;
 b=YB/sYL+R24h5dt6p1i5Ft6Y5WxYxHZDDXRqnDUAVE851sAN/GWvs9/3hcbNg1NgEEI
 0QwUk7amWRHVL5IpKbCYr6rq7Q9s3GEFP927ze1r5f2YChPwWvZJ3JwU52EotY7677Dp
 llnBrqRdGtbH3tgDuoGq4PBqEpEYU+KkDLNv4kwQ5pF9SNACpiumg7QbHU/h07ZfmGOl
 UP+2QPNjt+JHybsNRDqZrXOW3jLtuhY9MhpXnK8++8hJnuv9lc/uTckfvoXiw7tUzfHl
 j410Y0ktw/LSJv0LECy0Ih3WhanErYxW2fHj83itzF9iRZSMPYcYBs1hMoKbnGFsmQ65
 L7uA==
X-Gm-Message-State: AOJu0YzCCs5LRjR6NRSdX/KdTm0k4w+ao682c2S4I7QepHJ3IboetMBP
 EeeK9a8fg9CtOWerbHwP3WwEM4AyUyNFlQ==
X-Google-Smtp-Source: AGHT+IGQyKpMFPorWnBIf7Ae6RenCyoYmDB3cCTIYCxQvCU+gAfoPORHjhGMZASTfGd4v2OUwklOLQ==
X-Received: by 2002:adf:f043:0:b0:317:e515:d624 with SMTP id
 t3-20020adff043000000b00317e515d624mr28478wro.45.1691514603099; 
 Tue, 08 Aug 2023 10:10:03 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:02 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 20/33] Implement stat related syscalls
Date: Tue,  8 Aug 2023 08:08:02 +0200
Message-Id: <20230808060815.9001-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Implement the following syscalls:
statfs(2)
fstatfs(2)
getfsstat(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 935663c071..9492c93c55 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -210,4 +210,73 @@ static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
     return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
 }
 
+/* statfs(2) */
+static inline abi_long do_freebsd_statfs(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct statfs host_stfs;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(statfs(path(p), &host_stfs));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd_statfs(arg2, &host_stfs);
+}
+
+/* fstatfs(2) */
+static inline abi_long do_freebsd_fstatfs(abi_long fd, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct statfs host_stfs;
+
+    ret = get_errno(fstatfs(fd, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd_statfs(target_addr, &host_stfs);
+}
+
+/* getfsstat(2) */
+static inline abi_long do_freebsd_getfsstat(abi_ulong target_addr,
+        abi_long bufsize, abi_long flags)
+{
+    abi_long ret;
+    struct statfs *host_stfs;
+    int count;
+    long host_bufsize;
+
+    count = bufsize / sizeof(struct target_statfs);
+
+    /* if user buffer is NULL then return number of mounted FS's */
+    if (target_addr == 0 || count == 0) {
+        return get_errno(freebsd11_getfsstat(NULL, 0, flags));
+    }
+
+    /* XXX check count to be reasonable */
+    host_bufsize = sizeof(struct statfs) * count;
+    host_stfs = alloca(host_bufsize);
+    if (!host_stfs) {
+        return -TARGET_EINVAL;
+    }
+
+    ret = count = get_errno(getfsstat(host_stfs, host_bufsize, flags));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    while (count--) {
+        if (h2t_freebsd_statfs((target_addr +
+                        (count * sizeof(struct target_statfs))),
+                    &host_stfs[count])) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


