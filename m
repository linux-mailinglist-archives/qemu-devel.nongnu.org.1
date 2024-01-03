Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF378229BB
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 09:50:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKwwE-0008U0-G4; Wed, 03 Jan 2024 03:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwD-0008Sw-5W
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwA-0007Qz-6K
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d89446895so1188065e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704271754; x=1704876554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P6AP33R7uLbzcM5ifE2R2q8gbfKrp6LDNdA8+yNBd4c=;
 b=kMhhMtPvCCV0ommLT/Qf/s49z8sG3NRcpeLKfMUqWN073G7JvpmXpxvd9NAr77d4Qp
 K7zXmh27Tla31KFlyKLgZj6Xo9MZMNCbzvcbMyFhBptMhNRsy0M5BFWGT06enac9NOTE
 uLSna1aph7koVf6DrsR7sHvUi7O8k9i59rj1LsquMigIbUw7cMcTeQ3x++m4IEtJ5OYS
 ILYrJTybQ0eDVidQf6RnXSZnfVbSqMurUqqj0Oh94g5jh7HF9ug8kTQCcUhGAjkSA/Kd
 Ws85EqwX6f8/o2xUnBMqgh/sCv4TrXccQwZ1ou7cBKPB0aSiQT7fsYeVmZzL04Nbd+pg
 lsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704271754; x=1704876554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6AP33R7uLbzcM5ifE2R2q8gbfKrp6LDNdA8+yNBd4c=;
 b=cbekn7Y8xayeKv1sFdvys7+LTDeKCskpmeEpQ6O22bL6+qI6WJQfyTvuzxRV0IruHN
 MYzSx567nXap4gZAKGnw4aDfoIrS1CWQoCElGwOafqSicBFn65QJrlPuGCg8uIcu4CHy
 pVrXlX3jxGCY/byoLqZ4vIRylSS9cIUm2in58hk7kXckMVALm8aQf7zBl95blZfESu/c
 UD7oYGFvK2xRhKNTF/QWZaY9O2QlAd/oAGwceb/3l82sLGu1Cd5fVlweDRxZnz/Rgp7v
 o5Otf0t+So7wOTWojDQ8IcmX36UVYWmY2FBPdoqHl1Zjabk+oF07AdrTIBbb4is5QR9E
 /hbw==
X-Gm-Message-State: AOJu0YwM1GpEg4t38MEuA8916mokZc5V9AGG+ivqgJ1IEKMO4dBdL/jI
 t9L9gCK789sboHieUkC6qOh93xh3nw5cBA==
X-Google-Smtp-Source: AGHT+IG1ARzKgqwd3g+nI1PycL4FNqJGvkxmCNMzEq56NmaJUgOpRsMrLxOYicd42BSAOv3pRMdOAw==
X-Received: by 2002:a05:600c:78a:b0:40c:2ace:6e58 with SMTP id
 z10-20020a05600c078a00b0040c2ace6e58mr283920wmo.182.1704271754405; 
 Wed, 03 Jan 2024 00:49:14 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-013-084-064.77.13.pool.telefonica.de. [77.13.84.64])
 by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm30063183wrn.81.2024.01.03.00.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 00:49:13 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] Fix PIC interrupt handling of x86 CPUs if APIC is
 globally disabled
Date: Wed,  3 Jan 2024 09:48:58 +0100
Message-ID: <20240103084900.22856-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
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

This two-patch series is part of my work emulating the VIA Apollo Pro 133T=
=0D
chipset in QEMU [1] and testing it by running real-world BIOSes on it. The =
first=0D
patch fixes an issue regarding PIC interrupt handling, the second one just =
fixes=0D
a typo in a comment.=0D
=0D
During testing, I've found that the boot process gets stuck for some BIOSes=
 that=0D
disable the LAPIC globally (by disabling the enable bit in the base address=
=0D
register). QEMU seems to emulate PIC interrupt handling only if a CPU doesn=
't=0D
have a LAPIC, and always emulates LAPIC interrupt handling if one is presen=
t.=0D
According to the Intel documentation, a CPU should resort to PIC interrupt=
=0D
handling if its LAPIC is globally didabled. This series fixes this corner c=
ase=0D
which makes the boot process succeed. More details can be found in the comm=
it=0D
message.=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
=0D
[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t=0D
=0D
Bernhard Beschow (2):=0D
  hw/i386/x86: Fix PIC interrupt handling if APIC globally disabled=0D
  target/i386/cpu: Fix small typo in comment=0D
=0D
 hw/i386/x86.c     | 10 +++++-----=0D
 target/i386/cpu.c |  2 +-=0D
 2 files changed, 6 insertions(+), 6 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

