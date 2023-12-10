Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A780B915
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:33:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPg-000464-4E; Sun, 10 Dec 2023 00:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPZ-0003LQ-LG
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:30 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPW-0003MC-Kr
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:28 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35d74cf427cso13927765ab.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186283; x=1702791083;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6imu23nIO4V04/+2B+cKuXmtUXThR+FuAI1ZTlifZ1Q=;
 b=TeoBg3QffxQeufhEAhvaqz0eRuzkO4C+cblVj0p91LctDqgGOXUMDp6UVbg9wzxOuo
 Wklc8DBbCWVnmijcK1X7ru70wt88Gd3GEpfB7KHbpLsh+s/838O4wRmrZ/EOdDO44vTb
 k4HF0OtSCCXoKR+/rnjN4y9L0fz2hhBaCitr2GLSCRgqyqH85TL6GvuvXFi81iQ8pLCT
 3a9IvHbrU5Z199egsNzxv6m6gnJrP5+HG19wSMBz8darnbKj7IEghTt2gd7aUQ9uzK85
 eJldl0ZMQt0w/oHgQW67QLnycLjAJPRhlyELaof4AN79zJg9YmLE/b5wn+Ek89q2foqH
 5jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186283; x=1702791083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6imu23nIO4V04/+2B+cKuXmtUXThR+FuAI1ZTlifZ1Q=;
 b=HDWKns9nWDiYRG1qhKH0NHhuYdgEdrORNlb7erYWjF9M39A0+xjw/J4prc/ku39ckQ
 ByOo4+T4pq4fYwbiXRzam82SrBI3ABvdDRJFOAfG7QaT8iJGwifAbdQ3mTEvNHYbDsH3
 jTLmE1XzIZPRUwDVX5zswlNBxXbNl8lYg3D5fuK+p9dkHekipEt2ihLf7bPYvGolaGYE
 7du77aHnQ7RQnapMeX1AdyRx75DJua2STU56cRhaQ93BMXB2JqeQcyKD+eURbQeD8dCJ
 I98qyhfA9/ombNzLIuNHnw0vIZo9nMzxPIYM9SZ4PjRVE3GUb1RqVuiIJwzLxzL9QdZd
 oMCw==
X-Gm-Message-State: AOJu0Yx3CQd3uARhpMRPUEJn/hdalTlCOcAjr6MrhxKC1A0yCLSk8ttc
 zqLLKS/QmUwaTD9kWRxmellA3Q==
X-Google-Smtp-Source: AGHT+IGjIVIHnkBLpOXmDlfR79y2DCFa9BTnjpRBfVFyP9PhZeMr1Z2VjBMu9B8IhsIOzkZY0BRvZw==
X-Received: by 2002:a05:6e02:1587:b0:35d:59a2:6464 with SMTP id
 m7-20020a056e02158700b0035d59a26464mr3909665ilu.55.1702186283430; 
 Sat, 09 Dec 2023 21:31:23 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b32-20020a630c20000000b0059d34fb9ccasm4026576pgl.2.2023.12.09.21.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:31:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:57 +0900
Subject: [PATCH v8 19/19] ebpf: Add a separate target for skeleton
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-19-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This generalizes the rule to generate the skeleton and allows to add
another.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/Makefile.ebpf | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/ebpf/Makefile.ebpf b/tools/ebpf/Makefile.ebpf
index 3391e7ce08..572ca5987a 100755
--- a/tools/ebpf/Makefile.ebpf
+++ b/tools/ebpf/Makefile.ebpf
@@ -1,23 +1,24 @@
-OBJS = rss.bpf.o
+SKELETONS = rss.bpf.skeleton.h
 
 LLVM_STRIP ?= llvm-strip
 CLANG ?= clang
 INC_FLAGS = `$(CLANG) -print-file-name=include`
 EXTRA_CFLAGS ?= -O2 -g -target bpf
 
-all: $(OBJS)
+all: $(SKELETONS)
 
 .PHONY: clean
 
 clean:
-	rm -f $(OBJS)
-	rm -f rss.bpf.skeleton.h
+	rm -f $(SKELETONS) $(SKELETONS:%.skeleton.h=%.o)
 
-$(OBJS):  %.o:%.c
+%.o: %.c
 	$(CLANG) $(INC_FLAGS) \
                 -D__KERNEL__ -D__ASM_SYSREG_H \
                 -I../include $(LINUXINCLUDE) \
                 $(EXTRA_CFLAGS) -c $< -o $@
 	$(LLVM_STRIP) -g $@
-	bpftool gen skeleton rss.bpf.o > rss.bpf.skeleton.h
-	cp rss.bpf.skeleton.h ../../ebpf/
+
+%.skeleton.h: %.o
+	bpftool gen skeleton $< > $@
+	cp $@ ../../ebpf/

-- 
2.43.0


