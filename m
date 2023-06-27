Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01D73FB70
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Em-0001w4-U5; Tue, 27 Jun 2023 07:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7Eh-0001vi-UT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:55 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7Ef-0004lJ-67
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:55 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-98e25fa6f5bso445117866b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866711; x=1690458711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGZXRn778tTjabpObTTq7zFLfhDFVmkSDdvtG4Gr8rE=;
 b=ivXPP7EELHfP6sJ0l5qbHx5mCV8QlbwHGwSr7NB/wOhD6ru2flkDn3IF6/KjnLc1Sc
 RuPyAvov01ZLYBdsoZomj1ewZoI+FtwOEl+ccTsSDdOldyqu+FZwmlFqzaqtzYFbfs8P
 ce1DotNHn0nwCBkYyHAAx/Bd9+mhjvIj0Pyhk+o56mBDh/nXkkbTS71Ee83uhnydL9yI
 P77qRKp256o1b5l9IuNXT9ndDCwwreprJlClr4Q5c4N+b1Th9tj8Xpj+sbA3a1w9/BJR
 GOcbV8TtL+sewaMNfqzFZ2+sjHp2XuNJOG9liHKOZSwFlzeMYHcKGHdDLNplrav8YT5U
 JkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866711; x=1690458711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TGZXRn778tTjabpObTTq7zFLfhDFVmkSDdvtG4Gr8rE=;
 b=M8MUoIDCyltfn6zHgYbdlCGs/mYWDrlN0PlVi1mOMBGhZUouPGfODWJ6QqWFYKkPwW
 x++TTD0bjbq8XLI7R15PxhCNmBQC30WMqzJRphBx2VgiSDo4V7zTciVAqWybBabUd6xK
 aZ4ezWdfvLqCeSo3ZJ19ASCtkoXU7frmWI1BcJ/yoQpDrxXPF7ww2zTY6x0ffB/G+UhI
 v+TSqoC/gczm/y22PqSMWGw8MUVX0CbGW5r8E8i7m7JKEBMeKZDHTDaJ426tQkTX0Ud+
 IZQRU3fJQ92VDrYSUHDWvlblBQV3n+l+vqw06iUkWApyJP4z0GR17qjVO7Bhjc5rwXMm
 ORRQ==
X-Gm-Message-State: AC+VfDwdfIsImLavHQ70Bzx6KV8WN7gP0Vb2vjqPD3BeFNUxdBDeqYuJ
 8diaifcbZWkEN+FWW0L9azJZ12DalkP6VsT/cj0=
X-Google-Smtp-Source: ACHHUZ6KmfyVDXHoF0LSGwDDJ1p2i/7O7JP2KiimBL6Oz48s5RB2ncVVHEPFcgvvbfKEdG3eNwqUoQ==
X-Received: by 2002:aa7:d5d6:0:b0:51d:961c:8ad4 with SMTP id
 d22-20020aa7d5d6000000b0051d961c8ad4mr4856426eds.28.1687866711477; 
 Tue, 27 Jun 2023 04:51:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 v20-20020aa7dbd4000000b00514a5f7a145sm3701418edt.37.2023.06.27.04.51.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/6] target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
Date: Tue, 27 Jun 2023 13:51:22 +0200
Message-Id: <20230627115124.19632-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

TYPE_HOST_POWERPC_CPU is used in various places of cpu_init.c,
in order to restrict "kvm_ppc.h" to sysemu, move this QOM-related
definition to cpu-qom.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 2 ++
 target/ppc/kvm_ppc.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index c2bff349cc..4e4061068e 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -36,6 +36,8 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 #define cpu_list ppc_cpu_list
 
+#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
+
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 
 typedef struct CPUArchState CPUPPCState;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 49954a300b..901e188c9a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -13,8 +13,6 @@
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
-#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
-
 #ifdef CONFIG_KVM
 
 uint32_t kvmppc_get_tbfreq(void);
-- 
2.38.1


