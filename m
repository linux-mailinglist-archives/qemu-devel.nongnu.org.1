Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BCF7766B0
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK5-0000Po-MI; Wed, 09 Aug 2023 13:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK3-0000OO-0i
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:15 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK1-0005fC-4b
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:14 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-269304c135aso27716a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603412; x=1692208212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljQLvXBY81ZagAz+vbBgSRpeNzKthjrbvj4TtE4JxtM=;
 b=BewAU9F8uxcXcjMSwnG7vSFog8x6+0b77+Zl8kth06lQlqkv7O11O2S+xMxcViMWlp
 UVRh70LQPc3CwtfRBmLSt9cIRjvrH6CtwwmuKnMOV43whuzaIpB5Fi0sctaSRY23SIOR
 +/c76Ck9O5RnYIncBjJosgfQsjPIfvwv1JQlt982/IXaFvEBW5ITbFJehZ7gCTpelu+J
 jlESAX5baX+zxb3j01/iIxDbaYSz5wzbGojA4symALLSw3kv9I5nDbAkMZNxuC8JEwZ3
 F4cNjXMC2LbJCErLR1I+JOUAbJ9EaRaeLZmusIl6ShSY4BUWJ95KXN7e3WH5oXgbWBwx
 C24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603412; x=1692208212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljQLvXBY81ZagAz+vbBgSRpeNzKthjrbvj4TtE4JxtM=;
 b=fYDTCK62d61UNvoNyCOK/t5Xb1QrMLpl5abZrtL3rUPhdkcgeG/BhNP5cjSfrChRvM
 efF+Fq/wV2b/1ynvsDuqM8UVJFbf5/kqID46hHLJ8VUVU0RSKauSEnCeDN6miCIWm0Gs
 8fAzQQsIbSFQv4ohhYn4cCqMaHUJpBb0CrrGg8/D53DeLN4gETrM77Y1xRWG4rIX34xy
 OlagJ9SjJ7EIo3v2eGUeOVTLyLaluOgB0EIv0IccAKEyDTWlwPMW4E7iztxeUOtip7hx
 nk2VcRpoXuNogWaPGUFc/TlHCJmsrcNSO+sdVROfsCxJf1HheRb/EzqxwoVSNUNqkXtx
 Dz2Q==
X-Gm-Message-State: AOJu0YyfEM6f8wgJKBygbvq23gb0aMTPCWnofyk/MLqRJ3a0/ogOsMBr
 xwqbBXMAt38TWnKvSnz7KXoYTRIoIdyEMPCON94=
X-Google-Smtp-Source: AGHT+IFf524T2OY5wZEVc69M1YR73Tk7aW6o0LEc6IpKGStSJKu4Ff26lJiTKPEcERZA5sk/GjN2jw==
X-Received: by 2002:a17:90b:20b:b0:268:14a0:f8a with SMTP id
 fy11-20020a17090b020b00b0026814a00f8amr2794757pjb.39.1691603411859; 
 Wed, 09 Aug 2023 10:50:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 5/6] util/interval-tree: Check root for null in
 interval_tree_iter_first
Date: Wed,  9 Aug 2023 10:50:05 -0700
Message-Id: <20230809175006.242479-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Helge Deller <deller@gmx.de>

Fix a crash in qemu-user when running

    cat /proc/self/maps

in a chroot, where /proc isn't mounted.

The problem was introduced by commit 3ce3dd8ca965 ("util/selfmap:
Rewrite using qemu/interval-tree.h") where in open_self_maps_1() the
function read_self_maps() is called and which returns NULL if it can't
read the hosts /proc/self/maps file. Afterwards that NULL is fed into
interval_tree_iter_first() which doesn't check if the root node is NULL.

Fix it by adding a check if root is NULL and return NULL in that case.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3ce3dd8ca965 ("util/selfmap: Rewrite using qemu/interval-tree.h")
Message-Id: <ZNOsq6Z7t/eyIG/9@p100>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 util/interval-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/interval-tree.c b/util/interval-tree.c
index f2866aa7d3..53465182e6 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -797,7 +797,7 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
 {
     IntervalTreeNode *node, *leftmost;
 
-    if (!root->rb_root.rb_node) {
+    if (!root || !root->rb_root.rb_node) {
         return NULL;
     }
 
-- 
2.34.1


