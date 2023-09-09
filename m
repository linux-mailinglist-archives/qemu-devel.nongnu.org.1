Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26D799AA3
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3my-0005wB-FH; Sat, 09 Sep 2023 15:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mv-0005rL-EJ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:37 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3ms-0003DE-B0
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:36 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401b393df02so36662635e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288312; x=1694893112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7l8yTYvF0exPE7Y1/cG6wE7nHKc1Z9FnZqMFX4sgdA=;
 b=OsAp0Hdzl9320SGGh+HoJNI6/fbl+eKUwGkyY6n/JG1c7lHKqmVkqhAaiTP5hoL/Rw
 gpkWVX3F42SYN0QpaHCHmoM5pPFs6mrWnzXjcMWeLYxxcF+nISqcymVP9t/ICxJmtTE2
 lv8zUAF3UN4yoknrfZ4FCsrYezaCA16/C0k84JKECLDMfi3107VBL+YuwCbejZAbm2p2
 7ybD3Gu6tOPbW6bEq7KPN6KOilYcTnmjarc1I8KTHSgqUa7xEQiWKjTSOaXK+7GAbeFz
 6w6SV7e1IoFYwU7NG8gLSAoKmqSJF9fF8zkIdry2KrTKpxmaKXvxc16+tMVhdYIOTYip
 f8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288312; x=1694893112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7l8yTYvF0exPE7Y1/cG6wE7nHKc1Z9FnZqMFX4sgdA=;
 b=rAob9sSQqeKi6xwOKbAnrXKFB64UO4XSvU+kLHYExsDNIwVkIH1QR1empYGBKVHQpL
 6LMQuWxPART+F56pI9UmTADJqCsFI0fMo7ClAu+/D3conEmFyYpJmQoZ2VgtLMTibxOP
 JZ0DeBdY+Tc8XdcDZejB/soki0m3xzV5kjNNxhjQUzdYjp0+TD/4EMGf+UAeyINWDFI+
 GmLSPYl6Q8/E6GceUu5Yh34ULia/BQvIo4Cyo0Cc8NMJNwkWkR9I0EB1uOc6QHf3boQk
 +k8uPkaaRJ3Pwwxu4wnmRphJpzerAUYIoT6bWSHkwgq+8/6n/n3AviqXAx7Pc7iqCmNp
 Fh1w==
X-Gm-Message-State: AOJu0Ywz3L1bStvdmstooHBy3bbioUdYodsa7U6fn69hHBKFKNegkcca
 /nJNu60DsL8lWvNqmU3v7G7wKnt4luY=
X-Google-Smtp-Source: AGHT+IGzQtPvuewfTr8YOS8Ogbpexs5wG9GkUYjjr0IUpjqSX8ATBrxhVvXRGiEhux5K9TX50bD3Bg==
X-Received: by 2002:a7b:c7cd:0:b0:3fe:2b8c:9f0b with SMTP id
 z13-20020a7bc7cd000000b003fe2b8c9f0bmr4655901wmk.23.1694288312455; 
 Sat, 09 Sep 2023 12:38:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 07/23] bsd-user: Add bsd-mem.c to meson.build
Date: Sat,  9 Sep 2023 22:36:48 +0300
Message-ID: <20230909193704.1827-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..6ee68fdfe7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
-- 
2.42.0


