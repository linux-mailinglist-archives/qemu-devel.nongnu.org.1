Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98B3709A98
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01TC-00056Z-HS; Fri, 19 May 2023 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Sa-00045K-IH
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01SY-0003hS-Im
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgZez/77CPjISuZkTP4eS35ZBSmaQPk9oC+m6mGfSMg=;
 b=ZFLQQzKe+uUL/isouhgsGMpHtHcgYb0dyLu8yWQRQ6O/2nFL5PLalB7MvLlOeYBulgAZrH
 43ue6kHw4yf3cWgP5fVvUuWydGspDuVyM8rm4YbpPNIRjgXoaWyIEy5t6CA+nH6vqhpF1I
 fleiHIKCLCJ1Dqxp9YT+rJ+7sCfDLU4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Pcf9LbYzOoCmZmKs-c5K4Q-1; Fri, 19 May 2023 10:51:55 -0400
X-MC-Unique: Pcf9LbYzOoCmZmKs-c5K4Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f381431472so2201313e87.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507914; x=1687099914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgZez/77CPjISuZkTP4eS35ZBSmaQPk9oC+m6mGfSMg=;
 b=aC0hUqj6zVqJiIQ47U1trIq2gVsiIoMlDg7GF2c7qjgCIuHpHnQEAl/WfGTs73mXXa
 3bewrnKWHTbUe6jwHrPyTGLk3beLbbHQqeZkqLLpZcd0KTrh8aCnqer6RUMus+p0BwQx
 50arl6OtVV922zBQepim3oRIdxf6OmwYu4s1Idg5fcTJZVSfiOMN9qt1xQnMgqwjzo6f
 SQqdOc19lxD6p5cvIecZ38fi4n/ZO4cs3Sq33zIXYKJFrvA4a84tv4ItAj79/glOneb4
 09h1jk1cACZhuI2IgM4tSMvKxnKDEEQ3Hx7rdVfTQgh+JmfhlMFluoTd5liXCq1U2RtG
 1DNw==
X-Gm-Message-State: AC+VfDzikxwqF5vJ2Wzpx+3h2XzF+01Kfsqe4+3qF7r8VXPRSklD7nR7
 vdxyTuR9VaQeBb/IQxKqUiG0dbeDDRsyGhHW/sL8k+mF4ynqAezoqLvooFdy1UH0L4yPNc0c8w4
 6qWYCqE4kiAakOeG62b7wC1pUoNb0uMv47K16PhXclBGBgUReWEP7PaEmqH3F0Er6jVNG
X-Received: by 2002:a05:6512:15e:b0:4f0:e2:c709 with SMTP id
 m30-20020a056512015e00b004f000e2c709mr1012302lfo.17.1684507913807; 
 Fri, 19 May 2023 07:51:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IgbkPjf95fc+Gveiw6rYCrWOLqg0H9aNHFbpk4MVr/3JkYlhztYUZg+dDLRdghUFlrRFX6Q==
X-Received: by 2002:a05:6512:15e:b0:4f0:e2:c709 with SMTP id
 m30-20020a056512015e00b004f000e2c709mr1012288lfo.17.1684507913415; 
 Fri, 19 May 2023 07:51:53 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 f17-20020a056512093100b004f27cecb68asm625222lft.166.2023.05.19.07.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:52 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cindy Lu <lulu@redhat.com>
Subject: [PULL 25/40] vhost_vdpa: fix the input in
 trace_vhost_vdpa_listener_region_del()
Message-ID: <3d1e4d34a81a212e234f674e57e73c824d4b131a.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Cindy Lu <lulu@redhat.com>

In trace_vhost_vdpa_listener_region_del, the value for llend
should change to int128_get64(int128_sub(llend, int128_one()))

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20230510054631.2951812-3-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index bc6bad23d5..92c2413c76 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -288,7 +288,8 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
     llend = vhost_vdpa_section_end(section);
 
-    trace_vhost_vdpa_listener_region_del(v, iova, int128_get64(llend));
+    trace_vhost_vdpa_listener_region_del(v, iova,
+        int128_get64(int128_sub(llend, int128_one())));
 
     if (int128_ge(int128_make64(iova), llend)) {
         return;
-- 
MST


