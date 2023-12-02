Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA3801B55
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwS-0004VB-Mn; Sat, 02 Dec 2023 03:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwL-0004UF-Hc
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:30 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwJ-00057e-5T
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:29 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-58ce8513da1so1835970eaf.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504085; x=1702108885;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=55rVeQPmJn6G2IWu8r2Sq8kbSZfBOqAtZltJfVWEVs0=;
 b=qzwPYb9BTPoTqb6wYvTx/4qLj6VJRTnn6H0Q7pww7rRWOSG2UvaomYs1h/XGWyHpqD
 yUIWBHi8pWUXbA8tPkXUI+0vROki2JAXMeJ2Ft3j7g2VW3j28Gu4tNRMm0a8T1WNaG+P
 1R0jRFX+AqCW5l5z9h5iIdWyOWbV26sZSxnLv/NDLOQ0UbQm5mjkJn5Y06WFbEUwr5+a
 bNel8Zoi0ER1ewXGSRpjjvuACj1tjEzUhVqSJdz2HoOSNQCD/fwyBei8CaQfFxdHGPx0
 5XtfcgHkVbcOIkfO+cgFk6zd5NGGN43xovObMVKww90U7cC7QZ99R5fI+CzajYqjWiv7
 L30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504085; x=1702108885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55rVeQPmJn6G2IWu8r2Sq8kbSZfBOqAtZltJfVWEVs0=;
 b=vy3CAF3Vt/glrax1uGp0KD7r2djv1ijaXxIjEJI/WrHxYR5jsllKXXvihzOD02qzRP
 KrHD857jV1ljurOMGV5UYR4wPDIJ7WXEDsb0e7dq7dh6cXCj0JyvPydgEOCImr+6632C
 908ZtMNQ05nNsWucIlCGg54udKE9s8w/x+4RYGptCwDjPaQnWA3UwOJvCSdrp5+4bJIq
 hgGTAKDd9gKoLDOz7YZS4o9Ebib+nwT5ZQo4nHNxwDd1+Nhxj9NY+oCO3LfjkOvO3p1U
 wsJmwWgmmRBEz9CkI3mdaRXJieszIvhsASbsFW9dX0HWUvRWS3nwQmEFKRwJfNcErjeT
 M4DA==
X-Gm-Message-State: AOJu0Ywg6WeJQAVXn9ItIpRU2PxfJfG3inKTa1gZX+1Ch3+3PIoWh/30
 mmBGdRAc/rcxhZQo25Oi24/N2g==
X-Google-Smtp-Source: AGHT+IEoiuhkeMVLRcKxzu5GZmWfQ/RKqbs4AZIypGvdDcqylu9Z2YiV7WOHJxeaJ1Zw43ZYQoo00A==
X-Received: by 2002:a05:6358:4285:b0:16d:d0e7:e7ee with SMTP id
 s5-20020a056358428500b0016dd0e7e7eemr1152106rwc.28.1701504085334; 
 Sat, 02 Dec 2023 00:01:25 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ep13-20020a17090ae64d00b0028672722301sm579417pjb.40.2023.12.02.00.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:24 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:34 +0900
Subject: [PATCH 11/14] pcie_sriov: Release VFs failed to realize
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-11-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2b.google.com
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

Release VFs failed to realize just as we do in unregister_vfs().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pcie_sriov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 5ef8950940..3ec786d341 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -153,6 +153,8 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
     qdev_realize(&dev->qdev, &bus->qbus, &local_err);
     if (local_err) {
         error_report_err(local_err);
+        object_unparent(OBJECT(dev));
+        object_unref(dev);
         return NULL;
     }
 

-- 
2.43.0


