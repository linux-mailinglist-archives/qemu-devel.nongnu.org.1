Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2A479C7DA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:15:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxaF-0003DE-Jo; Tue, 12 Sep 2023 03:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxaD-0003CZ-UQ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxaB-0006gX-Fx
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb7fb537dso1842225b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502790; x=1695107590;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHEeIOFIQeEybg1OP9uxYR6frP9B0kGaVRtOZCYAkPQ=;
 b=S/xHtX2EOPT4EFBxlvq4qoTuB/fFOZDJyqBRmFlykOO2VF/lgLNoa8H4OhovrQEt5S
 2IdrIDVpkyU2XpmWpRKhHKizfqao9Clvfw7APZtnRqf8G8b0ps28UydXVj8me5zfR3SA
 r/d0tSwEH/1wtc4AMfQ+6lBGaz3AVW5sLG7cspKrum8N69Ht6qDInZ3R2vznPyzicl8I
 PviKpjAVwTuU6i9Ae0a4hiJ3nYrq63vZTFZy+wVFeBG7FtrGIgdLvMMfqonX+iLOfbF1
 aoVOha1cmU3aUQxPrsJPhPt9MPPQd/jCDLsU8SewPjtfns8tRhMhsuEB79BTR7reGbuF
 hNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502790; x=1695107590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHEeIOFIQeEybg1OP9uxYR6frP9B0kGaVRtOZCYAkPQ=;
 b=hozMrnAtm0XVd/GTIPorFZwN3bvwHi6qUDrPj8PSHMmeZEDGjBHaeeHFIttAuYFGsd
 jxhoOzZCYwUf1E142XFHJZo7eOIEkAU0T92w89n/elSkD1NFOa6z1fZ+SnRILkAIiBjM
 CrYoh21kOUV6e+IDIEr+QgWNeUTPhAMYIhTZr4lbjuLZzZjWc20P3kF1kLudoNi8iwxU
 P6F+8LN/thq7OdRTQ9/TttJ+6frqjz3n4lxSYXXwbFSkyh+21tzGTIQJkK0gSaJRY55Z
 8kgbMuRWrvrnIPmmCeFiphkGwzVpWECLCtJbYxTqxFkbigZ+6umaBoTPJjI3H2p5cEr6
 ufGA==
X-Gm-Message-State: AOJu0Yz99sCGXgfztDZMsC8Ui4GxXksKlcaW+O+YJr3k6LcFp8bKK/Sc
 3+qpd921LuN4iNbZOF7H59KXLw==
X-Google-Smtp-Source: AGHT+IFOWa/5WVd3ut2t/YYtS2DGi4oaar3stg80ZJ5ZNpOVJqPOHD/OlfVpQ6chDpdRtQ0YIYuiIg==
X-Received: by 2002:a05:6a00:3088:b0:68f:e810:e86f with SMTP id
 bh8-20020a056a00308800b0068fe810e86fmr774590pfb.28.1694502790317; 
 Tue, 12 Sep 2023 00:13:10 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:13:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 17/18] plugins: Support C++
Date: Tue, 12 Sep 2023 16:12:03 +0900
Message-ID: <20230912071206.30751-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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


