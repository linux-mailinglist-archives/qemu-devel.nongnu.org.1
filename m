Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E91DD7CB99A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbQ1-0000CZ-QQ; Tue, 17 Oct 2023 00:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPw-0008NY-T4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:52 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPv-0004pD-CA
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57ad95c555eso3008059eaf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515850; x=1698120650;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=BPRbE/IhfP2A+n/JJot+C0AajFe8CG5a+KOVAzoB4i3ZOlIGLaZrWSFigFOowWWU0y
 Qk+ncEkzqXhrLA6tfuxGwEr/i0W10vBYxPfCRbXNHF5Wr5P8JN3IMwidYdSBc7K33MbN
 3e862prGmJ74ZiDbtvSqiSgsHE17oT7YBrYvyxnlGx6KkQxv1lo1OFlU4Wvq7m8pl/uk
 0bzAJKLNF5w79GLn3yX01fAI+9Qa/x4QzrQ/bRHt4Qxxp0eWdyTe3+hMSiuCiRH4JTuU
 drNKUsJQIERKYRXhQ6/epqoF88GX/MS0UdgsXUco3wvnwxd88gp+DO4ZO1Z3CD7zT8Sw
 Zl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515850; x=1698120650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFYf/Wglj+2qNXu6Gu4r3dFUMAoEmBhswUuuZHDNbls=;
 b=vh1FXwbKygv4Xt8ocgQ84u7JYfasRT0zY5zOynzE8GinXnZPYQ02frVF7h3KiEO9uV
 ATzNIprROq/YB110J3OGj64r3Gp636Mvj/LqqYtwaP/woXwzN31NDMQ30lwOzRzXr8on
 a+XfgfTkrtLd0aXjCVVSYhfc6ONk88KGPdx338PNSKiTcrO9vi+KFYiFxb/Eyi+sHPuY
 rgc2839uhrif6cZuX7ZuHQOT4B+b7cWTXkmXQRPLqw9TJZdAZlhLpbIEaAznk3b4sNnZ
 6iS9XDUctuyhVx/FGJNlqP5BRVmIB/lgYUtDazGWSM08lPBkvVeFgY2ZW6ei/hq6azLN
 Fv8g==
X-Gm-Message-State: AOJu0YwK3xlvvUaRsSIpOcwN3mvf0NGFNG8u3KQgmlaNJNkmY3/IvHe/
 3mkCF7N0moJkhx5+yfMk9Ft4c3P8+/ch9E+k4ESR/A==
X-Google-Smtp-Source: AGHT+IHEv+4qadv8Y4Inmcc2GWJyXKxSzN7jIwTedxltymisFEMshN4nHK20gRvYriqa6TmzuONniA==
X-Received: by 2002:a05:6358:729b:b0:139:b4c0:94d with SMTP id
 w27-20020a056358729b00b00139b4c0094dmr1300730rwf.12.1697515850063; 
 Mon, 16 Oct 2023 21:10:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y7-20020aa78f27000000b006babcf86b84sm357712pfr.34.2023.10.16.21.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 21/21] ebpf: Add a separate target for skeleton
Date: Tue, 17 Oct 2023 13:09:27 +0900
Message-ID: <20231017040932.62997-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
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


