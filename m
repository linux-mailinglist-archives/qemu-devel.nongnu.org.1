Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684047B7543
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovy-0004nm-S5; Tue, 03 Oct 2023 19:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovq-0004Vi-Af
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:02 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovg-0007Th-KU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:58 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79faba5fe12so57777939f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376151; x=1696980951;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQsJ8aRx34rU+BSo16ILhtd0DDp2FIzYDvvE6gfNhKU=;
 b=C//SUph2bxxglbF/2VxlSQAGkIcHgj22gZ9INDaZgEx/JM5NO3kGJ8zZxhzSvNHo0N
 DCEJX39+IKuyJnq9FmFS71wDnkkR+/FQil8ZeDasLKDMaLpHMrimHAVgUiVjzRcYQlik
 qXqmYCPJddQzRBZcTkG0jQ0CMcY6M+FLjyySNuyaszXnl9yYNlg4nRbEMzr6GmjDkEQm
 aJGQl/QuYF0NP0G6d9034Eb4nMB6YlT50ESePbiE97OA6jXc0tfAByEsdOzKa1vKPnTE
 pPqlfpYUpaF5wTCNbw+IlG858esVsc+zZcuQCapKtTo2+zvYM81nkbBnlY1Aaj7u/FMG
 b8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376151; x=1696980951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQsJ8aRx34rU+BSo16ILhtd0DDp2FIzYDvvE6gfNhKU=;
 b=da6rIaVvJ80lIcyvk05CdHEKpZUoahc5u/ngpIHGyYxCRQyqtCjXzM3HWWI1DQFpAk
 aJvQ55+ZZcCNrSe78ibKFHOmYkBUfwnP3QsNNo6TZ2TyNHdzoZCiQEyJlP2x9NC+ZEr0
 5umg/pC5/a6qllv0Neo5GAeB146ShJZ/IuX9yyiiV70XXi3IXnSnERYmyrxhQZxJedeP
 I0lbu8E6RuJxLphDLZ0bUONxx3NuRlWd/+HJKa4HITA1UoX3k23osX62wCSYFTcx0hJ0
 LLt6cKzFmifAfve5lVxRyoewvowU0+TUB5ccMWMyJiuRmrapbe9kwHW3WZ9/InupRv2X
 9qpg==
X-Gm-Message-State: AOJu0YzjzkCiJLXnkiauCTbuilUXdH8imdqNsWfdLOgI0Gs1S8SzX3a2
 TyC43uSVPHiFKCZW+lBsAPyZBX1E2AdrFH7R3VImcA==
X-Google-Smtp-Source: AGHT+IFO8VMixQfnBRpfHvBiTa0e3rYsXETfRm8ppcSf9j0Fwp71HyQvkUkP2dY6u/QmT4gTFfEqKA==
X-Received: by 2002:a5d:9943:0:b0:79f:d194:d6e2 with SMTP id
 v3-20020a5d9943000000b0079fd194d6e2mr1054628ios.10.1696376150744; 
 Tue, 03 Oct 2023 16:35:50 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 48/51] bsd-user: Implement shm_unlink(2) and shmget(2)
Date: Tue,  3 Oct 2023 17:32:12 -0600
Message-ID: <20231003233215.95557-49-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d35;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd35.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-21-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f8dc943c234..c362cc07a30 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -282,4 +282,27 @@ static inline abi_long do_bsd_shm_open(abi_ulong arg1, abi_long arg2,
     return ret;
 }
 
+/* shm_unlink(2) */
+static inline abi_long do_bsd_shm_unlink(abi_ulong arg1)
+{
+    int ret;
+    void *p;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_unlink(p)); /* XXX path(p)? */
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* shmget(2) */
+static inline abi_long do_bsd_shmget(abi_long arg1, abi_ulong arg2,
+        abi_long arg3)
+{
+    return get_errno(shmget(arg1, arg2, arg3));
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 0d4c3118f0d..4f67677eb92 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -859,6 +859,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+    case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
+        ret = do_bsd_shm_unlink(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_shmget: /* shmget(2) */
+        ret = do_bsd_shmget(arg1, arg2, arg3);
+        break;
+
         /*
          * Misc
          */
-- 
2.41.0


