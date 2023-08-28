Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB3378BBBD
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsT-0003xQ-9Z; Mon, 28 Aug 2023 19:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003si-I0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qU-W2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:21 -0400
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-794d98181f0so48590539f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266129; x=1693870929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZzGKX91yr67fIOgLMVQ4bKuqceFUDjMtINiYOw56ek=;
 b=aQrF7iywzO/txU5RYDEkuKsQhz03u3YBd04jYsunWaXbnLVVbQabqyWLUVkfr0Opuj
 99HT/whFfdBoPkwf0RzQ+qAcgUi1j4oBUeBrNuL4nIraWppNwA9vg9Q0N6Mzr/nBq/tq
 45geiHr+//k2jVk9EFjZGXD674S+JSnNSPiVjMU0kX7GIuj1WWcgQhRxkpSEpG+xYXiC
 UAFT2n/hIDkuy7r4OBb4LP7VTq+g68KrWBC01aX+VTTMhWMv9xNnVYv0hN4Q1KbyoML7
 dKKbMH7604TRJrcHj6cxyY/1NOVDroZ2X0/ezJAPi413cmalfYyfOPm+w6xMS4s9j8y+
 XwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266129; x=1693870929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZzGKX91yr67fIOgLMVQ4bKuqceFUDjMtINiYOw56ek=;
 b=C1oaxmCZq4nrKaq8vIex9FZvoi7z06oqtIc0jX7JHbt6VAj4aAsmiVmUk2uYHfU9uT
 9CNdg5SX2xeUPYVQVeJp9or+to6oyrPXAa1SYI3ADr3X8VuXQYRw9ZLaIrfjvr7s1EyO
 Mf+9B6eOl98xmjcI9VknXfzAwEFC+GSDMO8OXHvxILyP1CVMDrIb2tgljQm/enqxG4oB
 jM3EPs0VORSwJUM1KJkjeDZPBssfYUssGtdooL0Ut/6ggQKcx/161HBhqP123nQ393+v
 GgHhqZgIZ4hYrtDBdjgJMS8pW24/RqLgkiliMboSVxrpu4wpHavmCOOqaytVLxiXqnuh
 OkWw==
X-Gm-Message-State: AOJu0YzXZtbMvDT/9P7LtP0+Vky214jK/aAISAgqY+3ooHcTNddRcYIe
 zGgudWT5nL8saWMVFwsKYpbWdxUjI4RgzknRXgw=
X-Google-Smtp-Source: AGHT+IH7u7NC6rUx/0hvuAO0qb0TbwMD3kX3ZbMOm8y/0IHRD7Nkkd54OdYRtqa1COuUOhjX+BmV8w==
X-Received: by 2002:a92:c565:0:b0:34c:e4c6:c51d with SMTP id
 b5-20020a92c565000000b0034ce4c6c51dmr10889197ilj.6.1693266129106; 
 Mon, 28 Aug 2023 16:42:09 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/36] bsd-user: Add glue for statfs related system calls
Date: Mon, 28 Aug 2023 17:38:19 -0600
Message-ID: <20230828233821.43074-35-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d33;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd33.google.com
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

Add glue to call the following syscalls to the freebsd_syscall:

freebsd11_statfs
statfs
freebsd11_fstatfs
fstatfs
freebsd11_getfsstat
getfsstat

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 73616a5be08..916a754bf8b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -552,6 +552,30 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd_fhstatfs(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.41.0


