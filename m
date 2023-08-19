Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75A17818A5
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZs-000881-BV; Sat, 19 Aug 2023 05:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZK-0007sD-Qv
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZF-0004FD-93
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so16333515e9.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438503; x=1693043303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtWQErPsfmqjBLE2FgdZ3jKytvyM+bVeZHZz4VRAnn0=;
 b=apsaA/t/TpdL08Ud+WfCRjZe80XZcxARKncOwV09x1iyGsndzw0Ni6lBCzUQxGqDPp
 HyKwHbUl34HT98tcXQVkPh5S2Llic9NkcvHdeJhrvJl5A+XFei01G+wAI+tLdDNAvXXM
 toCNK+Ftj5nueOEJHxsXbkKP1iRA964cIR0jVYtI4ebdSLegS3cCt4T0K+BtHT7yczOG
 lujtfPos6NKq1E340k2s4VJhebVHdXxtDaKIOKwN71x5I1fiZ814WEC29zIQmo4NnR8c
 AqoOea4O6i2x12v67HDL+/3IlXRMN9PQSLuisYheNcL82PRZywsVWeiIde/yzFK2XC7x
 VrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438503; x=1693043303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PtWQErPsfmqjBLE2FgdZ3jKytvyM+bVeZHZz4VRAnn0=;
 b=agYuznJgh8TCErZIgZv5sDViarazGsQJNFq8vJrTCHtK1GNzbQuDfyEbAS1khzMYWN
 0UbnZiXpSQFbe9C6KzvoCQjweMkCgbnqX0zXzo4Z51JDFl1XmSvc722Hl0mSy627CDxi
 GLCf0kT4N5f0MkN88YqkL035vG1WIfdDOfPB92uQAvHgtj72xg+IFDTCKeEAT1we8TT7
 i49g/WMjMlDZH34ZIQ4X/t8snpy9PTGqtjYXyGh/ZM9I1SjhsaR0BErm1Ow6zJmz8s6d
 Gsd5s3Az3EC3QPtl7FVi6QPqj28sTDEyWv2muSzwchU65VdtO8ZnX4+TSACYrt1vzfi4
 SiEg==
X-Gm-Message-State: AOJu0YwIkxL9hutjoGreInC+BdphDJXWZJTVFlYT4N2PdnoXAyokX49x
 /c7luNYlk4094HpaYdMKOlnbVGgzZiY=
X-Google-Smtp-Source: AGHT+IG6Nc4dGBsz4n09/4MkkHvIbi8KPycChlz0CHJBKvjcyCsSjtVgOsm7vXY26JvN0CBV56BR/A==
X-Received: by 2002:a5d:5452:0:b0:317:759a:8ca8 with SMTP id
 w18-20020a5d5452000000b00317759a8ca8mr1057630wrv.67.1692438503291; 
 Sat, 19 Aug 2023 02:48:23 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:22 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 01/22] Implement struct target_ipc_perm
Date: Sat, 19 Aug 2023 11:47:45 +0200
Message-Id: <20230819094806.14965-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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
---
 bsd-user/syscall_defs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index e4825f2662..39a9bc8ed7 100644
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
2.40.0


