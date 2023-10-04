Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 084987B86BA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5jW-00039h-Tr; Wed, 04 Oct 2023 13:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jP-00035J-Vx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5jO-0000ti-E4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:32:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40651a72807so465355e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696440736; x=1697045536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iUgMeUD+upV2LccJ26enpy7uECYexY6ww0G/2qJYl+4=;
 b=cLNJVtnKzc3wwJ8rHg5Okc/FfO/MF9cDGfyPqUrJbR+SE5a7jEkcyzChoJNz/eenyt
 5snfuiD9zPLjYwTep1hk9QrrDosGq+Xz/vlWj5p6ExfZ5orWKou87rbmZ+9Fl39ya11b
 PbtUIzcHrHXzgStA39PICdJE3CyaADSkRypNJ/l8PPayEqEPGmK0Imx+M1iSaxvI8aYL
 /4jR82Na4Et7nZgceGt1J2IHNqBuKxMADFZd5eYE2likYUhVvUxIAaPPouIvxJsPpF2C
 Jrguj8gw5he5RVqdRQZLfG2/bGXtQx5DLF/lNndUMJPLvvM55vWZ0EQEr2ptBXgFNDAt
 gdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696440736; x=1697045536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUgMeUD+upV2LccJ26enpy7uECYexY6ww0G/2qJYl+4=;
 b=gKA4CtZ16r5caCgUGRSbMBj3m+AfrPoKsrUMHUiAWbepESnS0ui+zjD3RkRxZaQhAN
 /ANip8BdoBynwcOWu/nFrOtKqisiWjtEyJsHqfHF/TbbRRIHhaERa/itPOfMP5S1u3j6
 x/KLos4P4V4zfHb/cY0qNnOusguJKfD0L46Jo31t7bxtsD6LtxWud37XSWB/EJLBNgsx
 CrP/0rdTvfEoyc8l8oHPe2gStKN1+LsSZcLKsjOInWEyNlRdUPxgZPs6zecEVEgAlmwM
 emMn8NI7AVFHhVHCi47DlxJngoFSZnFqltiE23F+vXlkY0FwOnH4oK+yZmPnAhJu01ZW
 SPZA==
X-Gm-Message-State: AOJu0Yz1ZI9Zz2NWIqL4o4ZHkoJjhDS56kvPw0OJ+lDr8on7tR4Ce5Rw
 2vRQN40v520pBdnp0apJ8HJ7r4IaHtCl2f/sQd0=
X-Google-Smtp-Source: AGHT+IHsPNCReIto6W+6CAHbw8CGfedRQ9MqS3svW1ytyQvvdaFPi/eTwK9ztJfcZ3+YqlCygjwaMg==
X-Received: by 2002:adf:e606:0:b0:317:6314:96e2 with SMTP id
 p6-20020adfe606000000b00317631496e2mr2624583wrm.14.1696440735924; 
 Wed, 04 Oct 2023 10:32:15 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c228a00b004065d72ab19sm2059688wmf.0.2023.10.04.10.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 10:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 02/21] qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM
 definition
Date: Wed,  4 Oct 2023 19:31:37 +0200
Message-ID: <20231004173158.42591-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004173158.42591-1-philmd@linaro.org>
References: <20231004173158.42591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, manually
removing the definition in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qapi/qmp/qerror.h | 3 ---
 block/snapshot.c          | 4 ++--
 blockdev.c                | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 1a9c2d3502..168177bcd7 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_HAS_NO_MEDIUM \
-    "Device '%s' has no medium"
-
 #define QERR_DEVICE_IN_USE \
     "Device '%s' is in use"
 
diff --git a/block/snapshot.c b/block/snapshot.c
index b86b5b24ad..eb43e957e1 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -345,7 +345,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium", bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
@@ -420,7 +420,7 @@ int bdrv_snapshot_load_tmp(BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium", bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
diff --git a/blockdev.c b/blockdev.c
index 325b7a3bef..e5617faf0f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1422,7 +1422,7 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
+        error_setg(errp, "Device '%s' has no medium", device);
         goto out;
     }
 
-- 
2.41.0


