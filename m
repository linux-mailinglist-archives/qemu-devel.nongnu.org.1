Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B5AA9BB49
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 01:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8600-0003DU-LF; Thu, 24 Apr 2025 19:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zq-0003BI-PL
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u85zo-00086s-9x
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:28:45 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739be717eddso1228741b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537322; x=1746142122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VU4H5gBzaTT//12kf03NeonR/1W+AoBYDcX+xQsRjak=;
 b=CvyzBBDNtujimV9DsUDAiSccxap41pQANBvL/KnxNCbiYGv+5uchyU9OPvapgZ2c+V
 D3wqiBPZE6Ex1tZSvK6rq7WOMXt24Benu4HhwMMlKLnZLeZV9jmoK+luovsfx77ujTrr
 DwDCn6jXrFW67ylnMk9wNhHrfXcSdeOw5Z4fzqiuwpUHGl0mNUZl6haKXnmr9kVP6G5s
 e2CPsOpLmCrLF1M4iSRF38BIT/RhBpfWCCasO+zNrt0C4DwbUvubNal1uGLP4DlgV6+X
 H6VygDSxb8f6nnploqxQFyo0QhJFgKHGfKGLWIKKybSZPUbyWphnNnADa6SFERqo60Lz
 Ek5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537322; x=1746142122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VU4H5gBzaTT//12kf03NeonR/1W+AoBYDcX+xQsRjak=;
 b=DRbanTvZtZep45gOQ2v6BEba+aMAuIGLI7rIQVT9ug2BVRS18Fyo4JnaxYJ6KawlQ+
 uh41+RfMaw6Iugf5zmGd5/ZS0ZaMMpOCr9qgWrZYLpFvmbQj5efkHX1aRiIm1fHiGkiF
 nEuTCdZshH8SWWTgwwjR8w0+aJ3H/JYwwaO7jgDjRtcQVmQdXasRjmcxlEtMhbay2TxK
 CF1+dsyFT5tR/xIIHK3NEecSBuHmb6GC92NTfYuhGX99tuGgFfS7nMWdDKeXSVSSga02
 Ji+pnalQGMqxWEtdWvN7X/lBUQaJaWTjNA3TsYN9SDFsVh1z5y+0Pa9Cx4s4TxnTFPpH
 8JUg==
X-Gm-Message-State: AOJu0YzDsGhVnUGHfKsKqoCWE+OUQ1QyL/r++uIgQfyyBUdtLcYbHzx/
 34YiHnUx+mo8rVxM3Pc8pVJJb8jOBkthhjxmky36VvDTa0YbAeNTFWKRZ7bDJxEF6jy5dhmHapN
 k+iY=
X-Gm-Gg: ASbGnctDiMa+/2EKRw6YgSpfbEoDl1Ulu1B8v4d9egTz9PcyBNbqxY80zaqeRt+PnLu
 aVRNsUCAW/mCm9OOrA2JBcoKOyHn8/xKodfkF+24Z7CIFhLPFCScD64P396xZUREGndDBlVou6R
 I2PW26VvlKg4RXAfZ1Y+7hO4v3x539hLOQFe/2UpVfyBN0iRJFOgSu/2l8S8Lc4phvOvLf2nrEP
 /4cToBr2qYbzanADYvTWwZz6NlNIIet79H01I7+iUl2gOe968eyYHND/26BkpijgbeG9NWf03w1
 a2AdSLfSA1XsBlrJLzhQTbGD+eimZWzwu8YGGGns
X-Google-Smtp-Source: AGHT+IECiElg13aCp6iXTwsCVsYwe1s4yuOdgcG0oT4UliCkJPy+e1n7QFUec7uaJun/gU3pWxujNw==
X-Received: by 2002:a05:6a00:114a:b0:736:a540:c9ad with SMTP id
 d2e1a72fcca58-73fd9047c3fmr122457b3a.20.1745537321988; 
 Thu, 24 Apr 2025 16:28:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25accfbesm2044318b3a.177.2025.04.24.16.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 16:28:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH v5 4/8] hw/hyperv/syndbg: common compilation unit
Date: Thu, 24 Apr 2025 16:28:25 -0700
Message-Id: <20250424232829.141163-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

We assume that page size is 4KB only, to dimension buffer size for
receiving message.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/syndbg.c    | 9 ++++++---
 hw/hyperv/meson.build | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index a410b55b9a5..6cb8b6c427a 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -10,11 +10,11 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/loader.h"
-#include "cpu.h"
 #include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
@@ -184,12 +184,15 @@ static bool create_udp_pkt(HvSynDbg *syndbg, void *pkt, uint32_t pkt_len,
     return true;
 }
 
+#define MSG_BUFSZ (4 * KiB)
+
 static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
                                 uint32_t count, bool is_raw, uint32_t options,
                                 uint64_t timeout, uint32_t *retrieved_count)
 {
     uint16_t ret;
-    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
+    g_assert(MSG_BUFSZ >= qemu_target_page_size());
+    uint8_t data_buf[MSG_BUFSZ];
     hwaddr out_len;
     void *out_data;
     ssize_t recv_byte_count;
@@ -202,7 +205,7 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
         recv_byte_count = 0;
     } else {
         recv_byte_count = recv(syndbg->socket, data_buf,
-                               MIN(sizeof(data_buf), count), MSG_WAITALL);
+                               MIN(MSG_BUFSZ, count), MSG_WAITALL);
         if (recv_byte_count == -1) {
             return HV_STATUS_INVALID_PARAMETER;
         }
diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index c855fdcf04c..a9f2045a9af 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,6 +1,6 @@
 specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 specific_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
-specific_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
+system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
 specific_ss.add(when: 'CONFIG_HV_BALLOON', if_true: files('hv-balloon.c', 'hv-balloon-page_range_tree.c', 'hv-balloon-our_range_memslots.c'))
 system_ss.add(when: 'CONFIG_HV_BALLOON', if_false: files('hv-balloon-stub.c'))
-- 
2.39.5


