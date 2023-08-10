Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDD777FF8
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUA6G-000242-2O; Thu, 10 Aug 2023 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5s-0001yc-DB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5m-0001y7-Di
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso8858485ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690936; x=1692295736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fo39w1Ncf4bpUzNN7kkWxqgkT7EH9KrCL5R8N2HXRgE=;
 b=De5lx/fQBqDRIGzs7BXZmBUhFKVgkX4zg/MSoiNOzZjflBt9LZGUPKMhMHHsiac0/l
 sEZAVZFc6FAQC5M0cJFXdurVAhelCFyRXo+yXexiFVj7/ynaNsdiftJg+AMOC0ZAqe+R
 HpH36TkUaUSB47DBkPlsxg8DqmTmj4J7VWUZXXF2wbRh0xzEXPavNErGyuQj3ZbePFdG
 0/mAeoa+UiimoC/35cM3AmT67x8OqlfaoArVkIV9WiJEvdYCUeuoOsMi7Ny9v91OnXwf
 ZgjOpxbgjvlgxIRhhIIdOdPI0/MKP2DuvUYNnFVMLq1Mv7rG7k5wIoI1ciDG6w0L2RTT
 HHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690936; x=1692295736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fo39w1Ncf4bpUzNN7kkWxqgkT7EH9KrCL5R8N2HXRgE=;
 b=mHaU13qctogNUzhtDqjqg2DaVy9ioXRM2HUADjSeWLF/SGZBtfoljEX7ZLpzil0Vwc
 oe1Q6tHtlPSNKB21mvBW95A/CedNlx2zGp5Aq+WpW0Ivc5qiFBToQw14XaFSwLvPzdia
 1DOMFuqCol7fvdGe3Kv2VOIqNtdk5+NR7pIBckLPmt4aGWQcvLZlcOCrq99/sxRetw9o
 yD9lg+enZHKEXJfzoL4mcTddJObto4dTDLvA5L9UlD4f6mhLfZ7aZVx7xK66yVJLU2W6
 TWwrVk+cpnfspAiyPw4j0KXrd+UjrkmyjfmWPV4SCfnGkjSAsMexSEGBTUrfGgxE4f4/
 oAVw==
X-Gm-Message-State: AOJu0Yw7v6+cpQEfq2nNmtu8DGTa26ELkwJB1MlxsUl/mexYBra7Bzzr
 6W9Dkrqk7UOK3pAE1hjXCM5CyEhUkjMqgSdFPB4=
X-Google-Smtp-Source: AGHT+IG59eB5ANwqx/NMqJf9yYBM4UPXeX7YrR4K+6rzEP9HezqTCzcytbsWOBQ62Mz/lqAl1eZUVQ==
X-Received: by 2002:a17:903:234e:b0:1bc:8c6c:217d with SMTP id
 c14-20020a170903234e00b001bc8c6c217dmr3234350plh.61.1691690936363; 
 Thu, 10 Aug 2023 11:08:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902b60e00b001bd41b70b65sm2085212pls.49.2023.08.10.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/4] tests/tcg: ensure system-mode gdb tests start stopped
Date: Thu, 10 Aug 2023 11:08:50 -0700
Message-Id: <20230810180852.54477-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810180852.54477-1-richard.henderson@linaro.org>
References: <20230810180852.54477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Without -S we run into potential races with tests starting before the
gdbstub attaches. We don't need to worry about user-mode as enabling
the gdbstub implies we wait for the initial connection.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230810153640.1879717-7-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/guest-debug/run-test.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/guest-debug/run-test.py b/tests/guest-debug/run-test.py
index de6106a5e5..a032e01f79 100755
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
2.34.1


