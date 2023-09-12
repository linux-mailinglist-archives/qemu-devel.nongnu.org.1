Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D158C79CFEC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1bV-00041z-3N; Tue, 12 Sep 2023 07:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bH-0003sY-27
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:38 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bE-0000pv-HK
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:30:34 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so700754866b.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518230; x=1695123030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F/EKm1PmSvEC7rs4ZxmxgrW2WM6+iO3cGl9uzitMTBI=;
 b=WYfxOMQoELoTcDCscN+4NXjIRPNTqVBlHYwmRJQgdWLfOhvZA7b4Ze94Vn3LpTXq26
 lTVIDwzx6klpx2TcSU81ZLiwNzGKvUcv2e36Kt+oXVaHuHmhHJOrfte+EQ2OlVfgZUwU
 +MuGRVat3fpT+tm+rUOeFMOglOqsPtKfeUGFAmGqoCkCwQuuSLeJpBt7OL7Fc7LuTUJN
 htSMO4cOBEZI6OztQ95dZTqOvMT3Yd57FPRzpIEkkzHeMH1aknYlEfHv3sFs8n2i5Hey
 NPYiKbzIP+LXp2lbvB1/QtPd1StFPHHAWPNU39BVvZvfSOiylmfERnu8mwPh+hbIyy88
 wpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518230; x=1695123030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F/EKm1PmSvEC7rs4ZxmxgrW2WM6+iO3cGl9uzitMTBI=;
 b=NKxwSEf30Hihao2YWbYUXmKZkchKGcubdjue3hlKRfQxf5Znq/WvqG+KGr+SQg+Zp3
 w9B7fLUf7FsyDQDiADQsrcjJS0WDnyA3Di3HxyIothrMod+xzWQkjNFjOoDGQODeSiop
 s06irmYoK26iaaUMRxMhTBpIwMQLfqzBhKS+x5T9H3Q5GPAGhjOZ8OU1FidI098cfVFd
 8QLZhbywa/I1NAFhb03Ca1FJLrn7ow0ONrdMXQV/JxBhnoMdPoP4lovCVi7LRA4ADnIK
 HpU2HvK2ySBQ85u6A5uw510/NH5jnVSd0mYSvN4LQGP5oAjD5uXnx5EK9Cc4o6KQqhkV
 RyVg==
X-Gm-Message-State: AOJu0YzmYg9KL3jQLieU/ZltPUM5zBNtfeQOujOFfu+OTbNBVMMjXlYt
 qovJEhJUlVpZPvtuZ6KfS3XauvOp1/1o1m+baqM=
X-Google-Smtp-Source: AGHT+IG8ZGVAtPAxgR7LQWZ2H5QWK9SxUmAMBPgezLz6rY0uT5RF0bLMGBo73IIHaakvdDTgoxb9xw==
X-Received: by 2002:a17:906:53c4:b0:9a5:c9a8:1816 with SMTP id
 p4-20020a17090653c400b009a5c9a81816mr10949917ejo.58.1694518230392; 
 Tue, 12 Sep 2023 04:30:30 -0700 (PDT)
Received: from m1x-phil.lan (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 kj27-20020a170907765b00b0099b5a71b0bfsm6787085ejc.94.2023.09.12.04.30.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Sep 2023 04:30:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] target/ppc: Prohibit target specific KVM prototypes on
 user emulation
Date: Tue, 12 Sep 2023 13:30:22 +0200
Message-ID: <20230912113027.63941-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Implement Kevin's suggestion to remove KVM declarations
for user emulation builds, so if KVM prototype are used
we directly get a compile failure.

Philippe Mathieu-Daudé (4):
  sysemu/kvm: Restrict kvmppc_get_radix_page_info() to ppc targets
  target/ppc: Restrict KVM objects to system emulation
  hw/ppc/e500: Restrict ppce500_init_mpic_kvm() to KVM
  target/ppc: Prohibit target specific KVM prototypes on user emulation

 include/sysemu/kvm.h   |  1 -
 target/ppc/kvm_ppc.h   |  6 ++++++
 hw/ppc/e500.c          |  4 ++++
 target/ppc/kvm-stub.c  | 19 -------------------
 target/ppc/kvm.c       |  4 ++--
 target/ppc/meson.build |  2 +-
 6 files changed, 13 insertions(+), 23 deletions(-)
 delete mode 100644 target/ppc/kvm-stub.c

-- 
2.41.0


