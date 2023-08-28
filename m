Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214778BBAF
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrt-0003kU-3T; Mon, 28 Aug 2023 19:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalro-0003hz-OG
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:56 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrm-0006jc-GV
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:56 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34cc0ad6f61so13464095ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266113; x=1693870913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwFVwEC3aiItv5/cugiAZJ9x7ROCgkBOW62fSEi/E4U=;
 b=yhPOy3eIn6Qtbvr/4KxFFqqBkejfa2I1uwiA42kPfnY+DG3oYaDXLd6G3xRkV9q/tD
 KlmGvTQv3g9d5Uwm/8l+U4B5fHt+XpGP2XacJ/fL4xjNb0FmM3UFDRs+RgtmHdqgxEwY
 gXy9bLGcWxqa3ATL8aO7G4iU1Qt0Kw1cYSEOtq8Brs6nELzshmcvvplVzyXpIhCoPTU3
 LOmrH5lNGoar0DthU/vOsxDwu2vRuyihRzNUWM2jWZV5UxCELrqIhnPL/4lClGNa/mPh
 cPEkoJaIZp2alXm1loghrURY0qZ5Y7Oh3gKOVz22lB3gwJmRGg9iOXfN9YoW7VGqM3U/
 sG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266113; x=1693870913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwFVwEC3aiItv5/cugiAZJ9x7ROCgkBOW62fSEi/E4U=;
 b=IKstrbXmLAiyBrxQPltYikmlAURl0oz6eCDYHqeYmysCXdyTlkern3v+z1GSnQ/L66
 ReZGUJobzaQFPljMvuw5CgfSdUKCU2RZRH+n8DRrWGf9NsrOIv5AZWZ9RFZYDI3ZVNZM
 Ndo5Amm8TaueMMPhAJY8B0dNCIta33LU2nQ+dNVmLA2mxnrNBqmYvYUOj27OsMhF68nv
 43yUWIGP94LunE/hRxxEojW+Fo/ZZpQHSd3AkukLIAdXIS0D5EInGTDiqnPxuhLjKNCu
 kMqyRE2DOi2lNBw8Z9u7KnuZ0bod5DW9s0RfTGoJ/73pZXKwiminWQ4aTPQmyrraEmBd
 bT3g==
X-Gm-Message-State: AOJu0YyQfGeD1h9LLHDcTm11vZHuFu2dSO1WBOKiDNmDmYilE9ACdSUR
 iX7tl0/Cc1SlzP0V2APeEPX3J1bufOjWV4Hkyds=
X-Google-Smtp-Source: AGHT+IHLozdniee7dOXjznCOGGBV5R68VXtxYWsj0adTokD50Ilw/UiTPNRYa8vjhvnhlK+uTEStkA==
X-Received: by 2002:a92:505:0:b0:34c:cee5:4bf5 with SMTP id
 q5-20020a920505000000b0034ccee54bf5mr14999391ile.5.1693266113071; 
 Mon, 28 Aug 2023 16:41:53 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:52 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/36] bsd-user: Implement h2t_freebsd_fhandle
 t2h_freebsd_fhandle
Date: Mon, 28 Aug 2023 17:38:01 -0600
Message-ID: <20230828233821.43074-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Implement the stat conversion functions:
h2t_freebsd_fhandle
t2h_freebsd_fhandle

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 8c73f7402c2..6716cee3e22 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -92,3 +92,40 @@ abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * file handle conversion
+ */
+abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_READ, target_fh, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __get_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(host_fh->fh_fid.fid_data, target_fh->fh_fid.fid_data,
+        TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh)
+{
+    target_freebsd_fhandle_t *target_fh;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_fh, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_fh->fh_fsid.val[0], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fsid.val[1], &target_fh->fh_fsid.val[0]);
+    __put_user(host_fh->fh_fid.fid_len, &target_fh->fh_fid.fid_len);
+    /* u_short         fid_data0; */
+    memcpy(target_fh->fh_fid.fid_data, host_fh->fh_fid.fid_data,
+            TARGET_MAXFIDSZ);
+    unlock_user_struct(target_fh, target_addr, 1);
+    return 0;
+}
+
-- 
2.41.0


