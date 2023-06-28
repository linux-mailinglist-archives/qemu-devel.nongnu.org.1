Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E818874190F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:53:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEbDC-0004g7-MG; Wed, 28 Jun 2023 15:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD7-0004fR-EC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:17 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qEbD5-0005hO-PW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:52:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-991ef0b464cso249567966b.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687981934; x=1690573934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qTEjiJO+rGciaKNYAv4AjJGsmsXEooYuDKonzHCbf4=;
 b=Mfd7atY84/FKHIik5Kqo2ACsvtK0RKxdnXsNRrsB9DeTjJVO5tihP/NRBuIE3l0wgh
 oAz/rY4Od56mGDqNl9WMBn6vpBH51RMA77NUvuY1gD0RQVnxLHMCC2Y/224eHFAF/rmB
 JfYMt3kvNrQ5i0BYCAoBlJ0ZryZd1nOpZl/75fMJxSJ1r41hvNIhfWxluyJrcKhWDOqE
 FzbOALyd+4Bbp9pBLqo58qXBSDeIxwCsiM4aaL97phWFXYLZmtV3peS9MJDzolfr9mZS
 YVKabfUE2+zE9KQJA2fO4mSLsu0sCTAjwoPKmLMp5WDFUmK1YEDnLPj0+FEm5XxKAFhW
 eU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687981934; x=1690573934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qTEjiJO+rGciaKNYAv4AjJGsmsXEooYuDKonzHCbf4=;
 b=Rsn0yZHHJ2rfGOh/k6VaKLKKtDMtAJzHyyYulZRew2CxXGvGFncKBwlYOujmgGPjyQ
 SkgskFfMaMBJ9Or+4cKW4taUoRYLZhHh0r0PPq5778vikCuXpO2na0i9itYNel2F+i66
 B1kOiXxJPWEYJVWSnSLVH00AX5P1GyrW0/hNXL/KAakm4z/R7ISrd+2GgvFIBomoFR8M
 9wUFU+4Ngy5VZDy2rgkiWnDeD8XiKm1AfbbnOz+HXvAmEGclr3618qvd1OdzbuEjBd5U
 LBKx3YtIXtQsvguIjuC7Jg9i0tNhg1DvgVOWzMI+zJHgnMT8tOoFYc9lHvnlqdzdj+eM
 9pZA==
X-Gm-Message-State: AC+VfDyjioMaMU6HR27p8rCkA8kkab0R7bYe8mcYHvzaurew/JaJsA68
 RmCJ/Kwe3lw7236yqoLCXvuYSfVSxVk=
X-Google-Smtp-Source: ACHHUZ5D6yWNiDlqPjgKzfzAwGMTFNfPgBNW8slafVrho58xzOKeLDFxkrC/Dhh9mL1fG8MeCP5nlg==
X-Received: by 2002:a17:907:2d27:b0:98f:c9b:24ef with SMTP id
 gs39-20020a1709072d2700b0098f0c9b24efmr2329241ejc.20.1687981933804; 
 Wed, 28 Jun 2023 12:52:13 -0700 (PDT)
Received: from archlinux.. (dynamic-077-191-074-208.77.191.pool.telefonica.de.
 [77.191.74.208]) by smtp.gmail.com with ESMTPSA id
 ec10-20020a170906b6ca00b00982be08a9besm6142817ejb.172.2023.06.28.12.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 12:52:13 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 02/16] hw/pci-host/q35: Fix double,
 contradicting .endianness assignment
Date: Wed, 28 Jun 2023 21:51:50 +0200
Message-ID: <20230628195204.1241-3-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628195204.1241-1-shentey@gmail.com>
References: <20230628195204.1241-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fixes the following clangd warning (-Winitializer-overrides):

  q35.c:297:19: Initializer overrides prior initialization of this subobject
  q35.c:292:19: previous initialization is here

Settle on little endian which is consistent with using pci_host_conf_le_ops.

Fixes: bafc90bdc594 ("q35: implement TSEG")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/q35.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index fd18920e7f..84137b9ad9 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -285,7 +285,6 @@ static void blackhole_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps blackhole_ops = {
     .read = blackhole_read,
     .write = blackhole_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
-- 
2.41.0


