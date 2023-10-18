Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE867CDEC9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Ic-0001SI-TN; Wed, 18 Oct 2023 10:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7IY-00010d-VQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:22 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7IT-0004uw-E9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so7074374e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638395; x=1698243195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdVcxCWktT39vzMZdxBJ8XXhyBvhi+GxO2un0WHgbj0=;
 b=N7gxpKTjgD05fXEbaT1N6TVkXMRa3HHGW9Dcx4ZtDMuHct1IywVCHDBDdFkkpVAzOd
 X8G6j9+qYOt4I1Sw/jM/bgkMAUVR/y3WEYNUt+sv6LH/XnswXaJcCp49ZkMxwrWM7hV4
 WPgOzJCW1YW9OzGyMDUTa4sQ9S0vnP5kDjQqwHkYlTo05TU6zm5PER3G5MEvYG4Cng7M
 etDIn+0qNXHwXwZHTt8lVQiZKkMeqBaVqc5BXOeEjvlqsvVmbv8JBs4ATo++w/Mr3xSL
 vmI7mz9bkgMmhvIP5Cyd5g+0237gmDoHc0TDmRd37lGHFdowqYDPBhv4LA/aX8LmbnHR
 Hj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638395; x=1698243195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdVcxCWktT39vzMZdxBJ8XXhyBvhi+GxO2un0WHgbj0=;
 b=SVTdohCp9gzikZtxRes4AZF0qV4puH6OBYvpXi18Ymn2OOsBsOTXHOMIx4bQ1ENmqP
 jRNs6I/7dRpmCLpXA9JI3pnR2T4/6ugJJrXXTD9XKK6JMn0CtHuxyw2Q1zzF9AbhRVI2
 bJFxTfMXpC6w6UyjacFVJ0tT5t6iz979GUyWOriMj9ZQvxcXvocVbcX73iT4pK6H0hEV
 AvDl4Zl/0I200l2y2qRPzcbEFKChBVTOjmBAfIcD9unh0/W63yDODVEUJac9Zju0iuJ1
 6+FIjU8X9vl3uvODS0wFC/m0OK0JxO6NrPEEMUc8SjD0bHq9teV4tv1diugqTxGzoKiF
 ARTw==
X-Gm-Message-State: AOJu0YyWut6FLDpiaRSPJPPRL8KPfSrtfzNIbWdT5+Flvf2e3RZhsRwD
 bttr1Cs25+MdqKfX0FqW48CtdV/saTLx1auKMQw=
X-Google-Smtp-Source: AGHT+IE8xPSrZq7CBsw2bMWAkHoT7sqvlumWoOpWRK3y5mGvkqfIzUK09Dz2IHSV0PFECHL6gQUZTw==
X-Received: by 2002:a19:7503:0:b0:503:38fe:4598 with SMTP id
 y3-20020a197503000000b0050338fe4598mr4328425lfe.64.1697638395402; 
 Wed, 18 Oct 2023 07:13:15 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 s23-20020a50d497000000b0053dfd3519f4sm2933046edi.22.2023.10.18.07.13.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:13:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 10/12] hw/qdev: Ensure parent device is not realized before
 adding bus
Date: Wed, 18 Oct 2023 16:11:48 +0200
Message-ID: <20231018141151.87466-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

qbus_new() should not be called on realized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index c7831b5293..c92d07667b 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -21,6 +21,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/ctype.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler)
@@ -163,6 +164,12 @@ BusState *qbus_new(const char *typename, DeviceState *parent, const char *name)
 {
     BusState *bus;
 
+    if (parent->realized) {
+        error_report("qbus_new(type:%s parent:%s, name:%s) but parent realized",
+                     typename, object_get_typename(OBJECT(parent)), name);
+        abort();
+    }
+
     bus = BUS(object_new(typename));
     qbus_init_internal(bus, parent, name);
 
-- 
2.41.0


