Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C657D14AF
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt6W-0001Lu-SH; Fri, 20 Oct 2023 13:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt6A-0001Bp-7e
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:47 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt68-0004Z0-Fa
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:45 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-507b96095abso1494687e87.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697822135; x=1698426935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxDbAKxZshnw2aCKoDntFb9lK0/E0E536iU7q/e3O4Q=;
 b=VmlTd0mb7FXAg4+pnW9Ea5Vb5D1pTmy7FOuIk68qWYKpAcJjflZmOLdhRV2AtTp7Uo
 mKTT4PtcFKlFjdVFpWZur0nsvKO+oeIq2n5TpE2NcNkz4n+ZktEZsD4RzMSifFMfh96a
 PxC9sN2ThmWvBHAwlUq5T28kWV5D12dk2wXzC0h9uQjfUQokgPBKRZHMXiAX+sVn81uo
 jjnuiIywKHwimRXAcYHf28AnCIouhPLIspS8eTA9YNaN1TMkz66AqxghyUTBL8yi94mt
 lVhwYvFN53jwTOOa8Y4UKQ/vYyfH85bNTaYFqqfWYlyqgYx2lh0O9tvCWV569ur4AexR
 y0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822135; x=1698426935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxDbAKxZshnw2aCKoDntFb9lK0/E0E536iU7q/e3O4Q=;
 b=ldsMMsxetCLCHC7zIq+E1JgWLQluL/oF//3t5ATzkGj+9SsTuWUyDnBjKV+DcRTpdj
 dzoVKxCuRvhQHjl17WACLxBnLpY4J9gw9OAMVKaboRLxVhXVUoHFogr+TfTAo2IFH25c
 ZLrB5N7ZbHVF43PvGQghdLHpSogfxrcEwZabJvdj65qX83zBnpDOMlCw8ivYs1sd744x
 fHBXJp/OxEtUL2Jat7oRCfy0tblAc+FwRHfKszzt+WpOo6hEYWacqB4UB7wLWY8RJpFT
 QKylo9Xe+eexcpvFA3APC1fqiKtDov727Qykg3jV6EnQbdYLa+bKVLuNIw92FJ8eJczf
 noWA==
X-Gm-Message-State: AOJu0YyKwwOLuYMdSHk/z4Xufs4mX/Qm68fTjGzRLD47VS8maYA4j64m
 V6M5BNVIeOi5z7BVj0eQuSf4B1d1+0bj2Ivk3vc=
X-Google-Smtp-Source: AGHT+IF6Lyskk73QOq7MCWLpCya3dnsD9PobmVXrhjRBIU9XIqJf9eFDCkk94l4Gz9KyDhykLY7c+g==
X-Received: by 2002:a19:5051:0:b0:507:b084:d6bb with SMTP id
 z17-20020a195051000000b00507b084d6bbmr1717277lfj.43.1697822135285; 
 Fri, 20 Oct 2023 10:15:35 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 p7-20020a5d4587000000b0032db430fb9bsm2072239wrq.68.2023.10.20.10.15.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:15:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 4/4] hw/isa/i82378: Propagate error if PC_SPEAKER device
 creation failed
Date: Fri, 20 Oct 2023 19:15:08 +0200
Message-ID: <20231020171509.87839-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020171509.87839-1-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
we neglected to give a change to the caller to handle failed
device creation cleanly. Respect the caller API contract and
propagate the error if creating the PC_SPEAKER device ever
failed. This avoid yet another bad API use to be taken as
example and copy / pasted all over the code base.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


