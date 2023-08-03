Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CEF76DD9C
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWd-0000gP-BJ; Wed, 02 Aug 2023 21:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWZ-0000eY-FB
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWX-0000kj-Nh
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686c06b806cso297401b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027588; x=1691632388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=rCbGeD2c0E16GfrYdJuv+93Z3QI+nn23DdOSbwqRoiO9Ms3DCqp2WsHU99QzBBy5pW
 N/LRlt4Uaicx+IMlo1hm21OJORHK79hCuFEQMVXGp5z5Yx7RSxeL+qvkRY7W2UcxQSI8
 acYUfW+d9fez7BMwlHPDr6sbEILvxoe7NExXux/727zc83ezpVPix6Xm+NqZsYEs8l6A
 sSs9egYqAKWK8USdLXD1YEzQa7H/em2WMdcuyqmwdbbfIwpNuDkI6Qa5iBkMoaFgg/Sd
 Iiia6ONsaJ5BeIljB5wvHbgxSvvfOfHEDyNqKqr3G2M3OkpoR2nHVzVBl6w+WHCtaVB2
 fDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027588; x=1691632388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNYrY2Waoll+LErzR9Xgbts1EKTxuONltL+p3Yeklu4=;
 b=BQqOUIwFDkIZiH9XDCsJigwWMhz6fJfgDd6CiuE0k1ue+H0yZm7w2MdXtD1uzfMofC
 W7r9kzP8YGxKq2ybKY19Jc2f/ie5Foovy1dFIWiiKIi0vpXFRO6/Xy1cg9tgJ3l6ShgW
 Y6rfvU41fM3JY844eGa+9jmq1TcEwDcD3NjFaMlcm5G7srHrbIQGrB/1ZTdyuox2vsHk
 TcRRALn++KlHgpNu7AoHMRGs0v7+HvkzK/goLXT9zqrmwLCNu5QccfsbE1m79WvT9011
 CXmZ90VjQwkDi5xBLpgfD1Bvnf/I6rIdrrvUHItbnP8uGM5+CQ+oQpdGe/Rhk01l46pt
 5f4w==
X-Gm-Message-State: ABy/qLYL+MrkTXhqbLdObsyQzAcwG3xk8rV+ZbkArJ42ulVAdJj+3VWY
 CfEd9VZx3/2V5TyBSpmNfyrQn8aY6FJ9ugAiYlM=
X-Google-Smtp-Source: APBJJlHRJhIzCrIepObEKJMpvW4jhaD7jUvDWnjt/WRTza1TaYBQips8yRKx1SxeloTS7wOAIxBlvQ==
X-Received: by 2002:a05:6a00:2e06:b0:66d:263f:d923 with SMTP id
 fc6-20020a056a002e0600b0066d263fd923mr20213091pfb.20.1691027588220; 
 Wed, 02 Aug 2023 18:53:08 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 05/14] linux-user: Do nothing if too small brk is specified
Date: Wed,  2 Aug 2023 18:52:53 -0700
Message-Id: <20230803015302.407219-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-6-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f64024273f..e1436a3962 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)
 
     /* brk pointers are always untagged */
 
-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val == target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val == target_brk) {
         return target_brk;
     }
 
     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val = initial_target_brk;
+        return target_brk;
     }
 
     new_brk = TARGET_PAGE_ALIGN(brk_val);
-- 
2.34.1


