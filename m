Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C830C74C755
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:42:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAq-0008WU-KC; Sun, 09 Jul 2023 14:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAj-0008Sl-Ex
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAh-00013z-8k
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so43912185e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927410; x=1691519410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1Ndh6I1tE5UeDqHZyfe4FN5fGzwUfKgv00siQ2QsL0=;
 b=jPDN9xZfxi+4wLPYpkE1ZMOamKewzhn+K9ojLubUf0gpsiVG+k70qf5dMIQsgW3XPr
 BsoFKzkRzMuZqFER917PrZ/I3sUhuHIOZnRVYkddyppPk1wQmCfnFoQdtk3AcLR9clWd
 QLJpI8KdSWQQywu3MyKxb/ggga15u6iPfrkBqdEoVY6/E+iBWTp1vneex63ZDLha8Xg+
 pWwyzRkBXunSs5f3vgY0TtFtkFl0TOTo/QToUL2jiBpIqDMNtmKk4wxe22CoQUI0RG5Y
 4r2lcoxp9B8GyHExTXAbtJB9/XZAczqiMw+338/mHx+TogGxRta7fMdaHi8Jiqp9pMck
 AOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927410; x=1691519410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1Ndh6I1tE5UeDqHZyfe4FN5fGzwUfKgv00siQ2QsL0=;
 b=dCAxpytnzxak42GwFtGAWyhytCWihnQ7ItO5HTd9rsXvxi2/fNrdjr3PKIckwwFzz2
 LbZ5fnMkGMbp62M2fgWph06h7ZnyepT1G8ow2VSg33ynRkXWO/DiwylySajJ5R+6wlNp
 cWqY+fZfvqZGEWDq+tEuWNh+afY1oN9YvIxmJipGSPPz5l7cVJXWNBw/i4VybOj6u4a3
 amujZ7bxhoefgcQ073wJqVRq0qBNW5qHwQwmybt7Xm8LXSk6JMdWzOvIuqvsLDDWcZ1e
 qQ3tHwi4tZpmC2eMR8AEiDTa6QGOLznB49eCHXZKedP5hhpaSuh31ymaD3foTNFK3SWC
 m+TQ==
X-Gm-Message-State: ABy/qLanf80IorSXUz0wsBrWKPMZHLybHXa7zoiUvkCiyeHV3/oJVAq6
 99C5TKQtgQ2wyz4c7FMT2KkOv4VQCflxYABZUdMXmA==
X-Google-Smtp-Source: APBJJlFhXvGQZ2GsAhGpDeWOZ4e0rJIiTcI06GYCL302ISkK2GJrN6fzTm7V8FPVMh6JU+Erydc1Sg==
X-Received: by 2002:a7b:c5d3:0:b0:3fa:934c:8356 with SMTP id
 n19-20020a7bc5d3000000b003fa934c8356mr3151501wmk.10.1688927410002; 
 Sun, 09 Jul 2023 11:30:10 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	Andreas Schwab <schwab@suse.de>
Subject: [PATCH 20/45] linux-user: Make sure initial brk(0) is page-aligned
Date: Sun,  9 Jul 2023 19:28:51 +0100
Message-Id: <20230709182934.309468-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Andreas Schwab <schwab@suse.de>

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Message-Id: <mvmpm55qnno.fsf@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8b12774fba..04e07cf261 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -806,7 +806,7 @@ static abi_ulong brk_page;
 
 void target_set_brk(abi_ulong new_brk)
 {
-    target_brk = new_brk;
+    target_brk = TARGET_PAGE_ALIGN(new_brk);
     brk_page = HOST_PAGE_ALIGN(target_brk);
 }
 
-- 
2.34.1


