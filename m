Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D360D78BBBF
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsO-0003uP-GA; Mon, 28 Aug 2023 19:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals7-0003op-4w
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:15 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrv-0006ln-Ir
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:05 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34dea77cbe6so868265ab.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266122; x=1693870922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEJ4yqkPcxV2O/9AHiCAR4WW/EWetmRbNI/78P0DXQM=;
 b=oB4rcYZ90Hlw5DvYlo/Hsiutr4oX3YPVmKvokuXCqFJepWlesxElcAz5rlsmiGy9ZQ
 p5Iy+hIyXqIIZ11Du5yFRM/yXQoRDgfaE9dWMmEXx/jYIlCzcrz8j2PVPYZuQN8GjN1Y
 NvoQNUDpZ/FCMVwCQ0YV6iVV9OtWm5XCZMiFyWr9iX5ZsqKwuOnT9Cg64pXaGtCI7+ad
 AZ6nB7X2H8kLRISxrfriJoGli2mfi/YKA+eyoUfRoHagrVwcaQ0pIkIUXuMH63vpoaWc
 gaKkaf+coT1Eb+LdlE7JpjUvod6/jJUJ54alNrjhEy3Gfj2RgtuC5SkedpPBVN7VypHM
 RzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266122; x=1693870922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEJ4yqkPcxV2O/9AHiCAR4WW/EWetmRbNI/78P0DXQM=;
 b=H8XvyD2UZu4cc/w0SCzgUUPRHBKnsQfqUd74fIP/DCpasb8cfRDVxY7+fdB05X+007
 UNCwiKPVcBWAwZTKlgGIGxMIFKsDbdaPo7yiT2yivGOSh/oS9NadPevMbw5Kc4h4l6+F
 FHLk43k74vi4xKK6jIAY4oBs5U9KVUzcfJ58CDs9PoAOwmLo65baat07ese0uSRQQe8Q
 3k+Esgdy6Qlcnhz6J6ZZEECEIiN9JQT6Su25p1ML1jEa7oR0Qz1JawE5d4V2ovCh4UV9
 TTOCzZvspEx/aZilGBjeZrDUE63lrfTOYAiYLwjmyYX+EEUlweiTstbcH1hb6SOdUxXn
 x3gA==
X-Gm-Message-State: AOJu0YyNQ4Ml3fM91HXn1NTesUZQiWtlzrOANmQmebxq/F5KXbslXLqt
 3OLrRUAHdqWsfnNVuwgqoZ0V6sTyQsxP7U0vY+A=
X-Google-Smtp-Source: AGHT+IHW8M083XZPgWZvYazEHB0XbclWznI0JRH7d8seInbyqIvbUSU4JOpULAOZzuc2fjDdc7dd4w==
X-Received: by 2002:a05:6e02:dcc:b0:34c:c7c6:d8ed with SMTP id
 l12-20020a056e020dcc00b0034cc7c6d8edmr15593946ilj.13.1693266122228; 
 Mon, 28 Aug 2023 16:42:02 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:01 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/36] bsd-user: Implement freebsd11 fstat and fhstat related
 syscalls
Date: Mon, 28 Aug 2023 17:38:11 -0600
Message-ID: <20230828233821.43074-27-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12e.google.com
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
fstat(2)
fstatat(2)
fhstat(2)
fhstatfs(2)

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 78 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index aef55c8bb53..2e0c7245dfd 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -24,6 +24,17 @@ int freebsd11_stat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(stat, freebsd11_stat, FBSD_1.0);
 int freebsd11_lstat(const char *path, struct freebsd11_stat *stat);
 __sym_compat(lstat, freebsd11_lstat, FBSD_1.0);
+int freebsd11_fstat(int fd, struct freebsd11_stat *stat);
+__sym_compat(fstat, freebsd11_fstat, FBSD_1.0);
+int freebsd11_fstatat(int fd, const char *path, struct freebsd11_stat *stat,
+        int flag);
+__sym_compat(fstatat, freebsd11_fstatat, FBSD_1.1);
+
+int freebsd11_fhstat(const fhandle_t *fhandle, struct freebsd11_stat *stat);
+__sym_compat(fhstat, freebsd11_fhstat, FBSD_1.0);
+int freebsd11_fhstatfs(const fhandle_t *fhandle, struct freebsd11_statfs * buf);
+__sym_compat(fhstatfs, freebsd11_fhstatfs, FBSD_1.0);
+int freebsd11_statfs(const char *path, struct freebsd11_statfs *buf);
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
@@ -57,6 +68,19 @@ static inline abi_long do_freebsd11_lstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstat(2) */
+static inline abi_long do_freebsd11_fstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct freebsd11_stat st;
+
+    ret = get_errno(freebsd11_fstat(arg1, &st));
+    if (!is_error(ret))  {
+        ret = h2t_freebsd11_stat(arg2, &st);
+    }
+    return ret;
+}
+
 /* fstat(2) */
 static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
 {
@@ -70,6 +94,23 @@ static inline abi_long do_freebsd_fstat(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* fstatat(2) */
+static inline abi_long do_freebsd11_fstatat(abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p;
+    struct freebsd11_stat st;
+
+    LOCK_PATH(p, arg2);
+    ret = get_errno(freebsd11_fstatat(arg1, p, &st, arg4));
+    UNLOCK_PATH(p, arg2);
+    if (!is_error(ret) && arg3) {
+        ret = h2t_freebsd11_stat(arg3, &st);
+    }
+    return ret;
+}
+
 /* fstatat(2) */
 static inline abi_long do_freebsd_fstatat(abi_long arg1, abi_long arg2,
         abi_long arg3, abi_long arg4)
@@ -178,6 +219,24 @@ static inline abi_long do_freebsd_fhopen(abi_long arg1, abi_long arg2)
     return get_errno(fhopen(&host_fh, arg2));
 }
 
+/* fhstat(2) */
+static inline abi_long do_freebsd11_fhstat(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_stat host_sb;
+
+    ret = t2h_freebsd_fhandle(&host_fh, arg1);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstat(&host_fh, &host_sb));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_stat(arg2, &host_sb);
+}
+
 /* fhstat(2) */
 static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
 {
@@ -196,6 +255,25 @@ static inline abi_long do_freebsd_fhstat(abi_long arg1, abi_long arg2)
     return h2t_freebsd_stat(arg2, &host_sb);
 }
 
+/* fhstatfs(2) */
+static inline abi_long do_freebsd11_fhstatfs(abi_ulong target_fhp_addr,
+        abi_ulong target_stfs_addr)
+{
+    abi_long ret;
+    fhandle_t host_fh;
+    struct freebsd11_statfs host_stfs;
+
+    ret = t2h_freebsd_fhandle(&host_fh, target_fhp_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(freebsd11_fhstatfs(&host_fh, &host_stfs));
+    if (is_error(ret)) {
+        return ret;
+    }
+    return h2t_freebsd11_statfs(target_stfs_addr, &host_stfs);
+}
+
 /* fhstatfs(2) */
 static inline abi_long do_freebsd_fhstatfs(abi_ulong target_fhp_addr,
         abi_ulong target_stfs_addr)
-- 
2.41.0


