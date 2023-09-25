Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1807ADCA9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:06:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qko5Z-0005oN-Ln; Mon, 25 Sep 2023 12:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qko5F-0005jc-A5
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qko5B-0007IT-Tg
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695657912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ck+8DKD6182hoZ4xHPrQvIXBRhdaPWWFfYLrX95g5Cw=;
 b=TbfnR1jvDa8jnm0E3CA9M0l44ibLbCceHUFaWYEagknC1jIGKpfEGtvuBtAlfMX1cNfUp4
 CnNlY7UJiiZL8rDWpU8JjzzX7tMc9lzPpTzmNse9FUOX5BYXzL4m8vTh/VnIeco/ejab2g
 QdUz6mSmFfk9WccPLuAmsC6CDP65WcY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-ePdW2hcrM-Ge1VZL2CS9jw-1; Mon, 25 Sep 2023 12:05:10 -0400
X-MC-Unique: ePdW2hcrM-Ge1VZL2CS9jw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32001e60fb3so4056160f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 09:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695657908; x=1696262708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ck+8DKD6182hoZ4xHPrQvIXBRhdaPWWFfYLrX95g5Cw=;
 b=UAl3bD1cdzu8eoSUk5tb6gN8C5TMrJ4vTMnPQeiLNDQoVDzFUZU44feWAWpferG4bQ
 DRLQLZAlZdSePUCqu0D8mTy1natIZlpset4QcMOm89YB7rTeAkS3lINlJDacu+hpboV/
 vOxPBDNLER/urnzR/+8lWe6+qb+fuvBY+MD74K0GJPxOotnvUaW/x9WKzZ+DoyKjReKU
 moyhWA7gV6CTzJ+ONbzLEBUEdnsXBmglyhPKJ2svHu5JXZcQgADzkAKZfN1hjcAajsj9
 JMXt1V7lVLvJ3dv1MY11zEGcOv/LK0C7PKTi2Y4bTVUqHTTh4Kn/gTZNx0//Tpm7Ou93
 z2gw==
X-Gm-Message-State: AOJu0YyEgYzFEovNp+UrxRD/qHzEHunmLovYhlCbR5GfMWxBTKGsPayL
 7UHVg8ndK3XjL3jrONeP+/ZnrljZ/Sreff7Q6q2YOJn9/yjMXSz0kGYodVkLKmq11nfFy483qy9
 vDJDQOGgoz1EgPRpBTQvMZIpuxjO4yyIoaWGKbbHZtO8E7Zg+CCrjmxcHp3en8U6cNsvqYrpeGa
 Q=
X-Received: by 2002:adf:e691:0:b0:31f:a717:f1b6 with SMTP id
 r17-20020adfe691000000b0031fa717f1b6mr75202wrm.11.1695657908512; 
 Mon, 25 Sep 2023 09:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiHuhsVGE0rot2qOJZvZc41CNmYE6yc1AxKezIyTW2KPxrUUZHAkmLS2b6g5MOWZ5R9vMsvw==
X-Received: by 2002:adf:e691:0:b0:31f:a717:f1b6 with SMTP id
 r17-20020adfe691000000b0031fa717f1b6mr75178wrm.11.1695657908084; 
 Mon, 25 Sep 2023 09:05:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0032008f99216sm12428057wrq.96.2023.09.25.09.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 09:05:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH v2] ui/vnc: fix handling of VNC_FEATURE_XVP
Date: Mon, 25 Sep 2023 18:05:06 +0200
Message-ID: <20230925160506.579524-1-pbonzini@redhat.com>
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

VNC_FEATURE_XVP was not shifted left before adding it to vs->features,
so it was never enabled; but it was also checked the wrong way with
a logical AND instead of vnc_has_feature.  Fix both places.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 1684ab90968..c302bb07a5b 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2205,7 +2205,7 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             break;
         case VNC_ENCODING_XVP:
             if (vs->vd->power_control) {
-                vs->features |= VNC_FEATURE_XVP;
+                vs->features |= VNC_FEATURE_XVP_MASK;
                 send_xvp_message(vs, VNC_XVP_CODE_INIT);
             }
             break;
@@ -2454,7 +2454,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
         vnc_client_cut_text(vs, read_u32(data, 4), data + 8);
         break;
     case VNC_MSG_CLIENT_XVP:
-        if (!(vs->features & VNC_FEATURE_XVP)) {
+        if (!vnc_has_feature(vs, VNC_FEATURE_XVP)) {
             error_report("vnc: xvp client message while disabled");
             vnc_client_error(vs);
             break;
-- 
2.41.0


