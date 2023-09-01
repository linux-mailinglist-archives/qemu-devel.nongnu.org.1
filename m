Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A618A78F715
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp4-0006Vc-Fc; Thu, 31 Aug 2023 22:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp1-0006UU-N2
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtoz-0001PA-I4
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-56b2e689828so1155217a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535020; x=1694139820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVk5X9WdvzLtlHCovbmOH3Icf/xYwVyrtvZHkdMNBJ8=;
 b=DJHlhrzjtGxAqF51HsLiOjtbRj2CgTD8jpjSVGCKJKwMQDsg4465a4y+CxEKmRcUhV
 apV09VIch6h6yf+p9Qps6DbqXhpsOCv+YJ/7XLbdCxHB1ENyuIx7KamkJ1lGK7UWKwZw
 U0gIkrEblSGZzD/1+MqtFK2OQv7bHQsLVxDgTPhu5cAucJXDBMQT2e35MidrsB44Bmdb
 dlXSSBEnekFUwD88AJFCsKcUNsjPY58VL5/Is6qoBhK3YpUqLO3WRqf4eTe+FT3CmUA+
 1kAdhLzrxe5w+0Lfo/hucSABUwLQtscjVN1Aa/BQFBtUaaExHALcYkAcqCrb3YHVdgfx
 YxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535020; x=1694139820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVk5X9WdvzLtlHCovbmOH3Icf/xYwVyrtvZHkdMNBJ8=;
 b=DvOVWR8J/uVdOCx1dze8kXqAp5WQoFkXMZF9IjWA98lo4bEBVE1BofjTerg2vUv+JZ
 ixegfwyogm0Rho60JXesInQTIhQeQF0I0WsPk4YQMM8l/rCoKG4XGaz5G9gH7qQh5L/X
 J4mH0Zu7kKcQZmoWFjOrXtmBIMQorS3d6m0+TqYFvStjvUjDs1aQPaO7gyLlj5CXgFvm
 USv3vgLQyjNmphxeYQQ1/sSEjRAD3N4fUkVAed8Sm/ih39c0Uwt1qFJkVtk2jcbPUfEu
 /pHAgp2ATY9tb5KO42hhy7LZ9pHQ8SBpOExZMtffxwnnTUibX8UsFUILGN9TmVTORvUX
 XT7g==
X-Gm-Message-State: AOJu0Yylr0HTA1IdqJfYuckqvTrFqsmJR/J0pmXGUGwDnXxw65pH8dXF
 E+RyCsyLbl1kimKVit5cceIMV2rGcvf3rJ4pQQQ=
X-Google-Smtp-Source: AGHT+IFzsTkyqQdHHR1HRsjjj+aR096K+pxKwNM5L3t7aKsjAKwpXfJrrUZW6gj6p4NDAMF7nk3QBQ==
X-Received: by 2002:a05:6300:8084:b0:14d:8624:b144 with SMTP id
 ap4-20020a056300808400b0014d8624b144mr1449067pzc.61.1693535020200; 
 Thu, 31 Aug 2023 19:23:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/33] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Thu, 31 Aug 2023 19:23:07 -0700
Message-Id: <20230901022331.115247-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

We already have qemu_real_host_page_size() in a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index fc23192a32..48a6ef0af9 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -541,7 +541,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * the hosts real pagesize. Additional anonymous maps
              * will be created beyond EOF.
              */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+            len = ROUND_UP(sb.st_size - offset, host_page_size);
         }
     }
 
-- 
2.34.1


