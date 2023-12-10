Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40780B8CA
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5m-0005WX-7b; Sat, 09 Dec 2023 23:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5f-0005W5-Gy
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5e-0005KI-2A
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d08a924fcfso31085305ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181209; x=1702786009;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hu0ldtbrouyREh7dXtH6XSPkSj+IX/l4htTLTTF1Uts=;
 b=iIoiiqZt4oYaUTCv9Hpf13r9UafivD6IRx5ajSw8PjhU6elIbdoAnOtsMNRHAOAzzD
 +9H+iiKNtsdnCVtLHV/ABHBgM/pw/wwkFd8CDp+nJFnpMro4DPYDkeq3pM43+uNBczWb
 jGnl0RoRa2G8lG2/SO54NzNFFj2UvqnhKEUCLy5BvqCRWRswIAoKBiNT9hAX9UmBiLiK
 GlEqhCYTruecZj5Yc2EFjsDPlg0cWn4oixeN2qEn3gi5agoC/sR9qGQ9CQxZn1KvAMmF
 rgnrhm8nNkUOM5HaprH+TPaqVMO+kJMmdQ8ZbwBMgDN1s7Efd6hFA/NiBTarLQfqPyKA
 O1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181209; x=1702786009;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hu0ldtbrouyREh7dXtH6XSPkSj+IX/l4htTLTTF1Uts=;
 b=Z3qUV3PqaSfms7ftBi9xHVCnOFto3Ag72s3HMa4247MykALZesTTnKi+n6lskSXopF
 NK2sr6kWGUEmVJwsTFs+98Zl1JrVRwfNcvOeu4soQPOY9Usnmm6sA0rmru8JGEUWOjkq
 HZponTvkjYAer1pjxrBa9exvbAf1DHy8sx3T6SIndSrpsIlX6hPenR+puGOvKtB0Pwzw
 G6qEuRNxTKvpvsB6yNAQdbiPYnBm2ZhEoOqWre6RJqvxioIrk8mw6WLuvcFGvnVZiBJO
 PqqsAKCn/dNct98mYWMXkJyGviLVbGwUqDY1WLLpWT+2sAEeinB+cmiMy5h/mlHTqlaN
 IvtQ==
X-Gm-Message-State: AOJu0YwZ38Uc7xtEOxtffd6j9Xps9f+hZUIY8mp8Nr5BmUuynlX3MFFH
 zgdBYEhX68Y5YMhLcmoPRjP7DQ==
X-Google-Smtp-Source: AGHT+IFYWJvZoRG6Taxh18TnrTdAj9B+IKd4Sw4YqkZzWkizZlVYpQLS50FEQMD2EPN8gr57qSiMZQ==
X-Received: by 2002:a17:902:c411:b0:1d0:6ffd:e2b4 with SMTP id
 k17-20020a170902c41100b001d06ffde2b4mr2993346plk.78.1702181208991; 
 Sat, 09 Dec 2023 20:06:48 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 d14-20020a170902cece00b001cfb6a7e41bsm4103220plg.151.2023.12.09.20.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:51 +0900
Subject: [PATCH RFC v2 08/12] pcie_sriov: Ensure PF and VF are mutually
 exclusive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-8-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A device cannot be a SR-IOV PF and a VF at the same time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 566aeb9e99..160dfc84ec 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -46,6 +46,11 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (pci_is_vf(dev)) {
+        error_setg(errp, "a device cannot be a SR-IOV PF and a VF at the same time");
+        return false;
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;

-- 
2.43.0


