Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6513801B4C
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kwe-0004jj-7k; Sat, 02 Dec 2023 03:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwZ-0004j1-O0
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:44 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwX-0005B3-8y
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:42 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6cde11fb647so3013887b3a.1
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504100; x=1702108900;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s16ZI44hQXkr05xkfwm1J4giXFLAF4fylGs8gYJ7YV8=;
 b=Tz+2+18XlKLIAg/buM0ulDrWq3wKlMnWMMiuHG2oXY3wiQVkZRhVQJuUCrOsozriO8
 CX0sfGDy6Gamyyjlbo+SRiIB0RrrqjuwutZMPgnDHvHbshcSa+/35iWeEypv019xj662
 PN4PD60lAQsuziC17yruGXvs0dESnXdbP19PKgPbdR4RxImfFu1ix+Gm5b4cBHrH27OD
 qI5WA0CJ/xPXI1+bLVxc7HgP3aQC3X9BhlfOJvOi8MfXNqzl83VhievM4J6ikeSnY+5w
 oeqxSAIL2okPB58Y5wSr+Y2U/lx/hbehW1bnyXjmXazAHvOlIsp5gogu0vl5WfCiFOwu
 8IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504100; x=1702108900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s16ZI44hQXkr05xkfwm1J4giXFLAF4fylGs8gYJ7YV8=;
 b=nZ4M47UKuH6ar/CqmpMsM0kIww3njISR3YPyDsEHW+rmMK42jmMhnpdukqY9+4JNLH
 p6fR0IT0u3QUhF3ZibWH9SCKwLvk/sHTgT5jkV/PlQKSKXl1vcVprCbnjrx+ukSvmVaI
 PSDuCuXGNnlrdMYSWdeROKaAPKYc3L63lmzD2vkHPBij/mZSqnFGyJ8Z3MD1vy1WWtR8
 zNhavKZIm9oUIUHu5S9uhaSy0rQ5ogzEMNx2n0uoVEgpW4hQUQNSE5XuHPIZIWjbWC/2
 efe257/Dbauxki4ydWQRCl07zTLRQJgAykqA4r/zRf76zOSQwE7kLzP3EKb708sxLUsc
 0/gw==
X-Gm-Message-State: AOJu0Yzup20cuyzom3Szgx4DuMeclnku7NIxGiud1OcrxhIYU9qd0jlO
 x4NAdEGn6ASEBy99GZhsKHOB6Q==
X-Google-Smtp-Source: AGHT+IEty8qzuzQIfSTtaye/71tSTJiDe2P17w2pG40Kgezvk15MuIHER/U5tNX6RNLVHmMRG9utgQ==
X-Received: by 2002:a05:6a20:1454:b0:18c:6559:37f8 with SMTP id
 a20-20020a056a20145400b0018c655937f8mr1088959pzi.34.1701504099822; 
 Sat, 02 Dec 2023 00:01:39 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 z27-20020aa79e5b000000b00686b649cdd0sm4114160pfq.86.2023.12.02.00.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:37 +0900
Subject: [PATCH 14/14] virtio-net: Add SR-IOV capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-14-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This enables the SR-IO capability previously added to virtio-pci for
virtio-net-pci.

Buglink: https://issues.redhat.com/browse/RHEL-1216
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index e421cd9cea..421d69e206 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -88,6 +88,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
     vpciklass->realize = virtio_net_pci_realize;
+    vpciklass->sriov_supported = true;
 }
 
 static void virtio_net_pci_instance_init(Object *obj)

-- 
2.43.0


