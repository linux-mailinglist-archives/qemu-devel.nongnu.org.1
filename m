Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E107766B2
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK6-0000Q4-C9; Wed, 09 Aug 2023 13:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK4-0000Ov-78
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:16 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK2-0005g0-Ep
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:15 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bc8d1878a0so54818a34.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603413; x=1692208213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIJbV1+QSy586PHNn48HKMsvhOSunQxnQqr0K94zk5U=;
 b=Ld3vbphY4vL9PDzXs1ZSC+0g/pDzUI71ZYemHpH+T0FZK6o8iIjo0EwvzNHPLBAfEE
 WXSRBmubQBBXF+t4Bp1edacF3IIwbk+MNz2i7ZmEIfl6U0EqmFO36rbN1FcJuSzHtYXD
 j9aW5p7q/J8R9XOIarXqpIuf0t12RgsICnTc+neikFsi+a9gKml/o5JGbH+E/9nDJdvS
 +SS4Lw7P6D5nxETBFKWhL6EC+sU0RxVnyt0mWZPWoyRRRif+LFPhTpVetthPXS7rh9ji
 gzpkVMpA19+XlclJRBCMizuXEh2d3E0aTQTIgq90gnvo33yhMW4TVWTXZNUE6aB33bxy
 5ETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603413; x=1692208213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIJbV1+QSy586PHNn48HKMsvhOSunQxnQqr0K94zk5U=;
 b=Yra75fGETBgTtVH+GdtrjAtZ5BF1IEaMNlwSbnHEOeElwhdNXn5oVjcjFR9Q8mh5yj
 S1PtHCjW0rB5rGoALYp1iItvUlnrCkLutvxucHPLH0mllBT0PrAKU0XcSjczKbw4x7X5
 GcSsHRZGFOfhD+7rF530Z7revem7ld84hfH+6VDOh/1DtsckuxLiKNZg1GH4K901cfG2
 LC2HxjOX/VkoLQuKVVdtgXwQu+S1Hi6GG5vNGWEHF8g1sGtYDoH8O5AB16p756Uxfxav
 wwP1qz4M/tq2AYCgCdOjbxYmo+Iw+dJunXT/vejb4pnctYbrv59H07X1tXnb5XqI5FU/
 BjjQ==
X-Gm-Message-State: AOJu0YzJYdPdTVjiDG9p+fpIVPLVkxhn3PzLXSgS0koGoMFoD2R9DO8q
 tHf8kIp1sMbCdyFRVXhn++KGAQGPH0U/i9ZSvls=
X-Google-Smtp-Source: AGHT+IE0q1U8d8ySmI7HF/9rbdrVO8tAbMHXkZcCcv4GCj4wEYnIsFA7Ptf6tw61pXi1e3f/UYEDrA==
X-Received: by 2002:a05:6808:2092:b0:3a3:613b:2787 with SMTP id
 s18-20020a056808209200b003a3613b2787mr41229oiw.32.1691603412805; 
 Wed, 09 Aug 2023 10:50:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/6] linux-user: Fix openat() emulation to correctly detect
 accesses to /proc
Date: Wed,  9 Aug 2023 10:50:06 -0700
Message-Id: <20230809175006.242479-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

In qemu we catch accesses to files like /proc/cpuinfo or /proc/net/route
and return to the guest contents which would be visible on a real system
(instead what the host would show).

This patch fixes a bug, where for example the accesses
    cat /proc////cpuinfo
or
    cd /proc && cat cpuinfo
will not be recognized by qemu and where qemu will wrongly show
the contents of the host's /proc/cpuinfo file.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230803214450.647040-2-deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 12ebc70df5..9353268cc1 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8557,9 +8557,12 @@ static int open_hardware(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
                     int flags, mode_t mode, bool safe)
 {
+    g_autofree char *proc_name = NULL;
+    const char *pathname;
     struct fake_open {
         const char *filename;
         int (*fill)(CPUArchState *cpu_env, int fd);
@@ -8585,6 +8588,14 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
         { NULL, NULL, NULL }
     };
 
+    /* if this is a file from /proc/ filesystem, expand full name */
+    proc_name = realpath(fname, NULL);
+    if (proc_name && strncmp(proc_name, "/proc/", 6) == 0) {
+        pathname = proc_name;
+    } else {
+        pathname = fname;
+    }
+
     if (is_proc_myself(pathname, "exe")) {
         if (safe) {
             return safe_openat(dirfd, exec_path, flags, mode);
-- 
2.34.1


