Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B5719EC4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ieW-0001eE-Cj; Thu, 01 Jun 2023 09:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idV-0000eO-1U; Thu, 01 Jun 2023 09:46:45 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q4idS-0008Om-H9; Thu, 01 Jun 2023 09:46:40 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f3b5881734so1058984e87.0; 
 Thu, 01 Jun 2023 06:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627196; x=1688219196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UYDWKGvKYC6by67JPxRh/7gjQRGbIlzsmtLuE8pp3NQ=;
 b=UFiHB0XXKwmXF9g2Nh1el7A381w/5T+DRunnU5qgdmWo0KkRxo9rMK4ojrKgr45E9a
 7FaMKiCvxM9WemUkX41ou6FIj5Ior6k0tgi8ag3+c0ifkRoV8+ynUVgzhldHoilj4k9R
 bQ61ZfquDf3OLvQsjdhOu8c2VUXrmeWz5TLWyEIgou5N1TIpTdefow3tudrm7fzuLvf8
 QUpFoyJeEYEHVm9Qc3T+u7R9r4zxRIOD2ZX/kr2do5hhR4cC5xqf+4JPlEiErGlOmp6E
 HNIdNO/9xEGkP5bqsIqtVhwx8UkoXqrNYTyJzA1XN1zwvBXWbse0ITGoCPTk7qcVUsRl
 JjjQ==
X-Gm-Message-State: AC+VfDzLgEEoa9vkIx7tmXAYB8g7XjASf0AkSKC+r3T0Vfsopsiyhs9o
 eHcQ5KCS22niQmZg4ywM6/xnxU6WhPfwIVra
X-Google-Smtp-Source: ACHHUZ6oxm3rg5XywG8Q45WtAdpzTzumZcXzZ/0l6MLhX/Top97yf/uij6g3WymO3MwsFbtbm882tw==
X-Received: by 2002:a05:651c:112:b0:2ad:92b9:83b4 with SMTP id
 a18-20020a05651c011200b002ad92b983b4mr4536080ljb.5.1685627196456; 
 Thu, 01 Jun 2023 06:46:36 -0700 (PDT)
Received: from flawful.org (c-fcf6e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.246.252]) by smtp.gmail.com with ESMTPSA id
 x8-20020a2e8808000000b002a9f022e8bcsm3690202ljh.65.2023.06.01.06.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:46:36 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 40A4818B; Thu,  1 Jun 2023 15:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627195; bh=8dATELxmRIkH+ezlgHYDRcOBfPchD3qIpLWy5BGqYcY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qsDhVUvNzjpcE9mFP04DSMmtVvjKguCVzQKcfC9yA9V9MFJiH6jCxqKh+cJcMgpUU
 Fo4k87fQASdPI9sIgcfxeJ835BWQcpTqBw78yrZp4S+jc/vq7yGdvk+SkEqfWJKVLa
 gcf5LYgpLHO3otglSkg/FKs4xcFhI2GZgyn0Vx0w=
Received: from x1-carbon.lan (unknown [129.253.182.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 94A857A7;
 Thu,  1 Jun 2023 15:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1685627145; bh=8dATELxmRIkH+ezlgHYDRcOBfPchD3qIpLWy5BGqYcY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mNpQrXf4+le1c7Ccvfds/SYNocvC32n+RIEQ2zUxk4FZDoOqI3oj+9O6SN3OqYQg4
 XkmipuGVMUY/Qb+l7KG82OeoNtrqEWT1aE4NyB69najXJsjc9Db81IU75YGQIfdG6X
 5xEcQMevavKxcDDamQjnbBNd5Am1xf/KP6j36/wA=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 6/8] hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST
 is cleared
Date: Thu,  1 Jun 2023 15:44:32 +0200
Message-Id: <20230601134434.519805-7-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
References: <20230601134434.519805-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

According to AHCI 1.3.1 definition of PxSACT:
This field is cleared when PxCMD.ST is written from a '1' to a '0' by
software. This field is not cleared by a COMRESET or a software reset.

According to AHCI 1.3.1 definition of PxCI:
This field is also cleared when PxCMD.ST is written from a '1' to a '0'
by software.

Clearing PxCMD.ST is part of the error recovery procedure, see
AHCI 1.3.1, section "6.2 Error Recovery".

If we don't clear PxCI on error recovery, the previous command will
incorrectly still be marked as pending after error recovery.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 hw/ide/ahci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 1237f94ddc..12aaadc554 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -329,6 +329,11 @@ static void ahci_port_write(AHCIState *s, int port, int offset, uint32_t val)
         ahci_check_irq(s);
         break;
     case AHCI_PORT_REG_CMD:
+        if ((pr->cmd & PORT_CMD_START) && !(val & PORT_CMD_START)) {
+            pr->scr_act = 0;
+            pr->cmd_issue = 0;
+        }
+
         /* Block any Read-only fields from being set;
          * including LIST_ON and FIS_ON.
          * The spec requires to set ICC bits to zero after the ICC change
-- 
2.40.1


