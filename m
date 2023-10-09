Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD97BD7EB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:05:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpn73-0003T7-9Y; Mon, 09 Oct 2023 06:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6n-0003Cf-Al
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpn6j-0000Cj-V0
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:03:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3231d67aff2so4340803f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696845803; x=1697450603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV1dKtatvnpslv9IY1Ow2PCBM/jxT9Mvzt/XqDZ+aVE=;
 b=BizLTxfjQaUfC3b6v9gx+lRxs+TNsM9dcislbcXj4BkRrPlwRnZ/NXZStflqpgjef3
 3LR1eFHdUGzIRDpbETPW1SjyFNZbRMYdj287jbVjN+NZf6tD+obu0sYAjRNqCBOyASAo
 uzq61kv5kcWmJdJC567JvvV3QuS7kcocaPAvWRNYF+oKr8uqYCJUrS7+Ar0K2i/SWoYi
 Hn+v3mZpzjAvBL6mx9dIJK/RZN0hxhxZqX28sCL6cL9ku72PSxRhYS5WnrjkG6qpsHYi
 jF9wYhdSqdrw5VGkc5rLnFHD1LsSw5F9fXfsqAQUgrL7lpFPve2rkW/hpnSyfp7II048
 bBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696845803; x=1697450603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tV1dKtatvnpslv9IY1Ow2PCBM/jxT9Mvzt/XqDZ+aVE=;
 b=g2EnoVUqID7AVY30t3sNMJxWZYJZj+BpW48INoG6xC/OWnODJuBdYN6iDaaNq9bImw
 i9puxDdj70IvocPyL0sotNQ6f6LyJhhoL0CpJ/OgOpH6/PHGnVkbawa/w8fRSdGszq5q
 O6Sbn9LNRppOOdbZ3VTW1YM2xM3+ZX5R/5nED8/jhHV2rZzbI0Ah/kxPu7QIdIoqRvm2
 9znrYpEpbhZ7/V4g06k6PZfezlbq1YFawnSo8Sg5S14sbKQE/Cbv2dseNohyGGLP8lGx
 qvXRU0k+jBZA2YOM2HCcPGGIG6+gGzZCV605vN1pygDYQSa0Ovg1TTgNfQbRWkq1o3TR
 RDzA==
X-Gm-Message-State: AOJu0YwIpD74uMqZ5s5j8etVzqaM9+/W1tBDSbVpcpm4G9c1m4kLBPjB
 dC5kDfWxJ4BrcavWmRUmEY+QhPqOHUEyQaRSTlQ=
X-Google-Smtp-Source: AGHT+IGGPZwRUmfq0aik9grg53A3iGCiS7xFvgeog0+qk6Vo78/tHl7sSfYNuWPRC4Hlret45wznjw==
X-Received: by 2002:adf:dd8f:0:b0:313:f45f:74a1 with SMTP id
 x15-20020adfdd8f000000b00313f45f74a1mr13833134wrl.51.1696845803597; 
 Mon, 09 Oct 2023 03:03:23 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 l1-20020a5d4bc1000000b00323287186b2sm9144677wrt.29.2023.10.09.03.03.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 03:03:23 -0700 (PDT)
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
Subject: [PATCH 05/10] tests/hd-geo-test: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 12:02:46 +0200
Message-ID: <20231009100251.56019-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009100251.56019-1-philmd@linaro.org>
References: <20231009100251.56019-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

  tests/qtest/hd-geo-test.c:610:11: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      char *img_file_name;
            ^
  tests/qtest/hd-geo-test.c:80:14: note: previous declaration is here
  static char *img_file_name[backend_last];
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/hd-geo-test.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index d08bffad91..e5e28c412d 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -78,6 +78,7 @@ static const CHST hd_chst[backend_last][mbr_last] = {
 };
 
 static char *img_file_name[backend_last];
+static char *qcow2_imgpath;
 
 static const CHST *cur_ide[4];
 
@@ -607,18 +608,17 @@ static TestArgs *create_args(void)
 static void add_drive_with_mbr(TestArgs *args,
                                MBRpartitions mbr, uint64_t sectors)
 {
-    char *img_file_name;
     char part[300];
     int ret;
 
     g_assert(args->n_drives < MAX_DRIVES);
 
-    img_file_name = create_qcow2_with_mbr(mbr, sectors);
+    qcow2_imgpath = create_qcow2_with_mbr(mbr, sectors);
 
-    args->drives[args->n_drives] = img_file_name;
+    args->drives[args->n_drives] = qcow2_imgpath;
     ret = snprintf(part, sizeof(part),
                    "-drive file=%s,if=none,format=qcow2,id=disk%d",
-                   img_file_name, args->n_drives);
+                   qcow2_imgpath, args->n_drives);
     g_assert((0 < ret) && (ret <= sizeof(part)));
     args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
     args->n_drives++;
@@ -1139,6 +1139,10 @@ test_add_done:
             g_free(img_file_name[i]);
         }
     }
+    if (qcow2_imgpath) {
+        unlink(qcow2_imgpath);
+        g_free(qcow2_imgpath);
+    }
 
     return ret;
 }
-- 
2.41.0


