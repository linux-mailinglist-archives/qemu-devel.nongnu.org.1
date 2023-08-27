Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022978B946
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:13:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiaX-0006bY-RW; Mon, 28 Aug 2023 16:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaQ-00066w-0M
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiaN-0007qs-LX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:45 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bed101b70so446542966b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253502; x=1693858302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZmRWS4Lgy7toRM0U7Laa3HHLfg2pMqOOkMzLq4+C8s=;
 b=FpcofFjDqIfaYvPP1Zur1w1fo4VizRrf0dUeJxtK4Pg78Yig4YlS4BY88Td1/tgvWI
 mtU0kz8Nd5JRxy8y1rCaH6TKhTDNFVPVL7FLR7DH8i5ZHcgbZvlpJkB1c/OUG1vNARKa
 W1xuuR/rteyEdKWv6SX6bQxc21Iz+x3dIz8qz0wMGpD9FXOa2y8/QvD5rfRdRsQFN/yN
 S+Ru0In+vjT/DAzVd33BbPtrRuF7ju7QSXuDwDHBjBmzjfKaJvCbdBcF2rJbSusp1367
 M2bjNbnN+vAl9yvA043zkVIE169bKP4ku1M7Snlg+Pk0EHBenDpX+WOUtML1Bk9ffaRe
 2lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253502; x=1693858302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZmRWS4Lgy7toRM0U7Laa3HHLfg2pMqOOkMzLq4+C8s=;
 b=ih1sW+Vt0bloQgUjOARevLCH5vLAGw5jwioC55BPeyXFyHzq2PpqHqquN8jalV1kWH
 ik5LbsZ855H7aCXEMpi/OksJuaXJ2YZXAdCoFxkZXvMo0yJGJhi79e3HbT265SaVv4/Q
 6JEWYP4YohNTiU9FDXlJffuOr30gt008eyh21/cjJdCL+jGmRV9XSmqCyHEjB1PYIb5R
 46Vs58D2jeg1aWc1oBzofWbGSJkio7QtbYzrITXxUvVES08eaP7PtqMeNJb+/H4FXE7Z
 E4JLE4skikjQvE68Y9cU5qYmgaYM7YTVObj/Zj5DLLXpN9cPXHQppDNW0VZk6+3OGmuW
 0xcQ==
X-Gm-Message-State: AOJu0YxCszY/CdvLPihfCnPpgXpjFyuIeKTSwFtVPtssrcl1aZPfoMun
 cG4M55EjiMu0algtkoL82VcQsFouPzNTtQ==
X-Google-Smtp-Source: AGHT+IEdL9eRQq+pxrbdRukOPmEcQku6Hr+QpFZleM0npBCl+VdD8b/ZwpKAmjK29ZqjSYjDWNwGnw==
X-Received: by 2002:a17:906:217:b0:9a1:e293:987e with SMTP id
 23-20020a170906021700b009a1e293987emr11245056ejd.50.1693253502076; 
 Mon, 28 Aug 2023 13:11:42 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 32/32] bsd-user: Implement pdfork(2) system call.
Date: Sun, 27 Aug 2023 17:57:46 +0200
Message-Id: <20230827155746.84781-33-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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
---
 bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index 94824d737a..1eaba908a5 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -248,4 +248,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
 
 }
 
+/* pdfork(2) */
+static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
+        abi_long flags)
+{
+    abi_long ret;
+    abi_ulong child_flag;
+    int fd;
+
+    fork_start();
+    ret = pdfork(&fd, flags);
+    if (ret == 0) {
+        /* child */
+        child_flag = 1;
+        target_cpu_clone_regs(cpu_env, 0);
+    } else {
+        /* parent */
+        child_flag = 0;
+    }
+    if (put_user_s32(fd, target_fdp)) {
+        return -TARGET_EFAULT;
+    }
+
+    /*
+     * The fork system call sets a child flag in the second return
+     * value: 0 for parent process, 1 for child process.
+     */
+    set_second_rval(cpu_env, child_flag);
+    fork_end(child_flag);
+
+    return ret;
+}
+
 #endif /* BSD_USER_FREEBSD_OS_PROC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4464b3369c..27fc9d21fb 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -236,6 +236,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_rfork(cpu_env, arg1);
         break;
 
+    case TARGET_FREEBSD_NR_pdfork: /* pdfork(2) */
+        ret = do_freebsd_pdfork(cpu_env, arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_execve: /* execve(2) */
         ret = do_freebsd_execve(arg1, arg2, arg3);
         break;
-- 
2.40.0


