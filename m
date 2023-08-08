Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44997740D2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDs-00040t-E3; Tue, 08 Aug 2023 13:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDo-0003XY-0O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDk-0003ip-GE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so50287455e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514610; x=1692119410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tixgSZaHS/ZX2Ev+4ktdHOXajBb1vL7WwQRW2iV2F2s=;
 b=qcNzImgvPCDC//LZRkZ4cKEPvxq5Pmc9lL27Bo1/8gYXlVS7F7uOfG2pFKxFnJLnQP
 kgzdWwvAvLFHW8x2kf9T0Eu2r5aBlQSnvTNgkGVqAGlLAcWD+53n9JNG6dspYrw+QIPU
 oXxdfU5iJhbPxAJV2O/nHhyave1iio5CZapBqQ95NWnJECeMTgE8ojr/j3K6MEjGQhmR
 6bKyUkYJhoHYZGGWi1O+qm2HF8Vp7FaVfJwwDPo1Oe40JRKdYSdmXXBhy1jX+yTyyc4+
 a/2v3DmswC8o7o4RPJFdUYtoNqWba1e37J3EjD27arrDCnO7i39342T0eqr5Mq8BkqUB
 jFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514610; x=1692119410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tixgSZaHS/ZX2Ev+4ktdHOXajBb1vL7WwQRW2iV2F2s=;
 b=XheqtsEsAOtOnwe3VqeQp8Jj7Ust+p73kEwU+n4LXE6kiOwQRsDQJvKggG5ZIWU/Fg
 xj2OWIYVBwtd424UpLV2zDObdOhRf7PrNxSqP8dLal5S83GHWQi62eMnjIS4dI+j4YuS
 pDd9epDbMRZ/TNBrQeRhXCh+7kotRr8QshPlmYjdhGyc/+wiUUk5OAFGqc2rt/4EOfQV
 v2uF27WnvluP3HQ/tYu7STyTBSw53blT+eVJYEhyV79+99jmQSPR0dkhfq5OoTNWhSac
 MFNqAaS07nFdM5djzlwJ3wyj3PcG3I7ERBjAntdOZTjYt4JK7PKP33qWALXb67pKK/QR
 bRxQ==
X-Gm-Message-State: AOJu0YxbnrHVT46Uc3Z//91fWynVcfHTl3jtnCjeg+Bsc/VJ4CkmSl3U
 XRtzEaczp2oc6l3wqg05O9dQvX0MJpB+uQ==
X-Google-Smtp-Source: AGHT+IGBB1r85AWYkP2iaRIDiPavglhbdwRIqr0AY5NPgGwigTiZ97GSLMd5fJAbaUzTE9uqXqb7Ig==
X-Received: by 2002:a7b:c34e:0:b0:3fb:ffca:b6b8 with SMTP id
 l14-20020a7bc34e000000b003fbffcab6b8mr348207wmj.41.1691514610535; 
 Tue, 08 Aug 2023 10:10:10 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:10 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 25/33] Implement freebsd11 stat related syscalls
Date: Tue,  8 Aug 2023 08:08:07 +0200
Message-Id: <20230808060815.9001-26-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x335.google.com
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


