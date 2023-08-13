Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722677AAF9
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzf-0007nl-7J; Sun, 13 Aug 2023 15:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzb-0007mq-98
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzZ-0002O0-RB
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so33018045e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955792; x=1692560592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uTjuUZfn1BMnx+++7JtIeJPCYgZiSfPp9MKsrrDqfY=;
 b=R8jzdv2k3tkXmhnawXu0kCHasixcIfB3cKv+eOt5H1gmjou8MlX7et4pNJWIdOGQtI
 iSmzN2/ilgAyq+5tPi6uo2Tkq4/YNS6B27bBZh6a55Q8JSAinoetspKrVE5S6Fl82qTs
 NoYrWXS9VLf8mY33Lf8ccP9IwtNku26n/ngrLy7Ipa5EYWWmllq5wEH0HzAsEdgrqMaq
 I/GanErMll4Es9lU5u8ONnswGw8sRr4n1LowZ0Vcx/nxQCWWgVn4K9bM+zNCkBXJYRZ6
 DjUTWeCumYfdUoiGfsTDZ4eq6hFFRkmW/Zqohmbu9aFbnEcm2ss5nudzZi+vCkaaIHBu
 ezzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955792; x=1692560592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uTjuUZfn1BMnx+++7JtIeJPCYgZiSfPp9MKsrrDqfY=;
 b=ggdIrtGyS3+tleO5BE+Ah0aMKw/xad7dymsP224j7lmeQ69mCZdme37HSQn9tgy9D9
 8DZxzxTKH6PMI5lgPNN4XV3nIABjBkMVNVCiNvCgFMcoS6anxl0GwRW7w3W3X+KmEBa+
 ai88I/IvcZC7aZPKz7v8xJYretrbOrQQqvTSIoKE5i/3TD+UBWOY7fozRWvNmurncMw7
 LNJPCTKUxvhFdxHPFiIThbFZgoDb80zyIg+3a4vVRKDPnsNACwV+uVRHJiGtOjH51Ffv
 ZxbvUduS6yvDQLBHnxBuN6IBl0khTx+rsSl86acxHvpQxIE1xs3KJCPRTgAscPERiQV4
 DBdg==
X-Gm-Message-State: AOJu0YyWO0JQNy++3YtSb6ZAWuR8ZVaCQ+t1x8tRcbiiMbzFGPxqDRv7
 VBqxLGJfanhk8na8K2wOP67Tt+/uAeA=
X-Google-Smtp-Source: AGHT+IGbswNsXXUURDyTe/+MrrFSHtS1Fa+19ILA2Mpt2Xj6XuzcrRSmUsnQlPXEn4esL7A/K86xlQ==
X-Received: by 2002:a05:600c:2811:b0:3fe:188c:b684 with SMTP id
 m17-20020a05600c281100b003fe188cb684mr5774881wmb.7.1691955792237; 
 Sun, 13 Aug 2023 12:43:12 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 10/32] Define safe_fcntl macro in bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 10:41:31 +0200
Message-Id: <20230813084153.6510-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 68db9cf4b2..bdcdc4c0fe 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -437,6 +437,8 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+#define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
+
 /* So far all target and host bitmasks are the same */
 #define target_to_host_bitmask(x, tbl) (x)
 #define host_to_target_bitmask(x, tbl) (x)
-- 
2.40.0


