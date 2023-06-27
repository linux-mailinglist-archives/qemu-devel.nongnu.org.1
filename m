Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E1A73FB6B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7EM-0001hH-Fa; Tue, 27 Jun 2023 07:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EK-0001gk-M2
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:32 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EH-0004hS-JF
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:32 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso5830034a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866688; x=1690458688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qPtl76CipHVizf8iARQn4UaHNN6Q85+7HKGDlYZi6lk=;
 b=IHXdv9VH6AeXO0m39eVCHQOX+VJnJPytveSYJdymBKX+NaBmcva/dMtq9RXkcD9J1q
 Vjc29PPtva3lGclZMGpXay+GlQhObuQH9NeWFz4wIh3Mh2swBwuI4R5smZmO7jJ8VxHv
 a/rqCsobN6UKbX8EehPtOrH4u/MwhaxKLyJFHAigdJCAMJ1mZxPhnKk9tKCNpyy/Uz4e
 HnNTksYKRATrsN9Yo3vvOLRG4+aoIBlnI7cqslpx52YlAOrZOZ/DuiryRnhmnU14ewnj
 pbLiYbuV2J9O7Lqxhy3+ZEONYwQU65Drt0OupnBvKPKecGXSTDLxbipim3FIw17YCJ3e
 4tZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866688; x=1690458688;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qPtl76CipHVizf8iARQn4UaHNN6Q85+7HKGDlYZi6lk=;
 b=VnNmlEMN/5wQxSZe9hOkW5PcnqvfNfUQcTc587RoGOe7m2kSmCKDleJEes3c1OW1sR
 rS8P6q8QdhOfYxGEcCQkzV/xCa8UpXKezSft4eAxjWkCsN1oRRAt5D166619efs9KijF
 UZZvonILa6+SbVYsfVA+NIdKUY5OKa7xk9eF+w7kLnUu84Grw+dhdL+/BtxV6ACB2VNO
 Pu0YOR26xKK2kw2nvYHVOXFNrHPeq+CsozaXez3FhmgZgjAEy7mPFQ8BJBfZFXNKWMNj
 Jr1+cAIXfew7v/oghYkGqwXkJABHLliE32yRIZDX5w+CZ4OyWy0yDiesYs2z5IKhE2Bv
 V7uQ==
X-Gm-Message-State: AC+VfDxe8bUzRxZWdy529f5DbcVGXRurjpLgNGf4bc6+9qQ80ROzvsNB
 yhaFIcfuTtudInFl/sOTWB6DUnG1ztTqre5cxrg=
X-Google-Smtp-Source: ACHHUZ4bhSYl2ChCkrhZi7oo7PTKNdL5gy6/V5UrWzFh8sqg1GlhRG4M0JvVQV64c45Y6wiDFouwKw==
X-Received: by 2002:a50:ed06:0:b0:51d:902a:63c3 with SMTP id
 j6-20020a50ed06000000b0051d902a63c3mr6298243eds.34.1687866687711; 
 Tue, 27 Jun 2023 04:51:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa7cf98000000b0051bfcd3c4desm3676022edx.19.2023.06.27.04.51.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/6] target/ppc: Few cleanups in kvm_ppc.h
Date: Tue, 27 Jun 2023 13:51:18 +0200
Message-Id: <20230627115124.19632-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

PPC specific changes of a bigger KVM cleanup, remove "kvm_ppc.h"
from user emulation. Mostly trivial IMO.

Philippe Mathieu-Daudé (6):
  target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
  target/ppc: Reorder #ifdef'ry in kvm_ppc.h
  target/ppc: Move CPU QOM definitions to cpu-qom.h
  target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
  target/ppc: Restrict 'kvm_ppc.h' to sysemu in cpu_init.c
  target/ppc: Remove pointless checks of CONFIG_USER_ONLY in 'kvm_ppc.h'

 target/ppc/cpu-qom.h  |  7 +++++
 target/ppc/cpu.h      |  6 ----
 target/ppc/kvm_ppc.h  | 70 ++++++++++++++++++-------------------------
 target/ppc/cpu_init.c |  2 +-
 4 files changed, 37 insertions(+), 48 deletions(-)

-- 
2.38.1


