Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD68A7A2E75
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQGs-000498-6g; Sat, 16 Sep 2023 04:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGp-00047a-8x
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:03:15 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGn-0006Dk-PU
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:03:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fc081cd46so2752548b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694851392; x=1695456192;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHEeIOFIQeEybg1OP9uxYR6frP9B0kGaVRtOZCYAkPQ=;
 b=YGABrqQQUR9QRh0346kTIJ2VuE99KAECVv2U54cYthWFhVoyxa7oFAS6g0yeuoIStW
 ryJ5jg0nSu6kDQ1MWNVGzWXPyjcG0hl/6Bzv6Yboq+t+SGSHiByA8uIlfnPmsHRaUSSs
 EIIYpAMVdCyavU4iygMOAZIfK4jqCvZghiP/l15YdwRJ2nr1ynfY3sExYkrbZAnRPo4j
 EkmfENw2r9WLzJ32PYoQdQot7SuK4ML2NwF+sblTs6fMyrrhLk77ZGBWNtqATH5IZkcC
 9j+UQXWfcj+5ztetTrfwVQ7qIqRIPWzLi0L/Uez5F9+Ts2SzxBhhwDbphj+nmuB4MbS9
 HLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694851392; x=1695456192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHEeIOFIQeEybg1OP9uxYR6frP9B0kGaVRtOZCYAkPQ=;
 b=XQxTjDEEoKowIBt4bo2qG+kYYLlnokRQM+0zP4e+sP2A7hnyqKXMYW6WxcdUhouFii
 aelvX505hLpUPCboXKEKHA8RfsaZE2nKesIn/yKfEWT7UkDKcn9MRUF7TNLHKWJc2bcv
 cZ2IKj8ZC6uorm1mx6Kr/zGhU6L8VMiEmHppge1/lEKV5eHASbn3bClIwoc6tbELpSq5
 n+0U1BZLI8fybFNkUDHCQIPvTQopzoPNzsp/GBEpDShQ4Fk+Z27QHE7PXpL3kZREMuSX
 MqdG1wyvTNUHLeml0V2LBcshYSQFcO8qJccEp3p4HpgkedStoEvjzR9T3DNyALLhK2eu
 GF6Q==
X-Gm-Message-State: AOJu0Yw93f7Son4cQhkPPwTJbiy36CuWhx5lrqBT9PdZvZ+Kfy3ZSdrH
 09wMu0ksB1Gtp+sVIKo8v7em7g==
X-Google-Smtp-Source: AGHT+IFycmLgwZhCZbjHimc0h6fGsSyYEyrFjQNkWPB6gzc9gf7+kfoiqibHqouHAUo+p11/4sy00g==
X-Received: by 2002:a05:6a20:394b:b0:14d:6309:fc90 with SMTP id
 r11-20020a056a20394b00b0014d6309fc90mr3113589pzg.8.1694851392330; 
 Sat, 16 Sep 2023 01:03:12 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0068a46cd4120sm4029484pfa.199.2023.09.16.01.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:03:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 18/19] plugins: Support C++
Date: Sat, 16 Sep 2023 17:01:35 +0900
Message-ID: <20230916080149.129989-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916080149.129989-1-akihiko.odaki@daynix.com>
References: <20230916080149.129989-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Make qemu-plugin.h consumable for C++ platform.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/qemu-plugin.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 40aae8db68..55f514ca6c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,8 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+G_BEGIN_DECLS
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -710,4 +712,6 @@ int qemu_plugin_find_register(unsigned int vcpu_index, int file,
  */
 int qemu_plugin_read_register(GByteArray *buf, int reg);
 
+G_END_DECLS
+
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.42.0


