Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C576490F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTb-0005GB-V6; Thu, 27 Jul 2023 03:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTX-0005DZ-Pi
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:55 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTV-0003eO-76
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666e916b880so437237b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443111; x=1691047911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26LP4jR8UCRhJyh1M0qdx1yDCFp8JOR+j4jZMhaZd5Y=;
 b=FMXUAO4Yoxbd/c3ZDAJO2Eft2gOvbLIXf4hOBH5Dj9DW3gt3d58iYHeQbhg3l1Hpmg
 I19AscWEwJNXso/G1WZ6tivdoRArUDtLLbJ6rH6XmR1/n+H4xd7fhr11URWhGi2HuOoM
 YRIhUGNyDTY6U/j1ShMhaPgpHYqhrjN5joKZ+zuJf4vgAeLVFubAD1fgso1+zLlpEBIl
 aQP0NIhtn5cgY5kVQCeKUcrAVL5klU7kvwre68iLoq9uUIhKDR+roXkSeTWsG2Nj05w3
 m2v2Gg9ffatEkLhmzvEW8yEulbHU6UGF2Novf97q8cExbXPUMqDh0NstuyISfzWG1n6w
 OJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443111; x=1691047911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26LP4jR8UCRhJyh1M0qdx1yDCFp8JOR+j4jZMhaZd5Y=;
 b=Q453W6qpZ7zpLXxDZzqumJT2ZpCpgBiCxTfEQ38b5owywB073bB5uJFQG7GedKN+Ll
 Td/vJiOsAoRgdveNjwYIFyPLAl184iVezxn7Dm5dEYOQIZnZYc4V2Sepxxlvoe9i4c8v
 usUjzp6P5Isyz2SXKZXZSdvmYE77DVMGnS5pLQvBds8bnN7XnEB1ItzlBkKEv/3YzjxV
 YJ2K3ACcZoIDQUdJwMORx6ITxFx8vcMf0WVBok8w8FQCrxP6sFpiPiexDIrr2CgNSvUz
 +DKlTBhFsDrbnkj25gPxyj6AB6Dwkw6CbNFKPKcy9E3312j+uk5bN6QoFcP0vxth21Ic
 5OZg==
X-Gm-Message-State: ABy/qLZbd6QUPdlnc5axKs91pS4MS/NwOO6SslwwDzoTrGTQa2+d04MK
 h6Ow+zrfzILplGzpyjwdNt+jsaDXWjKyhoepELs=
X-Google-Smtp-Source: APBJJlF9vyB/rMKDG8kcKzWzhp8EQUmef9v7mW4IywNdEUOM/7FJYAMVAQcRxxvO32/savSwOQjPaA==
X-Received: by 2002:a05:6a20:1610:b0:137:53d1:3e2 with SMTP id
 l16-20020a056a20161000b0013753d103e2mr4116444pzj.41.1690443111088; 
 Thu, 27 Jul 2023 00:31:51 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 3/6] mips: Report an error when KVM_VM_MIPS_VZ is
 unavailable
Date: Thu, 27 Jul 2023 16:31:28 +0900
Message-ID: <20230727073134.134102-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

On MIPS, QEMU requires KVM_VM_MIPS_VZ type for KVM. Report an error in
such a case as other architectures do when an error occurred during KVM
type decision.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 target/mips/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index e98aad01bd..e22e24ed97 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1278,6 +1278,7 @@ int kvm_arch_get_default_type(MachineState *machine)
     }
 #endif
 
+    error_report("KVM_VM_MIPS_VZ type is not available");
     return -1;
 }
 
-- 
2.41.0


