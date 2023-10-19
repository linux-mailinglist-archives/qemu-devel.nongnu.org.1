Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A9C7D03FD
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaTd-0004jS-Se; Thu, 19 Oct 2023 17:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTa-0004Ra-BH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaTX-0000gh-Vn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:22:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so1208865e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750558; x=1698355358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJ9ZaPpfbPcFNzI45afXvQgHQre2Ry4Lwlv0pUnRA5c=;
 b=mootwnurg06jyGfU97h1CYzTo0cLBrF0Lafp8vuaj0SYCSxIPnd92idv0Empt+VKGU
 qSux/N7HQriLx8o8RYXhBZnap0P5cKKgwUhaIldBSmbo6Lz0P5TJ4YJaEvuEqAh5b4EU
 vOt/OOZQhP7Ith1YBADUTbpYjdRajv8pwT+nan0F9WAw2D37R2uB3DIlhR2M03VLbMQN
 xgH+frCgrxfvEtbv+qDUVTQuCMCM1v/tJ6YVuFAtsXysO0z/bTyhJ2EwotgiSseT+tzC
 Y9hpLfWsztyqGVcoLYFJcN5NH5qAIPQfLssrWnot9n8fw2549KIaGQbQddQTnq3iFvqb
 YheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750558; x=1698355358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJ9ZaPpfbPcFNzI45afXvQgHQre2Ry4Lwlv0pUnRA5c=;
 b=aaxCUkNUPVQxGWLGtvBQCo9fSojHy8aVDS86LTM0ppCwl7wFcSY/HFwt1Cy3oyZyeE
 oSOedlMPmeCNgSEVNK+yuydGiUM6B+WX4K1Aq4Zro3VckLnC8sQRd6gDKtTkvUFbef3T
 sxoNVPlesZ3mKbsEvHW18NOT74StkQEgJtX6pnhTwIP+ajme79RxdTQtGHxHDLdbN5z8
 y6UxjY3EppkFSu05VJ6VqB03DN30Z++UMCB2P/3cw1gMhKXBNqQAwTD4NOQhQ4N4P5ne
 oShmY/uv2dTsinkiy4ZQIM4DmlqUGogvNozK4KlE51BLrBDrF40dWKumdOBsusrMSbhC
 RVNw==
X-Gm-Message-State: AOJu0YyRboKzASuFHPMe3fd3Fh3Zm6c3ti+lZMzTRWqL1YAXjutWLBmj
 2kwwaUSOZrn5yrnjTrhHRdeiw2iZFk+reQHQ47WtzA==
X-Google-Smtp-Source: AGHT+IH0tYXBQAPcbu1JuDECiIvpDXN+d2hGDfv2AinU0XMYWpamK/Lzp+Dmb/iC5x/C+VaoBWsezw==
X-Received: by 2002:a05:600c:3502:b0:407:8e85:899f with SMTP id
 h2-20020a05600c350200b004078e85899fmr53066wmq.16.1697750558265; 
 Thu, 19 Oct 2023 14:22:38 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 az15-20020a05600c600f00b00406447b798bsm5381485wmb.37.2023.10.19.14.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:22:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 39/46] hw/s390x/css-bridge: Realize sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 23:18:04 +0200
Message-ID: <20231019211814.30576-40-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

qbus_new() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231019071611.98885-10-philmd@linaro.org>
---
 hw/s390x/css-bridge.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 4017081d49..15d26efc95 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -95,7 +95,6 @@ static const TypeInfo virtual_css_bus_info = {
 
 VirtualCssBus *virtual_css_bus_init(void)
 {
-    VirtualCssBus *cbus;
     BusState *bus;
     DeviceState *dev;
 
@@ -103,19 +102,19 @@ VirtualCssBus *virtual_css_bus_init(void)
     dev = qdev_new(TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
                               OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_new(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
-    cbus = VIRTUAL_CSS_BUS(bus);
 
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, OBJECT(dev));
 
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
 
-    return cbus;
+    return VIRTUAL_CSS_BUS(bus);
  }
 
 /***************** Virtual-css Bus Bridge Device ********************/
-- 
2.41.0


