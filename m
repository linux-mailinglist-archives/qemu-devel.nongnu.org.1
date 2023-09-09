Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D9799A93
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mp-0005ZU-Jg; Sat, 09 Sep 2023 15:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mn-0005YX-4k
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3ml-0003C2-0a
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:28 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso32885115e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288305; x=1694893105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJTRK8Tm4oCBWcEts58SyC6/NTwYSAeOzRKwQE1l8qs=;
 b=JSZ3FM1U/RY7BPwFJ4hubRcmpS8EYSnaecIjIUI6gY2rMRE5Ra4nWrjdd04Yy2iBcZ
 ESMI+Og5BFHB7gkE6vcjOeF2V6/F+uha2J+rB+QxsJTRGrSpbVI4rshG+aFq4+4Q0U1Y
 yrnPq3Gs137Dw2fdbzQCNdaYgAuRcZI6vhOlQRLdGrUzV4GLvVHCx+QGH7bz/eGZ6t84
 IFNHIBikSNALhPCoLEVn2ako9c5kU8v4C9mvXmYWsPTZ5JaaCQiln98MnqMQjjfAqYZj
 B3LqmTCsmlqVO4mTu8zoGgRp+6EDu9Un29Xxo9p7W85aM997AdQiM688wWaMRmmzlFAi
 B8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288305; x=1694893105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJTRK8Tm4oCBWcEts58SyC6/NTwYSAeOzRKwQE1l8qs=;
 b=DwTxk2lPlaf9cmPb4/y3HC6MuyFyjh3+YkoRnFwe1ya5QKZOxDol7e6DzElQEtCWwv
 MF/JEJBAqcoGt47Xzm+o/HrvFXOAiTBFdhJa8qW/TfkFw2VRwDkacVbC/AOgQlEHCdl1
 +tcd+4m67gsZ+YWGXhv+X3uRy4kbfDYpjOqz2BUbc60uWr9psl9gR+KwMloFIdfsZTHU
 6n2OLI5aUkuefyEQZvxTJgVIa93eDr5EsqGhOQzFCvrE3KpPAD4H531eGjtJN7cigemu
 wFvz36iq1sj2dujgHDut/MT3DmXdSl4KlNgZLn65beZ0mqOA0UCpEGuILfXWit479ny9
 jbng==
X-Gm-Message-State: AOJu0YyW2tgYTUfdw3sGNOPEELHEbRnGBrU2oCsMXd3NQxFN1EWKUBAn
 YzIqNKlJBbSIwMJG8INKZYt+bCVnOIQ=
X-Google-Smtp-Source: AGHT+IG1VYWZtYYAqO+dbhf9/wUm1sEDsJ4fp5I7lzWuNdVtb6WH5Mpzc5cbJuQ+hqnsSH76UZJopA==
X-Received: by 2002:a1c:7c0e:0:b0:401:6800:703c with SMTP id
 x14-20020a1c7c0e000000b004016800703cmr5679881wmc.21.1694288305327; 
 Sat, 09 Sep 2023 12:38:25 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 01/23] bsd-user: Implement struct target_ipc_perm
Date: Sat,  9 Sep 2023 22:36:42 +0300
Message-ID: <20230909193704.1827-2-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
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
2.42.0


