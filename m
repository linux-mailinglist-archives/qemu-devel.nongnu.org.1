Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F87BD7F3
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:06:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn75-0003Xz-Sd; Mon, 09 Oct 2023 06:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6l-0003CK-83
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6g-0000BJ-I9
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so41851495e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845798; x=1697450598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41oTD6R/rEUywh5fXwmkk1fZnIoCcZZdSBr5PNChPlg=;
 b=lTmCt5zVWvuSfREsyX5+5q3QyhFC/3EU8hv4Kt0Bj1EwsxjnJihBXjpgWxu8ZDnrrj
 54lNAarh1aLyYBjb/xKhz07yv5v67ifaXr9rI4ngSw6ipUIlTGr7fcVSLTLJuuUmYqDH
 IYbZfO4eb8XY/g1EztLSx8gR4lm3WvFa4GVpYgxqZS/WiHfKYwWo1sycRI7zRtIYwPuY
 /74e7er2tSevzuPFG3hgUEVIbxOd6jhz1qE4GfOBA0kJUCwTPCk/V9kRPvFqi+Mdh1PX
 aJZlGkA9VxrxgXz7MxcC4sBZ/vop6F1G4lXa6WnxDOMOfzfOzJwz+CTw3fj2xRDbdBVi
 Vxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845798; x=1697450598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41oTD6R/rEUywh5fXwmkk1fZnIoCcZZdSBr5PNChPlg=;
 b=CkNUYQYgR+pFQNK3Ek7WvRoiggGiC8Oc+0LF1bj2o6YB3Nxh8azF90hFli24Fzv75k
 WJUrzKuvKW21jXF4uyv5Z0UDjGDKzj0g2hUOR1D9m02GXaVsn0LOjQCx+uFI38SPoUYJ
 TKTbpAP46umdXjngpFgsi1pYBmaAGCCxLIma95ZoOSYBmh5AolGJbOvVOz58mxZs/8PV
 HAn4qxYP7W8oSLz3SUCZUC11N16Ru17u8tUn38swCmpbHxK1ngRQUk8eAYwNrqmEjcLt
 obuLB8KcZgCpHyNttwdtBUU4pQbmWbI34a7BZ5dO3AjvKe9eZB1MOL41ouDZPgoD4LzX
 RBLg==
X-Gm-Message-State: AOJu0YzrH3wsxYH/fIxoIJ7XxsPdMuIRxBhrgbw9jPZjoPFZLJwGqX+s
 bsTGMecvkJC8iMc/GR6N0Ys4+/NQKOXw0OqUNe8=
X-Google-Smtp-Source: AGHT+IHsFNNjsBvmkuF8QXHop8Si6ohVN723mIOptbt+kODQXuxjNBKT6Go7/bJcuCRwbboLsnbFSg==
X-Received: by 2002:a5d:6a4c:0:b0:31f:8a6d:e527 with SMTP id
 t12-20020a5d6a4c000000b0031f8a6de527mr13848722wrw.45.1696845797855; 
 Mon, 09 Oct 2023 03:03:17 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 f15-20020a5d50cf000000b00323330edbc7sm9152973wrt.20.2023.10.09.03.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Hao Wu <wuhaotsh@google.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Tyrone Ting <kfting@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/10] tests/cdrom-test: Clean up global variable shadowing in
 prepare_image()
Date: Mon,  9 Oct 2023 12:02:45 +0200
Message-ID: <20231009100251.56019-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Rename the variable to fix:

  tests/qtest/cdrom-test.c:40:50: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static int prepare_image(const char *arch, char *isoimage)
                                                   ^
  tests/qtest/cdrom-test.c:18:13: note: previous declaration is here
  static char isoimage[] = "cdrom-boot-iso-XXXXXX";
              ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/cdrom-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index f2a8d91929..0945383789 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -37,17 +37,17 @@ static int exec_xorrisofs(const char **args)
     return exit_status;
 }
 
-static int prepare_image(const char *arch, char *isoimage)
+static int prepare_image(const char *arch, char *isoimagepath)
 {
     char srcdir[] = "cdrom-test-dir-XXXXXX";
     char *codefile = NULL;
     int ifh, ret = -1;
     const char *args[] = {
         "xorrisofs", "-quiet", "-l", "-no-emul-boot",
-        "-b", NULL, "-o", isoimage, srcdir, NULL
+        "-b", NULL, "-o", isoimagepath, srcdir, NULL
     };
 
-    ifh = mkstemp(isoimage);
+    ifh = mkstemp(isoimagepath);
     if (ifh < 0) {
         perror("Error creating temporary iso image file");
         return -1;
-- 
2.41.0


