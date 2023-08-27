Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAD78B92F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZK-0000eD-00; Mon, 28 Aug 2023 16:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZA-00007y-KL
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:30 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZ8-0007fk-DM
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:28 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bd0bc8b429so24007891fa.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253424; x=1693858224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57sl4ID1/SSP42rUJKmuub1xcVM/sJL+siK5hXwzvDk=;
 b=lfsuS1tHWGnNXiPW2sCjjIzNhe7ow+QGOW7uFkjlepGOLqKrJPxpEow3X8rEH/rB6j
 krIrSm3StTE6/0N1LSwRaQ/fw2sHkIe6hGxAZcHidSmqfp8wHlSB+bHV0iZyNeOmX4O1
 CCZuOOCmef9S5s8SET8uonEcMLIqCRxW3LlUVTZQTLN+tjnjpErpEWhc0SZioOhPahq9
 sAPetDzh+XWepA1bbwP9ASVBwzJ5FICXLIq8hRbtAmg0fnIErQ4uQPxH1u8I/5gzSP7W
 tROrPb/L12U26wk3Jqcy5y61Ogperhx7xPz3z9rZGsh2Wqh4qMLsbNZsNzDdW4W6mvVb
 dPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253424; x=1693858224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57sl4ID1/SSP42rUJKmuub1xcVM/sJL+siK5hXwzvDk=;
 b=NlrzKeAVuPIvpQG4CxMm3ubwzbPSX7GL7LqdVFJIs/FWtdVKhBciNHgKtZGVORsT/1
 Y2/KCoQd8azs3MDB7D5YjYoye3BzhZfhoJo5CrGx/AULGYGd/F71wSc5/FdD4ORCGHUq
 dZPv8TD9UFsAwb4GtBQ4qCdoH/V7Ywx/qBCPtcPThlHTXSAgFgEKNGvTsIBbfv9ASqg7
 1u6bbYq9sm5LZ4Vr2vuua0L3bR89tr7YyKSYyEIz3XZhrG1pCWZC6WcQdS46AkNbpg6k
 8m9LWgEOwBWPHQHBCcXqn3LpBoknUW+uKEvd5Jc/BuKLiEyQPPUVFXyZKP7juxcFe7TN
 Bdww==
X-Gm-Message-State: AOJu0YyeVNbzA7JktCZA8JsEPldK1vQB8uwHBFFW6m8cRZRGX38XN68R
 8uAW4BA3FHLdcJP8T2M/p6AR8bbVTyuyow==
X-Google-Smtp-Source: AGHT+IHE5GEP9h7hPNAAVQ/NUX7eCLLMph1Evb+Qxv+6oVPcR9tDvYiIiWB5YWLaWJv0heE1DaV9Aw==
X-Received: by 2002:a2e:984e:0:b0:2bb:89e6:184a with SMTP id
 e14-20020a2e984e000000b002bb89e6184amr19852213ljj.10.1693253424213; 
 Mon, 28 Aug 2023 13:10:24 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 15/32] bsd-user: Implement getrlimit(2) and setrlimit(2)
Date: Sun, 27 Aug 2023 17:57:29 +0200
Message-Id: <20230827155746.84781-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lj1-x231.google.com
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
 bsd-user/bsd-proc.h           | 59 +++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  8 +++++
 2 files changed, 67 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index ddb5a4d452..2c225b12bc 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -137,4 +137,63 @@ static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
     return ret;
 }
 
+/* getrlimit(2) */
+static inline abi_long do_bsd_getrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    switch (resource) {
+    case RLIMIT_STACK:
+        rlim.rlim_cur = target_dflssiz;
+        rlim.rlim_max = target_maxssiz;
+        ret = 0;
+        break;
+
+    case RLIMIT_DATA:
+        rlim.rlim_cur = target_dfldsiz;
+        rlim.rlim_max = target_maxdsiz;
+        ret = 0;
+        break;
+
+    default:
+        ret = get_errno(getrlimit(resource, &rlim));
+        break;
+    }
+    if (!is_error(ret)) {
+        if (!lock_user_struct(VERIFY_WRITE, target_rlim, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        target_rlim->rlim_cur = host_to_target_rlim(rlim.rlim_cur);
+        target_rlim->rlim_max = host_to_target_rlim(rlim.rlim_max);
+        unlock_user_struct(target_rlim, arg2, 1);
+    }
+    return ret;
+}
+
+/* setrlimit(2) */
+static inline abi_long do_bsd_setrlimit(abi_long arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    int resource = target_to_host_resource(arg1);
+    struct target_rlimit *target_rlim;
+    struct rlimit rlim;
+
+    if (RLIMIT_STACK == resource) {
+        /* XXX We should, maybe, allow the stack size to shrink */
+        ret = -TARGET_EPERM;
+    } else {
+        if (!lock_user_struct(VERIFY_READ, target_rlim, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        rlim.rlim_cur = target_to_host_rlim(target_rlim->rlim_cur);
+        rlim.rlim_max = target_to_host_rlim(target_rlim->rlim_max);
+        unlock_user_struct(target_rlim, arg2, 0);
+        ret = get_errno(setrlimit(resource, &rlim));
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f7c4a64f9a..5467cb2341 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -244,6 +244,14 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getrusage(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrlimit: /* getrlimit(2) */
+        ret = do_bsd_getrlimit(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_setrlimit: /* setrlimit(2) */
+        ret = do_bsd_setrlimit(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.40.0


