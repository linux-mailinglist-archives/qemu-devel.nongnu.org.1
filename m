Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B277973A5A7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMrf-0002Vj-Vn; Thu, 22 Jun 2023 12:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMre-0002VZ-7O
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMrc-0007fk-BR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:08:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-311275efaf8so5835774f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450130; x=1690042130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xHLdIwIywOmneOj5eUp5g6ra2t5DF15QteoMLknkUnc=;
 b=hz1Iri7fzveQD0XzRURoVBQ0AayjUFEKed+ma5hJWh66FT6qnBh9fJ6Yqa49kNHo/F
 3IpOngfIDQP04/ptc2tjcBXuEBGYnyItgUqUv1Xzu4OMyAwehLKCQiYvbdeSNCij8x95
 cWxKOYJL2Kj+I0ElvY9i/iRKv7l1uzjI7KdJo4fnnC4me8XMGc9CZSrylMv1xwbefMDq
 20wIR6Hftn5IW5cBGp88Pv5LYTiLSSfKvPKxbm7q5nblR8TO4SLMy+l/dx7jOAt50qA/
 UPo0hT2rx1nx+tTGE22u6Jz+w2s4b5BrZ3reMQGP04EpIgkSA8Qr9dx1Stp7KU/I3xGF
 CtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450130; x=1690042130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xHLdIwIywOmneOj5eUp5g6ra2t5DF15QteoMLknkUnc=;
 b=Dk7MGTv9pkGlVRqUnt5xY0dLS7sAdVh2Lq7pSLJuF0WH65i4kZSQpmnDTk/7T2GBrx
 USYu16WISZ6f47rh7XD6oD8GnhoB4wrV5peyL/ztI4SGNF8qkX0ecHYm8Yk3GlGgBQeM
 L7c4pXWuPz4i7jww9pD4A54o/J5Iy6xQAHUDBtVeq/ZevJCM4jxmTQptRwRl2TyvcjHn
 GMXdJDmFfEoS+Iy9NNaxRWepzeQRo/2qR7FDepDwSbGyYP4Vq9bFbG6Lxr8GnKKZ6iCR
 oSECcwjYrMork8dN32g+BbVCn2vrc/flMS7JAzNt5wxk1B8oF/zCvJ1ODdQnh710kP9I
 TuWw==
X-Gm-Message-State: AC+VfDwcwn5+dvizEbaOMPc9tlAp9XXo/J/OP5Ovqd3Qno7BCa/8nY4q
 nEei1243LAnuqMlQdbTFTo0mzJHnG06rxHaNFygvAQ==
X-Google-Smtp-Source: ACHHUZ5FZJ07KWuWBYKgfrnuifY1fdOTl2VG8E4TsYr3Kvhd2tgi1EDXYohQtUPqrVHBijnkT2QeEg==
X-Received: by 2002:adf:f952:0:b0:30f:ca58:a00d with SMTP id
 q18-20020adff952000000b0030fca58a00dmr10419263wrr.45.1687450130628; 
 Thu, 22 Jun 2023 09:08:50 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 o8-20020a5d4a88000000b003068f5cca8csm7356928wrq.94.2023.06.22.09.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:08:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 02/16] accel: Document generic accelerator headers
Date: Thu, 22 Jun 2023 18:08:09 +0200
Message-Id: <20230622160823.71851-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These headers are meant to be include by any file to check
the availability of accelerators, thus are not accelerator
specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/sysemu/hax.h  | 2 ++
 include/sysemu/kvm.h  | 2 ++
 include/sysemu/nvmm.h | 2 ++
 include/sysemu/tcg.h  | 2 ++
 include/sysemu/whpx.h | 2 ++
 include/sysemu/xen.h  | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/include/sysemu/hax.h b/include/sysemu/hax.h
index bf8f99a824..80fc716f80 100644
--- a/include/sysemu/hax.h
+++ b/include/sysemu/hax.h
@@ -19,6 +19,8 @@
  *
  */
 
+/* header to be included in non-HAX-specific code */
+
 #ifndef QEMU_HAX_H
 #define QEMU_HAX_H
 
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 88f5ccfbce..7902acdfd9 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -11,6 +11,8 @@
  *
  */
 
+/* header to be included in non-KVM-specific code */
+
 #ifndef QEMU_KVM_H
 #define QEMU_KVM_H
 
diff --git a/include/sysemu/nvmm.h b/include/sysemu/nvmm.h
index 833670fccb..be7bc9a62d 100644
--- a/include/sysemu/nvmm.h
+++ b/include/sysemu/nvmm.h
@@ -7,6 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* header to be included in non-NVMM-specific code */
+
 #ifndef QEMU_NVMM_H
 #define QEMU_NVMM_H
 
diff --git a/include/sysemu/tcg.h b/include/sysemu/tcg.h
index 53352450ff..5e2ca9aab3 100644
--- a/include/sysemu/tcg.h
+++ b/include/sysemu/tcg.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* header to be included in non-TCG-specific code */
+
 #ifndef SYSEMU_TCG_H
 #define SYSEMU_TCG_H
 
diff --git a/include/sysemu/whpx.h b/include/sysemu/whpx.h
index 2889fa2278..781ca5b2b6 100644
--- a/include/sysemu/whpx.h
+++ b/include/sysemu/whpx.h
@@ -10,6 +10,8 @@
  *
  */
 
+/* header to be included in non-WHPX-specific code */
+
 #ifndef QEMU_WHPX_H
 #define QEMU_WHPX_H
 
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 0ca25697e4..bc13ad5692 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -5,6 +5,8 @@
  * See the COPYING file in the top-level directory.
  */
 
+/* header to be included in non-Xen-specific code */
+
 #ifndef SYSEMU_XEN_H
 #define SYSEMU_XEN_H
 
-- 
2.38.1


