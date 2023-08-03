Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C0C76DE6B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 04:44:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qROJM-0004L2-K4; Wed, 02 Aug 2023 22:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJD-0004IP-PZ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:28 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qROJC-0007eG-AL
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 22:43:27 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a751d2e6ecso365946b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691030604; x=1691635404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKpdoxEEVb/l2HWGC4KXDy5cd06NGqkqX5eOsehHBMI=;
 b=jTHDhr7wpWqn44c2jGpuSMtU/HfcLIMlPjuOiRrvIIoUihTrzBKWqUDVME4PKEi6kB
 hv9b/VjK9fos3iLx0C1pZlq4penXyLsmPtfRGB1FWPZkqlA9Z6LzIbjWtjfwQS/QzuBp
 3KeXIx+MfCMNPv6KiiqLcf8T1xmsLpUGqeBmhaOuGpGLkG3fB0Mfv80IvttoZPB2/rVY
 nr3Jp8nATihGAcfJK8puPlCuYFfD+eOs+d5G9wzX+o45Wiq2I0DvA9GkRJtlXppLAQCt
 9LjMJleZAEQwprWVwDABo/c14cukXLbzZRvyVk5nAAvqZNfKjnH58BktEHHjcC1L5ZnX
 cf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691030604; x=1691635404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKpdoxEEVb/l2HWGC4KXDy5cd06NGqkqX5eOsehHBMI=;
 b=JEJcfh75xExwaB30nkcnfDLKSGpyxM1UyfUZ9gaw/+laInYY+DL9EhUvFt4UULtXBD
 qTBrhS8E3AWm+HV1xyylqrtNU8acqfWZHFX5eObOKBcIJQOJE3eX/KMnGakSICHrFIoh
 IVWpAdbqMXn4JdevGasm/1IIFOGSRL2T+rPMtXx3AyZbaeA80y+hvQZEabbXpgU1mczx
 vQNSmEMiPSfjN59/dxMmyqbjGM3gf5l8TrzprUW2tVeoKPP3Q/+pUCecBaKNhE5RcT1J
 /0Sj3+EFhd2NZxCcDJUKk6oCHDOKm5XNbwnrACWpD/ZU3sJdHXjdIbHrZHtrWRRCCvN5
 OhWw==
X-Gm-Message-State: ABy/qLbTZvGhWhqzOLQXzxZ0KC6zfbRuBfeZg73PsaYWq61Bt1smddwC
 +UsZjRNwKG+uh5QeUS2/uV2L/w==
X-Google-Smtp-Source: APBJJlHIbpjlN/7zZs/b8ai7Cbq5R0Pre5MZdOucG9aJaelakTaqzaCiCpNo2DotmAj1gmhy+gz0Rg==
X-Received: by 2002:a54:4e94:0:b0:3a7:30cb:c092 with SMTP id
 c20-20020a544e94000000b003a730cbc092mr11386128oiy.48.1691030604540; 
 Wed, 02 Aug 2023 19:43:24 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 j22-20020aa78016000000b006862b2a6b0dsm12090578pfi.15.2023.08.02.19.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 19:43:24 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: mst@redhat.com,
	arei.gonglei@huawei.com
Cc: qemu-devel@nongnu.org, taoym@zju.edu.cn, kangel@zju.edu.cn,
 nop.leixiao@gmail.com, mcascell@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/2] virtio-crypto: verify src&dst buffer length for sym
 request
Date: Thu,  3 Aug 2023 10:43:13 +0800
Message-Id: <20230803024314.29962-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803024314.29962-1-pizhenwei@bytedance.com>
References: <20230803024314.29962-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x235.google.com
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

For symmetric algorithms, the length of ciphertext must be as same
as the plaintext.
The missing verification of the src_len and the dst_len in
virtio_crypto_sym_op_helper() may lead buffer overflow/divulged.

This patch is originally written by Yiming Tao for QEMU-SECURITY,
resend it(a few changes of error message) in qemu-devel.

Fixes: CVE-2023-3180
Fixes: 04b9b37edda("virtio-crypto: add data queue processing handler")
Cc: Gonglei <arei.gonglei@huawei.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: Yiming Tao <taoym@zju.edu.cn>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/virtio/virtio-crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 44faf5a522..13aec771e1 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -634,6 +634,11 @@ virtio_crypto_sym_op_helper(VirtIODevice *vdev,
         return NULL;
     }
 
+    if (unlikely(src_len != dst_len)) {
+        virtio_error(vdev, "sym request src len is different from dst len");
+        return NULL;
+    }
+
     max_len = (uint64_t)iv_len + aad_len + src_len + dst_len + hash_result_len;
     if (unlikely(max_len > vcrypto->conf.max_size)) {
         virtio_error(vdev, "virtio-crypto too big length");
-- 
2.34.1


