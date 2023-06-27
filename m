Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E213273FB6E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7Ep-00020X-QD; Tue, 27 Jun 2023 07:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7En-0001zy-CN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:52:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE7El-0004nM-Oe
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:52:01 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9920a6a6cb0so105715666b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687866717; x=1690458717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VO9Kit1sdoJ392FVmc33R5cx+Y6OihE9F+t/ncxHt8c=;
 b=YT5YuAOOsTqqfatWHVtR5bkFlY0OTtUHvz/0s46L5ULvuQ9jKzUP8DdeP4Gvihrma4
 p3ihWqPzfDEhIHOOPHC+rsh5mMYQeIQ3JnTnrFzesbzAqWnLmlojrINFWAaITg2IsoRa
 fFIVnpjnh0gaHLZeA0mtf9bEsjWc7j+R1jKgwpen8bJanw32gRd8dXnt/1Jln2WieGxc
 SfADtn16kwQiMn1ONmCxcXlGIEhWJ91N3aoLX3XCIWTMHMS7sJOPVwM7N15G+1CRoRf0
 cb1rzlPPnpb0DCmjSUxVMvNUof956VdbGliqmdPEL8p2bsAS8PUXfgobj2cWf3KG5MOu
 rvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687866717; x=1690458717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VO9Kit1sdoJ392FVmc33R5cx+Y6OihE9F+t/ncxHt8c=;
 b=gmFym7uPN2L03nCCNwNT/dJvqXLEDdo111gt0KoGLKbWhyollcJyYcqwCNJDi47KjO
 SeSan9uSu1yZCbJxslMd1LcvHLg3Sp7kZGiVGMEvNs5mOF9t/TBlj0/9pM47dP8cnO7B
 3tEbGomhz1Kci1Wn7vsTtfFDiHJGi7FV/Za2/5ZRPKjAzAbmCBVcduz6p3IObu67OKmW
 LDWXEoZVNUYom00GBoS5Mhje/9ckzfGZW2lTj9nimnxzMkvgMm5LyM1p2X8DY8CHj7ll
 uyN2AKj8sZyTire0KIqviyRdnB5/m32VbbEUMiD/5tScWt2AiBmvFJhqwLtmF+tdE/tA
 nwwQ==
X-Gm-Message-State: AC+VfDw0BSR15uB4OJrjiANd25Va3H8VqXwxfkUaE7MciEmLpBZjxitp
 huy4vMoyZ8fP/aDGTHLnxB6nHiEVwFGnAULdk0s=
X-Google-Smtp-Source: ACHHUZ5LgZQOdPi8vbeWTXXgBKtBWYxquWJPWcOG+nXOG6pwEQj7QCL4ybEz91QzLvRj1pWiyaIm9A==
X-Received: by 2002:a17:907:9450:b0:989:3670:3696 with SMTP id
 dl16-20020a170907945000b0098936703696mr17867636ejc.58.1687866717193; 
 Tue, 27 Jun 2023 04:51:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a1709065f8200b009827b97c89csm4455614eju.102.2023.06.27.04.51.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 04:51:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 kvm@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/6] target/ppc: Restrict 'kvm_ppc.h' to sysemu in
 cpu_init.c
Date: Tue, 27 Jun 2023 13:51:23 +0200
Message-Id: <20230627115124.19632-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230627115124.19632-1-philmd@linaro.org>
References: <20230627115124.19632-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

User emulation shouldn't need any of the KVM prototypes
declared in "kvm_ppc.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index aeff71d063..f2afb539eb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "gdbstub/helpers.h"
-#include "kvm_ppc.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/tcg.h"
@@ -49,6 +48,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
+#include "kvm_ppc.h"
 #endif
 
 /* #define PPC_DEBUG_SPR */
-- 
2.38.1


