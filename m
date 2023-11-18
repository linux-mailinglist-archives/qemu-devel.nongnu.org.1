Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5EF7EFEC1
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:30:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hc3-0000Ic-6x; Sat, 18 Nov 2023 04:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbt-0008Hi-DK
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:30 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbr-0003uA-TG
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so2847794b3a.3
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299646; x=1700904446;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0IWpuVugnOHhHW4iRdjHhQop01tKq8JlW1RJdmELNI=;
 b=y0kUqMNk2IIhRCE34sF6BT0RZn1oMFXmOz4QIK/ELB4rVlrVWeARP5qzsJ3p3Jjg0H
 MX7cP010pbabqtLFn6h1TCiQxPNJAIqeoaxfArOapKjemadNUYVdoRQIJEx2HfKOvuS1
 1UGFrJOqOAVTLsrZq+3MGIDCFAi9cZK/iA1n5MYau84YM3t0dCNpnG+L+xTailmG0QJb
 +1kArvdg2NF13CgnT55KwEBVnPoV1FpK/v/xhOzj2Zna9szi3y25qUoL6Sz9LGsLlMtq
 nW9vwUfsKggtZJ6t+n4kIvTLSk2UQaCtHZDL2UiEN5ZdFyxIjd94oBfNwtsloSUdjUW+
 2YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299646; x=1700904446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0IWpuVugnOHhHW4iRdjHhQop01tKq8JlW1RJdmELNI=;
 b=bxGeWUA+285cVpQcVM3Ap2A1l2u9x4/onOwRED55ko1vElzOn9h7ohFJpw5KvWpI1l
 Vtj5lNbCkzhruQDeqnAbjaengvVNvamgBXwpVJgJOVHDjfQI+h3NJyPmMM8jTOUcSB9Q
 o3kABDD/Piops3b0wN64hzYpCKNJvj9umcyCuZLiMj6kP81gOPCdJXDnquinq1Nv0wRP
 qr+T3Sx7RKQENVH1dY+q1vcNzwEN7sWQoKe8LVl/Jn4yiCwobztkEpqKMTcGx8qju5Qf
 OXJbASZR9xvjPmFmOkgFkR4C7BLXDYl3AueJBbPzhG1PE+hCUqfJIzwtPser5u666vOA
 c35A==
X-Gm-Message-State: AOJu0Yxa0Jbo9TlkU4PzvW3JEgOy2wKZ8lxBUqRJvc8yUnedj3+g8wun
 XpeTq/xi0fGIrCeL3W9SZ/aZQz+6GTxviSxj6Wo=
X-Google-Smtp-Source: AGHT+IHxurB82PoPrYzYMGAHFKHRmZndjq8sGwA7ifSrECwz6uDvLo3Dsnfb844zJu6D9dowl9BS9w==
X-Received: by 2002:a05:6a00:1ad3:b0:6b1:e876:168b with SMTP id
 f19-20020a056a001ad300b006b1e876168bmr2559731pfv.11.1700299646389; 
 Sat, 18 Nov 2023 01:27:26 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x27-20020aa793bb000000b006c33c82da66sm2643437pff.75.2023.11.18.01.27.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:27:26 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 19/19] ebpf: Add a separate target for skeleton
Date: Sat, 18 Nov 2023 18:25:59 +0900
Message-ID: <20231118092601.7132-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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
2.42.1


