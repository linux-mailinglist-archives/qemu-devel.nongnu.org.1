Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64B47EF708
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 18:36:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r42lP-0006rL-1I; Fri, 17 Nov 2023 12:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r42lL-0006r8-93
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:36:15 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r42lJ-0003Sn-Iq
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:36:15 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507bd644a96so3177944e87.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700242571; x=1700847371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gdlfSc8Mj23T3emHvkhQO9d2Gze1r8acbpnb5VJSrBk=;
 b=kP6Gb5pPb8T1jTGaUckWbd2nH3Ac2JeiT54h+FvfGMdlDrnwWhChflpeM+2VcEvlWC
 HbPHj5PT7o9QLVcEDj9sheaD47teKsoLNrTYcRMN0r4i8Ds1pYaNIn6uous3K0PdowMu
 2vAD5TxzZw+kxuHxmTQ3HUJ8ouGYSZFNzvLonsN9ORbNf2c6Wmk82Vlh3BdnNCCnclpv
 mZMC+acteIEnglWSF9c+E5IVRneA/P4lv+FWtclglxRQrpr1mTIL4X5F4gRfLO2LtNxT
 WObXSy/tFfhejHOtGJyb7DQAMd5PyTAySZ4c/3a0VWuDMxrVFe/NlH9UZhtg9PC9MDdT
 /v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700242571; x=1700847371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gdlfSc8Mj23T3emHvkhQO9d2Gze1r8acbpnb5VJSrBk=;
 b=Gm/lOTkk32wIYHqSMRWer1wg6dRLNdkocinl6ZZv3Jl0pnFos/SOUgE1gLIo1/nCke
 zbST7nLZinyCIywM4tsb7ah+sfjsQ/px3lfeO64w1rQQ9cs+KvVqM6dG477UxdJNDPQk
 gghmD4Gga9vWlx2Vy6pHQS+NjfJt8tm6uYpHUDNECIUe6CBx45uwOwWLq6OmFSSTn4Qu
 4NQP8dtjEsWBtaoCLy1vuZwUnoEdqnCcj017r5AYMxXOruzQ2ugQYhorIlkuKiPBxONy
 Xhd+fsO8XbXdRUxdqNcuq7Fmi2vHImm1FhfqpZFrkTCnwRPLszyW0Bq6/P1gVeiSHQfq
 kvlQ==
X-Gm-Message-State: AOJu0YwdsZv6FNAT1I6BzNRbSBvDYfJJYmq8CsZRjmCeb51oaE7e6/8c
 HkrlVdLrlEqZ6BWzzSYCVGs/TzBq58Uytg==
X-Google-Smtp-Source: AGHT+IE1Oz0zxAM9zTsDrW62RFkINQgQggmZH6VpSWaRf6dvrsUG+c/PETo56i2emg5XAOput+d7aQ==
X-Received: by 2002:a05:6512:159c:b0:507:a12c:558c with SMTP id
 bp28-20020a056512159c00b00507a12c558cmr160107lfb.46.1700242571290; 
 Fri, 17 Nov 2023 09:36:11 -0800 (PST)
Received: from localhost.localdomain ([185.174.159.112])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a198c59000000b00507f0d2b32bsm289533lfj.249.2023.11.17.09.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 09:36:10 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v2] hw/usb: fix xhci port notify
Date: Fri, 17 Nov 2023 17:35:58 +0000
Message-Id: <20231117173558.3318-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x12b.google.com
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


