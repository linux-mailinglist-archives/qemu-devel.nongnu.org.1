Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A660978B930
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYc-00085T-HB; Mon, 28 Aug 2023 16:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYa-00085E-Vz
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:53 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYY-0007MT-SW
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:52 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso476349966b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253389; x=1693858189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sIeO8W0baR2FISp4wtor7bsCo4X20vsw4pEiY+bS7hY=;
 b=UXe45DZqSjV/7ERj8gOsg3X3JtRofUv76ggCYfIm4gDnZE4ys9wllrzspMx2H3+cXo
 3JirH3anyQol8pITozuof3EeCuL1STRtzb2RGIHXuGgryU34sat2rbMwMkpXoQCrvj9a
 WKGtArkvFj0ok7YSlQHyBCve476O9B9CAJpoempIhLvOKYb9WoBI0/JOlrCR/Ke4ljgF
 16Yvh9D9JjvBJZNyhonCxcVVSXGIyHZ0wBQNOBsYZgGJuZVED8LDkzQyl1g2UuXa5Vd1
 sjQSylsi67MbL/ifgtjJVtaGz6b6N8W53l3zNJV+0qXDUfAGW1w7pZ1j6ZfdFz8dBEUb
 geiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253389; x=1693858189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIeO8W0baR2FISp4wtor7bsCo4X20vsw4pEiY+bS7hY=;
 b=immJglHQTP9bc8JL5PMPS2oYfll8XqPP4U3y6QcHWgStyUzM7c2/13CVphlLBSu8Gf
 nFeWFVRarccPYlZlyDeXqLsWIZyj+dMNh1/o9xsBkgof2TxIvB9KVY6ZSLwOQqZ0FbZR
 zcAyQpeHPjw79moPW6Ml4HFlLlHFhXyegS8vI/39Uv99LZBvI8icLiFcUY6SnsDjAp7G
 b2Yjq6tJ3KWvC3quHsoVVqf3nhoIT+1mM+U8naIfbQlSCEKyM3HnN08ZSVRT/JNMo6JM
 H/timuFMzMlKH9eASsSJnYA7DcMcMpDnEofvvcwLrnT4sL7Xhg4Q+edEtmo/jiIAqhBO
 cf5Q==
X-Gm-Message-State: AOJu0Ywen2B7lvQH/gkNY2775AZL1xA5jvYXrVb5vt4xnNmfewcPk5nN
 9OLYaF9QJUAHVmPL9cD0cWipszgU0T7mXw==
X-Google-Smtp-Source: AGHT+IFI2EjjaRlpAR3b935AUJQNH5mHU3elIFh0nC2+/IdRJ8AkTbL95wz9T/41kNm6spMFoXkr0A==
X-Received: by 2002:a17:906:2932:b0:99b:4ed4:5527 with SMTP id
 v18-20020a170906293200b0099b4ed45527mr19047930ejd.25.1693253389331; 
 Mon, 28 Aug 2023 13:09:49 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:49 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 04/32] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Date: Sun, 27 Aug 2023 17:57:18 +0200
Message-Id: <20230827155746.84781-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62a.google.com
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
 bsd-user/main.c | 2 +-
 bsd-user/qemu.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 381bb18df8..b94b2d34b6 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -88,7 +88,7 @@ unsigned long reserved_va = MAX_RESERVED_VA;
 unsigned long reserved_va;
 #endif
 
-static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
+const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
 char qemu_proc_pathname[PATH_MAX];  /* full path to exeutable */
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 6724bb9f0a..23bbdd3e0c 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -113,6 +113,7 @@ typedef struct TaskState {
 } __attribute__((aligned(16))) TaskState;
 
 void stop_all_tasks(void);
+extern const char *interp_prefix;
 extern const char *qemu_uname_release;
 
 /*
@@ -251,6 +252,12 @@ abi_long get_errno(abi_long ret);
 bool is_error(abi_long ret);
 int host_to_target_errno(int err);
 
+/* os-proc.c */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec);
+abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
+
 /* os-sys.c */
 abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
         abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);
-- 
2.40.0


