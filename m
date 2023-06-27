Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC273FB6C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7ES-0001nW-EW; Tue, 27 Jun 2023 07:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EQ-0001j1-2e
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:38 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7EN-0004iU-MR
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:51:37 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6afc1ceffso9558251fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866693; x=1690458693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqGKfDWguJ/wQ1MgcOKBra/Rp1I0sbXrog+W6VzRYIk=;
 b=ewP/4+l1QLLin+KK4AdIpG6bDe13BPYlhXal/v/3ycYZcBW61sbUWbK85IvzFqoKWq
 taSeDcJpBYtghpfLdfEoAXcv+EI3epbC/jcMtzm19+bZ5TGMitS4MrDYVCY4T+SQvvwg
 krtsS2xOqMCc5FagWxKD2GAFDfSG5WSMWZtZkhtkWbNKSSh0qNt1XHRFiskR3ixRupXW
 5D6SGbX/c+qD+5Ied4g3hsI0hqfWWsq4XyMgPeJQQW8nLSwbUS5PpZ799Gvymqq25yQR
 G2/Jeqkuk4ZJ0l3k+RcQCJjYqxjZp7QZZ2jnu3EKwZlfPMjivKmZrvBy2uemvS9Tz+L0
 aM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866693; x=1690458693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqGKfDWguJ/wQ1MgcOKBra/Rp1I0sbXrog+W6VzRYIk=;
 b=HtHuSM4AhNLo1MqScVxFQqMTaF/agjcnURhFi2Dv1J6VPVOcqKB/noE/JmcHsvFhxm
 tO9EqSlLX+5PJuyffv/4ux165eOn09SR6z/qrHqJhMk8K7FcDY0aSDqZAQF4DD9Xs/9q
 vkRp7ybw70sAoIu+EOy+AOzngdy9cdiachpAv0N71mbbQi+837JGbyyD/Bcp9KlcLQ0r
 5zZ5UrLsYhw6iNFGRN+Tb6xDHVoxcdV/31xLA2QyORpD272tufYVtgM7yOaMgy6fPuRt
 vq/WeM+e62wJABTOf3lvGP8McRJH1OcwhU74StVG8Rv72/p985a+7J5WV4GFgEgNLMRI
 kc5w==
X-Gm-Message-State: AC+VfDxqAa1Li978eVlhLCXFF09x4tdyj1nRk72oHiaHcUJSRBdZFsEB
 /49mar/iBXtpUFe8PKuVRk2niQPdZ6IAyev6ESQ=
X-Google-Smtp-Source: ACHHUZ4G6BPvWH8r1ThUzkk54gczIHvhE6zDhvt40IrOFYOLgRAQlYtaiLny9tyUaBy38s2P0CdE+g==
X-Received: by 2002:a2e:2408:0:b0:2b5:89db:187 with SMTP id
 k8-20020a2e2408000000b002b589db0187mr12374664ljk.42.1687866693587; 
 Tue, 27 Jun 2023 04:51:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 v20-20020aa7dbd4000000b00514a5f7a145sm3701188edt.37.2023.06.27.04.51.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/6] target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
Date: Tue, 27 Jun 2023 13:51:19 +0200
Message-Id: <20230627115124.19632-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

"kvm_ppc.h" declares:

  int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);

'struct kvm_run' is declared in "sysemu/kvm.h", include it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm_ppc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 611debc3ce..2e395416f0 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -9,6 +9,7 @@
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
+#include "sysemu/kvm.h"
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
-- 
2.38.1


