Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F038F7415E2
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXX2-0003NP-Ll; Wed, 28 Jun 2023 11:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWj-0002ux-FF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:18 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXWg-0001uY-AC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:56:15 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so5485064f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967771; x=1690559771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LcTeii/p5RpE6oLxIZo5TfJdBeq6mI7i0HEKUop/mU=;
 b=ZIk1AK7uhstYx9XqBFtfOfH/Lx7QsEbM+LaWVq2aqEtkUmFdq/7zjwfS3AcQgF3bbs
 76EFNcVNwHC9xXPaN2auMScy7B3+xAi2Nnuc6IjBLwvAa4bMeQZph+v91zFD3kZuh3rK
 OROAfYUNNp/8GyjPHJSZV6a5UgLKMfXpvIOpcrVeQOXYzHzoPXuotZhDTiv/8IHRZq92
 C0+OrK3nyb0XLAuFpgHvETW5VoXiNy33d5nm4cdnJ4++Zrgf1H/88lQV7AaMz6pZo33P
 ITUNfd/RFioHbrhIPypHudvH+dq91OFicdd1Op0tXNg+83y2HUo/eX3ml2X63Xvkmwo/
 ttfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967771; x=1690559771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LcTeii/p5RpE6oLxIZo5TfJdBeq6mI7i0HEKUop/mU=;
 b=XRfYyvJPxK7Dox+PW7KXtCzhwjOartUm/aJ3oeYLZLvVk+XmewLUojfwxB9whDKHfd
 HLmct9Jlvg5wJvrKKPNNfCH6Pj+4/anNI6g1XFYpYjE6xUrURAqD0Sih3LFsXrihsD4K
 R+r+tE1TTdQKvaJArJPv5PsTdbZn6w0OPGRB4yik7oUCMhLgF310Pw3CmqkcvExeu2qU
 RY3VFCGammkLJHdXCEYyq094/enjFzsrPfbypbCq1vbkXhXVpZFkuWuaqZ8vWXq1GVsd
 abfU0S28ZULeEOdYiIhjjH60ckyIh01svUrpvy8+fpSK8RP61GRrBeiOdS+YZ6RXYN43
 igeg==
X-Gm-Message-State: AC+VfDxXfmKf4Yqx2pMZnjNL+tsH1RBqbFLFelKgJWjrETSV6YeFOaDZ
 Atq0l95uHTpYtVB0FYoMJLBbA8iBYvsng/R4dMA=
X-Google-Smtp-Source: ACHHUZ4f8A0KZczKWiV5Tg+qs0mAfBCCALRJY+IHY4oueM+n/NRnMx0d9lj2m89nE7rAaBlbIhEbKw==
X-Received: by 2002:adf:d4cf:0:b0:314:824:3777 with SMTP id
 w15-20020adfd4cf000000b0031408243777mr2317365wrk.48.1687967771208; 
 Wed, 28 Jun 2023 08:56:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 bf11-20020a0560001ccb00b003062b2c5255sm13624852wrb.40.2023.06.28.08.56.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/30] exec/memory: Add symbol for the min value of memory
 listener priority
Date: Wed, 28 Jun 2023 17:53:13 +0200
Message-Id: <20230628155313.71594-31-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add MEMORY_LISTNER_PRIORITY_MIN for the symbolic value for the min value of
the memory listener instead of the hard-coded magic value 0.  Add explicit
initialization.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <29f88477fe82eb774bcfcae7f65ea21995f865f2.1687279702.git.isaku.yamahata@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/memory.h | 1 +
 accel/kvm/kvm-all.c   | 1 +
 target/arm/kvm.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4d789461a2..7f5c11a0cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -811,6 +811,7 @@ struct IOMMUMemoryRegion {
 #define IOMMU_NOTIFIER_FOREACH(n, mr) \
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
+#define MEMORY_LISTENER_PRIORITY_MIN            0
 #define MEMORY_LISTENER_PRIORITY_ACCEL          10
 #define MEMORY_LISTENER_PRIORITY_DEV_BACKEND    10
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9d0837a39c..373d876c05 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1105,6 +1105,7 @@ static MemoryListener kvm_coalesced_pio_listener = {
     .name = "kvm-coalesced-pio",
     .coalesced_io_add = kvm_coalesce_pio_add,
     .coalesced_io_del = kvm_coalesce_pio_del,
+    .priority = MEMORY_LISTENER_PRIORITY_MIN,
 };
 
 int kvm_check_extension(KVMState *s, unsigned int extension)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 84da49332c..b4c7654f49 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -341,6 +341,7 @@ static MemoryListener devlistener = {
     .name = "kvm-arm",
     .region_add = kvm_arm_devlistener_add,
     .region_del = kvm_arm_devlistener_del,
+    .priority = MEMORY_LISTENER_PRIORITY_MIN,
 };
 
 static void kvm_arm_set_device_addr(KVMDevice *kd)
-- 
2.38.1


