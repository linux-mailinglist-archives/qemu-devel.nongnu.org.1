Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD881147A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQ3i-0005vi-7O; Wed, 13 Dec 2023 09:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rDQ3f-0005v1-I1; Wed, 13 Dec 2023 09:17:55 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xun794@gmail.com>)
 id 1rDQ3d-0005zf-GE; Wed, 13 Dec 2023 09:17:55 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-5c6b9583dcbso5860240a12.2; 
 Wed, 13 Dec 2023 06:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702477070; x=1703081870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lUKBpQvbb/yNq0i9RdFSePX/EMam/n8OGH7BjrR4+o8=;
 b=SlS3C/LvyoYbh3X7ZdnO8IhfOHridUctRjDvlGeHs1Drbhd+NMqNx8xDSClqBBMbL1
 im2nnjGRX2bha7hW7Vxu+MnmeAgGzI9Egd7PlkxcJ2XUNruEmU0SjJZURO4/lHXK1qS4
 zOuCfn02gjYyFnGXuin1QqBUB0XBLIAryr2qiC9RqyckaRrJ56do3ddUPMauKLyTGaR6
 bDrJHYpWfwyX1FNlW0LJxBev/P99w5GPpcPajZgv4oQRhb1ZLYxHGios8rzSPh71RJix
 8cc5H144xMlWJ1za+aKMZsQTT/hsn7Oc9IDE7Nnm0ahXoibtyhKq58mVkWitBgzHw44F
 Bvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702477070; x=1703081870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lUKBpQvbb/yNq0i9RdFSePX/EMam/n8OGH7BjrR4+o8=;
 b=lUTxbmK56Y94mHGEAmlk/uI2KdFAv/PLUkGuvgkOjzaSCyv7RW/OQeL+gXZIALmx04
 4R1pOvOYkQ74i42j0Q7Y5CeKJPly6mSSAOYDXxApek3kyz1vrai+aeVx5+HUBCz3bUAs
 aIEpd1LuK8IP0Mu36HyMlmZfHLuCzSXYQh+6DAjaXdSh4BKl/Fh8Db+MgQUL7ftDQ/H+
 zECdYRzJZFA2NqP8FUeMLHgHHjXmgfgpAZcAPmlEDDP9nghKoJ7wgAgXd+nBA2tYg3eh
 P1IYYyz/3a5hqTsHGz47RUoOhbuwDVDOXZcz3TqotF/TRWXz/Zyd+LumJllWjMnVx/vu
 6jfg==
X-Gm-Message-State: AOJu0YxZnA4xzEuvSSFBF1QcKf/MZjQBNzfgGFJkoWRA8Ab/ahwtSZs6
 49Nhq+ME/KPWXdHgCij9ILgYUpK+HXeZkBzL
X-Google-Smtp-Source: AGHT+IF5NSOdWJgki6NTNqkOhfabHjltHl66o+7oL8Kt6hWmfCZO7LL4xwJ/XkGxo/N2mz2EaqASIw==
X-Received: by 2002:a05:6a20:1450:b0:190:1246:7d20 with SMTP id
 a16-20020a056a20145000b0019012467d20mr9781942pzi.87.1702477069696; 
 Wed, 13 Dec 2023 06:17:49 -0800 (PST)
Received: from localhost ([2409:8a20:bc4:a9a0:40eb:1e14:5537:3084])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a056a00195000b006cb574445efsm10062993pfk.88.2023.12.13.06.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 06:17:49 -0800 (PST)
From: Yihuan Pan <xun794@gmail.com>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Yihuan Pan <xun794@gmail.com>
Subject: [PATCH] qemu-options: Clarify handling of commas in options parameters
Date: Wed, 13 Dec 2023 22:17:07 +0800
Message-ID: <20231213141706.629833-2-xun794@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=xun794@gmail.com; helo=mail-pg1-x541.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Provide explicit guidance on dealing with option parameters as arbitrary
strings containing commas, such as in "file=my,file" and "string=a,b". The
updated documentation emphasizes the need to double commas when they
appear within such parameters.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1839
Signed-off-by: Yihuan Pan <xun794@gmail.com>
---
 docs/system/invocation.rst   | 5 +++++
 docs/system/qemu-manpage.rst | 5 +++++
 qemu-options.hx              | 4 ++++
 3 files changed, 14 insertions(+)

Changes since the previous version:
- Added a generic comment about doubling the commas to the
  documentation.

diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
index 4ba38fc23d..14b7db1c10 100644
--- a/docs/system/invocation.rst
+++ b/docs/system/invocation.rst
@@ -10,6 +10,11 @@ Invocation
 disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
 not need a disk image.
 
+When dealing with options parameters as arbitrary strings containing
+commas, such as in "file=my,file" and "string=a,b", it's necessary to
+double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
+parsed as "-fw_cfg name=z,string=a,b".
+
 .. hxtool-doc:: qemu-options.hx
 
 Device URL Syntax
diff --git a/docs/system/qemu-manpage.rst b/docs/system/qemu-manpage.rst
index c47a412758..3ade4ee45b 100644
--- a/docs/system/qemu-manpage.rst
+++ b/docs/system/qemu-manpage.rst
@@ -31,6 +31,11 @@ Options
 disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
 not need a disk image.
 
+When dealing with options parameters as arbitrary strings containing
+commas, such as in "file=my,file" and "string=a,b", it's necessary to
+double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
+parsed as "-fw_cfg name=z,string=a,b".
+
 .. hxtool-doc:: qemu-options.hx
 
 .. include:: keys.rst.inc
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..a935aaae44 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4086,9 +4086,13 @@ DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
 SRST
 ``-fw_cfg [name=]name,file=file``
     Add named fw\_cfg entry with contents from file file.
+    If the filename contains comma, you must double it (for instance,
+    "file=my,,file" to use file "my,file").
 
 ``-fw_cfg [name=]name,string=str``
     Add named fw\_cfg entry with contents from string str.
+    If the string contains comma, you must double it (for instance,
+    "string=my,,string" to use file "my,string").
 
     The terminating NUL character of the contents of str will not be
     included as part of the fw\_cfg item data. To insert contents with
-- 
2.43.0


