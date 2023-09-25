Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0197ADA4D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsl-0000dY-1o; Mon, 25 Sep 2023 10:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsN-0000ZU-Ot
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsL-00082T-75
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NJGqA6Oaxj+LreVzi+zO0n9RenAwtUk0abaWD2nkWM0=;
 b=PMz3KNdvpBY4cczd6tuf+PbJdwbM1b21un8om9qHQ4NYLVrJJ6rkSW2Fm6jogcfTFu18/P
 gX9vyJk2fLSsPa3FQ/BLOPPX4nxZXhGfJl5Iu8RAkiTB8c9fsRv7BDsidpVhFlws91hIdO
 /Le867QH26hOE15hEtC4cdIXjBW+OJ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-XX8Z2RLFMISfPZiAGYy1RA-1; Mon, 25 Sep 2023 10:47:50 -0400
X-MC-Unique: XX8Z2RLFMISfPZiAGYy1RA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so49357775e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653268; x=1696258068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NJGqA6Oaxj+LreVzi+zO0n9RenAwtUk0abaWD2nkWM0=;
 b=D+95PJuIxcf9LJMJar9OEVLtSvHsTbFQoD3Xgl2h9w/P2juADNNa0lA+IrxC3f/ew7
 igOca8wsOGDfmfFoRAJxVuIjKaOtxple4udPlAposxScvxbNu2J2mXtejvnaSApJYJm5
 OdMVER5Cr7i+s0qIxuBtJJvKD8Arnsn6Wp++8XayqOIPUqraeegAT/ITU7R5OZPcdyh2
 cmRD86BvgWC0cpoVt+zzeOGFbwt7NNGXHDHY0G1Q3UG1itoMElF/I9QYCqPdDItAmo7Z
 hw7RmnB8EBJsC2unazqq38OAA4Nyyx4BIyK/oCvsXJm+kPEff5xAyywApIHjl46zn4QX
 b/oA==
X-Gm-Message-State: AOJu0YypDMB4XXQv+XTybz9yirH/w7KA99UNwZLqrZ5CH22wIsgO8yUc
 0kk40qAF66Zaj5pDu/mejnRxxxwPYzNsMVKdg7Ki2vTg2mk914iyTmKhjz1Ee3kVOURXNr5/7Zh
 SvBwIm7ypVxBdgtUBkxGxH2qS8UYZK+6w7M3uIUmJg6mmcX8M23Bq4DP5qOpxVNfMAkIkWK/5IU
 k=
X-Received: by 2002:a05:600c:211a:b0:3fc:1a6:7764 with SMTP id
 u26-20020a05600c211a00b003fc01a67764mr5537162wml.16.1695653268625; 
 Mon, 25 Sep 2023 07:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4YvD1oRDWrko/U55Wz7tFz98Er2beFMjZTgPeaSKcarHVbTXXD8Bi48BCHGGKbYkKz1Y/Hg==
X-Received: by 2002:a05:600c:211a:b0:3fc:1a6:7764 with SMTP id
 u26-20020a05600c211a00b003fc01a67764mr5537145wml.16.1695653268239; 
 Mon, 25 Sep 2023 07:47:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a1c6a11000000b00402f745c5ffsm12488037wmc.8.2023.09.25.07.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] pm_smbus: rename variable to avoid shadowing
Date: Mon, 25 Sep 2023 16:47:39 +0200
Message-ID: <20230925144744.527958-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 9ad6a47739b..4e1b8a5182d 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -279,7 +279,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
             if (!read && s->smb_index == s->smb_data0) {
                 uint8_t prot = (s->smb_ctl >> 2) & 0x07;
                 uint8_t cmd = s->smb_cmd;
-                uint8_t addr = s->smb_addr >> 1;
+                uint8_t smb_addr = s->smb_addr >> 1;
                 int ret;
 
                 if (prot == PROT_I2C_BLOCK_READ) {
@@ -287,7 +287,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                     goto out;
                 }
 
-                ret = smbus_write_block(s->smbus, addr, cmd, s->smb_data,
+                ret = smbus_write_block(s->smbus, smb_addr, cmd, s->smb_data,
                                         s->smb_data0, !s->i2c_enable);
                 if (ret < 0) {
                     s->smb_stat |= STS_DEV_ERR;
-- 
2.41.0


