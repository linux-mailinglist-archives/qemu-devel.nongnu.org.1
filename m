Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41761839303
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:36:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIoj-0005vn-A6; Tue, 23 Jan 2024 10:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoS-0005qd-8x
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:44 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoN-0007E5-9s
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:43 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a685e6299so4609453a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706024137; x=1706628937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuvhd4XqM90NTbdIC1Jw10LgMGZUekSAlaXFP98Jiu8=;
 b=M6yqYQb67Xq+QSXxsUcBJDNAiN+7axLz5fpzl/w9ccj0aCwE9Hrwc1dEpXSbY4Vjom
 VODA8e6mDlW31hFhfFJ0vuV7GQrteZwW7SHPh1JTszOgbM/oQN/6smrO5PWXOvVSc3WP
 hoaqoeiBXyJyup2AG+dLPZMERuvc57pHQC9mYR0k4+EoFLoPhziEwXr3BHFkpD7+5mNi
 iS6ufe3pH4b5fRdYnFy/4EjyirfHYZ4pAxcGzk1UfAvH/Ur1Hr6/Wl3ztm+gk0FQPOfU
 vmSxNg/nd9GZuaoa2gbhCMj4OOB6Kd9PavZ8W8L772+RBlM1VlQ/DaCBefCoi6sKmF83
 nMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706024137; x=1706628937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fuvhd4XqM90NTbdIC1Jw10LgMGZUekSAlaXFP98Jiu8=;
 b=Yj2AjNtkruZlcpE/lKsNwkUU3HPmGZrnZ8vwmldxh5XV300Zr0fVh2vqLK2PIwXyYd
 Ya8eDKgeNK+FPEf2DfHF5/mXIy0eO09cuh/OZOy3N1ky+uw/BBzyw5cNIRPVUz3Pu+Ef
 pjAW1+hCeQj4xUhi8Ntx+gxxNHYxwKcxSmiAc862ou3SPO5ivLNePjIaB/C3LzBTA+dx
 hH8TPUQFL/lpjFkFZwSbzaG03KipYdITsFVJypuunnx2sPGbXSiGiqGa5JB0SxtFRNGR
 rU5IjI6jrqTXGR7g0WREayt8AJL3T6iXJtuoLFKGNCUG8V9iFO0LBWWPytCNZZYKZuRy
 7a8g==
X-Gm-Message-State: AOJu0YxYrdYYuFoY+uZ/nqoHx9h3yT8AxcnyYjyHk6G+4OFcC/3/dw+b
 J3HWeBVNlgWlm5+ivOWrAW50jso/xt+OgvmbDClTUqSdE1UY6MWgGz06Ngo22fqf55+zxWSaxgP
 DPUI=
X-Google-Smtp-Source: AGHT+IEyskmhHyhEaI1N3j5C26niVe/i0V8fKufmSg9iAiyv7ay4uRPG+dZbe3yCZnvXOmcL5OUp+w==
X-Received: by 2002:a05:6402:1512:b0:55c:96da:16cd with SMTP id
 f18-20020a056402151200b0055c96da16cdmr304978edw.61.1706024137058; 
 Tue, 23 Jan 2024 07:35:37 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 cf15-20020a0564020b8f00b0055c903e61easm484663edb.82.2024.01.23.07.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 07:35:36 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v2 2/2] hw/block/block.c: improve confusing
 blk_check_size_and_read_all() error
Date: Tue, 23 Jan 2024 17:35:31 +0200
Message-Id: <8e7eb17fbd39d746079e2bb2525b0ed8c97cca33.1706023972.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
References: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In cases where a device tries to read more bytes than the block device
contains, the error is vague: "device requires X bytes, block backend
provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 include/hw/block/block.h |  4 ++--
 5 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index 9f52ee6e72..624389d62d 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -54,29 +54,30 @@ static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size, void *buf)
  * BDRV_REQUEST_MAX_BYTES.
  * On success, return true.
  * On failure, store an error through @errp and return false.
- * Note that the error messages do not identify the block backend.
- * TODO Since callers don't either, this can result in confusing
- * errors.
+ *
  * This function not intended for actual block devices, which read on
  * demand.  It's for things like memory devices that (ab)use a block
  * backend to provide persistence.
  */
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp)
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp)
 {
     int64_t blk_len;
     int ret;
+    g_autofree char *dev_id = NULL;
 
     blk_len = blk_getlength(blk);
     if (blk_len < 0) {
         error_setg_errno(errp, -blk_len,
-                         "can't get size of block backend");
+                         "can't get size of %s block backend", blk_name(blk));
         return false;
     }
     if (blk_len != size) {
-        error_setg(errp, "device requires %" HWADDR_PRIu " bytes, "
-                   "block backend provides %" PRIu64 " bytes",
-                   size, blk_len);
+        dev_id = qdev_get_human_name(dev);
+        error_setg(errp, "%s device with id='%s' requires %" HWADDR_PRIu
+                   " bytes, %s block backend provides %" PRIu64 " bytes",
+                   object_get_typename(OBJECT(dev)), dev_id, size,
+                   blk_name(blk), blk_len);
         return false;
     }
 
@@ -89,7 +90,11 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
     assert(size <= BDRV_REQUEST_MAX_BYTES);
     ret = blk_pread_nonzeroes(blk, size, buf);
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "can't read block backend");
+        dev_id = qdev_get_human_name(dev);
+        error_setg_errno(errp, -ret, "can't read %s block backend"
+                         "for %s device with id='%s'",
+                         blk_name(blk), object_get_typename(OBJECT(dev)),
+                         dev_id);
         return false;
     }
     return true;
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 26ce895628..0a12030a3a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1617,7 +1617,8 @@ static void m25p80_realize(SSIPeripheral *ss, Error **errp)
         trace_m25p80_binding(s);
         s->storage = blk_blockalign(s->blk, s->size);
 
-        if (!blk_check_size_and_read_all(s->blk, s->storage, s->size, errp)) {
+        if (!blk_check_size_and_read_all(s->blk, DEVICE(s),
+                                         s->storage, s->size, errp)) {
             return;
         }
     } else {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f956f8bcf7..1bda8424b9 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -848,8 +848,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage, total_len,
-                                         errp)) {
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
+                                         total_len, errp)) {
             vmstate_unregister_ram(&pfl->mem, DEVICE(pfl));
             return;
         }
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6fa56f14c0..2314142373 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -902,7 +902,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
     }
 
     if (pfl->blk) {
-        if (!blk_check_size_and_read_all(pfl->blk, pfl->storage,
+        if (!blk_check_size_and_read_all(pfl->blk, dev, pfl->storage,
                                          pfl->chip_len, errp)) {
             vmstate_unregister_ram(&pfl->orig_mem, DEVICE(pfl));
             return;
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 15fff66435..de3946a5f1 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -88,8 +88,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
 
 /* Backend access helpers */
 
-bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
-                                 Error **errp);
+bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
+                                 void *buf, hwaddr size, Error **errp);
 
 /* Configuration helpers */
 
-- 
γαῖα πυρί μιχθήτω


