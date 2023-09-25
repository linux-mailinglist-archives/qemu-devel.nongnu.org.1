Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874CF7ADEB4
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK9-0008Hy-5L; Mon, 25 Sep 2023 14:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK5-0008Cr-O0
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:45 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqK3-0007kh-0x
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32320381a07so2993216f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666521; x=1696271321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=JgCCS0oR3cOwKwu/Jh+7z0S3jZ6diEkpJuAmgrAPZrgjnIVfI3A5PWTPXEPWr1fKsg
 of3l6YiHGAvr+ulScpUr499JkVSTL8VUgrdfTn87rYe8d/POOBhVcnAcTX1DGUJ2O9Li
 7GNPk54kQPgN/2kPI/xTZa+ZE18PZEoLJtMgEp7hLOekFD/rn5diMbPIXb2zmuHEjb8k
 WPMGyA3wnxa6EvLcGS5mi2TLhuOSQZeMcL2jMBg+8bpg80JUqmoI81/j2Wc5Ln7Ax0OS
 KMhJ0kAflP5tQ1wXo5h7I0UxhRdyetYtZjVeI88ixrHdguPzaq6x2ZyZ77hm9h3Lbtft
 00jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666521; x=1696271321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=SpfquESzi40LNbyrHrORPTBLV4uabt9NTomp5jkKGu+w4/Sxh6TbnSOD7If1Q70G3M
 +u4G+e2PlpFnK/wzSkxxqlw1f1kM7dHzYJqYskphaj/80QmcYsIiCtAFqooenJGqY4yR
 TJELJXCFrc1lP/orWGjZvlDVdDAaeZe6iV5SrOZL0BZqn0G2ni1F/LyG89PhIQ5qziWy
 Lo7/wjNtOBwge1RDfyjk13qm29h6Ocv8faHRHDANrtwVmQ9BhfE+5RJxt4T7uXP4MMEq
 +HjcYj0wZD3g5Lf7uCbsXd1TL3uUISSufvK0BAgZR9ynOG4gpzKnaWq3srDnCkKcP31l
 C77g==
X-Gm-Message-State: AOJu0Yxxk8Q4o0jw7JCikJSrFpqeHB5O4/Dyuye9yx/GHy6CCG9Zdf7n
 OuJDhFB0o02DiH3ax70JPLJoCNdXpfY=
X-Google-Smtp-Source: AGHT+IGcM9cb8jNiwOQ4luwwaG+iC8P/Dcg0MmjKZ10uTQvKgw71c3hDC1NkXuqysqSsn0Vhvjm3bQ==
X-Received: by 2002:a5d:414d:0:b0:31f:eb8d:481f with SMTP id
 c13-20020a5d414d000000b0031feb8d481fmr6316407wrq.29.1695666521246; 
 Mon, 25 Sep 2023 11:28:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 07/23] bsd-user: Add bsd-mem.c to meson.build
Date: Mon, 25 Sep 2023 21:26:53 +0300
Message-ID: <20230925182709.4834-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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


