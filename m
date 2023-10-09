Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4517BE702
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptTm-0007jG-5F; Mon, 09 Oct 2023 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1qptTk-0007im-5F; Mon, 09 Oct 2023 12:51:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1qptTi-0005DU-AL; Mon, 09 Oct 2023 12:51:35 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690fe10b6a4so3855314b3a.3; 
 Mon, 09 Oct 2023 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696870291; x=1697475091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9YTlTK2ZJYbpojQknIylpsZ9v984f/ty25tpdC20tm0=;
 b=lbyX2ivP5AZso7ces/Inaa8YZTiYJe+SlcysVbiXkUX/Y1Vtv+x1hHeyspFyk7Ysk8
 sFSnTKeCc+qzyLd96aF+eP6rbksstDgXImrzmK//Q2U9hAAgA2zZPKL5PBbwhKHOogRG
 ZeXRG8voS/HhEOM0FSp/gDUKX1VqE5n6llEH22336czeYmZfzDzbbgL8BKSiIgmq+b0B
 tXz/tqoqfveTfNLvwsVKjk/+8wnLgascU/fGuM3F8pCEOcND6Ty/dFnw0xezqY924tab
 PNNoKuY9j1TmRAOkaLlispczmqPDYjGdz0TsucKfe/o7ZVW9nsav6FufOrNy+W8pvxqL
 ajNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696870291; x=1697475091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9YTlTK2ZJYbpojQknIylpsZ9v984f/ty25tpdC20tm0=;
 b=YBZ5IPWhlsmmLk4wm3qz+qm8h+BOPEP423DmgTClcVAD4Qb5HiI3sPVFc2qyr0yoad
 hB/QDSOdehQ5cZI9J3xNZKOCbH2lP2GNPtSqoDDENcIyHLt+kvLYA3NOdJiMIAPNlZ5g
 LE0YVP7EUvzwDlSSLJbBO5yG7lr/gBH9a52njZjXOh4yeLwTp7cQ/U64NfJL1OyZbokS
 asFngY16nppsj/AdIIwdyy8pSWBVlDNALyugzrWro19ADXUBucxxkXcGvckrrlxeqqAY
 slFG2jZCTnlW639s3o2J35WO5C0Zvoab63mhQtjjR1/RJ/jMrNNtyuxb0RBSb6DZUgkd
 UFLg==
X-Gm-Message-State: AOJu0Ywuu6MdAr835SUkyU/8L7jMscYjzrqbRbuy7rruaHghjASLiI0p
 FIivX5xHsmX0WvsW/AuOnryldNTBa9vIMw==
X-Google-Smtp-Source: AGHT+IGNn5nC5QkVDdOiKCY7S7ZZ4HSb2f9jP4W5yXq4uY+x5bHJPKwVf8v3tvymhFBUzmmY80Occg==
X-Received: by 2002:a05:6a00:22c9:b0:690:2ecd:a593 with SMTP id
 f9-20020a056a0022c900b006902ecda593mr20262127pfj.26.1696870291423; 
 Mon, 09 Oct 2023 09:51:31 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a21-20020a62bd15000000b00693498a846esm6589539pff.80.2023.10.09.09.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:51:29 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH] Revert "configure: Add workaround for ccache and clang"
Date: Tue, 10 Oct 2023 00:51:13 +0800
Message-Id: <20231009165113.498-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This reverts commit fd0e60530f10078f488fa3e9591cc7db5732989c.

According to https://peter.eisentraut.org/blog/2014/12/01/ccache-and-clang-part-3
it's already fixed in new version of ccache

According to https://ccache.dev/manual/4.8.html#config_run_second_cpp
CCACHE_CPP2 are default to true for new version ccache

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/configure b/configure
index e08127045d..3f8dd94b50 100755
--- a/configure
+++ b/configure
@@ -1161,34 +1161,6 @@ EOF
   fi
 fi
 
-########################################
-# check if ccache is interfering with
-# semantic analysis of macros
-
-unset CCACHE_CPP2
-ccache_cpp2=no
-cat > $TMPC << EOF
-static const int Z = 1;
-#define fn() ({ Z; })
-#define TAUT(X) ((X) == Z)
-#define PAREN(X, Y) (X == Y)
-#define ID(X) (X)
-int main(void)
-{
-    int x = 0, y = 0;
-    x = ID(x);
-    x = fn();
-    fn();
-    if (PAREN(x, y)) return 0;
-    if (TAUT(Z)) return 0;
-    return 0;
-}
-EOF
-
-if ! compile_object "-Werror"; then
-    ccache_cpp2=yes
-fi
-
 ##########################################
 # functions to probe cross compilers
 
@@ -1722,10 +1694,6 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-if test "$ccache_cpp2" = "yes"; then
-  echo "export CCACHE_CPP2=y" >> $config_host_mak
-fi
-
 # contrib/plugins configuration
 echo "# Automatically generated by configure - do not modify" > contrib/plugins/$config_host_mak
 echo "SRC_PATH=$source_path/contrib/plugins" >> contrib/plugins/$config_host_mak
-- 
2.39.0.windows.1


