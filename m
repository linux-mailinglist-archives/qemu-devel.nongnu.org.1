Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FBB9F774E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 09:33:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBxp-0004VK-7r; Thu, 19 Dec 2024 03:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxi-0004TJ-VJ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBxh-00055l-Fe
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10btOK/tXOZbr6ihErAOqq4vVYs+KgwJjIF/DYaWyuU=;
 b=Sboe1cHg67tBwoKtVUKtgBA74RXMdiRmJOI08k0UC012/Qs3WF74akCcQb2Koa52e85kM0
 mvDUDfa9ATwtfBSOLPocdNKCrNJMH8tzXk+np0i4P1PKhEHn7A6IY0pqmPIWXola1wy6Va
 e1oMjSlKRiNtD2RGGSWb2kjn2y3TnOw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-WY89vAePOFa-Pmxy63cF6Q-1; Thu, 19 Dec 2024 03:32:47 -0500
X-MC-Unique: WY89vAePOFa-Pmxy63cF6Q-1
X-Mimecast-MFC-AGG-ID: WY89vAePOFa-Pmxy63cF6Q
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43626224274so3086765e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597166; x=1735201966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10btOK/tXOZbr6ihErAOqq4vVYs+KgwJjIF/DYaWyuU=;
 b=alUQMcufXz5J1NTYIdjnCwLy0KtubBuTEb0TE4LnRQdc4RUfTLHTjHl3t0DsCe7zci
 Whdp5Ry805mnlbYFZtS2cFXQmt0gyaTGh9bPqfpramrANCnrWW4I7OsHW3hllMSsAvjJ
 a5NxTcGhzbSF7flE6YssoUKGxj8OZqPxJ4vZ5+Yvd4zuhXfXsoLYTRmN09jgpJaUhcmh
 84+nZikNixQKe61uETsHaoPzJ4qwd2+9PorLuQu/Es8jPJCD8Ad/+9/AKj6IcwKqwow2
 iEldj+vn6oXb4LalIX+CD/iKF9k6vFhaT1iItRn7kNb136BVoCSTAZWbrwwlXqSYudTp
 X94g==
X-Gm-Message-State: AOJu0YyaGrnW31AH2MsD24jz/ctI/OrmhbGYvER0/X5L6bAVrHRE/spU
 Ge49flq7aX2GUULBW3gfwRkLjJHBGUybV9uhtZf9sGeV+Q0KoMIPFmBkef4knlHuOfqJbpMs5AF
 QwDgW3zb0DDluyu6T3izqWOLMEk8D68R+XrmXVA4vXkspLCvGutDFrDSTQEJ/F7qpgbtgYM+TQx
 fTxeU4s4d9MsxL7BwN8x8BQzcTW7waataIiSTs
X-Gm-Gg: ASbGncuDi3leM7iQH/uUrBvEdqUxhz7K8gNlCcmPFAY5QG60QNY3bpF2a2DqPOOCXhz
 Z8cSOjxoSFUFNJaVNy1z16l2ba1MWNBo/RtdfT0aqbefXt+xKmyNbc1JbHJ5hnBLTlxkWOMg7tB
 YllDxchQjaJEZalioHj++kMFMqIVhFJhSXkyDn4Kwj+p9DsMaamZfIs6JhmA5a05d8pkjJtz3V6
 TX2J9ONPJTxI5gEc3dHybJ79ccGrz8I6pM0CrseEFPuc9t7hchnvuCamT0a
X-Received: by 2002:a05:600c:3146:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-4365c7c88f1mr13594515e9.23.1734597165802; 
 Thu, 19 Dec 2024 00:32:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoQ85XVPvBcEf0aad7LVDe87tNoujNdUKPOdG2ATAirmPr0ml2o0Tu7kj7suwCVIRhvADTXw==
X-Received: by 2002:a05:600c:3146:b0:434:f5c0:328d with SMTP id
 5b1f17b1804b1-4365c7c88f1mr13594315e9.23.1734597165397; 
 Thu, 19 Dec 2024 00:32:45 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8289a0sm1024941f8f.7.2024.12.19.00.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:32:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/41] hw/s390x: Remove empty Property lists
Date: Thu, 19 Dec 2024 09:31:55 +0100
Message-ID: <20241219083228.363430-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-9-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/s390x/3270-ccw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 69e6783ade5..3a8930dfd15 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -150,15 +150,10 @@ out_err:
     g_free(sch);
 }
 
-static Property emulated_ccw_3270_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, emulated_ccw_3270_properties);
     dc->realize = emulated_ccw_3270_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-- 
2.47.1


