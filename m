Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C07C9954
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:06:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1jb-0004YN-OC; Sun, 15 Oct 2023 10:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1jG-0003YC-9x
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1jD-0007za-QM
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso25076545ad.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378662; x=1697983462;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=zWipbHMQMV3m9U7rich1TjEfsH4nlQuYqnkrdaI9i3P+13MED46l2ogP1mDZveQYqu
 Ln8PM5jT5ddxb6eQhvzF1v8DGz9+sK7bvoqzsU1SrMdufEdYoL0ULMyTplaNorvJzDac
 c4RowzWR0fazLEeuyM3Q8uSEXblSuF8xDJ0sDJYLXQzDXs3XDPpFEgUpKUHKI6phx5D0
 4d0/RD1m12RUBPnkjFKCmf6j431nsCAhlEqlvPQb+uZ2Jdaa6PlqGTYYJbey/vdPyn9C
 Huvlg1nTdaeBjzjB2bjED//+dCmcl5iIvVMgTn4RNNb7f/xxWctqiUUUrQh8X67Niwhx
 LGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378662; x=1697983462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=JrYEUf81m9BmMlClzuFuANhBnKjrJvEJ5FWSAdBXqvChegB3xPMoBrR1cSHjt/Sb8Y
 DaHpdsRj0DAcv2mu/ecphJrnBpkuPKsG4SHJhaj5Z6jl6jbxVJzjJfpKJ+CliE02AZfz
 KkRqhZnr21xAv/lCe6XlgLfd4k7ClJ+b6u9gqWVmlTLqJNNKConh9ug1DqhnR96PArWF
 d3Rn5KpvyalUDIFe13B9NkBiHmXOzz8nJMFqxP2G9ZaVZiumNxRVR3P80hDno1LKgkNx
 SjkezK7f5wihYDR8LqId4MtWFql6M38u9TVFG5KmS2ecqB4B6S3ViqRQJa2mOvnOiFhS
 NrSQ==
X-Gm-Message-State: AOJu0Yx0WdPcomNjfG0gcgqZGlWJzoQNv5Js5MQgTSpBQQ1b2B9eg9iJ
 RPQEBM8i/URJeSQz/3/YeLIBbdHuElMDKbmNulmi7w==
X-Google-Smtp-Source: AGHT+IGDenPDjAJReXzmm7qJdOu0gS1mODXUmaJLHLa9tL+BOPROmFsimq2vIP+bDyYxgciAXQsEIg==
X-Received: by 2002:a17:903:234e:b0:1bc:5924:2da2 with SMTP id
 c14-20020a170903234e00b001bc59242da2mr30768063plh.56.1697378661716; 
 Sun, 15 Oct 2023 07:04:21 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 jf10-20020a170903268a00b001c724732058sm6847450plb.235.2023.10.15.07.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:04:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 20/20] ebpf: Add a separate target for skeleton
Date: Sun, 15 Oct 2023 23:02:52 +0900
Message-ID: <20231015140259.259434-21-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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


