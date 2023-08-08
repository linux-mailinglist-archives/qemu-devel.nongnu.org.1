Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3067740EF
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDg-0002Zy-TB; Tue, 08 Aug 2023 13:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDd-0002JW-38
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDb-0003P3-BE
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:04 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31771a876b5so4448609f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514602; x=1692119402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVcqaRcVj6JvKDy2BJiIRh7pr/hsDHDhyGBchxOUhao=;
 b=g6X68JpfiS/XEfLIV0wmuGqW28reBoijKxuRJ13j9aQQojuvArqxjIfJxxuaKSjvYB
 tx3Qcl0Te85Pv1EVVZ0RxrzfF5DqYgG/UlgW6qit+b51r86CgPXic7zYdcIs+uLnCMpy
 VQxXxo1b3yd7GdUdfbZ4mxiM8BSsEZWOgTFys0qItkhab4IpwT9Uc/tI3HTNsP20yIot
 R15juivMS2uSY4SuUMzWXpL5askx8u7JoJpATJgGV+cDbwFs2CJOA+xhWYcdOiGx43eR
 EwCIomUdjtA9je6tRKMuROM6HockT1mDNDxvUti6mrte9817WqalFYATfFF6SMC4O0LC
 NRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514602; x=1692119402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVcqaRcVj6JvKDy2BJiIRh7pr/hsDHDhyGBchxOUhao=;
 b=XWIhWwrC/8lbh0M2zzLDjTsoI1TfP48NJ+dinDFev/RFLXtDXDu75FDNr8L4t33Ccm
 glUBFrYjmjYA4BWJxZig4g3ctrEHnzMHzsfUvMJNcu0lSOO8YblLPJVfWArP67fBZwNN
 EfpTusIX3snWWg0NlaeEfFPg/4Ul15Np/CdPoM0Xgl3A/2cDdfaadAK6y30dFB79U1LD
 Rs7uoQeL+E6kfO+1KPV6eXl5QvOtXqmOWbzbf7PKDpOmR2cO5L3mhGcNCrxc10aixlxv
 xFGGEMuzXGvYNzuJrJp+WwPgc+rcabYgsrgng6zeczUMaXBOYWUPBcDF+C3cqNeuIL2H
 w2cA==
X-Gm-Message-State: AOJu0Yx2bgKxdqLblBq3/peyw2TxVM/C9mRyS8bGorGmV2X6V/6b/RBa
 uI8eGO2xo5c6fBGBcIR83gdB909miLsV0g==
X-Google-Smtp-Source: AGHT+IG8yJVfUTcaxOukmrUO0O4G7IP9DsJbDwXEMdGV4S0J78/HRmmJatcLp/5jmw5Aen+7aA/4Rw==
X-Received: by 2002:a05:6000:1185:b0:317:6c19:6445 with SMTP id
 g5-20020a056000118500b003176c196445mr50034wrx.39.1691514601713; 
 Tue, 08 Aug 2023 10:10:01 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:01 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 19/33] Implement stat related syscalls
Date: Tue,  8 Aug 2023 08:08:01 +0200
Message-Id: <20230808060815.9001-20-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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
getfh(2)
lgetfh(2)
fhopen(2)
fhstat(2)
fhstatfs(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index f8f99b4a72..935663c071 100644
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
2.40.0


