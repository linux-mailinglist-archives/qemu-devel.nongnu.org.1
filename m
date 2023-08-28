Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66278BBA2
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsT-0003yU-H8; Mon, 28 Aug 2023 19:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sf-Gt
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006pg-VG
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:21 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7927952ca67so111766339f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266125; x=1693870925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyoTisO2SKxuhTiuJ9PKmqpK606MeGtTF1rKK3KRIew=;
 b=SnxSUaT8prZEZLkE5rYh6vABPAesJUE3zZMCj9kVZkKSlzt6ndSw4wxuhg+gxQikNy
 nemwWP7jFov62oQksIKWCtnW7NI4rvqnYlskkQWHQeRzggiGBz18jo/2cFyTVE3OqP1+
 DNqWuNXfte6XXfPT1cDGEfEqjK5YhOxmXNVJoaBB+Gn91om4aDKy7iPIZgesGYvjyk61
 GKrtBgLXYTuJ3ZHQO4gdzPc5NEBkd/bi4DZQovl4mrG7sFBpnozE/n4CLoi5G4F0414Z
 vPMCY8aNIqoue4hDNgPDCy9I+DBCXwxZ3XSrHGuDuzN+1DfY4fgYpH/D5iUf0ZVMRQW1
 zp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266125; x=1693870925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyoTisO2SKxuhTiuJ9PKmqpK606MeGtTF1rKK3KRIew=;
 b=lqIifajE0FhKOTYUx7JvjzKX4qN5LKMmE5LOCNOciVfuCMCCE1RMOrUisSSwD7DysW
 ChnyzNBkZ/2grfjiNrEmY0HboYjS3irv8o8wYLr4RuYqC9Mo1tTLYXz1NBA19u9WufQe
 NENGbnSRfwSdr3tRsFfan6coFNX3wnhIJL4z8cjYf1mwj5RrDmVEb/7ojyT5KySJJ7P7
 eUQb8G4aomXhuYaJyNBJmU0EINioI1T5PraNqt2DVo9OObkzAmZu/6cbO+dv2SfVIcPW
 oKwU/2NkcH06muWvyN44b5/ob/K7QIXqyBgnqzFeuAhu6ggH11GRsvAa36s96np+t233
 tX0w==
X-Gm-Message-State: AOJu0Ywq1fMk5ryaqsRQBIPA7oS8MsQL1Db8NY1r2Ub9EjsoyRPmWYO2
 LrKSTLNdRsxv6CXGIwOifkRUeBDgxKNlxCMXDBU=
X-Google-Smtp-Source: AGHT+IErX26p4SQAV5Z/y3Irempszw+b1XQfjHZQIOLRqUu7V092lL4IB8RM58p3eLP80lo/VLUmgg==
X-Received: by 2002:a05:6e02:1d1a:b0:348:b114:a3d2 with SMTP id
 i26-20020a056e021d1a00b00348b114a3d2mr22811719ila.21.1693266125236; 
 Mon, 28 Aug 2023 16:42:05 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/36] bsd-user: Implement freebsd11 netbsd stat related
 syscalls
Date: Mon, 28 Aug 2023 17:38:14 -0600
Message-ID: <20230828233821.43074-30-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
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

Forward declaration of the nstat syscalls:
nstat
nlstat
nfstat

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 26909af455d..e31b2aab9e8 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -46,6 +46,13 @@ __sym_compat(getdirentries, freebsd11_getdirentries, FBSD_1.0);
 ssize_t freebsd11_getdents(int fd, char *buf, size_t nbytes);
 __sym_compat(getdents, freebsd11_getdents, FBSD_1.0);
 
+/* undocumented nstat system calls */
+int freebsd11_nstat(const char *path, struct freebsd11_stat *sb);
+__sym_compat(nstat, freebsd11_nstat, FBSD_1.0);
+int freebsd11_nlstat(const char *path, struct freebsd11_stat *sb);
+__sym_compat(nlstat, freebsd11_nlstat, FBSD_1.0);
+int freebsd11_nfstat(int fd, struct freebsd11_stat *sb);
+__sym_compat(nfstat, freebsd11_nfstat, FBSD_1.0);
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
-- 
2.41.0


