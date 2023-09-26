Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588CA7AF178
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPi-0002AA-Hs; Tue, 26 Sep 2023 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPM-00021s-Ps
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPL-0006dH-Bi
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ck+8DKD6182hoZ4xHPrQvIXBRhdaPWWFfYLrX95g5Cw=;
 b=P+y/j2n1Zr9+7T7/bqgIYCjuoV4jK4WzqGCGotghPPEaqYFv0yCG/XdqLVKBzDoc0uAxtU
 ZppSnoJ6ljHvwzjP3BugBM8yOp+QBiPAXRrKIkramWbI+hLnrosOm4Lbxrs4Mi6BSTfgLL
 xj5nXFN7bfM7Fhv/doA9oIfuioUFzsQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-8AypuJzxPxqeW_owsIZUAQ-1; Tue, 26 Sep 2023 12:59:33 -0400
X-MC-Unique: 8AypuJzxPxqeW_owsIZUAQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31fed999e27so7595077f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747571; x=1696352371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ck+8DKD6182hoZ4xHPrQvIXBRhdaPWWFfYLrX95g5Cw=;
 b=QnHJUSlRulme+bw18D7jQ8EmCI3KyotAG/j0UFtGWA/bjVqAe70OA4SKptqxO4w6Te
 gbQA4f80KWjO2m46xi6Tq9kvsEzAf/Fgw8sqbKSOu5J/WoF7ny3tRpbWxV3fqfQHbIEA
 o24SaIKALN7i6Ydh8j53Sk4I0jspuBEngzv1wGPPjto86/HdWq+zK+0md73QGIoLej1W
 4ywlhBdikgex1xMTAgk48iergKeSNT8NeAg1Aan9rPGQ8phkmOEU4GwXfbp5MMTNzZxd
 u+/RzwhKHXr7HAn0Zuhhiev9+ErAjAqRg8MCPat7nBwRfL3Zs4oAEFa/9kN7iUesV4B5
 96XA==
X-Gm-Message-State: AOJu0YyUpZ4jiJVgl2DPu+w4KHCQO+6jtMaNxOLlms+lJpNzYBrgFTrH
 x7PDFPC/HUfthjvMMD3vopJtw17FxEGcv7i/AdEEoBtbS+vxKJGU3z0CaYmbj/BNiuOmr1SU9hq
 o5ujpOA9VA0oai1WoMQnOdgpjmmfNSuKtZXHAmE7JDl8MWS97zt6YY+eUUPtvZFnV1z/PhGPhTB
 I=
X-Received: by 2002:a5d:4bc1:0:b0:315:9e1b:4ea6 with SMTP id
 l1-20020a5d4bc1000000b003159e1b4ea6mr10056934wrt.58.1695747571503; 
 Tue, 26 Sep 2023 09:59:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFupLcLHsw2MH2jglqTmry1+ycsjRdlrIZhuVnYAtzwtoDzE3MNeiyTa0R0x0JqfgCi1uC3bQ==
X-Received: by 2002:a5d:4bc1:0:b0:315:9e1b:4ea6 with SMTP id
 l1-20020a5d4bc1000000b003159e1b4ea6mr10056914wrt.58.1695747571125; 
 Tue, 26 Sep 2023 09:59:31 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056000174c00b003233b554e6esm749067wrf.85.2023.09.26.09.59.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] ui/vnc: fix handling of VNC_FEATURE_XVP
Date: Tue, 26 Sep 2023 18:59:03 +0200
Message-ID: <20230926165915.738719-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


