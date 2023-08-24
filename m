Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66837786C19
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ek-0007OO-Oe; Thu, 24 Aug 2023 05:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6eA-00047d-0c
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-0004y8-CH
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so60064605e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869322; x=1693474122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sqblpYqc+Ubm/oCI2PE0OOl/KVdBbV9qWryrUIWZBpI=;
 b=ZXP43udIpfxs+WUj6lBFNt9Woq1YFKTDp/gbwXRKdHNcseTJDW7tIVs4X7R6A9xu5p
 SCzvAWhOHbWrwqgic/huqdXQzzTm17myUNSk5Wsjx0L+zJoak1YgnEt1L3hcWatdnN4q
 bqI+rNh4e3B+szKWTHNLayr1zgcceQ+Ek64DpS2nSZ7YySzaZVdzQKDJGZo5i/hXnadr
 taLmx4GgM4oPIBsLfDxlkXsq8YtuRlptSD2JgY3d5UPDSfi2l+sQbRQvTmiH2rimF/Yq
 HbllYN0IBLZHd6W4qjff3CwWqxYoWyXu6lYtcyyGmbp3KBtD0Cv/eu/v5UJlN0k9T/Hr
 9AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869322; x=1693474122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqblpYqc+Ubm/oCI2PE0OOl/KVdBbV9qWryrUIWZBpI=;
 b=X+iwiAZufk7+/2FIHOZTF0Q3bmIx/5KPp1jf/uMush8ty9yg9v39oXG3X5zXEN7ULV
 aXzDUhOTfZUyVI76zdbAbT4UdkPDR4W8fvsXS8mUbxTyRZvVyoAZpe7tDroYZmQ/Kbfg
 gj/avka8M+JNBKHmzH0m5qgbqPnilH42zgpNdFvmgclvBWoi6Gv3OQZGQS+7/GcQ55K5
 XpZxwtL972OcJdVH+KEoJ+ppFvApaILpOSU9S8eOokUHmNhmu39r8Edp+irbZnrOYlzI
 q1mGZwCiyQfaSIyRrxvuny7Qsqcm+czeyDEeQkYUUiyz6WgP4eAJSzXniebVUO+O/dA3
 aAHA==
X-Gm-Message-State: AOJu0Yyw9ps6qdif8CbJtSG2XN47Pz1TozKhpILHuEkKecxp2oYNZuYb
 5Ilbbdgu2zpc4v7kq+8rnPWELIbrgH5RrEB/CjI=
X-Google-Smtp-Source: AGHT+IFoLOIyVpTQumEaw8W4fKtKCVMEbkaa3E7Ht9o1xMq0nGvN/phpTvK6iSGeA5ejbUrorYkIZg==
X-Received: by 2002:a5d:44c2:0:b0:317:7448:6613 with SMTP id
 z2-20020a5d44c2000000b0031774486613mr10316917wrr.55.1692869321870; 
 Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/35] mips: Report an error when KVM_VM_MIPS_VZ is unavailable
Date: Thu, 24 Aug 2023 10:28:10 +0100
Message-Id: <20230824092836.2239644-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

On MIPS, QEMU requires KVM_VM_MIPS_VZ type for KVM. Report an error in
such a case as other architectures do when an error occurred during KVM
type decision.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230727073134.134102-4-akihiko.odaki@daynix.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index e98aad01bd5..e22e24ed974 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1278,6 +1278,7 @@ int kvm_arch_get_default_type(MachineState *machine)
     }
 #endif
 
+    error_report("KVM_VM_MIPS_VZ type is not available");
     return -1;
 }
 
-- 
2.34.1


