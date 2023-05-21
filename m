Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC6C70AE0F
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 14:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0iDP-0001vi-NY; Sun, 21 May 2023 08:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDF-0001vM-TL; Sun, 21 May 2023 08:31:01 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0iDE-0001k8-EQ; Sun, 21 May 2023 08:31:01 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96fa4a6a79bso153482666b.3; 
 Sun, 21 May 2023 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684672257; x=1687264257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BZLXAZ0ETagSKu1U9dc04gylc7GNMLpCPSdXgwBueE0=;
 b=n89cFf5KcItLN6Vu654Uokdk/WhpNpjFjj15982vxuiLDdkEsHT1SDGnXgE3yRgMZC
 TpBpz7SRwFAZvCO/V17nmMcPcGnfr6C1KcsW7S/gfXUxm3ge8seXCXcr93o0n3GcGyex
 ldstHtuOuAhMOfR8ZbBrB9NwPfl60YeBcsgbiLxC64AkxPxDiXzWbYAQBtVUfLfD3gvH
 SRxP8flhSvyv4c3DBWRB7UJYkC5mrYxPxpE5MEjFd2KINCjiUkHvYcqUh4Aeyy8oL4uU
 4+0UFf1NJqaag7iXbGTfd+9ZtMJiTZY2RGJTqlBJXve+TX23jCGJepj5HcAvQa6w49uD
 JRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684672257; x=1687264257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZLXAZ0ETagSKu1U9dc04gylc7GNMLpCPSdXgwBueE0=;
 b=Ygc61de0sgsvbRw5YKhG1N5P4zTYs8ei8GRZZBRpqcGF60EMqS9SdyEKJLvNNQfLSA
 4V6WH8VWmEdGtYpK0qjs++bZueHh2XWU9SlVaYbXgGtqfQmitMKX4ZdXQoSk0Kd9Yq2M
 0bkUoqGT2L5GIMr1ApRBpmkkOvXaqDJrD5lhY19f0r/ZJoOYNMDT1EJnL5L3xzDYes2M
 cU0JbnWJBfzU5SrmAU447tyAvZMGXlHuAt6bbXUOO5KyQP8g4TFeKhlnFK8K1DENMC8Z
 RhDujnax//USjONqqtr4tiF7hsqUFSRl8menphyGtkU8hZ5HThRwbbOMUtjdwv4DuEUs
 98XA==
X-Gm-Message-State: AC+VfDx+V5ToAyZ3mrjQihAUJNo6vk66QqzOt7PF7tAscmo+sdXRjjPj
 sZL0lV3QBCsROF4Rqq6Tsn6FI6F0oQ8=
X-Google-Smtp-Source: ACHHUZ61CXtJ2oNIhgXMj0yFxL8DoNFYRkbiyWygpceqEHDwme7qYVGSzddCvl/L4+0Ny1ThzrrSXg==
X-Received: by 2002:a17:907:3d94:b0:96f:d67b:80af with SMTP id
 he20-20020a1709073d9400b0096fd67b80afmr853010ejc.75.1684672257234; 
 Sun, 21 May 2023 05:30:57 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906729300b00965ec1faf27sm1882678ejl.74.2023.05.21.05.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 05:30:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 0/6] Trivial cleanups
Date: Sun, 21 May 2023 14:30:43 +0200
Message-Id: <20230521123049.312349-1-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

This series:=0D
* Removes dead code from omap_uart and i82378=0D
* Resolves redundant code in the i8254 timer devices=0D
* Exports ParallelState and ISAParallelState in order to replac string lite=
rals=0D
  by TYPE_ISA_PARALLEL macro usage=0D
=0D
v2:=0D
* Export ParallelState and ISAParallelState (Mark)=0D
=0D
Testing done:=0D
* `make check`=0D
=0D
Bernhard Beschow (6):=0D
  hw/timer/i8254_common: Share "iobase" property via base class=0D
  hw/arm/omap: Remove unused omap_uart_attach()=0D
  hw/isa/i82378: Remove unused "io" attribute=0D
  hw/char/parallel: Export ParallelState=0D
  hw/char/parallel-isa: Export ISAParallelState=0D
  hw/char/parallel: Replace string literals by TYPE_ISA_PARALLEL macro=0D
=0D
 include/hw/arm/omap.h          |  1 -=0D
 include/hw/char/parallel-isa.h | 46 ++++++++++++++++++++++++++++=0D
 include/hw/char/parallel.h     | 44 +++++++++++++++++++++++++++=0D
 hw/char/omap_uart.c            |  9 ------=0D
 hw/char/parallel-isa.c         |  3 +-=0D
 hw/char/parallel.c             | 55 +---------------------------------=0D
 hw/i386/kvm/i8254.c            |  1 -=0D
 hw/isa/i82378.c                |  1 -=0D
 hw/isa/isa-superio.c           |  3 +-=0D
 hw/timer/i8254.c               |  6 ----=0D
 hw/timer/i8254_common.c        |  6 ++++=0D
 11 files changed, 101 insertions(+), 74 deletions(-)=0D
 create mode 100644 include/hw/char/parallel-isa.h=0D
=0D
-- =0D
2.40.1=0D
=0D

