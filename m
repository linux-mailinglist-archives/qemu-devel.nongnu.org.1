Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957677A6DC
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpv-0008GD-MV; Sun, 13 Aug 2023 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBph-0008C7-H9
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpf-0000u5-Ig
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so31497465e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935958; x=1692540758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MONonAVf/x+5s65BrH15EWH3H62fPVv1nAh+5Em/Wk=;
 b=HAZ4wCuodd/LUniGxU76phqFz1/GDn2C+3ZT4bC06fsTVaPUx3tdFX7alQqgN2rhLY
 HB7gIOTZBucBcgJWmwMvLSdm66vu+AeHmSyaYlMGBnlLcKn2SMZg6KafUYwOVXyHWjbo
 Jn80yv7AalgFQuH0Tn46pI8Shq68X285QDGmE+TteIRu7Uq/DfjB9SpAq0K2Rp28pKJN
 VCxC0Q6z468rG2yXe0mbJGN1RyF0E+f0N47fBm5r/ao5o2XGJnewejHXCUQxonnFSN3T
 RqUl73NlHziTUXrF0/7h3568G64+yo6jhbObl7kLq3d2Q2ycOHu30+x3Kp9TNsr6mn+S
 uhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935958; x=1692540758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MONonAVf/x+5s65BrH15EWH3H62fPVv1nAh+5Em/Wk=;
 b=fDsR+XRR3Ikb8alPDvDfia5DW38dqziQ1rvyHr+vj3eo9d5FS65YpYhxaO0AF48u+T
 DkU6Vez1tbqOK5Bpm7By2xoj8c8n5WnIs1TaiNvnaVTlKDo4CJFacaoxhh+Ph34uixck
 pk2eeFf9buWpJmmLfpEyqfG/kJbGk3oXgiJuPI4llr5uHV3RejwaNxsAY4vpIJtHCh1I
 8xN0hKaxDypUguAKmpvE5IKRgwV1T03kwYC6y3efEnX1Jf1pG1jna7Fs+9BB/tM1iiH9
 u1WiJohAE4QhDhGDJP2elPq6QMBAlNibGdejsGRz7L0YtZb9CDtki/EaChfnLFBbEntt
 nM6g==
X-Gm-Message-State: AOJu0Yxot+2Dlrl3db41D0fB6t+IK6rOWbIqQjwWDixUKF5kHFML7mEV
 a0L8deRFXbDIP9ZHL6u8+zkMSp4po0A=
X-Google-Smtp-Source: AGHT+IExw3Cw4vUs6nM2Ws9z0kOonYRhwDgiwWtXWyKasEh1bC6+VO1E7ZSsIZEcrf/1wIvLPY2WpQ==
X-Received: by 2002:adf:f086:0:b0:318:fa5:d84e with SMTP id
 n6-20020adff086000000b003180fa5d84emr4361985wro.70.1691935957801; 
 Sun, 13 Aug 2023 07:12:37 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:37 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 24/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 05:10:05 +0200
Message-Id: <20230813031013.1743-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Implement the freebsd11 variant of the following syscalls:
statfs(2)
fstatfs(2)
getfsstat(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 2e0c7245df..04a61fabd1 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -32,9 +32,15 @@ __sym_compat(fstatat, freebsd11_fstatat, FBSD_1.1);
 
 int freebsd11_fhstat(const fhandle_t *fhandle, struct freebsd11_stat *stat);
 __sym_compat(fhstat, freebsd11_fhstat, FBSD_1.0);
+int freebsd11_getfsstat(struct freebsd11_statfs *buf, long bufsize, int mode);
+__sym_compat(getfsstat, freebsd11_getfsstat, FBSD_1.0);
 int freebsd11_fhstatfs(const fhandle_t *fhandle, struct freebsd11_statfs * buf);
 __sym_compat(fhstatfs, freebsd11_fhstatfs, FBSD_1.0);
 int freebsd11_statfs(const char *path, struct freebsd11_statfs *buf);
+__sym_compat(statfs, freebsd11_statfs, FBSD_1.0);
+int freebsd11_fstatfs(int fd, struct freebsd11_statfs *buf);
+__sym_compat(fstatfs, freebsd11_fstatfs, FBSD_1.0);
+
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -293,6 +299,23 @@ static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
     return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
 }
 
+/* statfs(2) */
+static inline abi_long do_freebsd11_statfs(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_statfs host_stfs;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(freebsd11_statfs(path(p), &host_stfs));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd11_statfs(arg2, &host_stfs);
+}
+
 /* statfs(2) */
 static inline abi_long do_freebsd_statfs(abi_long arg1, abi_long arg2)
 {
@@ -310,6 +333,20 @@ static inline abi_long do_freebsd_statfs(abi_long arg1, abi_long arg2)
     return h2t_freebsd_statfs(arg2, &host_stfs);
 }
 
+/* fstatfs(2) */
+static inline abi_long do_freebsd11_fstatfs(abi_long fd, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct freebsd11_statfs host_stfs;
+
+    ret = get_errno(freebsd11_fstatfs(fd, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return h2t_freebsd11_statfs(target_addr, &host_stfs);
+}
+
 /* fstatfs(2) */
 static inline abi_long do_freebsd_fstatfs(abi_long fd, abi_ulong target_addr)
 {
@@ -324,6 +361,44 @@ static inline abi_long do_freebsd_fstatfs(abi_long fd, abi_ulong target_addr)
     return h2t_freebsd_statfs(target_addr, &host_stfs);
 }
 
+/* getfsstat(2) */
+static inline abi_long do_freebsd11_getfsstat(abi_ulong target_addr,
+        abi_long bufsize, abi_long flags)
+{
+    abi_long ret;
+    struct freebsd11_statfs *host_stfs;
+    int count;
+    long host_bufsize;
+
+    count = bufsize / sizeof(struct target_freebsd11_statfs);
+
+    /* if user buffer is NULL then return number of mounted FS's */
+    if (target_addr == 0 || count == 0) {
+        return get_errno(freebsd11_getfsstat(NULL, 0, flags));
+    }
+
+    /* XXX check count to be reasonable */
+    host_bufsize = sizeof(struct freebsd11_statfs) * count;
+    host_stfs = alloca(host_bufsize);
+    if (!host_stfs) {
+        return -TARGET_EINVAL;
+    }
+
+    ret = count = get_errno(freebsd11_getfsstat(host_stfs, host_bufsize, flags));
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    while (count--) {
+        if (h2t_freebsd11_statfs((target_addr +
+                        (count * sizeof(struct target_freebsd11_statfs))),
+                    &host_stfs[count])) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
 /* getfsstat(2) */
 static inline abi_long do_freebsd_getfsstat(abi_ulong target_addr,
         abi_long bufsize, abi_long flags)
-- 
2.40.0


