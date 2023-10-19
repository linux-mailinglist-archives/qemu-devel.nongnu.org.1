Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFAF7D0401
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRH-0007mu-GB; Thu, 19 Oct 2023 17:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRE-0007Yb-4h
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaR8-0005QO-PR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so107340f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750409; x=1698355209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LI6P3mAOEt0J+sULk7AcXOottYXxMcEMeJJN40YsQ7M=;
 b=kQqYdsN1+P7v/CetlfsBLjCcEuit0FbcZ2z27r0ove0HbXjpyg5RxIFN3ibJO/ubw9
 x3VwInzt33O1VyMezJIJrlCF8qjTyuZWjxZtQcMrMIknKQgr/9NTbwPh4TVijOoV3GQG
 XAXmVgb7GRl1feXNwkSMWdMSgxsbpnp187BEjRXF/zZ6ilzQOxipHhKWZVeeb5jqSQGK
 Xm7iBwI7MzzHHnwi0N6eT55FolNNFlEZK1JrHbZklS+rSmaPgp+RE+s8Db/0bxZeq+nT
 NjAfRPYpQfZLBKrsCn8PJOpYomqn8TpLTuVmSrPXKVxDw1hoPw+mgmXK4rGrtr2M3qq9
 57NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750409; x=1698355209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LI6P3mAOEt0J+sULk7AcXOottYXxMcEMeJJN40YsQ7M=;
 b=w2bWmq3/WlHGooWjM6W7xOrhOcCO3yrT7bkQmYua8SzUxfMKPkITe5RKqgDasC/MRL
 22i273/RxyZCzQU+sTp58yxHrhGDceEW05QJz3HEtDbmC1OY/lDA3WkkpRk0KWEdTS38
 DRTwPohDx5cCEA4+Ewjn/5lPhwXx3aineDr4e390KnfpK69KMTtmZN8DZq44JTE/ihNL
 jg2aF4QPqpad+RxdTUrHVX+e91vClJpTtI7di2P8J2xQXWH2ybN9q/K6VzDJzwFQknlA
 7fXx/BsxqYJxATZvDSUWt3bCca4JHBu9hvpDTUYXViLCCHGW8NzFHeW+MUtTcaieUL15
 omLQ==
X-Gm-Message-State: AOJu0YxvtNlD0ZMJb9OkrDxyeluhBIW5irye+8cn/cJ4zkrwIZ9LY9Ng
 QXvgMN3ToT1Sxycy0Jhc+GE6DE7X+SLdAvsstBUM5Q==
X-Google-Smtp-Source: AGHT+IFcY6+fpORFpwEUaIxkb0pAKsJFYS6aIFrc8okInhBqUvrZT6XoQLFoghOm9Em5VHl4OL9ANA==
X-Received: by 2002:a5d:5592:0:b0:32d:b06c:80b2 with SMTP id
 i18-20020a5d5592000000b0032db06c80b2mr15671wrv.0.1697750409162; 
 Thu, 19 Oct 2023 14:20:09 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a5d6386000000b00327b5ca093dsm208164wru.117.2023.10.19.14.20.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PULL 17/46] hw/pci-host/sh_pcic: Replace magic value by proper
 definition
Date: Thu, 19 Oct 2023 23:17:42 +0200
Message-ID: <20231019211814.30576-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20231012041237.22281-4-philmd@linaro.org>
---
 hw/pci-host/sh_pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 580e273d96..4edebced5e 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -40,7 +40,7 @@ struct SHPCIState {
     PCIHostState parent_obj;
 
     PCIDevice *dev;
-    qemu_irq irq[4];
+    qemu_irq irq[PCI_NUM_PINS];
     MemoryRegion memconfig_p4;
     MemoryRegion memconfig_a7;
     MemoryRegion isa;
@@ -131,7 +131,8 @@ static void sh_pcic_host_realize(DeviceState *dev, Error **errp)
                                      s->irq,
                                      get_system_memory(),
                                      get_system_io(),
-                                     PCI_DEVFN(0, 0), 4, TYPE_PCI_BUS);
+                                     PCI_DEVFN(0, 0), PCI_NUM_PINS,
+                                     TYPE_PCI_BUS);
     memory_region_init_io(&s->memconfig_p4, OBJECT(s), &sh_pci_reg_ops, s,
                           "sh_pci", 0x224);
     memory_region_init_alias(&s->memconfig_a7, OBJECT(s), "sh_pci.2",
-- 
2.41.0


