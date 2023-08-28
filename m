Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69178BB9E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsJ-0003sC-6u; Mon, 28 Aug 2023 19:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrt-0003lI-EZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:01 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrq-0006kf-Tm
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:01 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34992fd567bso9188545ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266117; x=1693870917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js5uGTNiL5OfrpH4rvtEP/KDQaXnj1Ew+khBSJh9KNc=;
 b=q2IfnPHWJjq5kLUeYbxkHAYNUVe9SrgL4/OvTHTkF7psvNK7LCuwte6y9zBuCUl5ji
 1CBf81hzwryx1zXS5NJgP2Nj70Qkxh6rlA+rQin5OfrhhCCwMkSSWG4j3RjjsA+T/wIh
 6sd00rk4yEH9NFGk296eUAM8hHZ062iEUc/L9tpEN27ELk4+rkiT93v4LSZvn89FXbt/
 iRWHvnKa76Ld9RW8EaTY1oQhrJlnGewFoNXnX/Mr+jhg0s2Q90AQkffN5MaIQNu4VFYb
 bFrignfLCwTKuGO1MePYCRpIYcIQVrZvYDU9iqCJn9Gm4wcWzdzLp0BLlDHKgbZPtASe
 soEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266117; x=1693870917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js5uGTNiL5OfrpH4rvtEP/KDQaXnj1Ew+khBSJh9KNc=;
 b=Vki9C0K6iiHCERfaGZOPdnxyhDJc7xgHYWRd9tts0y9dYvGNbJXExOXJRzdVDZhIfP
 kodIgtwI4fMV8tKbgzwo96qXe+ER4av8wDR4y9hPJrbdWI0EIumeuW5Pd8qZFdIX7kl7
 od9rynGxf/EXIDlLBPLlwRVH0+023Oe3RxYMZguhGPDm2GiT2SHVhlRANgNnkNqkMihH
 3gVS5oZUGEFKrE7JThtZxI/P9u/qA87vdGOJAG8aCtnFQolQzTlnp8eDCoew8OA5Pm4Y
 tEq1lKJD9xGX4hPI9q5urcdFi0jTCUpY8Hkfs5xhtAixA4wr+gV5yPqrCPT2EhlCdkAn
 N/JQ==
X-Gm-Message-State: AOJu0Yz/+VOSsn94tR0IKdFx9/mMqlzi2tpTW/3Sq2D/uOQEPYXVsrFp
 lj7vDxQsxW0KWUMUfDG9iqt75TMN3rVUF4Uf1BA=
X-Google-Smtp-Source: AGHT+IGhTk7rdbR0atqNqbDDSY7QlaWAgDkymosblAywPMC29EJjPwix+VJ3/gdIc9ur6N9JlKsmPQ==
X-Received: by 2002:a05:6e02:2184:b0:348:b07e:fdac with SMTP id
 j4-20020a056e02218400b00348b07efdacmr1175383ila.3.1693266117513; 
 Mon, 28 Aug 2023 16:41:57 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:57 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/36] bsd-user: Implement statfh related syscalls
Date: Mon, 28 Aug 2023 17:38:06 -0600
Message-ID: <20230828233821.43074-22-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12d.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the following syscalls:
getfh(2)
lgetfh(2)
fhopen(2)
fhstat(2)
fhstatfs(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index f8f99b4a723..935663c0713 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -127,4 +127,87 @@ static abi_long do_freebsd11_nlstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getfh(2) */
+static abi_long do_freebsd_getfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(getfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* lgetfh(2) */
+static inline abi_long do_freebsd_lgetfh(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    fhandle_t host_fh;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(lgetfh(path(p), &host_fh));
+    UNLOCK_PATH(p, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_fhandle(arg2, &host_fh);
+}
+
+/* fhopen(2) */
+static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(fhopen(&host_fh, arg2));
+}
+
+/* fhstat(2) */
+static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_stat(arg2, &host_sb);
+}
+
+/* fhstatfs(2) */
+static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd_statfs(target_stfs_addr, &host_stfs);
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.41.0


