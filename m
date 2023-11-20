Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58F7F16D8
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55td-0006GL-Kt; Mon, 20 Nov 2023 10:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tS-0005tx-Nd
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:09:00 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tC-0001F1-Vb
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:57 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c5039d4e88so58777251fa.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492921; x=1701097721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xunI738Fqo6s2FpWviDGopn4HPhskLpvM21aNsZbJoM=;
 b=VwpMFHeAvkKBE+nuZ57WbabJpa9xnAOHjYOIFHzsMLdO2QVO859pHUoBhE6fmSMcvN
 a120Cn2VONxmZLyOXNWCg4SrlVhaUh+RlZhDRA1n3havHd488c5lSKW+AZO+XYs0gfkj
 IsWGFWbdwEKrM1mFh1Lx1p3P046r3PQ1YgWzMiVWJLr642WKGwENkuBjtKegxO3Bu+pW
 Sl95/IZSEzovrxi6t6kZexPwTrDb43JYv3qxIXv4zYi4nIz58gd9LTCwlucbZHWMikXA
 IIIFGbXkg7VYgnaewP3iwSVYk+ICtuT1vZJzB3BxnMnjETENQ4QdDfhWsAZ5p10apc9q
 2V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492921; x=1701097721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xunI738Fqo6s2FpWviDGopn4HPhskLpvM21aNsZbJoM=;
 b=ghOXDDi5M8Sh6FfNaYW3tj7SPK/iTDrnSnHtZfr5LTCI4By2JZT5qORMRYgvVFxniL
 p5leD4aciXzi3TRNPuReiwO3rosJD1bEvmU7/QgApXysA82N4o26UDvJs9frb5kAAfmY
 Ml4jLx1Xrb0FOJy9u3CAyX0Sjtk4NU/wRp04V5QkcRCdyM+oKZjENRXoA5gdmSlq5YwJ
 uL4caYtcd7wTfbxqNX437aYYw7Nq9YLc0IjpR2WjrT8ynmkYjDIxnfmliGP1gQpnLlCe
 3qm+bim5zg9OtswUYWXLQ6vYVyLBojEcmfRPCDmcOwiVi6KoGN2+zilk5cL/W8VrOy/M
 aXGA==
X-Gm-Message-State: AOJu0YwVGd96x8CBcbryvGXuJqjuoPib2omw/UoExdK1szzTeXcsPlRg
 Ixbow9AJdsktSYZb7w+KlaLX2Q==
X-Google-Smtp-Source: AGHT+IFwJ6WbJtoEJBR0h+xaGIr/8q9ma1wJGXOzpHvHJgseeW9gzGnBJ+9SfCFUULqTsHelU100lQ==
X-Received: by 2002:a2e:9d89:0:b0:2c5:2813:5534 with SMTP id
 c9-20020a2e9d89000000b002c528135534mr5248557ljj.51.1700492920828; 
 Mon, 20 Nov 2023 07:08:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fc16-20020a05600c525000b004054dcbf92asm13671291wmb.20.2023.11.20.07.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A66665773;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 05/14] target/nios2: Deprecate the Nios II architecture
Date: Mon, 20 Nov 2023 15:08:24 +0000
Message-Id: <20231120150833.2552739-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
last contribution from Chris was in 2012 [1] and Marek in 2018 [2].

[1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-crwulff@gmail.com/
[2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Marek Vasut <marex@denx.de>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231117070250.32932-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/deprecated.rst | 15 +++++++++++++++
 hw/nios2/10m50_devboard.c |  1 +
 hw/nios2/generic_nommu.c  |  1 +
 3 files changed, 17 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6c84db90b5..2e15040246 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -236,6 +236,16 @@ it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
 
+System emulator CPUs
+--------------------
+
+Nios II CPU (since 8.2)
+'''''''''''''''''''''''
+
+The Nios II architecture is orphan. The ``nios2`` guest CPU support is
+deprecated and will be removed in a future version of QEMU.
+
+
 System emulator machines
 ------------------------
 
@@ -254,6 +264,11 @@ These old machine types are quite neglected nowadays and thus might have
 various pitfalls with regards to live migration. Use a newer machine type
 instead.
 
+Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Nios II architecture is orphan.
+
 
 Backend options
 ---------------
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 952a0dc33e..6cb32f777b 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -160,6 +160,7 @@ static void nios2_10m50_ghrd_class_init(ObjectClass *oc, void *data)
     mc->desc = "Altera 10M50 GHRD Nios II design";
     mc->init = nios2_10m50_ghrd_init;
     mc->is_default = true;
+    mc->deprecation_reason = "Nios II architecture is deprecated";
 
     object_class_property_add_bool(oc, "vic", get_vic, set_vic);
     object_class_property_set_description(oc, "vic",
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
index 48edb3ae37..defa16953f 100644
--- a/hw/nios2/generic_nommu.c
+++ b/hw/nios2/generic_nommu.c
@@ -95,6 +95,7 @@ static void nios2_generic_nommu_machine_init(struct MachineClass *mc)
 {
     mc->desc = "Generic NOMMU Nios II design";
     mc->init = nios2_generic_nommu_init;
+    mc->deprecation_reason = "Nios II architecture is deprecated";
 }
 
 DEFINE_MACHINE("nios2-generic-nommu", nios2_generic_nommu_machine_init);
-- 
2.39.2


