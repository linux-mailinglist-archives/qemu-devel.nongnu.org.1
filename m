Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93035722DCA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6EDa-0007wV-UP; Mon, 05 Jun 2023 13:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDU-0007vj-HD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:42:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDT-0006Tw-1L
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:42:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f730c1253fso18835585e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685986921; x=1688578921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pndkd4mqky/gWkS+dPo6iaUDvWqgI4SpsWKcy9JsXbc=;
 b=c/3rsR7fM8BK46xlpTdzecLZ+tkZwTk4edkTGjI1q75hceh01BS9d5VQ+HwjGcQZtV
 IyVliE8ATDRozNIE9Y1HwlPnwgAPO36qFDIhvE9Zfr0nICncOVVmHXI7JTznTIZ3cdi8
 A5YnREk+UdoLV+bqd6KchV633JTOFMp4LdNFPnnYOB9Dwe9co5HYKoX+rWwJACDg0jHP
 +kbcagQpcPncR3WK6MNnOQBVrYRybMjIGb7zQvjH+3CcrZJta1sDjsm5klVSM/4vgkHU
 YOcjxzjxD6J6rQVef/0aZt5Rw3hjW2rYpF77OKbeLfgt4SqAW1qyg3H9755yLnZ4uM1a
 bKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685986921; x=1688578921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pndkd4mqky/gWkS+dPo6iaUDvWqgI4SpsWKcy9JsXbc=;
 b=FrdM1oine5h6Fkul3AKor+gL2AaHmeDIszpZXGEGaFtiXBDmgMz/AQpWVqZqqp+H8w
 +aBvgHxGNyvIAAu0+HLy6VNY8kJkEGnEUfhgG3pJgybtNpHM54otzyvwMqmPTjuDoQr1
 afS/Z73puJpOZC9gtXY2PBcg6d9C30C4gJqVyOTrjnWemouv6077MvfEYy4vEGpl1d08
 P+GlRejHQaSUYOd/oirG/qIdNX8u+8k9/BDiiPTg+q1pMK65u5PLAJ0xwJGervDoRb+z
 gphD2QcxJV6tOSqfP8NmgUbu0gWkdusS8IJsSddQ1kDTK5K1B28E69C8PlDl9GUut0hI
 PHFw==
X-Gm-Message-State: AC+VfDzpMQdSdvt1T2phHP06LQdhXdHW8JTHxti4it5D+aLEnCspkCxZ
 yUQG8L1FXMxGeuqVpTWKLK2mwxrjQjIOd6CnFiU=
X-Google-Smtp-Source: ACHHUZ5YrdMr7Y4qvY7e3f9hzALgf8lXPy6cjggtGWMQMYtMNPRus50VOXTQLAVxh73RyqvCpVyTlg==
X-Received: by 2002:a05:600c:250:b0:3f4:e9f6:1c3b with SMTP id
 16-20020a05600c025000b003f4e9f61c3bmr7241621wmj.12.1685986921368; 
 Mon, 05 Jun 2023 10:42:01 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a05600c205100b003f604ca479esm15049983wmg.3.2023.06.05.10.41.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:42:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/2] scsi/qemu-pr-helper: Use defaults
 [get/set]_multipath_config() impl
Date: Mon,  5 Jun 2023 19:41:46 +0200
Message-Id: <20230605174146.87440-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605174146.87440-1-philmd@linaro.org>
References: <20230605174146.87440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit b3f1c8c413 ("qemu-pr-helper: use new libmultipath API")
declared the two [get/set]_multipath_config() functions to
satisfy the 'new' API. The library already provides an internal
implementation for these helpers, exposed as weak symbols.
Since our implementation doesn't provide much, we can default
to the internal implementation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scsi/qemu-pr-helper.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index ae44a816e1..4d64e6b53c 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -261,26 +261,14 @@ static void dm_init(void)
 
 /* Variables required by libmultipath and libmpathpersist.  */
 QEMU_BUILD_BUG_ON(PR_HELPER_DATA_SIZE > MPATH_MAX_PARAM_LEN);
-static struct config *multipath_conf;
 unsigned mpath_mx_alloc_len = PR_HELPER_DATA_SIZE;
 int logsink;
 struct udev *udev;
 
-extern struct config *get_multipath_config(void);
-struct config *get_multipath_config(void)
-{
-    return multipath_conf;
-}
-
-extern void put_multipath_config(struct config *conf);
-void put_multipath_config(struct config *conf)
-{
-}
-
 static void multipath_pr_init(void)
 {
     udev = udev_new();
-    multipath_conf = mpath_lib_init();
+    mpath_lib_init();
 }
 
 static int is_mpath(int fd)
-- 
2.38.1


