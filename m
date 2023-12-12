Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980080E099
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 02:01:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCr7g-0001OW-RX; Mon, 11 Dec 2023 19:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1rCr7b-0001OE-NG
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:59:40 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1rCr7a-0003Zc-7Y
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:59:39 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d337dc9697so696675ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 16:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702342775; x=1702947575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nb6M+eEhAvgXNfVgtl2QDYTwj/tqOTFZP8+wZOidPOM=;
 b=MKbT2682MUUwVNGUPqRJSDHNl/9H1GDCR+vbwE3ONWJ32N9Y9MQZBtPNV+m+xteXXr
 6VKiKyIIFszrTs0K0NVU3Aqqi4o14KzTUPhxfm1EnVo/KGDqxloUx5QeWoult5TJdLx0
 r1+TGUAVf9N5/TrWzzIGNEXJxy1Z5S7cgShHqufzwKTFFWVSAXpaUWWJFLVEQtrM6eOG
 QBnyhv+sxLYyH+Sihc07JBqz22r1uMpxNP4ibinltSY8Mss1Oj1FJ7IRwOWlIjW/7jNM
 q5P4y5IhbEB0jPBkUaJWqkDAUjonk7NFnh+eWDdw516MNPDtP0ZxcIY6Qo+XCeSYFvJ9
 a6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702342775; x=1702947575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nb6M+eEhAvgXNfVgtl2QDYTwj/tqOTFZP8+wZOidPOM=;
 b=aQ81AdsYlAV/ywiCFD43sDlkEWbx2aI8UvUIV6/J7w3FCZJBr9lBQe4k8SIbZOd5DS
 BcRM/7MTgL/f560GzEDnmBq9lFbbWoQYQXzCNrpVfN3nD/jkEa7UFDvEoA1ivA5knpod
 Vg+1AwhE2Ds4KsLIuaO4OQPUsnHQkGUMRAjX9GQTsD6x85ov1URG2mTxOngHWg+nzINp
 5V+nVtGnvOpHExRQJgsY+EmZ1HJFWtWVSNge8PEHf6m4m503G61sTC155JhxBfGUsWlt
 Y7Ew0BIu0WHvtLjShsOz/qyyV/5GTToXtTa/9X0Omk8hpDDHBvH0yvlPwGD1zRycwAnh
 T7DQ==
X-Gm-Message-State: AOJu0YziIfteRZfbDcCkueU1NbwueXAtwws0gVC6lXRxlkeG+OtdgAq+
 YOzKzKf86Fm40vA07NlRdlBRWr233WU=
X-Google-Smtp-Source: AGHT+IF+dblHPYqpj4DLDgkSbF5/kJXEWRHYR//HmE8c/TgWsSVWNIcwhBI12hOx1yWaMvHE37TEjg==
X-Received: by 2002:a17:902:ab4e:b0:1d0:8876:7086 with SMTP id
 ij14-20020a170902ab4e00b001d088767086mr5741009plb.71.1702342775323; 
 Mon, 11 Dec 2023 16:59:35 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::4b6f])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a170903020f00b001cf5d0e7e05sm7267449plh.109.2023.12.11.16.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 16:59:35 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: qemu-devel@nongnu.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] vfio: Include libgen.h for basename API
Date: Mon, 11 Dec 2023 16:59:32 -0800
Message-ID: <20231212005932.2700725-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=raj.khem@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Glibc has two implementation one based on POSIX which is used when
libgen.h is included and second implementation is GNU implementation
which is used when string.h is included. The functions are no identical
in behavior. Musl C library does not implement the GNU version, but it
has provided a declaration in string.h but this has been corrected in
latest musl [1] which exposes places where it was being used from
string.h to error out especially when -Wimplicit-function-declaration is
treated as error.

| ../qemu-8.1.2/hw/vfio/pci.c:3030:18: error: call to undeclared function 'basename'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
|  3030 |     group_name = basename(group_path);

clang-17 treats this warning as error by default

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 hw/vfio/pci.c      | 1 +
 hw/vfio/platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b6..f043c93b9e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include <libgen.h>
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 8e3d4ac458..a835ab03be 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -16,6 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include <libgen.h>
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-- 
2.43.0


