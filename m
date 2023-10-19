Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1C7CF0F4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtNIw-0007qG-SU; Thu, 19 Oct 2023 03:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNIb-0006jT-Cc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:18:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtNIU-0003i8-V1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:18:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso5126699f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697699900; x=1698304700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/IJC5PGwxG+6/kpGRlXi5TZPdjjr+EIEQtYpUJNBvhI=;
 b=O7AFaUsLh4aXgI0OTcXu4FKqiuhXJGwAHFFr9pJj+D2C3MMdgzvEOjNfo/1xVJSyk5
 HR0G8zdZD6IOZWP96aucfi/lyZzD5f7tHpMXhIPiSYu+mdzsTccJdWa0hvoZr8Ofpx6c
 FKYmSSIfcI74QjgWEvCop+nCBbq0cGldD6ARgKvgc1CWGrkkxEgDwCVEQwlUVo6qRG1S
 dtACVohE6hOEdS0x9E9TNlbavmuGIqxMn9KtpNO2+202suEclODE9PdgWSGkK+ezyW0L
 3IubmfOYKGcAxjvo+CH6WWWpxia0T9PVhEGHGoiCqK6olnGQF9313CkQMu/f/qOuflEH
 5Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697699900; x=1698304700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/IJC5PGwxG+6/kpGRlXi5TZPdjjr+EIEQtYpUJNBvhI=;
 b=N8RBX7DQutTLprM+mrvVr1YETxOR9v/wbhYwDJXs5Co/UVGLr9ro0js1js9jWTWCW9
 r/Fc9GDr7zzkA9P8xMUlGz5XPp3gt94JjIxowVlyYADbPFhUEhOOCba85hUnBXFRtIs7
 OKW9tIJzWAf96/gGM/+aB57VAJoH5gED8KpOq6TN7JFDNFkDM/ATI92Ls+ZZ0bmExryb
 mQUOXyCGu5Xc55/C2oyZf7k2TcP8Ue68LOCm35kSWHEsiKJ8K/7gJ6rNuPon0dCALeet
 6qRga5jF6aOCxgRqFPepHUgz9SEowSQGewi2pLMaVJujUXU9RCTp201DlEY2xj6uamYK
 uA2w==
X-Gm-Message-State: AOJu0Yy616Pq/YX2sIaxIfvOhEwBAWDqvEJiOygTJw4C3bSP5LpeyUU+
 n1ZQ5sWvZ0TrH8lVkZXM1MqOXhM3/EQiDO7LTqLusQ==
X-Google-Smtp-Source: AGHT+IGqCLwilYkDFuVC2tGspC8sOGmV56qjiZ7RVx+E5I0vq47oXsXiKTIMETanl0OTdPV1rigzEw==
X-Received: by 2002:a05:6000:71e:b0:32d:c0cd:cc15 with SMTP id
 bs30-20020a056000071e00b0032dc0cdcc15mr967834wrb.46.1697699900693; 
 Thu, 19 Oct 2023 00:18:20 -0700 (PDT)
Received: from localhost.localdomain (92.red-88-28-12.dynamicip.rima-tde.net.
 [88.28.12.92]) by smtp.gmail.com with ESMTPSA id
 v14-20020a5d4a4e000000b0032196c508e3sm3729859wrs.53.2023.10.19.00.18.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 00:18:20 -0700 (PDT)
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
Subject: [PATCH v2 12/12] hw/sysbus: Ensure device is realized before mapping
 it
Date: Thu, 19 Oct 2023 09:16:10 +0200
Message-ID: <20231019071611.98885-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019071611.98885-1-philmd@linaro.org>
References: <20231019071611.98885-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

sysbus_mmio_map() should not be called on unrealized device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/sysbus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 8f53cb926b..a46828a808 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -133,6 +133,13 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
 {
     assert(n >= 0 && n < dev->num_mmio);
 
+    if (!DEVICE(dev)->realized) {
+        error_report("sysbus_mmio_map(type:%s, index:%d, addr:0x%"HWADDR_PRIx","
+                     " prio:%d) but object is not realized",
+                     object_get_typename(OBJECT(dev)), n, addr, priority);
+        abort();
+    }
+
     if (dev->mmio[n].addr == addr) {
         /* ??? region already mapped here.  */
         return;
-- 
2.41.0


