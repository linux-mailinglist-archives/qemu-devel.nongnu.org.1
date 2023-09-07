Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1781797278
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcd-0002az-S5; Thu, 07 Sep 2023 09:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcT-0002aX-71
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcK-0006RA-LT
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=suF/0D6+0X4K+OiIqd3LL7gSvssUT0iVpfKnhOUhM8s=;
 b=Tsh6gUBlqSyREJvaVEZ28PrOYODeT+Svj7GqDkTbV44+2ZF+8OTTgGugA9daGciMoA4L+J
 HEE3Gbh7I+hp0YkpG3zPdkJCNeW4PSVq9xi42Og5d9vBI8g4Wo7E0iU2I/tJoCuTYGchbD
 PaN0XokiUC4p/h9Pft59IMvzPIIdR1c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-pstJX3M0NGquQYqGAChXFA-1; Thu, 07 Sep 2023 09:00:10 -0400
X-MC-Unique: pstJX3M0NGquQYqGAChXFA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401db25510fso6605085e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091609; x=1694696409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=suF/0D6+0X4K+OiIqd3LL7gSvssUT0iVpfKnhOUhM8s=;
 b=k/yN889LFrZzJtruuIIpPOnjN2Jfi9tRUmGHO1UarYQeCPCVVsDuK9uFfcrEo5KP3f
 6jtdxJ+/n7aBlByUxuCTrhkB8SCV38Gl+/ezN3jF5/ECnYQ6tOZg9okmmw/5xFjvo1QA
 FMpvkvJyOfITtpwro6x0uvsRrf2du5TLLJd7kjyIUxMwU2ubfVAZReEKAJPJ1uHJcDPV
 /haFWYoiOPb2lJIkpVHgn6F/VgTP/sFfbH2hrITx5/mHq+3hC4RObknfyQhgem7hrm9v
 S8fqUoudFGKDWOPiStPTchH9OFQB3PeJTS8oKiGtKMOF9VgbXxXj/QK6lO/sC+cnJq+w
 TxvQ==
X-Gm-Message-State: AOJu0YxCLY/5kNvjO/In0IhqDHPUS0crlPgmMpKGZRM3Drc41v9MkcKH
 fs0DZha86eU8Ml7tBDnRhfOFd8jnH/owEt72ggILPqarH0hiUpSTwvEZNPS7RPxLDf9+pAhyAJl
 wn7PciEqUgJoJYfIhqUvsZqCuF1Ui6VDhfhuKL+1yKAEd6yR1oPz3EQcbie2jqlrwoIPowin8ik
 I=
X-Received: by 2002:a05:600c:285:b0:3fb:b890:128e with SMTP id
 5-20020a05600c028500b003fbb890128emr4527073wmk.33.1694091609082; 
 Thu, 07 Sep 2023 06:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLmhqrt03UYfPqDFLcT7Q0uzw0VzTi1rxNjx6XzvyhYChHD3O5Y6BJZFv80QsLarVu6Hu9Lw==
X-Received: by 2002:a05:600c:285:b0:3fb:b890:128e with SMTP id
 5-20020a05600c028500b003fbb890128emr4527052wmk.33.1694091608696; 
 Thu, 07 Sep 2023 06:00:08 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c378500b003fefca26c72sm2490140wmr.23.2023.09.07.06.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/51] linux-user,
 bsd-user: disable on unsupported host architectures
Date: Thu,  7 Sep 2023 14:59:10 +0200
Message-ID: <20230907130004.500601-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Safe signal handling around system calls is mandatory for user-mode
emulation, and requires a small piece of handwritten assembly code.
So refuse to compile unless the common-user/host subdirectory exists
for the host architecture that was detected or selected with --cpu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/configure b/configure
index b9bd008592a..b9af8282293 100755
--- a/configure
+++ b/configure
@@ -871,30 +871,36 @@ fi
 default_target_list=""
 mak_wilds=""
 
-if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -n "$host_arch" ]; then
-        linux_user=yes
-    elif [ "$linux_user" = yes ]; then
-        error_exit "linux-user not supported on this architecture"
+if [ -n "$host_arch" ] && [ -d "$source_path/common-user/host/$host_arch" ]; then
+    if [ "$linux_user" != no ]; then
+        if [ "$targetos" = linux ]; then
+            linux_user=yes
+        elif [ "$linux_user" = yes ]; then
+            error_exit "linux-user not supported on this architecture"
+        fi
+        if [ "$linux_user" = "yes" ]; then
+            mak_wilds="${mak_wilds} $source_path/configs/targets/*-linux-user.mak"
+        fi
     fi
-fi
-if [ "$bsd_user" != no ]; then
-    if [ "$bsd_user" = "" ]; then
-        test $targetos = freebsd && bsd_user=yes
+    if [ "$bsd_user" != no ]; then
+        if [ "$bsd_user" = "" ]; then
+            test $targetos = freebsd && bsd_user=yes
+        fi
+        if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$targetos" ]; then
+            error_exit "bsd-user not supported on this host OS"
+        fi
+        if [ "$bsd_user" = "yes" ]; then
+            mak_wilds="${mak_wilds} $source_path/configs/targets/*-bsd-user.mak"
+        fi
     fi
-    if [ "$bsd_user" = yes ] && ! [ -d "$source_path/bsd-user/$targetos" ]; then
-        error_exit "bsd-user not supported on this host OS"
+else
+    if [ "$linux_user" = yes ] || [ "$bsd_user" = yes ]; then
+        error_exit "user mode emulation not supported on this architecture"
     fi
 fi
 if [ "$softmmu" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/configs/targets/*-softmmu.mak"
 fi
-if [ "$linux_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/configs/targets/*-linux-user.mak"
-fi
-if [ "$bsd_user" = "yes" ]; then
-    mak_wilds="${mak_wilds} $source_path/configs/targets/*-bsd-user.mak"
-fi
 
 for config in $mak_wilds; do
     target="$(basename "$config" .mak)"
-- 
2.41.0


