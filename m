Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AAE76608C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAV8-0008Sp-Uz; Thu, 27 Jul 2023 19:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAV1-0008Rj-H8
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:27 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAV0-0001DI-1I
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:27 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb960b7c9dso2752080e87.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690500864; x=1691105664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWDN8OQ7S1a/kBflaC/qAdwP0GllihYkz9NZehoKxpM=;
 b=o2I14X4vOjr7lIVCpUdmkBl8LPNtyzDobd/aIpZ4XQY/nX/Ss6hWvG/FdZ3JaMZt9N
 HMLo/HqYP7dT8PBELeJbfmIBr5QgEcfoyfv6pmwtLLSVqKjcPP3BROn6zwEbVw6vwgyV
 3zJK4AtYi0f9m5Ak9TxhC/+UQ5aj7UefaJ5HIQY5eRyHTrHuFvFyp4GS77vvqwVoc69J
 i0hW/RyDa07DZVj7ipNdurToQqCvlbR5AwhkNfVMJlJ6z8CaOXWUI0HmZekz6lmryl9r
 wA4dOI5BE/zQQrbQvRK7L17RE0I7YksdYGf9P7mqs6HWs8uKiafaEiF1n8G08Kpif/ub
 8gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690500864; x=1691105664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWDN8OQ7S1a/kBflaC/qAdwP0GllihYkz9NZehoKxpM=;
 b=PdiwwXWq5bNu/yYh2kxvZR52C0aR44yIoO81vtQ1EMUtzgTvPmyap1SGhJhjcn1NnP
 OaXfOEmnO2+U/lnPxuxrqRgitxqpyfMxP4cEoadN/lE8e5DAEbphLO9+VKmfJUBYWsy1
 SijOlH9Qz1Pun7r9qsPsi+vOM9PH5pg4kx8wNIVcxRT91WAgs+8bP5uzF2/h1v2WJh8M
 34ESyYyakRnSun6i77dx6E2ORhT0gAEYcq3bHW1agMwYYlGjmrEQBnJc5Lqevi6dP51L
 Lkl6m5i4ZTQ1BNoJqT0MJPvW2dzsefvIcQxYOb654E5CPTsVd82sLgEXCU4N9LSLcs0h
 2Gsw==
X-Gm-Message-State: ABy/qLZK65EERzHtRonWZmzMs6y6Irn6ue7FqWg97qKfWykRJm57KM76
 sbmKHpUhCyOEltyfvOsGvEcQdnadN89F+Q==
X-Google-Smtp-Source: APBJJlFV7By6X1CnP4vmdLnehqJoQD/NMgSB0HXPm9ojPiiHZeZe5+z7h0nz1uSpRW1UvBHxcDMMXg==
X-Received: by 2002:a05:6512:605:b0:4fb:780d:2a49 with SMTP id
 b5-20020a056512060500b004fb780d2a49mr415704lfe.5.1690500864192; 
 Thu, 27 Jul 2023 16:34:24 -0700 (PDT)
Received: from localhost.localdomain ([185.9.78.206])
 by smtp.gmail.com with ESMTPSA id
 h16-20020ac25970000000b004fe0de39fddsm528241lfp.290.2023.07.27.16.34.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jul 2023 16:34:23 -0700 (PDT)
From: Mike Maslenkin <mike.maslenkin@gmail.com>
To: 
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 3/3] hw/ufs: change ufs_process_db signature
Date: Fri, 28 Jul 2023 02:34:05 +0300
Message-Id: <20230727233405.35937-4-mike.maslenkin@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230727233405.35937-1-mike.maslenkin@gmail.com>
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-lf1-x133.google.com
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

Actually UTRLDBR is 32bit register. There is no need to pass 64bit
value to ufs_process_db() function.

Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>
---
 hw/ufs/ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index b0656e47598e..af57ba6df02c 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -256,7 +256,7 @@ static void ufs_irq_check(UfsHc *u)
     }
 }
 
-static void ufs_process_db(UfsHc *u, uint64_t val)
+static void ufs_process_db(UfsHc *u, uint32_t val)
 {
     uint32_t slot;
     uint32_t nutrs = u->params.nutrs;
-- 
2.32.0 (Apple Git-132)


