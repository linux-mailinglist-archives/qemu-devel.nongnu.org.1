Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59591777C58
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:38:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7iZ-0005PM-FA; Thu, 10 Aug 2023 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iV-0005MT-S0
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7iQ-0003Em-9U
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:36:51 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6157so16122561fa.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681804; x=1692286604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWHkl2jpAyxPACNnTV5P1s0rijLChl436ygUcdDaXic=;
 b=h3nj/RX/PEBMGORRsUbFI+KHNK8wIaqFIm9SzLx3IjDxRl0jb+QuZhpiW3teTbcfg6
 E3PDpgaFrplq5WN2SUvJF6yvqcGP5fJ1dOh3LxM5VMG/SNRT4c/bKr2pPH7bLmbTwfVV
 MYwk+w19KETrxyA6AM55Gjd6bltBVB1bNz4JeCcnRx68GeNwANgl7WrEAgoVb0WrzPKl
 5zv9fkpVQuNjZB8VLhymMm+Gs21b94erzYQ+XkN6XU78H+RbEFAZ3d8Z7RLgZawXVpaF
 KENHZDcCDwdJwFXag+RXdA5gu9v3lmCT34Jx4q790KQu5G25Yz3SyYv7nimdRTLR4AhD
 DHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681804; x=1692286604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWHkl2jpAyxPACNnTV5P1s0rijLChl436ygUcdDaXic=;
 b=E+VSDc8Wfk9wYEOL5OFFtXwBsN7PJZoRX8p8SGBOnUZgjNnSW70t/6s7ONc59rNz7C
 3QuvD89HiQfU3ODlWtb6p0fMZS8BJDlNnks1UdH6Kriwh9Bx4ksbfsV8l+pwlBILBj+V
 t1QxBMAyOTVdArrKwiuCXvaWFqXxVvByr/6SB1ly0UAVScZhh51b2B8o4y2OUILN+ytJ
 QSSb3qICdRCEmfhMB1PR4LqTVvgsB/CT6hDK/XQBZ/DsstXFo577mzdoH5e+xav0LWRb
 vwPlOIjNwVV0meeOY40KTRsqElDR1+S2G9x6taxhHrG+sZgBj66Lz2fKKnWDlqNouKEK
 gJzA==
X-Gm-Message-State: AOJu0YyJB09IBhTWXVNRizt68KgUc1ERcm5ECcxXNh8i64dN9fA4zeub
 6ZDChapZBg4KnZT+6oCSnT+6ug==
X-Google-Smtp-Source: AGHT+IHL54S1rQpcljLV5yVWT8wYrIxnkO8ICdS4coZbqboZFYHgMc/4zAZiuvhkNhFPsarm3vEr3g==
X-Received: by 2002:a2e:9190:0:b0:2b9:ac48:d7fb with SMTP id
 f16-20020a2e9190000000b002b9ac48d7fbmr2385872ljg.41.1691681804724; 
 Thu, 10 Aug 2023 08:36:44 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fe2bea77ccsm2504470wmz.5.2023.08.10.08.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:36:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F52C1FFC1;
 Thu, 10 Aug 2023 16:36:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 6/8] tests/tcg: ensure system-mode gdb tests start stopped
Date: Thu, 10 Aug 2023 16:36:38 +0100
Message-Id: <20230810153640.1879717-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
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

Without -S we run into potential races with tests starting before the
gdbstub attaches. We don't need to worry about user-mode as enabling
the gdbstub implies we wait for the initial connection.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/guest-debug/run-test.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index c0d0075e2e..b13b27d4b1 100755
--- a/tests/guest-debug/run-test.py
+++ b/tests/guest-debug/run-test.py
@@ -69,13 +69,10 @@ def log(output, msg):
 
     # Launch QEMU with binary
     if "system" in args.qemu:
-        cmd = "%s %s %s -gdb unix:path=%s,server=on" % (args.qemu,
-                                                        args.qargs,
-                                                        args.binary,
-                                                        socket_name)
+        cmd = f'{args.qemu} {args.qargs} {args.binary}' \
+            f' -S -gdb unix:path={socket_name},server=on'
     else:
-        cmd = "%s %s -g %s %s" % (args.qemu, args.qargs, socket_name,
-                                  args.binary)
+        cmd = f'{args.qemu} {args.qargs} -g {socket_name} {args.binary}'
 
     log(output, "QEMU CMD: %s" % (cmd))
     inferior = subprocess.Popen(shlex.split(cmd))
-- 
2.39.2


