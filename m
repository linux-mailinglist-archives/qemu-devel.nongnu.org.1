Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E961791B60
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCEL-0006Rg-Nh; Mon, 04 Sep 2023 12:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDn-00064Z-5n
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDf-0007nU-VN
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so2351736a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844070; x=1694448870; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GNi2AOj7YBZidVqMdiMTsl/wL7uqVeokPItco5CZ1w=;
 b=h21mdo5jeZ3kRCvq2SP/f6C4WDo/xWOTeLsY9vOo0fq7vH54j9u/J07N+NWmXchhHN
 ZTiRWPsFxHTh8v3VINzmFvAAtays/Rjr45UyTx+r1Lf33C4H92RDTJsYkXwEbIR6EBMR
 i7psqeEOfECjjOa/XdfQvjZ6G1VyBX+HSBqAxaX/7QM5xBic188TwNJySItNXTArry7l
 tifaZmKOeb5Xtm37Osl6Ah1NxMIQUxab+7AgSiB6say7qhYKH55t96S6+enpJGbGTdte
 ImbwqcMYAZPSF3BXerkWDmf+MoCWWxOap2OxuHMNBlJ9yYdCDlAdhmpZFKu29o5dd6MT
 3kWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844070; x=1694448870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GNi2AOj7YBZidVqMdiMTsl/wL7uqVeokPItco5CZ1w=;
 b=EzPmxLry/Qd+26QPzNAbyZB2QiC1Jn8x8/Qz8r80vDd+mkSRNi3Zj0qott+yleFHrP
 pmWbzssrBvZT55Un1IfSdzHuwRifmVYu1gMUF3OptBWssI+CSZVPMm3SkKweXOOlFJpU
 1e7Z6EcTCx92fsaq1EbP4bflfdsjYDhcUaZUNb+hx5QiLZqsI6RRICu1busvkfTpu2Ss
 dAkDFtpPs3XVCAQMz5Qtxgo1lBFppw8L5LSdyztJDACFa4fzYbMNiW0y74tLtuNlSIvN
 yintusgDDWs53PByQl9dY63t9983tGJfP4Dk9Bs0zWkB/0jIC9UzSo/aGf6xC33lsvXb
 CqXw==
X-Gm-Message-State: AOJu0Yykd12bG7bCHSizhfk1SAvKvpA7PNfnOxLuY2rmpGzUexUU6L0Y
 1odnqv6wLB/VQp1loSaMkclcNw==
X-Google-Smtp-Source: AGHT+IEe5clzyXiqNTTYljrRgwNpvMiouZd3Gr1Q4mi6qCK8BCnIBeXcwy5swf33GYUHZbmD9S/JHQ==
X-Received: by 2002:a05:6402:3202:b0:52e:585a:e95 with SMTP id
 g2-20020a056402320200b0052e585a0e95mr452717eda.2.1693844070498; 
 Mon, 04 Sep 2023 09:14:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 c21-20020aa7df15000000b005254b41f507sm6024930edy.32.2023.09.04.09.14.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:14:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 20/22] sysemu/device_tree: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:32 +0200
Message-ID: <20230904161235.84651-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


