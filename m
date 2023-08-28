Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3378BBB5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsP-0003uf-7Y; Mon, 28 Aug 2023 19:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sb-Eb
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals4-0006mP-11
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:18 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bbe9e916cso13113305ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266123; x=1693870923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0W3d2u7rz+/pVZ99RWkIygZtbsFMR+b9Wlcog4VF1M=;
 b=ocZbhnk6VtC2ugHu5MFbB/QiDiDlKaKxnPcXsTcQWNNU+a7vn/3TqBV5d0c2Pb9J+o
 tEDviJEA3sBJXKYQAc68bWxcAShmxVO775PuY7z0AErfYYjMi7YUzk2762b4sTDl7ZLG
 4OyaksTlh5NBcbSB8ayFebkFJqjC3jqGaVzbOTGDcJ60QRIBWL7gMLqFfk5opNrl11RC
 6h7b/SzwTVcLC8tr9I2mHsCur4ZYRVjfolJRqB758oRbox2P+tQuSoyEjM4myc82ocCr
 g1YVOvLjVD0yPg+uD+RxmA78aT3dPsZ97C0m6qr445K43I3uimi62Ed4UOY1EGAYI5mK
 Aasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266123; x=1693870923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0W3d2u7rz+/pVZ99RWkIygZtbsFMR+b9Wlcog4VF1M=;
 b=cemP/+rwE76YzOZDu8tgRaSNvedDrfGHuhGGohqslR73mfT6KWySwsRAuMpuyuveG/
 J0ppg+CcjW1bVYPZvFF3R7fFaE0d0rYbZKfwsJ8LaPdttKf6IH5DOZ3BMfU2WhSOEU+1
 zDE4+KCuVXVPCzGRKe4coGpYghGFtYrm2MKSFknN6mBgucQKEIOMTLnMVRujiPk7mfjd
 x2nZFiAO31R1UdS5bwUQI8PWebWTEpK+6J36TrOiFNM6JDhv+YFFo+6AA+U3jVto7u+D
 OKbEl/UJMf4pLP6LjVtlm7ze3gsSQPoLRF04WjEghIrzDQ9/AbOeSBcqMZNahM+4H3gg
 hq6Q==
X-Gm-Message-State: AOJu0YwlNqN3lM7dpBuyY8Fx6hgbC8P7+hAwK5A/uh/skDBA+DgWOukC
 3toVPjjkc7VSTcCn2SoXoHtY0jwDgz+bZu0tjZo=
X-Google-Smtp-Source: AGHT+IHmS/i6d+TgnIGFjBE0N8RLTQK2xvKi/jw0iekhFT7ck8qdE3E4G0jQ3NNqJ+XyNkZk72qhXA==
X-Received: by 2002:a05:6e02:1b04:b0:34d:ec00:2ce9 with SMTP id
 i4-20020a056e021b0400b0034dec002ce9mr173671ilv.26.1693266123165; 
 Mon, 28 Aug 2023 16:42:03 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/36] bsd-user: Implement freebsd11 statfs related syscalls
Date: Mon, 28 Aug 2023 17:38:12 -0600
Message-ID: <20230828233821.43074-28-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 2e0c7245dfd..04a61fabd11 100644
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
2.41.0


