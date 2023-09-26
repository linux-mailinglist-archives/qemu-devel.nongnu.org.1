Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9767AF172
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBQB-00037L-DC; Tue, 26 Sep 2023 13:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPV-000255-Hk
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPP-0006eE-Df
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qc/zUIWBOFnR2UjZvMjpIc+zASKSFV5bfRueWLtDPno=;
 b=jEjGp34TnKydD0vJl88WJcaAluPuc7qh+E1ERU0iaASYS0miatOVtkzhaIOBa5EWc3Opkq
 ORzUvvjy5jdLI8kX/RysJ443VIScGRYbE2V1c4Ba6X8XKKB6YfYMd9e6v6d99B87LDGTfk
 aSMsJKLfXvaJXuk++Ov6oTkI+Hy9hJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-u6fc4TBCNDeEFjh1fI9EMw-1; Tue, 26 Sep 2023 12:59:36 -0400
X-MC-Unique: u6fc4TBCNDeEFjh1fI9EMw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3200597bfc5so7067716f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747575; x=1696352375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qc/zUIWBOFnR2UjZvMjpIc+zASKSFV5bfRueWLtDPno=;
 b=f1irIF/EzsAxzsrrc/8Joh8pn1GzvsnHAM13zzsqtLvvAcrKXcDZ0l/97h3aTqRkGA
 aWFNU8g9B2VTY7hsse2ba4AqbWFdT9Bx0wjBNGfSRQSwxQv9WsHkTNoYT1xp9g9QIQTC
 kBmKi1W3XhNhlpFhX+kFf4k30amdNTYDiE+Q5c7oNufWtRyVwgZ7ERrBvusnAfS0LzCv
 tKH5qLOKcWV19/WNBJ9IobfzPFG1/hESKIb2fWHDCoQvUEprRCzbRGuPQM/RQgzNPGnX
 xQkAM7ZFWtnls+alIQLI079n4HkQ7K0CawZUYldebU5gqRa7w93WgA4EirtAo+j+S6W1
 mpsg==
X-Gm-Message-State: AOJu0YyGy9ltx7/ajFGbEdAyeFoxAX8naVqHDFIg0UkphYZRNllieiQj
 lloOtAaDCeILEP+r8Dhcgx7kZ6QrtJNwRCOtd2vTI8xAH/69rz3qH0WVsJ+L6jPElImz7im4Unk
 ccZhB6CvGbHJ8S6DuD3m7KdMS6d1GujPt9QXstCDS+kxUESR/TV6FJVqmlOxNetQaPQV74ObEkd
 w=
X-Received: by 2002:a5d:458b:0:b0:320:a4e:acf8 with SMTP id
 p11-20020a5d458b000000b003200a4eacf8mr8973998wrq.48.1695747575191; 
 Tue, 26 Sep 2023 09:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKXcKc1JZWIPTp6xTZflf192xG+rAogl0p7NdDdq+WME2ZDdZ7fxtZE0fhAp1dqqxU1FfwpQ==
X-Received: by 2002:a5d:458b:0:b0:320:a4e:acf8 with SMTP id
 p11-20020a5d458b000000b003200a4eacf8mr8973985wrq.48.1695747574909; 
 Tue, 26 Sep 2023 09:59:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k10-20020adfd22a000000b0032320a9b010sm7322237wrh.28.2023.09.26.09.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>
Subject: [PULL 09/19] pm_smbus: rename variable to avoid shadowing
Date: Tue, 26 Sep 2023 18:59:05 +0200
Message-ID: <20230926165915.738719-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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

Acked-by: Corey Minyard <cminyard@mvista.com>
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


