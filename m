Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6DB7B07E0
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD4-0003BE-DR; Wed, 27 Sep 2023 11:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD2-000397-4q
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCx-0005kr-Q0
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so82705265e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827530; x=1696432330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x3HQwcUCL8u5/m5uygc0R9hkwK38G1dWi3WRd+KuW1o=;
 b=zDGuoYCNh8EZ2ZswKUu3daRd0RSgVhVZER45gNd8y3Bd6atCOQtl6QLyXzH6KtJU6W
 yzgbbO9QPQ1+IToIAOUGYI0a3GVdKQ55qVLY9XMLUdGvViSPiB4BLz/OGa8utlF0Ni1O
 kBs7L6W965Z4Vovu6odmPJsIipQz7ZiEoaMABXiLwWOGvsavBGyLIO10qHu7k5RY2wrm
 gm1SaSp8CI5XJx8b9SrBd0VAfQeFqVkJKhENsvnDz54NDglfr1S2sLiWJDP5n6rtrz5f
 4oaVlNUnrTfjg15pSR1WlMUq/zHExEl5ETwyZzncNUzqlmD8WsEQ39CGmFMOO32X5RTb
 SjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827530; x=1696432330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3HQwcUCL8u5/m5uygc0R9hkwK38G1dWi3WRd+KuW1o=;
 b=JogpA98dFgzEledozv4/71DzxgJTsF+tKqm9oOBdqOu8IsHL/3G1cR8xe8pSmMO+zV
 YcqUurG8+DzBruFUy0SQVnJJiFqHhwxjb3WMTVMotNsnDfzeKOZr6tXUb4ZCVjS8b6Xr
 ltXx1XN36wPkRdFr4Mr8Ddrh8zvudnbccbzZ3Hv7LG/q00jcXcjgVYxTLavD4yTtrMFg
 WN3GUtF2wGEW91PnmKWB9nYogLdc65hkuzv8TU3JebyyuDm71aUNj4jFRnfHizj30CMv
 MHcnsDSL/3PDr3EklJ0m/8Ygr5PP0GW8cWVAdqVfawJaJ5hltfy0ZID8VQYk/T8XlM+n
 bnCA==
X-Gm-Message-State: AOJu0YzYUoJSFJHbJIX/fXUts1GvPi1o2bnrLuqsDqrdyLoS1wh1gQLs
 Bw9DDJ2KLTJCKlpQeSUJiPRUtBYynMbHoJZdFtI=
X-Google-Smtp-Source: AGHT+IFSRIbVnKIyzhjFe0SLQpTXCeymAagsTybA0eNL1IAGazCOi44DMkFUbZSjqsRZFm40wo9LGQ==
X-Received: by 2002:a5d:6a8a:0:b0:31f:a136:96c6 with SMTP id
 s10-20020a5d6a8a000000b0031fa13696c6mr2018834wru.42.1695827530240; 
 Wed, 27 Sep 2023 08:12:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] docs/specs/virt-ctlr: Convert to rST
Date: Wed, 27 Sep 2023 16:12:03 +0100
Message-Id: <20230927151205.70930-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert docs/specs/virt-ctlr.txt to rST format.

I added the name of the device to give readers a bit more idea
of which device we're actually documenting here.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/index.rst                        |  1 +
 docs/specs/{virt-ctlr.txt => virt-ctlr.rst} | 12 +++++-------
 2 files changed, 6 insertions(+), 7 deletions(-)
 rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index ee84b8109d6..8d30968650b 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -29,3 +29,4 @@ guest hardware that is specific to QEMU.
    ivshmem-spec
    pvpanic
    standard-vga
+   virt-ctlr
diff --git a/docs/specs/virt-ctlr.txt b/docs/specs/virt-ctlr.rst
similarity index 70%
rename from docs/specs/virt-ctlr.txt
rename to docs/specs/virt-ctlr.rst
index 24d38084f7f..ad3edde82d2 100644
--- a/docs/specs/virt-ctlr.txt
+++ b/docs/specs/virt-ctlr.rst
@@ -1,9 +1,9 @@
 Virtual System Controller
 =========================
 
-This device is a simple interface defined for the pure virtual machine with no
-hardware reference implementation to allow the guest kernel to send command
-to the host hypervisor.
+The ``virt-ctrl`` device is a simple interface defined for the pure
+virtual machine with no hardware reference implementation to allow the
+guest kernel to send command to the host hypervisor.
 
 The specification can evolve, the current state is defined as below.
 
@@ -11,14 +11,12 @@ This is a MMIO mapped device using 256 bytes.
 
 Two 32bit registers are defined:
 
-1- the features register (read-only, address 0x00)
-
+the features register (read-only, address 0x00)
    This register allows the device to report features supported by the
    controller.
    The only feature supported for the moment is power control (0x01).
 
-2- the command register (write-only, address 0x04)
-
+the command register (write-only, address 0x04)
    This register allows the kernel to send the commands to the hypervisor.
    The implemented commands are part of the power control feature and
    are reset (1), halt (2) and panic (3).
-- 
2.34.1


