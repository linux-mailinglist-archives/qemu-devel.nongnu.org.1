Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84C7415B9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUF-0005zZ-Ia; Wed, 28 Jun 2023 11:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUE-0005zP-BY
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUC-00082W-OZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:53:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9924ac01f98so197778266b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967619; x=1690559619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVELctKtUEVaXyK6xIWsbACkPKsq/tuQuxDDoPFElPw=;
 b=bE0aJqTp293+SFt0vwOMN/GB2lr3sPLl0HBolYkiIOOJwLwzzskr7cq8oRB/oXqpyJ
 4f/VFuB2o1XJyVy211r5QhO0kMwGIxrPDHLhbeL/b6H2sF316qhX0NDXYhozLwjxJb7o
 YSd8HvmjUu+8TjiRvWicJvd9Rm2vDqLoZ5GgZG9S6OKyU/zMBct42WTts64UfnP254jr
 EOp4AXDGufdPkYCJNOzxtQLJ+zrftgmfSerjgRGWEOuAeCufvZHIjj7ia1j3gZdltLnb
 NiNRGJO8Sdt71NqnkPwLdMkFVFCMzTGzcuOzJAE1RGoTxRPfLW/IuV7J6Mm3zl7kR8YF
 1zmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967619; x=1690559619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVELctKtUEVaXyK6xIWsbACkPKsq/tuQuxDDoPFElPw=;
 b=IlIodKySsDH/TFAyae3T7rUxrAyTWb5VlN7uRJZxprb2EXaJoO/8fZuUhDR3fmcIUV
 3veNG3WgztjQG5MmhkaGbAv10JAZjRG8UtZ/2vp8YZHE2KrnpaaA9VjIwIRmyYloaka+
 0czJj20/UIPeXQGyWvMWJTbgVnIS9Hb/wSChgpRUI4nGOcc67+saTF/NLwTYFMBgaGtk
 ar8aJCueTrJDElhHljRJFL0Y4laCryX38pGf09Uv3QbX+m2ici0/i/mq1ShpMiLxLFDp
 R2PU1tbzDQIrLEClK09BIG1dthv7K/G5mPL0gTF2AjdyKyCAXNtW3WSvZwZGkzC3l/Cd
 nipw==
X-Gm-Message-State: AC+VfDwJH6D9GTwxxvGMia7OQqpqXW4qsgk2/XR/e6lOlqWdOD00h48A
 R4TXEsQ6RQBOL3mK0pPmsgYUAj1wdRSmyLrHAwI=
X-Google-Smtp-Source: ACHHUZ7vmXuaOR/l2Kg10V9T58LCZHer6AuQJKIJAYEVrG+Oa/750LhAQUq7i1FMFbk3gyQ9dtDCiw==
X-Received: by 2002:a17:907:2ce8:b0:991:da66:e412 with SMTP id
 hz8-20020a1709072ce800b00991da66e412mr6042009ejc.46.1687967619026; 
 Wed, 28 Jun 2023 08:53:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a1709065a9000b0098d93142ce1sm5789812ejq.109.2023.06.28.08.53.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:53:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/30] accel: Document generic accelerator headers
Date: Wed, 28 Jun 2023 17:52:47 +0200
Message-Id: <20230628155313.71594-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

These headers are meant to be include by any file to check
the availability of accelerators, thus are not accelerator
specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-3-philmd@linaro.org>
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


