Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A878F719
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpc-0007LW-1M; Thu, 31 Aug 2023 22:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007B2-Mb
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpJ-0001TM-Vf
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:13 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a410316a2so1254094b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535038; x=1694139838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzcEJzTW0FxXggtPi1Qrm/hCkn19peXK5YmTgg9HZqo=;
 b=jyT2CQd6B/rywZOwyuojhg5esUhVLkKFczrXXF9re3qbvDuY3XFJqKaPAGHHLusDsI
 DS7e6YhX9JcPyOXWb97XfEVIh5Mxcwn2/GnxQkeQQqIOfeFhBN6pMTMo1jziFeHhzVk2
 zLbqyGoJF62XYN6IdtMv8/Str46uJpjL7uZPnEQBqNr+9/dcSkQO0bFQ9PdD3i//Vaa7
 TXaH6BjXiOGWYqabz/UZUw0MrqSwjYFLqxuIhNgOpu77wU51Bu1zlUKMvv5Oe8CdQhUE
 MyCV02yy2FYeYZI0zdfJsPhTY/H3lwbxyGEXVc9HExNY6Ta0u7yqHA2BO9z99CiazmpE
 xVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535038; x=1694139838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzcEJzTW0FxXggtPi1Qrm/hCkn19peXK5YmTgg9HZqo=;
 b=QZBiMdrbB6y1hvUCmUP1UcrTZB0QHy68WJdd94r9PdXW466ggkATMa0RGx1feiQOZY
 hGPXo/MEHBa/a3g69liTVzLMTOSc9sEmeSQ7hCHhmAWsc7nHxaewhKvGk7Gq3tmkfzRH
 4i+vt3PgVi1mWspY1dc0mkov2iOoRjo5Ts3YPxa4MS4H4Omo49tGwMw1g/2WuAtPY9DF
 4xkvVhH4i54+s9BcXakM3maF9NFslPAJijMX02bdkOp9dgn6NbWPfvRaoJI4B5rcvNMS
 G7mbZ8+9NA32NUrZaTdREZmJ9iUtiYdJXdM6z7Q61oBhBF+2JvqIetn5yCozmgSEPWkl
 NDVw==
X-Gm-Message-State: AOJu0Yxx1YJvn5GOm9TRu9iumkewef/3VYhjfLCJGqZ50ljJv1ZAHFhQ
 2sHP4la1Bo8ZnstVf+IQe+lYtfoSGzTg/v9Rql4=
X-Google-Smtp-Source: AGHT+IEmnslkpmpoflPk0bHFxu2fHYGr7hVf32XnM1j4Q1IL8CyB8Hb8tu8XaaxiJIjZHkyhTfl83w==
X-Received: by 2002:a05:6a21:7903:b0:13d:ac08:6b79 with SMTP id
 bg3-20020a056a21790300b0013dac086b79mr1278500pzc.60.1693535038559; 
 Thu, 31 Aug 2023 19:23:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 32/33] target/ppc: Enable TARGET_PAGE_BITS_VARY for
 user-only
Date: Thu, 31 Aug 2023 19:23:30 -0700
Message-Id: <20230901022331.115247-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Since ppc binaries are generally built for multiple
page sizes, it is trivial to allow the page size to vary.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu-param.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 0a0416e0a8..b7ad52de03 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -31,6 +31,13 @@
 # define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
-#define TARGET_PAGE_BITS 12
+
+#ifdef CONFIG_USER_ONLY
+/* Allow user-only to vary page size from 4k */
+# define TARGET_PAGE_BITS_VARY
+# define TARGET_PAGE_BITS_MIN 12
+#else
+# define TARGET_PAGE_BITS 12
+#endif
 
 #endif
-- 
2.34.1


