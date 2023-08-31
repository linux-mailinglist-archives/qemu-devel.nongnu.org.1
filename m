Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF3678F5E8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqbZ-0004sf-4B; Thu, 31 Aug 2023 18:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqbJ-0004fZ-Eh
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:22 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqbF-0003DF-Po
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:21 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-500cfb168c6so2428965e87.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522636; x=1694127436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GNi2AOj7YBZidVqMdiMTsl/wL7uqVeokPItco5CZ1w=;
 b=BO63+KHXIScqc/o1nMCK7Mz7lmzuQ7DEUqw5iMowpiHgfWKHpf+qh+cI6bt1O1X7lv
 jkWzn3QOvsV7qoTdoVIHU26sE7ytH1hGfb743k8ktggJdcq6bJM9UFASbkpsSZx8ulYu
 P3uChnX+V6qe5PFdlRv+dEmyh/zmwIuWb1G6kihR0vtPSasbauctsgyrKTnFQljyIji0
 tGbFI08BMYB60KPMHgmqnDJKF9olgPtTc4/hmpQbnMRbG6UfLyfIke2WjtwU1mxe5Rqj
 Ck15lRS8uClSMjIbrQ5A4t1U815fY1Oh5wtTPxFj1vtckQqUUwFnaG3+L+vd1wP1CbKB
 tSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522636; x=1694127436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GNi2AOj7YBZidVqMdiMTsl/wL7uqVeokPItco5CZ1w=;
 b=iHObpH4S3OwQ4I/XOInmNyrMpXVWqjS1SWixKiEiAnj0cQYTJaSedOMezvGW6ID816
 EobhsNTQHS7jT9G2GOWOHNgii3CH8pweHJ6lWLFn8ltWaNrK6dJeLj1eyHZFgeEQUSDc
 qoHZYuVQxTR7xGG1a2EhDMWj1WxKp2UKUNfS5SOQsnbZv6u24mySFGh6cdUUMzZZKqsf
 3domZ/SVjTT7q/3o56/sXyoZv8h+K28en/oru2ZjEaxklExlf1HR2PgevChsuQbOrubv
 nxHX7fl0i3cMv690pIu6v0IgZ5DqRfg60xti1Kt1rPdWMi5HpYCu6wLf9X/mADlbAP+U
 gisA==
X-Gm-Message-State: AOJu0YzpFxWvkqt+88zUNPjiQ8PJn9tTge3KjhgYHY2AMcaeW7/El12C
 Ei/vyy9tgErr+Lq8dkEmldK7IX9Wqwup4N9Sojs=
X-Google-Smtp-Source: AGHT+IGjAFi3vSCU73KKmCz/ZMWqIazeCAyvlKRs2rPDGApBDzbCegHHqOk7U1/PfnPtoZzjgEi0/w==
X-Received: by 2002:a05:6512:2513:b0:4f8:8be4:8a82 with SMTP id
 be19-20020a056512251300b004f88be48a82mr466680lfb.22.1693522635678; 
 Thu, 31 Aug 2023 15:57:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a50ed08000000b0052333d7e320sm1304363eds.27.2023.08.31.15.57.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:57:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 11/11] sysemu/device_tree: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:06 +0200
Message-ID: <20230831225607.30829-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  hw/mips/boston.c:472:5: error: declaration shadows a local variable [-Werror,-Wshadow]
    qemu_fdt_setprop_cells(fdt, name, "reg", reg_base, reg_size);
    ^
  include/sysemu/device_tree.h:129:13: note: expanded from macro 'qemu_fdt_setprop_cells'
        int i;
            ^
  hw/mips/boston.c:461:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/device_tree.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/device_tree.h b/include/sysemu/device_tree.h
index ca5339beae..8eab395934 100644
--- a/include/sysemu/device_tree.h
+++ b/include/sysemu/device_tree.h
@@ -126,10 +126,8 @@ int qemu_fdt_add_path(void *fdt, const char *path);
 #define qemu_fdt_setprop_cells(fdt, node_path, property, ...)                 \
     do {                                                                      \
         uint32_t qdt_tmp[] = { __VA_ARGS__ };                                 \
-        int i;                                                                \
-                                                                              \
-        for (i = 0; i < ARRAY_SIZE(qdt_tmp); i++) {                           \
-            qdt_tmp[i] = cpu_to_be32(qdt_tmp[i]);                             \
+        for (unsigned i_ = 0; i_ < ARRAY_SIZE(qdt_tmp); i_++) {               \
+            qdt_tmp[i_] = cpu_to_be32(qdt_tmp[i_]);                           \
         }                                                                     \
         qemu_fdt_setprop(fdt, node_path, property, qdt_tmp,                   \
                          sizeof(qdt_tmp));                                    \
-- 
2.41.0


