Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC277548ED
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjX-0005Su-Aj; Sat, 15 Jul 2023 09:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiG-00042Y-OX
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiF-0001FE-6O
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fc02a92dcfso26057855e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429209; x=1692021209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQ2Bxu/rilowTJXaihrKCWkhFlHMy8pQmQA827CvuAY=;
 b=MEGosP0Yy+10uRbZiHvlRDxU3yGa0m7gKvbZJV9Bw2Nl0j2kljDIeE6+rSwv+cshRl
 UvtYJ/zXIu3VmaGHbsR4hvsVLMe3EL5doyaG8jsuNTHDyneBwWCiW6r1CiylDx4+d5fA
 8R7mvpwJ0LmNwgRJniF87LvKhny1ahYvpLuIGcyKL9oA2lXixBVuI2tYxRbXwN0hP7f7
 TfMfM6CRtBxpvG8tEFzlDXvC1Gq/5iA8Z+pOeulX+MtdS1LRgkKfCegCazve2sGCA2Tn
 0DZ25T+E4a/tqXxa/z47F7l6s141CbGPMGkEeLbuZqibC+2Ord+pmCRbJOy/WQXN/BZE
 FJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429209; x=1692021209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQ2Bxu/rilowTJXaihrKCWkhFlHMy8pQmQA827CvuAY=;
 b=bruUazsw0vM2fcbzQHvLG0fS+UU9WZECDfnJ0J7OWWzbhXlxZQa0HVzhD00bW2Po+w
 bmMTKKf3iIpi1G10x721OishGNeDogjJRB1yLtWj1fhtKcVYbMJdqsB1M2lbgNqmV3ze
 3oP++pBmMx117BMzS3my6mGMEwiVf1AfUQqbzi7Mv0PRfQ7v7IaEQmOvd2KGNqRYKJfa
 ot/tt1OqjTl9zX+XhwfUxCDw8kiWodLFUK7MQzGKPz8Vd9GgfVT6gv/o8W4QGvz1+qAJ
 XzG2jUZOvanpoZQ8BDx+fljqot2tqDw9o0Gkn6RzNcI1vU1rr49ATrME9scZ0fG0c5i6
 nZ4w==
X-Gm-Message-State: ABy/qLaHo4Cpxd1SXi9e7HcyzlHEb0U5lmwO1K50X2+dqKpfdIs50n8/
 1CzCZ+ZT95Zzq++JHVY454O2O0WMUARaPSJtu/3H8w==
X-Google-Smtp-Source: APBJJlEdRN059aQVqrSs6mH/WUQ6qu/xuT7UO4WvdCnN06V+WVPbYF8X1lw8kgEgC4YaYsfN09WnRg==
X-Received: by 2002:adf:cd09:0:b0:314:3f98:a788 with SMTP id
 w9-20020adfcd09000000b003143f98a788mr6379541wrm.7.1689429209650; 
 Sat, 15 Jul 2023 06:53:29 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/47] linux-user: Use abi_short not short in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:42 +0100
Message-Id: <20230715135317.7219-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 21ca03b0f4..9dc41828cf 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -702,8 +702,8 @@ typedef struct target_siginfo {
 
 struct target_pollfd {
     abi_int fd;       /* file descriptor */
-    short events;     /* requested events */
-    short revents;    /* returned events */
+    abi_short events;     /* requested events */
+    abi_short revents;    /* returned events */
 };
 
 /* virtual terminal ioctls */
@@ -1480,7 +1480,7 @@ struct target_stat {
     abi_ushort      st_dev;
     abi_ulong       st_ino;
     abi_ushort      st_mode;
-    short           st_nlink;
+    abi_short       st_nlink;
     abi_ushort      st_uid;
     abi_ushort      st_gid;
     abi_ushort      st_rdev;
-- 
2.34.1


