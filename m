Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 028887ADF0E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK5-00088X-QM; Mon, 25 Sep 2023 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJy-0007uK-IK
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJv-0007iz-Kg
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4053c6f0d55so67631535e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666514; x=1696271314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7uKJtjQDxrpcslNDuL3FuFOFPTPw3U7VbY8diH7n9M=;
 b=iFUOzVbRIbFMn44zX1fNr4oMZfzxpbZZhtfG74dkIDrtfjiZVD/tGG4cV0k4h6QqMb
 rksR4LcpW2LlWccCPWGOK5TwHk5jQOgnrcOkvQhAZ2ls+xx5saUljbUgvqD1D5IBrp+M
 duNqQMCjSoB2rSBynoTcORArAA+hFEsIIFU6JPotrAwGeN/gwdzfwUrRtwcl2lvbLoIK
 mX6tYz4wiHpoxT48O7ZSYzDCOoyD2QwpGkHC1yHtsLik/sdT60HeoZ+WFC7nggWpisyO
 XRZdRHACNIrlj84Q63S3unHPsFWJwE0bBxeB3RMl4TyzqOaXPij68/oQsQ1iyH+l4aJy
 iwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666514; x=1696271314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7uKJtjQDxrpcslNDuL3FuFOFPTPw3U7VbY8diH7n9M=;
 b=CBYGEs1qR15ffzMRyelNvCz83JQhEOAKQ9MH9/zfsGpAtB3cvWzj7vtPHBWnhZ4Gum
 f1qYYPUj6UfAE3/j/hhOsOuboZxloXeUqAGPExkUI4jUtXSS4m1EwRq5bEpXTbn6kjrl
 G6wxgIk3EIDE4kJJWlyZtPcIH5QTx76xBN4y6ZSDKTxvuxsl1w7MZ0eu5GM8dx4nx+tO
 aNA4l3azq5HxeYLq6dvAGHi0mwdJTvIYDH4DXVDl6AITJCoOzLqo/0J136A/hxJbvt1S
 1kFfE2AsW1I/xUJ79gPynDXtmjTqQpJE9n4SBgfS0LoXV0nUZ+PF6XPQ0i/D1RSB12ER
 qetQ==
X-Gm-Message-State: AOJu0YwhnGpk63V97oEFn6ha0N9pvaWkJBXOsUGCx9UugPLRFvNMVZZ3
 0WjgCOGRE5km5/cdt2N4B4D/TB3HNEs=
X-Google-Smtp-Source: AGHT+IHjyfi7mOXQXrmmy1PrutILlLosPprDGhqW9+KFZAnnb0/J49lbahChbH7vhSNb7h0IqamGSA==
X-Received: by 2002:adf:d087:0:b0:317:6fff:c32b with SMTP id
 y7-20020adfd087000000b003176fffc32bmr5885459wrh.53.1695666513850; 
 Mon, 25 Sep 2023 11:28:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 01/23] bsd-user: Implement struct target_ipc_perm
Date: Mon, 25 Sep 2023 21:26:47 +0300
Message-ID: <20230925182709.4834-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 9c90616baa..4deb4fed35 100644
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
2.42.0


