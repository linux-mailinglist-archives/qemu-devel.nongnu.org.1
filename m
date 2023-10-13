Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F8B7C8620
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHbG-0000xB-EW; Fri, 13 Oct 2023 08:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rajatdhasmana@gmail.com>)
 id 1qrFyA-0005fM-L3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:04:40 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rajatdhasmana@gmail.com>)
 id 1qrFy9-0003Sh-4r
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 07:04:38 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57de6e502fcso1062389eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697195073; x=1697799873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rcMAnKlgWHW9Wv95fBhTp28i9H2d2kB99iSpgqxVkqA=;
 b=DDRr/x0cE8xJm1gxZBOLklD+/DE7MNpLvt/jic1Y/TUknce06zIn1IFY+sAf2YNTr4
 ZtT+74n5k87s57xG3RlB92hISOTY4B5UzoOVDiG2iclmV/UulCxyHawQixhPsU7VKMGC
 jQOXs/3HukS4ONsW7xlFfVuZuKhOP0T2sKaQQ9qwtug2RIGUEH4z7bkS04iT98GZwFbu
 G3yThf13OmC7wDSBNaVgp5kWjAemd0m4y7wEjXXy87GpROQ2eq6gSFi1MKj3zww4ZNtV
 5n/bGsPKeGe7RiIf/z0PaaXuWds9e4MhJK/HkZJWYx9MAYsABJAuT0+YZn+UZlQYxdnA
 bM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697195073; x=1697799873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcMAnKlgWHW9Wv95fBhTp28i9H2d2kB99iSpgqxVkqA=;
 b=ntVsWTNX7e22XX8kW3ZjmHTGqRmyO2CGevCdtnMMwOXut/nNBUyd4V08ISRSQoEyp9
 Ylj8rYhpV67ZB+GG3rCxIHuA29LeV96tbZrr9zZxzIWa8YYiTPc28cBTxrDpTVZrnkPu
 YeYze4bKZBaS9ynyYrjQE1yGwOh6CM3TlSUICsbkkfPCpSPZKydMUfIK2WBl/lSJbVxi
 SiUaanT7MychvCE0mB7lGJuwDlrOf1zCX51DBmh7aMcDJJztPqQGQTogK8bHbhv+7DAA
 DzNuPgLPfrBRVOEx/NO54OiSKVojetDejbMlP12I9VGW5/O3VE7LdOHLqmg+w8jKxIzv
 xUyg==
X-Gm-Message-State: AOJu0YxS3ft05wW8vOptqSRPs0c7T51MvAq8kLG+xkRoIvg9l3MhQmxP
 YcSze0qLKVjotno1Dgk4qkN3KSo6fcs=
X-Google-Smtp-Source: AGHT+IF2NlHO3Xl++YXBO/Lyvm5FHnJevXKKWmixFwMdHjqrr1k8cWlxW1U5JuJb5k1HUiivkYQ6Sw==
X-Received: by 2002:a05:6358:590d:b0:14a:ddb8:9a12 with SMTP id
 g13-20020a056358590d00b0014addb89a12mr32480064rwf.6.1697195072941; 
 Fri, 13 Oct 2023 04:04:32 -0700 (PDT)
Received: from Ubuntu.. ([122.161.51.217]) by smtp.gmail.com with ESMTPSA id
 a21-20020a62bd15000000b00693498a846esm13221073pff.80.2023.10.13.04.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 04:04:32 -0700 (PDT)
From: Rajat Dhasmana <rajatdhasmana@gmail.com>
To: qemu-devel@nongnu.org
Cc: Rajat Dhasmana <rajatdhasmana@gmail.com>
Subject: [PATCH] Doc: Correct the name of qemu-img dd parameter
Date: Fri, 13 Oct 2023 16:34:03 +0530
Message-Id: <20231013110403.231608-1-rajatdhasmana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=rajatdhasmana@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Oct 2023 08:48:52 -0400
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

In the qemu-img documentation, one of the option for the dd command
is mentioned as size whereas it is the skip parameter[1] that is also
available in the dd command.

skip=BLOCKS
    skip BLOCKS ibs-sized blocks at start of input

This patch corrects the documentation.

[1] https://github.com/qemu/qemu/blob/63011373ad22c794a013da69663c03f1297a5c56/qemu-img.c#L229

Signed-off-by: Rajat Dhasmana <rajatdhasmana@gmail.com>
---
 docs/tools/qemu-img.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index ca5a2773cf..88ebe35360 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -501,7 +501,7 @@ Command description:
   modified by specifying *BLOCK_SIZE*. If count=\ *BLOCKS* is specified
   dd will stop reading input after reading *BLOCKS* input blocks.
 
-  The size syntax is similar to :manpage:`dd(1)`'s size syntax.
+  The skip syntax is similar to :manpage:`dd(1)`'s skip syntax.
 
 .. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
 
-- 
2.34.1


