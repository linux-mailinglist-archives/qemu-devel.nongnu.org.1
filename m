Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E81B833734
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaS-0002ZG-Ql; Sat, 20 Jan 2024 19:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaQ-0002Yr-DT
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:18 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaO-0007RM-TH
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:18 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-361ae51a4d9so5617905ab.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796476; x=1706401276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AszAzFAp6jrF5ZpcMELuMynXb9ZnBs+nghMoHKpvVGo=;
 b=rusVckiWhew5o9FyoD9wdQAgIw9aUm8aOym54TDh1ozMzNfdcwXeoBLZnLEJyyxrx3
 vczkPgABUICoEKlNWX78cNhZz4vx15AivBIIJlwg+wFWmdgFGgLT4iK0rasZzQBOYGYB
 ZkQjvQZhHadzMtRSp3rJw8EPwNXaau4YBVc0UNKu7wF7yokm8n5WP3TSEXI2bZljOgLx
 bAz6WufDn+x3Q4PpBqoS9EnEHMIxPd9gfHqYVTRnjoUka+/oJ91UysJAeTpIyKzb9qh8
 Q/DszWP0V0UAA+zJ2byhoCz6Oxmf08L8mGY5/PuSjmaabvfacxonS/WG+VmHM9npsEsh
 QW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796476; x=1706401276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AszAzFAp6jrF5ZpcMELuMynXb9ZnBs+nghMoHKpvVGo=;
 b=V3ERk6n/Rb4hlwrYafJTexuinREbjcxnANg1dZrx2TESrF7esLrdNe57PZcNfR6Zh1
 xR4eAYhSd5AgGX7I9N+GzD46TIlSvwFCHyW09QCjzTFD1C8z2ZyEZtyUg6uVIaFkNlP9
 FS7S9ucGEmThMYIS1MICFqLerZMpYW/3Bl2VcWrDh5EP55KljiQAYlE40MyTFQqrwvf7
 3tlQsJVAmrOK6REt3hH7QMHARFEEBx49rXjOwQt1hc5J7m9YTL5YDOA32ms++3x0gcuu
 Mk6lZe6dTgka9phPhzO3Is0p3UP/1hXUUt0MvN6nNt13N7Iro6RHhjEHUJeW3GVMs4/n
 mrmw==
X-Gm-Message-State: AOJu0YzKUHZ8kQeer9vs/RajK8byugWw/cP1Al2Mzvd6QZHcB6t/yoT5
 5X0qKb3/l3y38xkRjITcHQZd/93Tc83EHU5KjJ96WKV3+2DVFaC0rkVRjbXDUPIsO3lOAJO9VZ9
 mWD4=
X-Google-Smtp-Source: AGHT+IG/vxkYNFSyvsgw+P6dfYaW3iC6CHH2AV4xlOjNkwmaXPLJlvs14wMWQKYehkGKhxmR8gIreg==
X-Received: by 2002:a05:6e02:f14:b0:35f:ca9d:6c42 with SMTP id
 x20-20020a056e020f1400b0035fca9d6c42mr3071536ilj.4.1705796475892; 
 Sat, 20 Jan 2024 16:21:15 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PULL 8/8] linux-user/elfload: check PR_GET_DUMPABLE before creating
 coredump
Date: Sun, 21 Jan 2024 11:20:47 +1100
Message-Id: <20240121002047.89234-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

A process can opt-out of coredump creation by calling
prctl(PR_SET_DUMPABLE, 0).
linux-user passes this call from the guest through to the
operating system.
From there it can be read back again to avoid creating coredumps from
qemu-user itself if the guest chose so.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Message-Id: <20240120-qemu-user-dumpable-v3-2-6aa410c933f1@t-8ch.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c596871938..daf7ef8435 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2,6 +2,7 @@
 #include "qemu/osdep.h"
 #include <sys/param.h>
 
+#include <sys/prctl.h>
 #include <sys/resource.h>
 #include <sys/shm.h>
 
@@ -4667,6 +4668,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     init_note_info(&info);
 
     errno = 0;
+
+    if (prctl(PR_GET_DUMPABLE) == 0) {
+        return 0;
+    }
+
     if (getrlimit(RLIMIT_CORE, &dumpsize) == 0 && dumpsize.rlim_cur == 0) {
         return 0;
     }
-- 
2.34.1


