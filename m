Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9597B756A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovT-0004DO-UQ; Tue, 03 Oct 2023 19:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovQ-0004C4-3C
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:36 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovO-0007Mx-LY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:35 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-79fce245bf6so58303839f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376133; x=1696980933;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azy/SYSaQ16IVZQzbRRCdYoe/s4kbJ733g8Itr242Ak=;
 b=LrNVoSpGcix51dVDz75z8iuPx0I5MCAMFl8zc5a5ZJEdyzZr3LBP7lhBBuqF4FvmHu
 hVipKubW8Pktj47+MZLWdiHCPmd6linurKJy3JiR24YG2zeA7qLRyDDu84wCc5ivNYNx
 2mhYXQykeaBfWZXapoSkMJMq7ka2TUDqhIMj1qEEm/1F8CpUuvP2XCz7eOi7zKAM1bkD
 uqAwiiwNRcdNKeMMegwEAKpIFOYR07HPJKuT5RS1bkRQQLl9Lff9OjcT9j1os1JDVwHI
 no/1UK/jUbD5TrBpf/SRME9WTN8X5Vi69jIi9GEZK/BUhdSFVIFljO0w8uZfxlBj1hgZ
 6bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376133; x=1696980933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azy/SYSaQ16IVZQzbRRCdYoe/s4kbJ733g8Itr242Ak=;
 b=Qfp8oYnoDq6CUD/yAxkUKkgldy0j+fY6PtxuFrjDMH3wpHhzX8LRe7+v+mUEzSw2pJ
 4SxZqs6CcT+sZU/znsvc8JblUiIl258QcbiQKbLvkt+VAHm+1J5objtRijKHIsVVu7sm
 WgbXTJqxrqSrivFrVkCGMbPEajFp+kRlhF/WlhY4BsGDCZNDxzPHh9Tlca+tNUua5Yds
 Z7F5p0Zj2pTNo96hlTpR/wCaCLux15S0XyeYpEccPrmh0ucqMrAiKDPX3lOi4NoedHWB
 4QHrtQlrOLEdNMEX7pRnGpw1jDi9m4ZEksRwT1EzTys2Kt/aJ47+u/l11tQ1c1sITL4j
 BuYg==
X-Gm-Message-State: AOJu0YwQot5AtZ6bgzLWTZ3bYAPPMf9ARppju5h2B/bFw9FIt5oGZ8wf
 8E6feYtQ+vKXDZkcueEM6oeA4TACxWbB4X8qS56Pyw==
X-Google-Smtp-Source: AGHT+IH/lqG4uzzUMfFhHWMdPvFEcvbvSkBfz2WcmuPUt56nPuR7jWtoxxbGaXNodf2lxoMTiNdh4A==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id
 t13-20020a5edd0d000000b00786710072demr895226iop.16.1696376133350; 
 Tue, 03 Oct 2023 16:35:33 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:33 -0700 (PDT)
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
Subject: [PULL 29/51] bsd-user: Implement struct target_ipc_perm
Date: Tue,  3 Oct 2023 17:31:53 -0600
Message-ID: <20231003233215.95557-30-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd31.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-2-kariem.taha2.7@gmail.com>
---
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index a3bc738ff89..0e54d7df690 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -55,6 +55,23 @@ struct target_iovec {
     abi_long iov_len;   /* Number of bytes */
 };
 
+/*
+ * sys/ipc.h
+ */
+struct target_ipc_perm {
+    uint32_t    cuid;       /* creator user id */
+    uint32_t    cgid;       /* creator group id */
+    uint32_t    uid;        /* user id */
+    uint32_t    gid;        /* group id */
+    uint16_t    mode;       /* r/w permission */
+    uint16_t    seq;        /* sequence # */
+    abi_long    key;        /* user specified msg/sem/shm key */
+};
+
+#define TARGET_IPC_RMID 0   /* remove identifier */
+#define TARGET_IPC_SET  1   /* set options */
+#define TARGET_IPC_STAT 2   /* get options */
+
 /*
  *  sys/mman.h
  */
-- 
2.41.0


