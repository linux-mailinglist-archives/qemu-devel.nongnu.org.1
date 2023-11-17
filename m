Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB37EF71F
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 18:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r42oZ-0007zj-R1; Fri, 17 Nov 2023 12:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r42oX-0007zM-MJ
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:39:33 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r42oV-0005wT-Ud
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:39:33 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so3134757e87.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700242770; x=1700847570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ogb63q9Cvxog6QUbUr7K6gdqCtmPGKnKxoxIttdawbk=;
 b=aSQFU2GTKPqzDH9GtUmf6tP+7OmKkBKC1gci764bbP9kgMlXFy/MIc+V+FuUccL8i/
 d7VZJ1ib8rZH32RJwFGTSlCoIJqaXQRyk/As87Atu23PEOVksU/d5lFdqYzBGKfA7NsS
 pjlv1rWPtJiVsyLy14DFtke047ezirsR5dzirsGH2PlUtCUI/L78Dt/jQXues4nH5s1R
 QVz/4UPBBq4uOwXUVovz4sow2cce6pnQUAwEYWq60u+jOus6+qc0EO3Vlv3gEX0TUXab
 W1FvkZgYTYg1nPb/62xbJloeY3s50N1m2y+S1kdno3aDczIYzvpjM54Of1FifvW5F9++
 b10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700242770; x=1700847570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ogb63q9Cvxog6QUbUr7K6gdqCtmPGKnKxoxIttdawbk=;
 b=e8CokHEMJTHpyerK+yEMfbBs4z8cNFDUznzpAvQ5DY9ZjgFz31wgJJDBo1SfRS+AKE
 k0IDRQfiZXKIyG/NhEgNM7qjTOu3Z5QQJRJc9+650JlixCm79tpIhsmCFYlb5ns0rTVM
 sPCyO6q6DkbeqrJtmfC80qSOEaX8vRG3NxC9dsUXMLScSBqSERi3gP7Owwrt2Lp6WWWy
 WzZopovLv+FEhRU2YK8sBiUqOn6vs1soymaSQI+6K2KLj23CLohjqlZqpOJHvBWyD2rc
 yj9x7RJuyo8FbAU0xnpoT+EDaj64wDc9+yxOEA5mm+PYXaLYG/dtW5kLd/XdIvaevMVQ
 ny2Q==
X-Gm-Message-State: AOJu0YzI4LkeJH3ZkYw8Cfn5gFB/mj6fmyVv+DTgUGcF18KXGDdXVN1p
 SAnOYx6z+t8ZgXMGBjzk9LX5iu9NLWmWMg==
X-Google-Smtp-Source: AGHT+IHjw/1zc2wCe4dy2MMMEM1Ysy9kXuCVS4DOguMBaY5OdBCteIUOQNithoykgpsajhUPbHSEuQ==
X-Received: by 2002:ac2:4566:0:b0:501:bd43:3b9c with SMTP id
 k6-20020ac24566000000b00501bd433b9cmr231675lfm.23.1700242769739; 
 Fri, 17 Nov 2023 09:39:29 -0800 (PST)
Received: from localhost.localdomain ([185.174.159.112])
 by smtp.gmail.com with ESMTPSA id
 u15-20020ac248af000000b004fe951827easm284094lfg.196.2023.11.17.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 09:39:29 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v3] hw/usb: fix xhci port notify
Date: Fri, 17 Nov 2023 17:39:16 +0000
Message-Id: <20231117173916.3658-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x129.google.com
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

From MCF5253 Reference manual https://www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf

Host mode: Port Change Detect. The controller sets this bit to a one when on any port a Connect Status occurs, a PortEnable/Disable Change occurs, an Over Current Change occurs, or the Force Port Resume bit is set as theresult of a J-K transition on the suspended port.

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 hw/usb/hcd-xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..1b2f4ac721 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port, uint32_t bits)
     if (!xhci_running(port->xhci)) {
         return;
     }
+    port->xhci->usbsts |= USBSTS_PCD;
     xhci_event(port->xhci, &ev, 0);
 }
 
-- 
2.34.1


