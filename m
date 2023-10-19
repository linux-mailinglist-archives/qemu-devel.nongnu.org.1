Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECD7CF100
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNIt-00079L-MD; Thu, 19 Oct 2023 03:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHs-0005yt-VY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNHq-0003KD-Fl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:17:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so6642494f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699859; x=1698304659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+HC0X9fTzvHDBaGKX3SssvMlymhei2jKRNiniE4txSs=;
 b=LmmhiZIP3SB4h9gPr9iOZ3/9T5jtEatvnLI7nUOux5gKefeXUfCo99zFl2mvHToNpe
 yc77PjqinmEvFBa6dJKVXGAwuVMfp1++KhGwJX1m/Repkz7ZElgVLPw1O4MKwYiuHzLH
 KGjhb+SsKhJE0lfl0orp5ZqBhQEWmSOSJn1RDItjg6S1eSuU1FNr1GCGEyvL9HIxLw5Z
 QU4o+oEg6+2mNEmtyUoNV1bDWqVdV6J7HGcNVvuTB/zOZbVP5a1exv05x13vgGHZ/fnH
 kcWERlnTxkVwY/WFcmLRiWl7jcuOdMqkeTLBbQt9fp2UAH+Nk2PPZFDRd/yuUU3eQqFr
 pBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699859; x=1698304659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+HC0X9fTzvHDBaGKX3SssvMlymhei2jKRNiniE4txSs=;
 b=iFNhJKFF7rrKd1yps5xIFIWta9dePil7l9HG9aQQWnPCpfkC4DQWxL4avlSqKbTluq
 akrnC0km6WgsjY9TFqFNDtPCpt0ih6+arITsMoSVBbCbItbywarmO3BSv4CV6dwbBf7z
 TPhSzHGmIoLnpDMkmsiauYBllNpSwcdy2De02xn+E0IKv/yi+9u7sNxVQxntgR63RQLX
 L/QS8SDtQ/4OMHgUElo4MOa5a04DUB33s3zAXOCdaKFtnLag6h28EyBTymx8yXIyfOTz
 HBzSEdfkzja7eP09VSFmj6FbLDAjGOaLrauGqdemgL06YeLJCu1XNCE+Qps2A60jfwv1
 LC+Q==
X-Gm-Message-State: AOJu0YyN8gg2vv1aj/9O8O/+/uR8eeZVCIr+MeXGwRMjYtl3olpceIE2
 9vO9mRPQ+k5yAllZg4Give/dOV1Mf/0wY1aa3LFvDg==
X-Google-Smtp-Source: AGHT+IE0tioHrNC1xMR08QwVFrHE4beMJGPc5ovI/RVtxEllCV6g6BA8biua+owla55Uv/WqtWvuhQ==
X-Received: by 2002:adf:ed0e:0:b0:327:e073:d5fe with SMTP id
 a14-20020adfed0e000000b00327e073d5femr854081wro.38.1697699859542; 
 Thu, 19 Oct 2023 00:17:39 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0032d9337e7d1sm3775457wrx.11.2023.10.19.00.17.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:17:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-s390x@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 08/12] hw/isa: Realize ISA BUS sysbus device before
 accessing it
Date: Thu, 19 Oct 2023 09:16:06 +0200
Message-ID: <20231019071611.98885-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/isa-bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index a289eccfb1..f1e0f14007 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -52,18 +52,25 @@ static const TypeInfo isa_bus_info = {
 ISABus *isa_bus_new(DeviceState *dev, MemoryRegion* address_space,
                     MemoryRegion *address_space_io, Error **errp)
 {
+    DeviceState *bridge = NULL;
+
     if (isabus) {
         error_setg(errp, "Can't create a second ISA bus");
         return NULL;
     }
     if (!dev) {
-        dev = qdev_new("isabus-bridge");
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        bridge = qdev_new("isabus-bridge");
+        dev = bridge;
     }
 
     isabus = ISA_BUS(qbus_new(TYPE_ISA_BUS, dev, NULL));
     isabus->address_space = address_space;
     isabus->address_space_io = address_space_io;
+
+    if (bridge) {
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(bridge), &error_fatal);
+    }
+
     return isabus;
 }
 
-- 
2.41.0


