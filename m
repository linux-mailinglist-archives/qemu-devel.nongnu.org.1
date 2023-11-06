Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C327E1F9B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:09:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxTG-0006Xg-QC; Mon, 06 Nov 2023 06:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxT9-0006W0-MQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxT2-0005Ab-S8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32fbf271346so1513617f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268906; x=1699873706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bC2TdykjktUVtXbtq0twsr6zjowOcVE1/YbXmtopUl4=;
 b=mHPVzGz0la7J3gPwaYN9JcS8YoNnrPxizKfKyAiyR8FBBwPBFkAK0LqLpL9vxM3x26
 skSRMcQv+VlS0LvrGI39tAE7O5SJtdp4myb9vGlTPR0AVpRt7FMUh5yrJFQb9qXccclB
 x4cfpaNZZuxegEseqrpLTMnHSyLdj3qhPWYVcbaLLNNsBYOE/KEm1VqC8qbTVg2CODwV
 4Blut9SNADfSFuiggogXH51r3oJzbq8jUnvVictKW2SbpaymwU79Yt5z3V0bc5uSGqG9
 l5HHDyi/ooSVGROYavcrVnHtpgI27YwG6TUcJiW+PIMpOedLp9/P6XVpiX5SWC489O5z
 xtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268906; x=1699873706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bC2TdykjktUVtXbtq0twsr6zjowOcVE1/YbXmtopUl4=;
 b=Y0F4lxbvF1SE1w8Z63TC/zyn5yQu9mPm98dWTVj6IVjvqUuZZi0DZJE2uqNh0fbXjw
 HaZQ6+jnaWHT2oxdOAxgNg7qccel6zTpqw5rj5Bx+vcIW0mOyon1oTWku4IgYtaW/69u
 mqXaCmrtfKWuBrcunP8DPgVDI6Xyb37P7hV4AbbqrJhIgw7q+KytdtcpRS2h5Si0iUIR
 9bdMg/Jy3B2w1PcVF4vP3QvFglfgig2/2nUp8z7HK+Jc9iJ/il/lLFB2CLInhnDNewr7
 TbIbyhQ/p53brYYbNsqbdF2ACV+6SznqI25cIdlLi6gKcNr4Cax2cGgrk9LrKbqCtf6o
 MHzQ==
X-Gm-Message-State: AOJu0YyuIgbxb2bA4r1cmVdfxwj0IIrCxj13/o472+46lq3/FEfC66d3
 KgRZd/o4W/RQw/2P0/q3p+axTMwzAs77segiATs=
X-Google-Smtp-Source: AGHT+IHcL9WmfBoUy68GkAigOFElgUltPcHFMGDZ3RNZRT8AFGVHPWLoneY5rupalCL7WjqSCGEKUA==
X-Received: by 2002:a5d:62cd:0:b0:32c:c35c:2eea with SMTP id
 o13-20020a5d62cd000000b0032cc35c2eeamr17839736wrv.6.1699268906698; 
 Mon, 06 Nov 2023 03:08:26 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a056000180100b0031980783d78sm9136370wrh.54.2023.11.06.03.08.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:08:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PULL 42/60] hw/isa/i82378: Propagate error if PC_SPEAKER device
 creation failed
Date: Mon,  6 Nov 2023 12:03:14 +0100
Message-ID: <20231106110336.358-43-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
we neglected to give a change to the caller to handle failed
device creation cleanly. Respect the caller API contract and
propagate the error if creating the PC_SPEAKER device ever
failed. This avoid yet another bad API use to be taken as
example and copy / pasted all over the code base.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231020171509.87839-5-philmd@linaro.org>
---
 hw/isa/i82378.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 79ffbb52a0..203b92c264 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -105,7 +105,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     /* speaker */
     pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
-    isa_realize_and_unref(pcspk, isabus, &error_fatal);
+    if (!isa_realize_and_unref(pcspk, isabus, errp)) {
+        return;
+    }
 
     /* 2 82C37 (dma) */
     isa_create_simple(isabus, "i82374");
-- 
2.41.0


