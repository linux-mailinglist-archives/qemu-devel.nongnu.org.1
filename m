Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DF7ADAAB
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmwq-0006UB-Ko; Mon, 25 Sep 2023 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmv4-0003oL-RD
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmv3-0000Y3-Dn
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YdQvSGGskotYWZpKXDQn2G8WmDCjN0olqxObSweRAeI=;
 b=J6YSSnruFeGrOdlQxrjR4U7Ttu0cN6n06s+EG2Jw0VoR3tmApqOoI0tY+Vf6DsNfCFg4Fg
 g59ZYERSqW8yZC4GiqonwLTHo2GLBeFivXK1OeZqtZBPwuoh58fm+kNnTcFdlmeJU4innZ
 hx7rMVs0QWwslI6UTs11HoB97OYV14E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-oDdUvPdvPZ6r9XvqmU10cg-1; Mon, 25 Sep 2023 10:50:38 -0400
X-MC-Unique: oDdUvPdvPZ6r9XvqmU10cg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so60723715e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653436; x=1696258236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdQvSGGskotYWZpKXDQn2G8WmDCjN0olqxObSweRAeI=;
 b=A8P47GJuEhzU76uBIOx0bHsTTvtKnZaf76Km3X2tDDuffoPDdQgLUIrJ0E6H5GlJUe
 Gnt0trXPhfAbgwUqz0wDEFJ1UkPfYPBmSiiCVbDZWVc1L6y6pluzwHCKnlqqPo4gDHKi
 KhNEeMlH2ujm5du/OeQk+eG+RHbtlG9KIzSMbOBXWvDKqXyKBBccFeti6FaRaVLIPQvX
 x/J6CVZZ04JsZ3ZJzRhOoSZqWahRFADzcwrhJ1Cwzl+3HnKyCg32QKpcDMobbyREbUN5
 81R9ntAjS4aoUYyJzEuwSZoDN9Bl6AZJRNk4vW5OsZ9km+/M5Vf4/fjKXTw5uDZIgACm
 EKKg==
X-Gm-Message-State: AOJu0YyHaqgTHB7KhSHoV25oRKEqps747qQBtVd6g8HmTgTr/x5al5g9
 5Mzldxw++8OEE9Kx7UScaauqcgsNiM9ZdthJPwxKBkA04n5QI1QNgviLqff8BzTLBPJIf+w79Sw
 xvtjaDdcN4tDV27XbnLMSZ91/ubpeQWgIOuXJJGPKWIN7ugwmdtErFC9ugBZ8uVOvZjvdO0VZV8
 w=
X-Received: by 2002:a05:600c:220f:b0:405:3466:6b8 with SMTP id
 z15-20020a05600c220f00b00405346606b8mr6101745wml.12.1695653436476; 
 Mon, 25 Sep 2023 07:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjjpwpajC0s9y+jArW8xaYLH/tVWtLtTiA1FtqLakiIB5Qc0h1YrWaWtUv/+yrxavlS2/DuA==
X-Received: by 2002:a05:600c:220f:b0:405:3466:6b8 with SMTP id
 z15-20020a05600c220f00b00405346606b8mr6101723wml.12.1695653435994; 
 Mon, 25 Sep 2023 07:50:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fefaf299b6sm879939wml.38.2023.09.25.07.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:50:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com
Subject: [PATCH] ui/vnc: fix enabling of VNC_FEATURE_XVP
Date: Mon, 25 Sep 2023 16:50:34 +0200
Message-ID: <20230925145034.530623-1-pbonzini@redhat.com>
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
so it was never enabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 6fd86996a54..3d13757b72b 100644
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
-- 
2.41.0


