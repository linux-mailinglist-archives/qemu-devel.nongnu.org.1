Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201076C647
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67a-0007a8-KI; Wed, 02 Aug 2023 03:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67Y-0007Zd-P5
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:12 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67X-0002oM-9n
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:12 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6bb1409ebcfso4082824a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960690; x=1691565490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOp4AdoD8Bkg7odyELEU2opCXFUALl4I3whyZmG1z+k=;
 b=0sMpcNzaSHOgQ5HMuWBKh9HduZNQoRAmXe802GAk2hMFLD2Rx6UjYDI2pAiDpIhYB6
 SNgPAjkgTa/KPYMiSj3zf3tHNZv2QCrSbiHL88Q+jVLLpX4amIKwufsw8+uEDa1w9YEr
 Gbt4WAA1xd8xefMzXRBVyUy0C5yhUlpn4tKZRvMWmFIuaWcepFn/pr9Vck3bLYIkdIg2
 ain3/q2wQ5Tz+BWI3FG3TOiBOMfO9RMvW2QJhmevxYZAIL07lDCwhJgZmWoSq7szgsjs
 KQYEvT5C/F3nchP67p05EGAiTxKaSL1fw982PBsJQEnlqnl9zHoVUAeICplt4V29np/H
 qNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960690; x=1691565490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOp4AdoD8Bkg7odyELEU2opCXFUALl4I3whyZmG1z+k=;
 b=lTDlLyxuIF4Bmow3iKjzhGnOqQRR4/de9hkDRMpbE8MD0XfynCiRvRP3NWVBdRY2tk
 0M78p8ROsFvBnUPqWFfk+U6YZ+NMWF3Xv582xfBTt7pdlMM917EvXlqm5tuK6sXoh26F
 QEtsvjPkaJTHTkffH4J11mQFOB0ncF+ZuJV8F4ox7DYCz3lGfTTZhUv2RS2vI3ZFF25z
 rI7pHDFepHVH1pGV4y12U45p2QNlsedl8D2tSp2MECYapOfxIihsJemyGPBxZinph83T
 W5h5I9N7Fle4X/N+LotD+JSaMFA7Hnv48vg6Hczy5LuCdaS4B/U5fepqpRx2WsFJEvu6
 ELvw==
X-Gm-Message-State: ABy/qLYyOKzE96z5+yyxZ6q9nI+VjNrps5/9DQ46SlKydqL2uLrxy3jv
 FOW3kYi+Coi8z5DOCNW/8bqhhQ==
X-Google-Smtp-Source: APBJJlHKGmLYH6bUvPiYfM56nzbTdx1EnEwWC6CON+dMO63RCq/GWgcECOZggdneQ8qXHoR6d7L64g==
X-Received: by 2002:a05:6830:110f:b0:6b9:9bcd:32fe with SMTP id
 w15-20020a056830110f00b006b99bcd32femr12989622otq.17.1690960690220; 
 Wed, 02 Aug 2023 00:18:10 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:18:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 4/6] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Wed,  2 Aug 2023 16:17:50 +0900
Message-ID: <20230802071754.14876-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802071754.14876-1-akihiko.odaki@daynix.com>
References: <20230802071754.14876-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..ac429a185a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.41.0


