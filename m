Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AE1B01DEB
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 15:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDux-0006QL-36; Fri, 11 Jul 2025 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu9-0004Y3-0Z
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu6-0003OU-W8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso22735595e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240905; x=1752845705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZrgtnfXgpymE8G7muX/kBHKLDatZv3Oqto0HtHHZgd4=;
 b=ifUDadW0amhQY3PyvcTbzEfxyxi19iH/7pAvhPpKbOR3Z5x33BmchSxF5naMM+Eg7k
 cSd1OuSro7olX47vulzkn48q0HWANgP+3y1M9ILfEnEabGfOzZ+Dx9T7mBhmT3maW4F8
 h2b2NYl6xEerB8NbtdHE2jpN7Rn4/wlRBQQ+RTIf8Gf0oWWZvRZ/XKb1Dof6LvddrWyO
 G5VoOXAEJzWLOIZBPQrCoa3MgRVu3hls45Ecz2+/RfNFMQ9py5pZxNf5OC3qSY+5DhiB
 +W4Vsev/uQz8IjRGIDcVxrZqR7ZEwc27WpSWX4YS84oPci9q6443OlqScvWPNW1HTCD3
 Q7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240905; x=1752845705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrgtnfXgpymE8G7muX/kBHKLDatZv3Oqto0HtHHZgd4=;
 b=Cq67ktxMifxPTq85lDjchzuUwbhP3egBeYUnOL3QfT4HTuH1I2xO2Z9ZCn3Tt+0tP8
 FhuDiIbsJ+Nz8zcRNnK6KD0YRedfKQb9pdQev0Drnc3KHvOkQF1Iq5Q8HQXQHfPYUjW0
 flIaXjXSZO3SeoC0TpXgf3GIFl5Jg9FUop5yhQayWgxtvSyX3cBrlNJSrzV0ACHEhTdG
 yUKyMY3o+Iy9wdrIfzMeUVdfpVsc9V+DrM9A7QpeN+dKzD/oE0pWOlrIXzZlxhi0iWJM
 3QXeGANEQMkFM/ODrdYoW+SUBbAkDp4tW5cXnd3246VQjGb4bZN03qb1AjU4Svp4TjMn
 vdLQ==
X-Gm-Message-State: AOJu0YyuTiek5n6onFwc/n9INoQjY4co6YXkfCf7Ga0Wvw+QzKXS48ZX
 0unTongUqeIDsI4yLGPIBcFglS+8EHkFk8fST56EGKFuvz7wt0n//sdyjgUWpnupD2/uGtQ+DFL
 lhIml
X-Gm-Gg: ASbGncvjMLRmPBPVCIlu8WHCgzWVjIgg1uUloGQ4pSYAiWK5yB4hR/rExKJldLKUlUl
 idU4zDwuwpLhQg1f+jQvn8fELPmUzPYmVBB3xp9J/qPkdefgEbuGJrnUszs3z4sx7G5wrhvl6ut
 8VDnFBRnYfZQmbVD13XtpWg5g8fVbuTJSpITFePX3b/IldNuB7qDA8pQ4byYPhHdONbHHu3KZsu
 GJ4MXrpn5kr0KzrqwxiSXFTwhxWh+ez0GPTyogu7t2lnSOF4/UMIot5wWzwSz+LZzerRDQA6Sf5
 qZH673RadtGKnXZpOLy338d6+IaRo3Vk0YPCRHF03SJhWqd8acPyNM3roKhdBF0rQ3JWP+UAk5K
 Yu5kUJF6p06NmQOY9JH3Tv0STJS6U
X-Google-Smtp-Source: AGHT+IGroGCGlc5enOx05alGi4vzxRhX9nd9whTwu3rLYuXeWfMvQfj5m0vhYM7MqPehenLrDR1y6Q==
X-Received: by 2002:a05:600c:a418:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-454db7b297bmr56648445e9.0.1752240904733; 
 Fri, 11 Jul 2025 06:35:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/36] system/qdev: Remove pointless NULL check in
 qdev_device_add_from_qdict
Date: Fri, 11 Jul 2025 14:34:25 +0100
Message-ID: <20250711133429.1423030-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Coverity reported a unnecessary NULL check:

  qemu/system/qdev-monitor.c: 720 in qdev_device_add_from_qdict()
  683     /* create device */
  684     dev = qdev_new(driver);
  ...
  719     err_del_dev:
  >>>     CID 1590192:  Null pointer dereferences  (REVERSE_INULL)
  >>>     Null-checking "dev" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
  720         if (dev) {
  721             object_unparent(OBJECT(dev));
  722             object_unref(OBJECT(dev));
  723         }
  724         return NULL;
  725     }

Indeed, unlike qdev_try_new() which can return NULL,
qdev_new() always returns a heap pointer (or aborts).

Remove the unnecessary assignment and check.

Fixes: f3a85056569 ("qdev/qbus: add hidden device support")
Resolves: Coverity CID 1590192 (Null pointer dereferences)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/qdev-monitor.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 5588ed2047d..2ac92d0a076 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -628,7 +628,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     DeviceClass *dc;
     const char *driver, *path;
     char *id;
-    DeviceState *dev = NULL;
+    DeviceState *dev;
     BusState *bus = NULL;
     QDict *properties;
 
@@ -717,10 +717,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     return dev;
 
 err_del_dev:
-    if (dev) {
-        object_unparent(OBJECT(dev));
-        object_unref(OBJECT(dev));
-    }
+    object_unparent(OBJECT(dev));
+    object_unref(OBJECT(dev));
+
     return NULL;
 }
 
-- 
2.43.0


