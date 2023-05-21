Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8370AD8D
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h2V-0000Yt-U3; Sun, 21 May 2023 07:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2T-0000YK-WF; Sun, 21 May 2023 07:15:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q0h2S-0004k8-IR; Sun, 21 May 2023 07:15:49 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-510b6a249a8so8920348a12.0; 
 Sun, 21 May 2023 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684667746; x=1687259746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=N/uPGTeWtBCLKW+S7kufLrKmZ3sYSrLgR0TU4XeIocOL8ioVmdGVP7nqZwr3xEYU4S
 vn57m4r8cL9NJQxhRG9c3im6cKcQpvfQfS0KzlbeFPYKAaX3by/9GuaU0BSgcBxaG5IV
 RfGefD0g5sl/f+nIheCnEqqQ8i09OWAWYgoKTZy2pC2EPM/XRjVYpLYAeLjL+K33uUjA
 /Vue66971loa9xmbjBObk8a+GRGoTxBN7CVBYzH4PieTaW8LYkfPjSXqr3vH711JW4QZ
 N3UaItrvG9qLlQWfhqmYlWeWywxsVRdbATO6hJoiifZGRQKVOvWrY3F3CLyN32KPnjh9
 G+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684667746; x=1687259746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAoL9Xwljn85Sw7ICNUech4c35BoMKkS8qS/rd79d7s=;
 b=fTt5QBeg2hJ/73ImPiVTdWxKdG7nlz0Ieqvb6KhoNOXE1Wr5b2QtSLjgOUhQ93tD1a
 jSCn3jkIxRLm96AqWtBxyQcaQTjLI7BtQdWPEcrmHRq6bkE7SUCd3DXU4zPbYd1QBCYh
 9H25Hy5bdgSwEHo4AsMNKwbXAE6mPpAHSPsQN/Ioif7UDcMamFR6/bdl8NdZ2OwRIdGK
 MeFLTna8+jCg5W+sWrc1fNGSIINQal8O1zG2gs5W+2QgAbl2mFJjw0YF7ALapcEMrjaF
 bEw8Pu5sZMxu6B281A3fv4jrto2J2UxtRKlvv9uMejs9egBWWkGNz4hAIpfvXjQcyxiE
 XOyw==
X-Gm-Message-State: AC+VfDzcNzIJk/nU0w3grkf30UYd5pGDhFXo0recADGyjzozMkKrH5lr
 KJSao3U4uqnNQG8MOakTkj1OrUBvrXQ=
X-Google-Smtp-Source: ACHHUZ4UeRnY+sX19xR9OzEXtRd8fc6GlEZ4S4SAc/ZEHmmnQTHzRHENhwrt/4pkV7kj/k1tziAVnQ==
X-Received: by 2002:aa7:d419:0:b0:50c:4b1:8912 with SMTP id
 z25-20020aa7d419000000b0050c04b18912mr6494323edq.15.1684667745838; 
 Sun, 21 May 2023 04:15:45 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-077-191-145-122.77.191.pool.telefonica.de. [77.191.145.122])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a056402124500b0050dfb9fc499sm1757123edw.39.2023.05.21.04.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 May 2023 04:15:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 3/6] hw/isa/vt82c686: Remove via_isa_set_irq()
Date: Sun, 21 May 2023 13:15:31 +0200
Message-Id: <20230521111534.207973-4-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521111534.207973-1-shentey@gmail.com>
References: <20230521111534.207973-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

Now that via_isa_set_irq() is unused it can be removed.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/isa/vt82c686.h | 2 --
 hw/isa/vt82c686.c         | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index da1722daf2..b6e95b2851 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -34,6 +34,4 @@ struct ViaAC97State {
     uint32_t ac97_cmd;
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level);
-
 #endif
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8016c71315..57bdfb4e78 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -592,12 +592,6 @@ static const TypeInfo via_isa_info = {
     },
 };
 
-void via_isa_set_irq(PCIDevice *d, int n, int level)
-{
-    ViaISAState *s = VIA_ISA(d);
-    qemu_set_irq(s->isa_irqs_in[n], level);
-}
-
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
-- 
2.40.1


