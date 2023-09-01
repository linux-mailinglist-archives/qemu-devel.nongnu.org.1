Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F4C7902F2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAzH-0007FB-Hu; Fri, 01 Sep 2023 16:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyt-00070O-Sy
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyr-0001xv-3R
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso2062479b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600980; x=1694205780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2haO9XzQj3kdCBvuyOIrGT2u14BthjtvXUbKPu1PcU=;
 b=JkE6tvYPDAZ1/qO70jeZDL5F5OFblU112Y2B5E3pJas2PipsR/Ug7bHL2ZgDrCKwCy
 piZg8jReixCgs9ktGOH6e8Hg2oqcx919hI56xZ2zl90OJVxKB1HzpaJEivU2LlV8Hy3j
 6YuR+H6hoxFA9l/abnbm9KaTx/r0SeRaWFhoXPK+/9qC3qrgK/i43uq2hot+ImyWyd+C
 51QfBlw/3l0x6CETG2RdSUPK5mv3Oa3EsKlygAESNkvzBw0BVlKNeOs7mre/jPwpOJ7x
 u0ym9PtpTJzZpyrIrKQAXT/5WXXxqLQG7TChaAnGsV6o1VqZ8xtef9Wgx2cGgws3HJJV
 AR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600980; x=1694205780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2haO9XzQj3kdCBvuyOIrGT2u14BthjtvXUbKPu1PcU=;
 b=ch5/Q5xk4WAoegFBTrYUQj4vXCEAsN0Ysx9osgH3Vt/9GeK8GmeO/7lyQ05didP9va
 TQ4AzcGMXh3/20u3UPmewQMjXtVVDISXr22t6tx3XtLI4Qc9ekLob5yVWG3U3hfdxJ1b
 3jiZ0okJ2vAO0W95Q1NOHwmC93OrO4lXsObUh8dFC3yXUUJrVBcsIgv4XtXqj/O+Q1XD
 xqDnmnEb5pXzXeT5g7cXQ7uyLe5ktwB0wUOzz51ZuFkzjyP/r8GrpYhsbayWgHbtwlS3
 7lnu5m2Q0EjQzbgP91V1Wx/eLjH9ULJB6u8xzciB5hI1ozylH7foHHsu6bijypvlHUQW
 EHCg==
X-Gm-Message-State: AOJu0YxXZbNEe7JX+9UFYmeYVJ0qRmLN9Xbnq6DyBja51pUjhMy7tSKx
 l9mFm9n/TqChJUYB9ddJzLygHbLdgAmnkjbORhM=
X-Google-Smtp-Source: AGHT+IFDykL0c8jeKEfF+LKrgcFeb4mYrcP0uo0oo04p9F5/onpyfFeU8SR2Dfs84FrMIc2xD8Skig==
X-Received: by 2002:a05:6a00:398e:b0:68a:4dc3:dbb9 with SMTP id
 fi14-20020a056a00398e00b0068a4dc3dbb9mr4254787pfb.28.1693600979804; 
 Fri, 01 Sep 2023 13:42:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/13] linux-user: Emulate the Anonymous: keyword in
 /proc/self/smaps
Date: Fri,  1 Sep 2023 13:42:46 -0700
Message-Id: <20230901204251.137307-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


