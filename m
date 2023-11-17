Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D967EED7F
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 09:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3u9R-0001Bs-HZ; Fri, 17 Nov 2023 03:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r3u9O-0001Bf-Sq
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:24:30 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r3u9N-00015m-1u
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 03:24:30 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c788f5bf53so22279921fa.2
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 00:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700209467; x=1700814267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9OqgtBrDr+vmRiWZS6+S26NtOh1CvIVadNMRqyM4VsA=;
 b=Xy3wM1U6+taylt003Kcm6/cXj3lZZD01yfxh02UioxEdeMmgzbORkcI/0wCpAjqXN6
 Qu9cYEwxvuipTpJxmZJ1YS7IiISLi6vj1Q0BNtCgvYeg1jmn95Vn4aE3FI9Y+Jkkb9bN
 lf32K6ftSkvchTqEt1K2ljAYjjxPuSSa5RoF81izMQbzXjs0hJSyfuSA1db6fBw+nLa8
 1GMxg+NfuAWr/fkc/XzJ9ToawwNEDvm1pkX8CcDtdnHpf5GdXI2NRdSuVGz98/agvIxu
 EJhBUTs5PIaAY4HaZyX9ibyXiMv6uMgAEQsGsqH6l6aYJLgZ0m1RKBqgPmWRSPWguTxO
 AmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700209467; x=1700814267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9OqgtBrDr+vmRiWZS6+S26NtOh1CvIVadNMRqyM4VsA=;
 b=uPfpYzTkjk7t9OaHI0otuLBY2DbfpK7RLjCv4GB9NGOs7fZdjNGwUTL14QdMHWV6tK
 FLJujzHG5NxZlcv70/yvrDfeBUOa6WCld/w3jxF/Ki2/daeeEmzm2tNNSV8OALoXWqpJ
 Ino9AAbmEgPlH8DT+9oMMzQthwmL68DKr66ibiE8rRtPS8mNUn8sPlbx8PVU6q2uF8dE
 mD/NL90zTXG6ZzsNOWVoO59sDsYAtUTq/YUrkpXSSQlWkddYVQJFrGUXTy+AgRs70KJT
 5XZ3b6696xCEkVqwimonm8XKoLqZX9RdiMYHu0RGph8E8mFE1Gg/+DfcIZsloV0Y0GhL
 CSJA==
X-Gm-Message-State: AOJu0YxD5G2qF15uGaQSZX0Yd9d6whPLRhWVnYrpLznchYb++63hY7Gp
 Ha7eazqyKRI5YZFH/QMzZ00Ah5XjfN9Oeg==
X-Google-Smtp-Source: AGHT+IFIrIWTMqL2FaH174DRu8XmS21n7woMbiq2HX1RVAA8D1EFsVcJ6Cx5R7TWupfC1nPnlypqhQ==
X-Received: by 2002:a2e:a58f:0:b0:2c2:8f22:d9c2 with SMTP id
 m15-20020a2ea58f000000b002c28f22d9c2mr9550282ljp.22.1700209466381; 
 Fri, 17 Nov 2023 00:24:26 -0800 (PST)
Received: from localhost.localdomain ([185.174.159.112])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a2e9790000000b002c6ec789f77sm138311lji.7.2023.11.17.00.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 00:24:25 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH] hw/usb: fix xhci port notify
Date: Fri, 17 Nov 2023 08:24:11 +0000
Message-Id: <20231117082411.2586-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lj1-x22a.google.com
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

Host mode: The controller sets this bit to a one when on any port a Connect Status occurs, a PortEnable/Disable Change occurs, an Over Current Change occurs, or the Force Port Resume bit is set as theresult of a J-K transition on the suspended port.
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


