Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B574B013
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:43:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjiX-00074T-Ea; Fri, 07 Jul 2023 07:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiV-0006uV-Ce; Fri, 07 Jul 2023 07:33:39 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjiT-0006zf-Kr; Fri, 07 Jul 2023 07:33:39 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1b055511f8bso1087313fac.1; 
 Fri, 07 Jul 2023 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729616; x=1691321616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeLn95Ux33FFhuaR0eKb0nd/D54OxxvXqQiZdIS6F0w=;
 b=SZu4IW1d94Z0Xql7CzBMTxqGBgRysO4oZpS2gzY01qfFUukLHuDt59OiWvcvgnaaOv
 BJeke+/oA/OA30i4b/Ap31rYBzJ5tZm0VXkpoQAH+1cOHRQnP8QDjHaFNmqPkq5DQyId
 58AyDDKjdgQm6DeC8Zs7DrDTzBXzt7YOWA6+n9iDsU9EjL9/5I2fhBsizpOYaUKlwKBb
 V+N6q5r4lE/ff1SYr0/yPvG4UGyjMtiojf1viRdMsUmVmmWcctcblJChWjp5WkNU6IZH
 jxiJ/svumFVXDeOthKEe03SDxMrinC5gIz/pruk6cKFlQNzj8xWiEXo4vCMJ0JH/gJje
 W79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729616; x=1691321616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeLn95Ux33FFhuaR0eKb0nd/D54OxxvXqQiZdIS6F0w=;
 b=Y3xGw/YPGko2FYltHIhXW1wCiOhRvnDgOSOyPCYtHBQnibPP7STHmW2B2J6yetsySD
 0bNMGU33AY98VDnMhtW9g17lZrY2rHtANfif50NnQM4ZSobX3z6Oeh0Z1cCGc+E7ROSl
 j5CH4tePn+a0q0Io+fCrF7xeoVKb6wijOPKqr2PeOfEXzkIMjBjcx0AFZKA+bVPsd7nQ
 aGEuatHL1UgahFNj2mvhvTtF+De+Faa2zd/iflWQa7Z7/N+nB81yUVOTtIn2Dx0dirHp
 KqWabfkZUqbbfnm1yWsutMym38I67z4NfRTYTGDVqMGCaK1JCnHjfKYZwOIA7i41bqaF
 zv9A==
X-Gm-Message-State: ABy/qLYEiYBeSbJRfJ+MM7ljtuXrA6GKxw11j24M0yr20D9sOJ+R22O7
 KG9x4Vm95dGG9Nqr5hMJGbFat09SLl4=
X-Google-Smtp-Source: APBJJlEYvgL8MgphOLG/YRgmObKjkrWJ8tcL1SDUu6ZDw0Otm/vRQmwxckG2GhLMmCsi0x5VU9foqQ==
X-Received: by 2002:a05:6870:c34e:b0:19e:b8e0:143f with SMTP id
 e14-20020a056870c34e00b0019eb8e0143fmr2449159oak.9.1688729615933; 
 Fri, 07 Jul 2023 04:33:35 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:35 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 53/60] target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
Date: Fri,  7 Jul 2023 08:31:01 -0300
Message-ID: <20230707113108.7145-54-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"kvm_ppc.h" declares:

  int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);

'struct kvm_run' is declared in "sysemu/kvm.h", include it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230627115124.19632-2-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
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
2.41.0


