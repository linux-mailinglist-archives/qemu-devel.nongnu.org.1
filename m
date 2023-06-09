Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD6729EED
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cnz-0002N5-50; Fri, 09 Jun 2023 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cnx-0002MW-8A; Fri, 09 Jun 2023 10:09:29 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7cnv-0000Hw-N3; Fri, 09 Jun 2023 10:09:28 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so2362726e87.3; 
 Fri, 09 Jun 2023 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686319765; x=1688911765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=laqE+jDbGMxNloibp38IdoI5cMDWlF6ShBRxAGY56M8=;
 b=PDHt+3rUkGeNDyfvPAtJSp680aFIJZnkyzv5nDsn4Wg9wOsEV+QggsnmcuKSkv8r37
 UnsuCnXh64Nw8ITFk+UIUvafBw+7zUvJ8MuODYm3hDpkCJvvjJR9eO0SBb/wTvdRbrwO
 vvLH1WnRyF7N77nVXaa4KkZJZasVTJFA+kZzOdatbkG0snBHwSGdrKhQwBQCOI6qImXH
 +83XTAd1CtvepqAD5Ej5vM+eDkoFK+YPaA8+A9NjWrQY26Z9I7utXNezFxaVkzOMDclc
 aKwUS9A/TIBmWlHivZdx5MMrK/rAfk5PDmJGGrn1dNFA2ZA2yAVJxwjGTm2y02tTo2RL
 be6Q==
X-Gm-Message-State: AC+VfDyxTbsaIJ4UOXyWYKioo2qDM9HNzVcFV9w51pvwPCfg9F9GOXB5
 nE1/rooxLvO7eTGJHUax2veIurvWrrhoVSVf
X-Google-Smtp-Source: ACHHUZ4h6PTV7PBCFO81O+6f1+pXOPjNSte8Laet4eMCVu9KK6b90tL/YRMoqM5WlntKXC9MhetCeg==
X-Received: by 2002:a19:9119:0:b0:4f3:a3e0:850e with SMTP id
 t25-20020a199119000000b004f3a3e0850emr951440lfd.35.1686319765610; 
 Fri, 09 Jun 2023 07:09:25 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 h22-20020a197016000000b004f517c21ef4sm561125lfc.44.2023.06.09.07.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 07:09:25 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id 5A82B193F; Fri,  9 Jun 2023 16:09:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319764; bh=+7Lfn6Z7q7WKc/uSkZhwLaBrCOUaYvjqYUoBgBJpe9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JlHgjcl/uI1mE3C3WPULgN8f04liEmFLXQPfutUwHddygbYqOvHv6RDx/XIYwJS1i
 YSIo7/McR9i1YIBWnKVbyNdx9n4s/LWUjAYNPqEt8DgypQLgfGtqKexVCsXsPGq8Pk
 t9vBDWguk7wY7gaqvor3m7EDQNYEM9G19Bq3AcVY=
Received: from x1-carbon.lan (unknown [129.253.182.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id D6D721754;
 Fri,  9 Jun 2023 16:09:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686319746; bh=+7Lfn6Z7q7WKc/uSkZhwLaBrCOUaYvjqYUoBgBJpe9g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=umSl+GVfY4oxHV5BJaFFrQdH4stW27YoKJc9PbPV2YJjeFwImmMMUS9UHN18TlmwU
 i8NpaPaNve+HEh6Ul4awFhvF7ienJKlWlafa5V5ZEQeOrAi9OTxDgUriiO7iFSnw4O
 bI92igZOAlgiqeEj8r31iei1YUpbKFSGHUu+Zz90=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/8] hw/ide/ahci: remove stray backslash
Date: Fri,  9 Jun 2023 16:08:37 +0200
Message-Id: <20230609140844.202795-2-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609140844.202795-1-nks@flawful.org>
References: <20230609140844.202795-1-nks@flawful.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

This backslash obviously does not belong here, so remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 4e76d6b191..48d550f633 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -690,7 +690,7 @@ static void ahci_reset_port(AHCIState *s, int port)
 
     s->dev[port].port_state = STATE_RUN;
     if (ide_state->drive_kind == IDE_CD) {
-        ahci_set_signature(d, SATA_SIGNATURE_CDROM);\
+        ahci_set_signature(d, SATA_SIGNATURE_CDROM);
         ide_state->status = SEEK_STAT | WRERR_STAT | READY_STAT;
     } else {
         ahci_set_signature(d, SATA_SIGNATURE_DISK);
-- 
2.40.1


