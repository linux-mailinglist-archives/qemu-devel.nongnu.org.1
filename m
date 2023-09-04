Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8762791751
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8vb-0001FK-PH; Mon, 04 Sep 2023 08:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8va-0001DE-0Q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:38 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8vX-0004cX-MC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:43:37 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bd0a5a5abbso21117381fa.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831413; x=1694436213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJCm9ielSGbSry5cbeI+YJvG0psfGNIv8B+tATNPjpc=;
 b=BcpVQzQeY+8d9RsVWQiy1VBVzzeyR6OkhEIrMeEOU50iOKjXNpTeu0Shm22GtCumGl
 ZuvosTK7Ee7SGSGto43LCoN56sGb2UPaD4adMMqEr9DF9FZ7U+E3SHDpsgWYHQHQ/tnt
 LecuXfyOLMSVwcpyZzStKgW08UlGrlR0csHcxwCrDLpN/diVfZTesC3WGjPvm4HxAety
 LZm80i39s9ltEn1EHbkXoeO2ZwIIAT1pwfYkFe0Ik38Mzkl9b5BmdAE1PxSSBLPiA/FW
 V3gJ1lyuuBeeq9X9Hl0fM/czRoZKH5urRfIed+//OR7+BN+OzXiYtyYOefdyXA6dRJd6
 bXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831413; x=1694436213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJCm9ielSGbSry5cbeI+YJvG0psfGNIv8B+tATNPjpc=;
 b=AmWMUVmWcCEApM0Ld56uU8tlj6fGobhXj9Ji3M9I52euraRgTS70kvQci1L6Wn2T7O
 jdth3NfaVYZulLr/FxLoLTAv2wF/wAZUz2qngGrTv6KMdYFWLNKT/6nv4CCMbEw1NUEC
 2BtiU4ymvhA/QDSjECL5i/M6/75tavC03dyYQikMKHS73Zt2g6GI4km+Pu0aylLWQd1h
 tv32eHLGyNF37ykV6VRMSvabtMgnI30rsrfn3KGJk5elKlxR8eC1hi+T4vkKAb0zBrvU
 EntoXMY6hEk+YuSxIzZyNDQr+u0NUdCKn/A2Wj9qcUZRM4sHltm+KOnPSP8Gk9gRBMa4
 nX0A==
X-Gm-Message-State: AOJu0Yxd8j9GfWLfwobvHOxe1qKef1PLJrEVPolQnaIc1GlKcOoQ4lfi
 NPnzN40T/v5W6VyWmaMJQX8WjMVKoSwOz5IfNbQ=
X-Google-Smtp-Source: AGHT+IF1LC+yWQ0PhXvd9yzZgLb7+mH1K3LMUlqzrxxaMQCoDCfGxeabIkm0GVrCgphK+2vgyIMWHQ==
X-Received: by 2002:a2e:9a8e:0:b0:2bc:b0ae:a9e5 with SMTP id
 p14-20020a2e9a8e000000b002bcb0aea9e5mr7458665lji.42.1693831413634; 
 Mon, 04 Sep 2023 05:43:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906824300b009786c8249d6sm6163671ejx.175.2023.09.04.05.43.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:43:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 01/13] hw/i386/pc: Include missing 'sysemu/tcg.h' header
Date: Mon,  4 Sep 2023 14:43:12 +0200
Message-ID: <20230904124325.79040-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Since commit 6f529b7534 ("target/i386: move FERR handling
to target/i386") pc_q35_init() calls tcg_enabled() which
is declared in "sysemu/tcg.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37c4814bed..43413dd1ac 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -34,6 +34,7 @@
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "sysemu/tcg.h"
 #include "sysemu/kvm.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
-- 
2.41.0


