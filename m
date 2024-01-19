Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37755832D49
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrpz-0000nZ-7z; Fri, 19 Jan 2024 11:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpv-0000lU-Ot
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrpt-0004mP-W7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:35:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so9795165e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682116; x=1706286916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeQ/bMA7W62y/SM3vuOP/JDUaEJLEfPl9aVZLxbSh4I=;
 b=pmcRm1uSjNu/lfXaFBsMP+btolE9DO33WFu85pGE1RYbTZQZLFYy7hCjDucQqwUqA6
 EIR93oD0vvwuc/IBPUaRHXwISEfGdcmZj0r0EKmVwAAanTGm0OtV9PEnRMx0HLhzbZMf
 2X1ccdu0+TEEEyZhbg+Wr8t3mCYe2ve5QVDVvTqAMNU2w6ieZ0sNAaALdAwtES3w9X0L
 0ylAfXiUuJaFtGaerc0jSEJWY3U7MIR813t6X/mFIVwpsjnygD4EFqZclgUjMUFnvNTJ
 0KBwP5GpCV/ivi+IvG6txqi5MfTJe7fmetOHwZkPOVLm8Cxx5G+1hqJvk4/IsK0G3Ahq
 p6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682116; x=1706286916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeQ/bMA7W62y/SM3vuOP/JDUaEJLEfPl9aVZLxbSh4I=;
 b=WUuF5ETFqEa8OhqruYUDgOs65Zre3OovXXiIjveLrS/TbcGg+nDZk0t8dBeB1rb0ZI
 lfn6si2D4e5JrIX1EWXaKo9+n2VPW6Mq7cPHIaTsVul+cCS+iSKi9bFUi+QeZwbkgLKL
 wLBMbLj7ASgH3q/MAnH5trZGsgED4upv8Ly5XvwAkfF38KapkMc4rPpfeKCVJ7A3N9Om
 TsOqKJDL+GExy6m3EFpTBvS1nkQJKZ3WPf11isT6FBlLJuvFcKer9WnhXyYen6+njRoY
 iplFpJu4iiI+9U6C69WRu70k/CiLSSFoVK/1RKryy8++Pl2zzXwlhmWASMcXsn1iHy2u
 yOSA==
X-Gm-Message-State: AOJu0YwTyN0LY38lfyBq+/Ma6Dz2cf6sndtTKzixmzHVhS9iHlf9TqCu
 0W8XHEX0Ek2AmyQ1cceD+ApS1p9B8iTPde1sI9thCDXC9X4vPH2WuvuhcAinpn0t3hZxa/ZIrJl
 u
X-Google-Smtp-Source: AGHT+IFCg/uHYQ6CdIarPXrMPK7I0kY5WFXcWwOzquQltxWT3V6BbkOgABdyUWYglSsFV0dzboOPPA==
X-Received: by 2002:a05:600c:2194:b0:40e:628f:96fb with SMTP id
 e20-20020a05600c219400b0040e628f96fbmr10369wme.168.1705682116376; 
 Fri, 19 Jan 2024 08:35:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e86fbd772sm10979260wmb.38.2024.01.19.08.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:35:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/s390x/css-bridge: switch virtual-css bus to
 3-phase-reset
Date: Fri, 19 Jan 2024 16:35:11 +0000
Message-Id: <20240119163512.3810301-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Switch the s390x virtual-css bus from using BusClass::reset to the
Resettable interface.

This has no behavioural change, because the BusClass code to support
subclasses that use the legacy BusClass::reset will call that method
in the hold phase of 3-phase reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/s390x/css-bridge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 15d26efc951..34639f21435 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -56,7 +56,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
-static void virtual_css_bus_reset(BusState *qbus)
+static void virtual_css_bus_reset_hold(Object *obj)
 {
     /* This should actually be modelled via the generic css */
     css_reset();
@@ -81,8 +81,9 @@ static char *virtual_css_bus_get_dev_path(DeviceState *dev)
 static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    k->reset = virtual_css_bus_reset;
+    rc->phases.hold = virtual_css_bus_reset_hold;
     k->get_dev_path = virtual_css_bus_get_dev_path;
 }
 
-- 
2.34.1


