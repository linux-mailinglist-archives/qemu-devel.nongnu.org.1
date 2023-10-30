Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6007DB2B1
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKcs-0002wO-7a; Mon, 30 Oct 2023 01:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKce-0002Y3-Fd
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:33 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcc-0002Gi-2u
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so11060915ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642928; x=1699247728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=EWyJj0pL8sIB4Bl48eXtbXAFsAvVbdX3HTTg9R8cZlomTFO1DhIsMmupi6nlqVXeqi
 RGLz/PFQl2sk+nefs9cb1BlXa19k83uJYbVLdWvb9B7YXBCn3wNsPvWTv6kdpIaELPb9
 u77mfYZ7xbimje8fS/8meX+dPE723E2IWwY242bGRImjerlrvSgusvBJUp9cTV1heQOX
 /ZpXKbXlD8FfbYh2FDm0ntAwVxP1gB5WpT76/t3aDMTbgcOnW/+leDzZTOmu/yTfAgaJ
 8JzV0v9E0O9DklwsvAfkLJyAyatOkzbfaZ0b3h390eabA/N/N3zPd+8rM6oRadCcoZSb
 y3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642928; x=1699247728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=q9a3dcmPyVWuqhdG92/Nt1fFkWyLpufglJ/IggnfdoAS2zn2RBUS0R2KaoKSdd+sTS
 39qi2iFHeEh0y00EkGU3Eqb9aPqT8KV3xqxUjDDbtekXEeOGPCqVe+zvMSzwTTsbYbSH
 yODOVNGJo0IfVP6omolv+jFxQGCqn0gjvdmuXNhRNFd4cS1MRA20g14ejYythieyJAd1
 yAUihYEn65Bm+SWCizlSLV5XxccTD/SXYhI6MJ7VxHmiF6VdsLzsOW804N82FMeza0BV
 V+GUgchLEBeRhlMVbwp6c7Lj56vO5+yWbYeDspkOiMXyhNJyJ0iPNxUR/52hzDJwSHLn
 g5XQ==
X-Gm-Message-State: AOJu0YwI/xnC2zojG+7AotxKGt4pSP5QElWCJwhvEJDN67VvtZtJ5b+m
 Wqiv5q2kYgI2VuBiyFxB+T1w3XRNpiG7VgWLuNfhPA==
X-Google-Smtp-Source: AGHT+IERIl3gQ6v3JUbZ8RUfNcUTjy/P8rrwZGmqLt2LrrsWzPg57M6QpvtlSoqFwVd/Hm2OJCheKA==
X-Received: by 2002:a17:903:2345:b0:1cc:38e6:f097 with SMTP id
 c5-20020a170903234500b001cc38e6f097mr5536251plh.7.1698642928630; 
 Sun, 29 Oct 2023 22:15:28 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 d9-20020a170903230900b001cc40912649sm1942724plh.304.2023.10.29.22.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:15:28 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 21/21] ebpf: Add a separate target for skeleton
Date: Mon, 30 Oct 2023 14:12:42 +0900
Message-ID: <20231030051356.33123-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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
2.42.0


