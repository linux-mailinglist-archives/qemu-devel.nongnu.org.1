Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C007B755B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovR-0004CM-Gh; Tue, 03 Oct 2023 19:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovO-0004B2-7K
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:34 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovK-0007Cm-9F
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:32 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79f909071c3so60621439f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376129; x=1696980929;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUbIdhN9Y3KW08Z4NFjwxOiSbSnqRae3Iwiwnvnh+H4=;
 b=QfVLKGNoe2H/3DpPLXtE/ZiUs5T/FuqUhB5qs3tpl+ivpKa68iYtzVwHjvy/P9FHQC
 UAG/SplyIfG/p6LEfzHO/TPUk9vkGVvMrkPzEDbX5E9L3hd3JDnnSQuu3gPEohzn6oS+
 tbiWsB8KvdSF+euZ3eARgZcbd2TFprp5C0TaY0IDCSs1eYINQQb6UmUpY7UiFWbPjq+H
 eT9UdMPuTyi1wymSeLjYSOclyYizmDlWymPqpSuo4D0ziKSamF6hgCbo5Jn6ynUXjDEb
 LQ6Jh3V1aNEuyxNFX05Cqk6UcM8kXLkYFl/mYSmzF3SJubyNM0VdX7x/N/Gn3gEGtSsG
 jKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376129; x=1696980929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUbIdhN9Y3KW08Z4NFjwxOiSbSnqRae3Iwiwnvnh+H4=;
 b=wNbGkqr0hhbT9lhtEZgBESaDEmKrYK5ctjDwOkWxlI2UX3v3Eh334P4MhbtYZ3RA/7
 1dL/U/E4bQ5QSZiLDIolsIMt3MprSlfIqRmEFkibuD42yGOtLQQDzfqS7E4sk48YP9te
 XnpvlKtSs7OkIwxPmqFzdLcgVTKrul0pl35tA2IKuVtTj+5zjvSeaefxGArX5Ew6dyGv
 b3xy1HuPCwqn4ntrYQfZozpktw2dNtywYcf5ZKsH2T+vdAUdbLaDnowjFygMq3GVKHtu
 +5FDchMYnHfmZ0ffOzjnew79pUt0vNfR5MfE/J7LTBMUFwygqVeNfBZfVxMLpe8KxLuQ
 hlpQ==
X-Gm-Message-State: AOJu0YwPDlr93NOwNJyOTLi8za1NLkOQ1lNYvv0aFB6B69suhoefGHNZ
 L8ygNsiyFOC6Ho5rm3jP62Cm+sKRFRL1JaVWp+bU/w==
X-Google-Smtp-Source: AGHT+IEZUz1APCDkGc4HP7xH/e6MXjZtYED1MPQI0gtnrQy0+BEJrwGfzepntQuNF6EoMTfXtkq83w==
X-Received: by 2002:a05:6602:39a:b0:790:f735:4d30 with SMTP id
 f26-20020a056602039a00b00790f7354d30mr946352iov.13.1696376128874; 
 Tue, 03 Oct 2023 16:35:28 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PULL 24/51] bsd-user: Implement setloginclass(2) and
 getloginclass(2) system calls.
Date: Tue,  3 Oct 2023 17:31:48 -0600
Message-ID: <20231003233215.95557-25-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-25-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 04bce755e58..2eaba141dcd 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -130,4 +130,36 @@ static inline abi_long do_freebsd_wait6(void *cpu_env, abi_long idtype,
     return ret;
 }
 
+/* setloginclass(2) */
+static inline abi_long do_freebsd_setloginclass(abi_ulong arg1)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setloginclass(p));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* getloginclass(2) */
+static inline abi_long do_freebsd_getloginclass(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user(VERIFY_WRITE, arg1, arg2, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getloginclass(p, arg2));
+    unlock_user(p, arg1, arg2);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 55e68e48159..d614409e694 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -375,6 +375,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_ktrace(arg1, arg2, arg3, arg4);
         break;
 
+    case TARGET_FREEBSD_NR_setloginclass: /* setloginclass(2) */
+        ret = do_freebsd_setloginclass(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_getloginclass: /* getloginclass(2) */
+        ret = do_freebsd_getloginclass(arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_utrace: /* utrace(2) */
         ret = do_bsd_utrace(arg1, arg2);
         break;
-- 
2.41.0


