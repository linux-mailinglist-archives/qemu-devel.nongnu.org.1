Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3477A6C9
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:16:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpa-00088d-Nc; Sun, 13 Aug 2023 10:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpQ-00086c-J5
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpO-0000q5-Mb
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3196fdb3238so720204f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935941; x=1692540741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67G9fN2Q7zbfyveGtQLMpgK+UelnXLFsR1uug7FJ/Rk=;
 b=LenXUHvnvvigkVRnADNG1wnvFkxd7fMfksKiY3303VHwoScpnlTYz4OBLovAN1P+/P
 ROHLZW4EfyQMtDaPxdjowzfgLaA5tSH1ew8v2PP2RWAy0/Cpy+7rzCShzEoHRigo5qM1
 Vj4/VTr7EvNU9VobXI1RDaQyVKbW5dfB0fmH+FQyOFczO2XxxfTPTjZNWYcFeIMY7uW1
 YvUt6T8JJInSal6IYw6yX8IFt0b3jMSZgCkgne/gqQh5AFRYK7JqhmCRfmUaMg3tEVpx
 7VPTVr2Dh4ErQeN4cTtt7oL2r+RCDHjO8sAk01uiPdXyrOwyw2PFzw6VFT9Kumb9N9uA
 oaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935941; x=1692540741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67G9fN2Q7zbfyveGtQLMpgK+UelnXLFsR1uug7FJ/Rk=;
 b=j6/KJfjcbuF8zX1WzksvP6jsoYtLm02mOF/DXpV4AOgDO1lEF+H/57D7N/1R4WHBx3
 jjRrgCxadByNdy2LRDEVZWAMW500vLlhQvPyUiyNlWa406m66XN+2tMVEIzMa7YzBLpA
 SD1D8DP9y9AzZ9qyQFIenWR8HdHUGEqkRW7aPaT9PueBKKi7IUOo9Jln9PMNAZhT0vVx
 3gjl5Cr4trS6TYkRSdUjnRDcKmdIAP5xiSyeOIuK/LGGqwvs/DCZFw/dFz11Xmb8qDjf
 PAzo1aRJQ8UygoL33dXYDqyRSODPwah06sGxwC2KZwrGTzn3J13t4cjfmHejmd4d85by
 WWjQ==
X-Gm-Message-State: AOJu0YyYFjL+Am1X9vMEtYx/6oMnjCSJJuIRbnc7UbVAFD3MplgJZwIU
 ByPySs6ZoBF4G+7o+x3VdltEiVLH+Hc=
X-Google-Smtp-Source: AGHT+IEpJkE4oafqsTH1ed8bmaA4Ved2i4Bi6IP2E+5Ov4GOPZa+rSiCu42TlEfWlW0vcOBpbuxxLg==
X-Received: by 2002:a5d:590e:0:b0:319:6d91:28bf with SMTP id
 v14-20020a5d590e000000b003196d9128bfmr2706692wrd.60.1691935939525; 
 Sun, 13 Aug 2023 07:12:19 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:19 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 09/32] Add struct target_freebsd_fhandle and fcntl flags to
 bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 05:09:50 +0200
Message-Id: <20230813031013.1743-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 2aefdd205e..68db9cf4b2 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -339,6 +339,57 @@ struct target_statfs {
     char      f_mntonname[1024];    /* directory on which mounted */
 };
 
+/* File identifier. These are unique per filesystem on a single machine. */
+#define TARGET_MAXFIDSZ     16
+
+struct target_freebsd_fid {
+    uint16_t    fid_len;            /* len of data in bytes */
+    uint16_t    fid_data0;          /* force longword align */
+    char        fid_data[TARGET_MAXFIDSZ];  /* data (variable len) */
+};
+
+/* Generic file handle */
+struct target_freebsd_fhandle {
+    target_freebsd_fsid_t   fh_fsid;    /* Filesystem id of mount point */
+    struct target_freebsd_fid fh_fid;   /* Filesys specific id */
+};
+typedef struct target_freebsd_fhandle target_freebsd_fhandle_t;
+
+/*
+ * sys/fcntl.h
+ */
+#define TARGET_F_DUPFD              0
+#define TARGET_F_GETFD              1
+#define TARGET_F_SETFD              2
+#define TARGET_F_GETFL              3
+#define TARGET_F_SETFL              4
+#define TARGET_F_GETOWN             5
+#define TARGET_F_SETOWN             6
+#define TARGET_F_OGETLK             7
+#define TARGET_F_OSETLK             8
+#define TARGET_F_OSETLKW            9
+#define TARGET_F_DUP2FD             10
+#define TARGET_F_GETLK              11
+#define TARGET_F_SETLK              12
+#define TARGET_F_SETLKW             13
+#define TARGET_F_SETLK_REMOTE       14
+#define TARGET_F_READAHEAD          15
+#define TARGET_F_RDAHEAD            16
+#define TARGET_F_DUPFD_CLOEXEC     17
+#define TARGET_F_DUP2FD_CLOEXEC    18
+/* FreeBSD-specific */
+#define TARGET_F_ADD_SEALS          19
+#define TARGET_F_GET_SEALS          20
+
+struct target_freebsd_flock {
+    int64_t l_start;
+    int64_t l_len;
+    int32_t l_pid;
+    int16_t l_type;
+    int16_t l_whence;
+    int32_t l_sysid;
+} QEMU_PACKED;
+
 #define safe_syscall0(type, name) \
 type safe_##name(void) \
 { \
-- 
2.40.0


