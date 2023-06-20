Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20294736533
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBW60-0002hD-CD; Tue, 20 Jun 2023 03:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBW5w-0002f4-Pg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:48:09 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBW5v-0005Cy-8L
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:48:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9889952ed18so321008066b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687247285; x=1689839285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mtegtrCAOBu3HM7a0/agnCLxhf2Gi1yFIfWMg2j2DRs=;
 b=JCYdSS60GtEQN7R0wwEIknru/NLc0XwXzcox0JLAQB1Q+aizacm7zme96J888ruYdN
 K/b/+jfh5MHwjbhfmZ40MOkPqJGwlOmVtORpdIuFwUOVc93DfQAsI4gwgj7ws/NilLvb
 xIdulWFsueXION19vQuI6co786gLLlaFNpRaZCYgz8G8Bz7XCyUWEzv58i9+yOB66rzc
 KrQxmx3mv9jai3m+AMBYd7uIW13h7y/WCZBsYuU7SYa/QNdd8mR/Ymby37JnVTJPjzMA
 UBn9MAxuILqoSbIkq1Yo27yCgX91czitmcYDoTQxZXpm5VfxTNv5rjYY7LQTq41+F6Tl
 T13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687247285; x=1689839285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mtegtrCAOBu3HM7a0/agnCLxhf2Gi1yFIfWMg2j2DRs=;
 b=EuRGLnSHKaQJIWkDhEf0Nww2OAXW1stUxPf2ye14BBWigghx2uT8XJrAW6o99i9OGS
 vyqvDzVmwVr0reLmU7qzhawPZeCbb6gnEBv5jxafSD4t9+XFYm3c+DKw3LcUz0YWgKdt
 qCQhHDZfFnugsXnMzM/dkmTkjVUzHqrAFsdguJBXH0htlUjZLgBEHqkk1FFdmI++kMcs
 ripcXUExjWF6Ud1Q1+sk9sQrI+EBcjxBRFrUd/2uIiI57iv9RKk4uYohMo6MC4h7goVB
 Zoo5MWQQha1TXhpTSlXxxKk4JK4IFKqZzQk1ZLz9mRvI82GdXLQfiRcWcbfW1sVHXLZp
 SNtA==
X-Gm-Message-State: AC+VfDxoRk9aOLCVhd9lBunlyC+8ny6cRt7izOAUvhRHn70Jwp9YAmAm
 s2U63EjG7Rb+awyuHd2C5A5KQCCneuhW0GYtCZ/Rlg==
X-Google-Smtp-Source: ACHHUZ6oTNjoZYIxcTkvwqAqB2H0os/R2pFeg7VFSPe3Vsnc0okX+3HHOYGzJvbBv7PWaRy5fzyksQ==
X-Received: by 2002:a17:906:4e8e:b0:97c:d2d1:3066 with SMTP id
 v14-20020a1709064e8e00b0097cd2d13066mr9543700eju.33.1687247284938; 
 Tue, 20 Jun 2023 00:48:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906390300b009893650453fsm450833eje.173.2023.06.20.00.48.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 00:48:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/ppc/spapr: Test whether TCG is enabled with tcg_enabled()
Date: Tue, 20 Jun 2023 09:48:02 +0200
Message-Id: <20230620074802.86898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Although the PPC target only supports the TCG and KVM
accelerators, QEMU supports more. We can no assume that
'!kvm == tcg', so test for the correct accelerator. This
also eases code review, because here we don't care about
KVM, we really want to test for TCG.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dcb7f1c70a..c4b666587b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2524,7 +2524,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     int ret;
     unsigned int smp_threads = ms->smp.threads;
 
-    if (!kvm_enabled() && (smp_threads > 1)) {
+    if (tcg_enabled() && (smp_threads > 1)) {
         error_setg(errp, "TCG cannot support more than 1 thread/core "
                    "on a pseries machine");
         return;
-- 
2.38.1


