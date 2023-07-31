Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C211769937
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgW-0005Zz-Gx; Mon, 31 Jul 2023 10:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgT-0005XJ-5D
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgR-0007et-07
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so9789195e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812937; x=1691417737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nGXXdjxZdAaUuuyvA4vW1eeAGJKvdfA5mFX80NPb9+I=;
 b=t0vvZVRQbYm4SQlk+vv03R+1hzQ6xwOI/R4QeLRgj9pnOImRQsDwiNR+nRCxon7yUg
 lbnkGojE7rMLRd7IMiQzrd4PkkXWFOQxf/bo+F/l98PdbVpbbtb1GRV6N8/n4/w45a1F
 lMbCW9Z+LRaVtcfTm6XKMtHed2RjCMDiOSXDvEjUAl4+ATDlzCwqoRcaZ7+7rnWDfZn3
 Wb47otAHEAcO+vr/45bWuOaY1J2rloaKTB8ZmtGEwSsWdzM7dMd3LHrc7BsOgL97bqOg
 M7pdTdNT/DErhokuoSQoMW2WKmABYByx/fabN9frA13/qhSUUR7pNhz7yDXha3W5epup
 /gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812937; x=1691417737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nGXXdjxZdAaUuuyvA4vW1eeAGJKvdfA5mFX80NPb9+I=;
 b=b7dhNTkLdKTFAKElBfvh8eQXBZwBKQOgBO1P5n6Y0506NfnySO+udOrRpCj9OSduWu
 ai5vDvQjRPM0LMVpHzmvmzPh5EDg+QUgR1DL0L/NerfjIZZzB3wXkvhwGQPP+91kueLA
 /trYZE9gVT1u+rAgY9uZ1mf4l4gwFVpS9RILKjFUA4ZvnxhUn/NW3AVVWjUQEfAXY07V
 5ryQnJNew/UJpvP05neNf4p5KGbbOYaU2XSqMpjcQgVcjNnH2TxEKGTY+jl8yp7NrK8S
 ITZSivwgG1+Wkrjy50eHZI9eqcahNmB2eRuUamVH89CTxVEKc1qKRtD/fJ5EIzqocPXl
 D+uQ==
X-Gm-Message-State: ABy/qLYl54KxkEacCMotWZV9k4h4sVcz51h/Os9+iz5+fL0g/2V1HxSL
 IjXAAggmkQOp8l8xHZ/UL5EGf2NLWOkgloIyYO0=
X-Google-Smtp-Source: APBJJlGweNEEVM1MIhxDK0mw0tmyG1h4p4atbtBdwUEelkKr+u4RnMzBJz3zaSHiBGdgOHTAeuwbAw==
X-Received: by 2002:a05:600c:2482:b0:3fe:2167:97d4 with SMTP id
 2-20020a05600c248200b003fe216797d4mr61136wms.29.1690812937549; 
 Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] kvm: Fix crash due to access uninitialized kvm_state
Date: Mon, 31 Jul 2023 15:15:32 +0100
Message-Id: <20230731141533.3303894-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Gavin Shan <gshan@redhat.com>

Runs into core dump on arm64 and the backtrace extracted from the
core dump is shown as below. It's caused by accessing uninitialized
@kvm_state in kvm_flush_coalesced_mmio_buffer() due to commit 176d073029
("hw/arm/virt: Use machine_memory_devices_init()"), where the machine's
memory region is added earlier than before.

    main
    qemu_init
    configure_accelerators
    qemu_opts_foreach
    do_configure_accelerator
    accel_init_machine
    kvm_init
    virt_kvm_type
    virt_set_memmap
    machine_memory_devices_init
    memory_region_add_subregion
    memory_region_add_subregion_common
    memory_region_update_container_subregions
    memory_region_transaction_begin
    qemu_flush_coalesced_mmio_buffer
    kvm_flush_coalesced_mmio_buffer

Fix it by bailing early in kvm_flush_coalesced_mmio_buffer() on the
uninitialized @kvm_state. With this applied, no crash is observed on
arm64.

Fixes: 176d073029 ("hw/arm/virt: Use machine_memory_devices_init()")
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230731125946.2038742-1-gshan@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c058..7b3da8dc3ab 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2812,7 +2812,7 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
     KVMState *s = kvm_state;
 
-    if (s->coalesced_flush_in_progress) {
+    if (!s || s->coalesced_flush_in_progress) {
         return;
     }
 
-- 
2.34.1


