Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656BA764A5C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTf-0005LC-Ob; Thu, 27 Jul 2023 03:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTc-0005HS-Fy
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:32:00 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTa-0003pa-TW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:32:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso493927b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443117; x=1691047917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KryCFoTvBP3nIdEsg77nTIkWzqmuMWTWodPXHjNoS7w=;
 b=sT7eY9uWJvO3BMx6lFVxseP9F1PeovS6Qw2urWg1NPKLVRcu28M/oqgLlLGgrpFyTY
 1vwQMtWatcerVjfj2BlQVAOCUoNwR3trS/c72W+2MlMSsV0b1SRJ/hNchg3RtkC4MjBI
 LhHpdeolCx+g0bz21dokX19IdvNXpMNexhbpVAzG9xhFpD/dnUGuRD6/BBwVxZmgLBu3
 ftOlzh/5Z0t49+mijXRwEpCB0a4JJkbr+fFG4Q0KsX3EzJG6cdbx4bnfnnj1IcT6kVjr
 g3anDuem2i5j0Wxo1P875QPwoecKOhkEmjx85WmYodu52vj5jhygb3Hp0UzHRHwyaCzs
 /ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443117; x=1691047917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KryCFoTvBP3nIdEsg77nTIkWzqmuMWTWodPXHjNoS7w=;
 b=TZmKcJk/MyXoJb1sGTXd6NHFQYaPIKR9rm08kq8NnE3H62L/mAcsVTZs9EBwawInJ9
 Whafvstz8yN39lZVZpCtJina+ajc/At/9bYvQ33sBPVFzU7CvNxUO3Z4RvR/YXLp1hME
 iJ7m5zYJWeJj5WUEuFAGR213umYWWhSg3ExMRw1Zb6kofUqDrkf7vIftG91kP+qxZQLG
 V82blO8/3RzvNOe6sy5dfEjmcUpWG5uwBKiEDOZ1N8XCs4LFhaM9upjA3c2DcuhnutzO
 51gqJRNaUp/3t+/h72NtRSwZ770flcpkU0zrvwboT1j9eyr4H7riR9JG9bCFdPmXunoy
 bzlQ==
X-Gm-Message-State: ABy/qLbVVVpeNw/dQpk5NiJkmoJUWQ6TCeroX2sxEF0gxtAqdc3NNgLL
 +hxdoDWzNAKKVXaCJpnW+ulM5EhZT0R/b7R/umA=
X-Google-Smtp-Source: APBJJlGoR80KicuYnq4Q3XY7GzEAoTXmN+bZbfxdkyHGuoNwvVoBjOiW9+g73QffU6YklFvoelFu/A==
X-Received: by 2002:a05:6a00:139c:b0:66b:8d48:8e64 with SMTP id
 t28-20020a056a00139c00b0066b8d488e64mr4516779pfg.12.1690443117393; 
 Thu, 27 Jul 2023 00:31:57 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 6/6] accel/kvm: Make kvm_dirty_ring_reaper_init() void
Date: Thu, 27 Jul 2023 16:31:31 +0900
Message-ID: <20230727073134.134102-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The returned value was always zero and had no meaning.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/kvm/kvm-all.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 4591669d78..a4a1b4e05d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1454,15 +1454,13 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     return NULL;
 }
 
-static int kvm_dirty_ring_reaper_init(KVMState *s)
+static void kvm_dirty_ring_reaper_init(KVMState *s)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
-
-    return 0;
 }
 
 static int kvm_dirty_ring_init(KVMState *s)
@@ -2744,10 +2742,7 @@ static int kvm_init(MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        ret = kvm_dirty_ring_reaper_init(s);
-        if (ret) {
-            goto err;
-        }
+        kvm_dirty_ring_reaper_init(s);
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
-- 
2.41.0


