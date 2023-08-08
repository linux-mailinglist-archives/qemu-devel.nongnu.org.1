Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A77740CA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDl-00037h-2Y; Tue, 08 Aug 2023 13:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDi-0002pI-4z
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDg-0003gB-5b
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-317715ec496so5100150f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514606; x=1692119406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvFPlgrYHpsc/4GkTgJK28/M4h5pOfI3dgSj1J3z6O8=;
 b=DrwaRMDJiX7Zd4zf5+NzJkr+vkyqrMMtXVwu0bQlmNi2DV6qXe8fWlKi88Svkp0ync
 OvdAqpQUjbr0KqIiZr0yfydi+s5uZkDkFDG2IDFIK8fBmdvqUYLut7nHeNrPtmdmVhI5
 HqYn43MavoLPbRMUoAHjENFxW5qz6l6GYqoWXKcDmvW5c17YSWBWdncW6mCf/8uMJKY5
 fpaXUENOIL7xYUiuKrJ07+v42PVjbwp60hjeJF19prR2w7+7GWxR7NUZwtfD6lQ5keNT
 ES+d30zedsohhVy4bx39OQAYX+w6k3dMgLrIBMmWK/X4k6m09TJ3HNlDTM1rf2Q2ARW2
 L0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514606; x=1692119406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvFPlgrYHpsc/4GkTgJK28/M4h5pOfI3dgSj1J3z6O8=;
 b=MFsYISoV3A43k3y5672SmQREszxD7UoTcEPSrgHZ+/X8q6ywo9gCaGdOgN5GWhSRpZ
 Jc+psEdexsx9GJXVhUYM4N+WTXqsh4omm2JbyAJaMycCnW8AadqFXoQc+k/i8Mt6Qbdk
 hKHVw72Ki46LJMc+HxE5xvzypt9QX5KwlptbpUeC1SfC/fdPvYJH2r6YGnIylbRPqoPe
 0nuII2+X4dnqVwUz29nET2T2K5Ho6DHnMKz5/KBUQgnXCIq0ClsVZAZ1DHv/Vk2rrwF/
 6q87xa1I/ySYRoXEdhsdB67sBqyecJlBHE2n1SYbkwts37odwDSDQ7GnQqEJcUTFHGyu
 4A2Q==
X-Gm-Message-State: AOJu0YxQ9wr7SR0gxenV0YE3/2695zjyhHyguvIMmQgG8VKUqr4HH2pi
 YoDfipdkB03bbWzJ/r7xBhrfKCkZ5EzvhQ==
X-Google-Smtp-Source: AGHT+IG2usyka+Ri9oAPZkAAmn9GMKQ5uOpZmpW5EWBIU6VFT0yc3zLLHx59oOErwOMpbP9PcYJRFw==
X-Received: by 2002:adf:f4ca:0:b0:317:6fb5:bafc with SMTP id
 h10-20020adff4ca000000b003176fb5bafcmr38183wrp.65.1691514606454; 
 Tue, 08 Aug 2023 10:10:06 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:06 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 22/33] Implement stat related syscalls
Date: Tue,  8 Aug 2023 08:08:04 +0200
Message-Id: <20230808060815.9001-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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
fcntl(2)

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 7dc41cd0bf..5d9323c7d1 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -351,4 +351,78 @@ static inline abi_long do_freebsd_getdirentries(abi_long arg1,
     return ret;
 }
 
+/* fcntl(2) */
+static inline abi_long do_freebsd_fcntl(abi_long arg1, abi_long arg2,
+        abi_ulong arg3)
+{
+    abi_long ret;
+    int host_cmd;
+    struct flock fl;
+    struct target_freebsd_flock *target_fl;
+
+    host_cmd = target_to_host_fcntl_cmd(arg2);
+    if (host_cmd < 0) {
+        return host_cmd;
+    }
+    switch (arg2) {
+    case TARGET_F_GETLK:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        if (!is_error(ret)) {
+            if (!lock_user_struct(VERIFY_WRITE, target_fl, arg3, 0)) {
+                return -TARGET_EFAULT;
+            }
+            __put_user(fl.l_type, &target_fl->l_type);
+            __put_user(fl.l_whence, &target_fl->l_whence);
+            __put_user(fl.l_start, &target_fl->l_start);
+            __put_user(fl.l_len, &target_fl->l_len);
+            __put_user(fl.l_pid, &target_fl->l_pid);
+            __put_user(fl.l_sysid, &target_fl->l_sysid);
+            unlock_user_struct(target_fl, arg3, 1);
+        }
+        break;
+
+    case TARGET_F_SETLK:
+    case TARGET_F_SETLKW:
+        if (!lock_user_struct(VERIFY_READ, target_fl, arg3, 1)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(fl.l_type, &target_fl->l_type);
+        __get_user(fl.l_whence, &target_fl->l_whence);
+        __get_user(fl.l_start, &target_fl->l_start);
+        __get_user(fl.l_len, &target_fl->l_len);
+        __get_user(fl.l_pid, &target_fl->l_pid);
+        __get_user(fl.l_sysid, &target_fl->l_sysid);
+        unlock_user_struct(target_fl, arg3, 0);
+        ret = get_errno(safe_fcntl(arg1, host_cmd, &fl));
+        break;
+
+    case TARGET_F_DUPFD:
+    case TARGET_F_DUP2FD:
+    case TARGET_F_GETOWN:
+    case TARGET_F_SETOWN:
+    case TARGET_F_GETFD:
+    case TARGET_F_SETFD:
+    case TARGET_F_GETFL:
+    case TARGET_F_SETFL:
+    case TARGET_F_READAHEAD:
+    case TARGET_F_RDAHEAD:
+    case TARGET_F_ADD_SEALS:
+    case TARGET_F_GET_SEALS:
+    default:
+        ret = get_errno(safe_fcntl(arg1, host_cmd, arg3));
+        break;
+    }
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_STAT_H */
-- 
2.40.0


