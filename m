Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EAB7875DD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDSq-0000Hi-Q8; Thu, 24 Aug 2023 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDSn-0000HA-Lo
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:45:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDSl-0001U8-HI
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:45:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c65820134so2226965f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895537; x=1693500337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WdhK96lna/G7cRzzC8nsZFsxxJgo7BbHQj8avVRRkf0=;
 b=ZGrLt+kYuwQHtzOkuejIdc+epTmyExF6J6Gxja2AXm7w54u/qkgCyg+w/1ICqb42PT
 PlCFJM7LfV0Mwu4kNi3gHc3wSVkE8tyw4z6aNhoFVdBPiYX1K94nyZFhGsJ+3fyVJ8zz
 +6pRl6i/FALtcxZEXRFFqMFIzX3fZgQYZaqBFD/WZ0Iidnv59wQNLK/CZv8QRcuwmaEL
 40QXRtQPRPtGI0yX8gRK3+PyNIto28J8PDOpMm1TLOhb+62ssOtsHpibyhDaRt0XYC6p
 rZVqbYFsc9hovNzNVCl0HuPsVsbqrbPYK7aFSQW/b3UaOjco1hMSE2yBx0TtB7TSaPRW
 FoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895537; x=1693500337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WdhK96lna/G7cRzzC8nsZFsxxJgo7BbHQj8avVRRkf0=;
 b=XfoJnBSqLuuuaInVBo06yROuZ9Oz/CSyFei+6CLWAgTab3pio7ebP+BYfajnyY0UqK
 ppgMo6ytU1fK7v5Nso7/9pBa7zCGMWeNmDetu5+mgdFi36fLihym9nljyhMzmjwVTRor
 tPhuypHAYju1xnR6cXytDBnpS8q2cFrJ2jcI+uKc2s/m+zFgKyZKrT37X7+WNGejTKAi
 1dWRMu43RPKnjIRmyLrJSZa1G26Qhk+obLiReyU2RAU1GQs5/bmDtbTnEheKV7Ac1a9y
 GnQB0vYbmF8oQO0PuNORw/GhMDBUqM60n0G5qLI6avQO+HLOXlAVHQqSm/poRzh8uUjI
 VCJQ==
X-Gm-Message-State: AOJu0YzvRpVhiHtPvNHiP1gvgr4yLlZXdG400CU+3u0CA/wD87aM2EBb
 5Ys1Ey6App//FqjnD4XimEAaSbUTIr5iq5hasPI=
X-Google-Smtp-Source: AGHT+IGF69xRzXYL2ymz8A1VzPtVOkuzdIRlt7FS0IJH2ERj1mtOLSNJ96WlZvVK7L/NAqJvTeMqHQ==
X-Received: by 2002:a5d:6703:0:b0:31c:6591:d41e with SMTP id
 o3-20020a5d6703000000b0031c6591d41emr6188915wru.37.1692895537628; 
 Thu, 24 Aug 2023 09:45:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o2-20020adfcf02000000b00317a04131c5sm22630323wrj.57.2023.08.24.09.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:45:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] tests/qtest/netdev-socket: Avoid variable-length array in
 inet_get_free_port_multiple()
Date: Thu, 24 Aug 2023 17:45:35 +0100
Message-Id: <20230824164535.2652070-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We use a variable-length array in inet_get_free_port_multiple().
This is only test code called at the start of a test, so switch to a
heap allocation instead.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/netdev-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 097abc0230b..8eed54801f2 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -82,7 +82,7 @@ static int inet_get_free_port_socket_ipv6(int sock)
 
 static int inet_get_free_port_multiple(int nb, int *port, bool ipv6)
 {
-    int sock[nb];
+    g_autofree int *sock = g_new(int, nb);
     int i;
 
     for (i = 0; i < nb; i++) {
-- 
2.34.1


