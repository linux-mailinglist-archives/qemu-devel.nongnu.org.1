Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D306786468
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykN-0000AF-76; Wed, 23 Aug 2023 21:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykL-00009k-UO
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykJ-0000RQ-1B
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a56401c12so2779210b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838965; x=1693443765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxFB11WokbscidLNJIq7jg3sXBkPLDLF7tCCnRzjj4U=;
 b=H9bvMoeLhoUHrZtnCvcK2q8sTAW8YFr3Gk8vqZHjcigHMn5j2JB0fCkYjBhoQHsZfN
 wuRU7jak5o8OIJEDzFpUBfPPEbEbTbM1oNYUFf3MBcto0b50axh6u5v7xCxYxIXgaN7z
 qydF1HWyoIPbtiWcYT5UtCO+fXuoc6rRcTEi4trD/P6HrBVqCTakzpiVhs3TYml0nme/
 pBEWkfXTfPrgJPFk6bpP9k+eH5XKTE7lYTH6QvzSzu/wfiXn5aeI+BpIPkZ1fLclp2tc
 OCIDE/eiZQYilPjjCA1ARGVvGbbfhiz3Vgj87pc79qtZIqqgAdSjgv0W94mK4Ph5czhB
 kEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838965; x=1693443765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxFB11WokbscidLNJIq7jg3sXBkPLDLF7tCCnRzjj4U=;
 b=BOs9sh3pR2Z5APbmu4rxPbPRgPaOmD9rHwJlN578f3GVgkgAEPvO/2HUHYQq70z57n
 mEliIg3fsZ/z09Jog3IF11EQ5H/57EG/y4VuPA8+VbiWrrCL/hUY4AjYl8U96szL5OsT
 L0nS6sbhFPi5Rxus4FN8lTBfUdhbO71mDtXw5Wp7H8UPjpQElZuquW2Q07JhjJ27aLx6
 SmcoojYLnZ1zUUEG7Q8BguNEw+zTW+V+O9NJmIJvJ5o4v32sqj+9TdiFMc/Dz6QUHbe7
 PTJcDKTFCH0S0540NNyQa6Ohk72milv4dQM7r5hZSw7la2Di3SwBszGKfCsfHbIvuol0
 Ya6A==
X-Gm-Message-State: AOJu0Yzxk37bo+2r/IQhlAXS4rF71qH8jcWHgN+7VN+hq5DEDlF4f/Pe
 lM6U427mxwiImT9PHRYBdVWrKOaRDTsNJ2fLAUw=
X-Google-Smtp-Source: AGHT+IE/DtTe3+dRscDRb5X0EuaZdJcBTUPEaJoxFcjs9+hrEhg3xVf7q+NYnxw/SNYvFygajaJIFg==
X-Received: by 2002:a05:6a21:7905:b0:14b:8023:33bb with SMTP id
 bg5-20020a056a21790500b0014b802333bbmr3110411pzc.22.1692838965541; 
 Wed, 23 Aug 2023 18:02:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 08/13] linux-user: Emulate the Anonymous: keyword in
 /proc/self/smaps
Date: Wed, 23 Aug 2023 18:02:32 -0700
Message-Id: <20230824010237.1379735-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Core dumps produced by gdb's gcore when connected to qemu's gdbstub
lack stack. The reason is that gdb includes only anonymous memory in
core dumps, which is distinguished by a non-0 Anonymous: value.

Consider the mappings with PAGE_ANON fully anonymous, and the mappings
without it fully non-anonymous.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
[rth: Update for open_self_maps_* rewrite]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0641d8f433..8d96acd085 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8167,7 +8167,7 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
                 "Private_Clean:         0 kB\n"
                 "Private_Dirty:         0 kB\n"
                 "Referenced:            0 kB\n"
-                "Anonymous:             0 kB\n"
+                "Anonymous:             %lu kB\n"
                 "LazyFree:              0 kB\n"
                 "AnonHugePages:         0 kB\n"
                 "ShmemPmdMapped:        0 kB\n"
@@ -8180,6 +8180,7 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
                 "THPeligible:    0\n"
                 "VmFlags:%s%s%s%s%s%s%s%s\n",
                 size_kb, page_size_kb, page_size_kb,
+                (flags & PAGE_ANON ? size_kb : 0),
                 (flags & PAGE_READ) ? " rd" : "",
                 (flags & PAGE_WRITE_ORG) ? " wr" : "",
                 (flags & PAGE_EXEC) ? " ex" : "",
-- 
2.34.1


