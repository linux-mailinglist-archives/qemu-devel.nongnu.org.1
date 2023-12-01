Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F18010EE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977Q-00030F-M4; Fri, 01 Dec 2023 12:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9773-0002uG-LB
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9771-0007iq-9j
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mIm/ZZ+AtEMMvxQLcKFz+qdaAOEyPQ7KcKiLyzLcQQQ=;
 b=J0WdiMDiJeyGZq6kb6iG/XA8y2/lBH6qhtQq1BXQ4alNeW4pC6gztNc6YRzciw94z3mf68
 lYGx+cFm7MiSEpGCw+f6qtUdRpTIaq4D9wypyEU9Ei6huBIZ2tNw7S3X6Aho5AZWhHUGD4
 rlLg/vRqvxwcF0Eai7KbuHppgeDMB4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-JFujUxdjOUq66T9cpcxk-A-1; Fri, 01 Dec 2023 12:15:30 -0500
X-MC-Unique: JFujUxdjOUq66T9cpcxk-A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40b297925ccso17137615e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450928; x=1702055728;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIm/ZZ+AtEMMvxQLcKFz+qdaAOEyPQ7KcKiLyzLcQQQ=;
 b=pArXJnyTZriFeCKpElXSMY9+cvLAUQI00rWucXnwCDRxMZsXzK9n7LKMDM6YhZt9as
 elaO0tDrTsA38NNF8VkEDOxYYkQNnIxZfvTxFVFJKhgpI0f0db+Zp/sP5i2b1V/d455P
 zGbOeufdp01hv1cQjWIHVk7rwude1AShRnucC1hYeq5sMzv7gwP28WASfgT5vIlXaVT/
 ThhE2CtxO89Z3H7FY3/FhoWq/AtJeDJ6o2dxusHKeK5N1GBScdjZZp4w4yG32JZNZ6Hr
 GHqAgMJXqn6cQOLLdEtodHdfP0OjHoRwXawx5V1tBg6eG1pwv6MqZj4wLg3NMgUrt2By
 8P7g==
X-Gm-Message-State: AOJu0YyrPeXc7yn8N3qqKSMDdaW+5YJYULvMoEBaKUOggLj9J+572wJz
 QouKwG8opkVP5k47neVYK1VdA8l1UC6Tmowbpd/B8aigRXBt3yDzCilhng/39eNg6HJKtlEibIA
 BihJnFvmIfont3hDKOf8bQ+RC0GGlHy80eJ4i1lXKL6ykh7wwkQsSGIvZWptu95fD0pRR
X-Received: by 2002:a05:600c:6003:b0:40b:5e22:974 with SMTP id
 az3-20020a05600c600300b0040b5e220974mr797983wmb.99.1701450928392; 
 Fri, 01 Dec 2023 09:15:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ3WlOhsWzu1uBXzuftI+71IX/uk6qlLfHxlliu7daUVG7SIcVu0iGmSptjR45Oe54zj5iYg==
X-Received: by 2002:a05:600c:6003:b0:40b:5e22:974 with SMTP id
 az3-20020a05600c600300b0040b5e220974mr797971wmb.99.1701450928059; 
 Fri, 01 Dec 2023 09:15:28 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a05600c3ac400b0040b538047b4sm9494751wms.3.2023.12.01.09.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:27 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 07/15] virtio-snd: check AUD_register_card return value
Message-ID: <e1da0b9785cd7618c13820ca1846f6c1d82b4687.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

AUD_register_card might fail. Even though errp was passed as an
argument, the call's return value was not checked for failure.

Fixes: Coverity CID 1523899
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 2fe966e311..83e97858e0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1102,7 +1102,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    AUD_register_card("virtio-sound", &vsnd->card, errp);
+    if (!AUD_register_card("virtio-sound", &vsnd->card, errp)) {
+        return;
+    }
 
     /* set default params for all streams */
     default_params.features = 0;
-- 
MST


