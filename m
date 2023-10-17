Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723AD7CC581
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskes-0004iX-Og; Tue, 17 Oct 2023 10:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskei-0004Jh-RI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:48 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskea-0008PT-CT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:40 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so66003731fa.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551343; x=1698156143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puWItc3Dt59czgvz0D+TYHTdmTo5qF+fqrS6/T95/pw=;
 b=Jr0gTcj/RCvda45qJVoLxlOfPrQpxeFOoJ2DoUamqij+IWMFPQooAP21YBJEujOIg8
 EnXLDix5/EJ3ZaMyJ9wBXU/5KG0BhejhGQsh5SXnktfDoEsDrwe1Bw65DxUt85QF0an2
 NJPXWsiNffazl3UmUeAaMSierH6+Go/ivvvMKsjYyOWWZ5BHI2M5PHsWfwyNXPbidcmQ
 EDbKvSKuQyc3b2sJBH4CpP498jB09jivLysTpZVwiIIyz4V1jVG9AsWd/YMkFxzSUKvc
 EwqbP12RNOno5pUZh+3ZZP4y4ssv1/haZmbND1QQo7aDCMDwGSdhOdNZdjLaFsHf5Jq2
 JrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551343; x=1698156143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=puWItc3Dt59czgvz0D+TYHTdmTo5qF+fqrS6/T95/pw=;
 b=cwjlW0h2eJ/eZS9Bw5643H1V/zndv5bNgf+pq8CT96Mb/CSKAfFIcDN1n2aoqa3RAU
 4NxajWf93VZ6+5knTQDGkDOOrClArCHL0QICUdJ0ENRYKfRfjIhN+EX3qXSbfnk14zPN
 exg/iGR96AirTLrvd/Keozt2ccNT7cn4mpkohVSlg7O766IDfDE6dARBWWKlqaKSLq6M
 Wix95BdOuc4rST/G1abbG+p8P+VK+jNb16Xw6pcw5X9WhcOVhh4fpGEUat+CKMz80X16
 OQqN/zEu+5vgdy9U8JEwln1sW+e05zyb0aIBDwmPLdDnoP8zsh4qbFKNckxWZa1YOqv/
 T5/w==
X-Gm-Message-State: AOJu0Yy54ElByYEabPMK2kq1ntztc8ivoFAvl00oK9vtUBsbv2zzuzMs
 +glXAyrJ6oSN85CdiRIGqwgd6AcRgXIstU98toZqzw==
X-Google-Smtp-Source: AGHT+IGK+KAEB1GS/cibqP/wJaY69f4yyn2AxgcSSpsXAeeJu9f6xBuPtr28EYm9edCiWb3Jx7/d3A==
X-Received: by 2002:a2e:5052:0:b0:2bc:f78a:e5e0 with SMTP id
 v18-20020a2e5052000000b002bcf78ae5e0mr1671765ljd.43.1697551343116; 
 Tue, 17 Oct 2023 07:02:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c358b00b004075d5664basm10086258wmq.8.2023.10.17.07.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/7] hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
Date: Tue, 17 Oct 2023 16:01:47 +0200
Message-ID: <20231017140150.44995-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017140150.44995-1-philmd@linaro.org>
References: <20231017140150.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Access QOM parent with the proper QOM VIRTIO_SCSI_COMMON() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/virtio-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..fa53f0902c 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -761,7 +761,7 @@ static void virtio_scsi_fail_cmd_req(VirtIOSCSIReq *req)
 
 static int virtio_scsi_handle_cmd_req_prepare(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
-    VirtIOSCSICommon *vs = &s->parent_obj;
+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     SCSIDevice *d;
     int rc;
 
-- 
2.41.0


