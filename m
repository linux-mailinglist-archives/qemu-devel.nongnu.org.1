Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664774E1F9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwi-00049C-JZ; Mon, 10 Jul 2023 19:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwe-0003ZA-Ed
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwP-0004oi-Re
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6owJwf2FkV6CUX/2hjmF+Amv1PF8cnNyFJlq3/wOoXQ=;
 b=HVD60UHH9nAcwMaoqc0sX0nl22LcovFePQrzwuaoZsUsnh2N135mFJQ5nyMQuEHNbQ3i82
 kGFN3/41LugFkwXoix1VzHeXZWAmq+NbfoUbouAalNXNlAelsjsxA1EiWYf2ELMuPTN/G1
 4qV5hEgsIKfc8kOcamU/bqLAp/ExOCk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-OedXWG-nMO6ol65hFNEDpg-1; Mon, 10 Jul 2023 19:05:08 -0400
X-MC-Unique: OedXWG-nMO6ol65hFNEDpg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3141c6f4173so2720879f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030306; x=1691622306;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6owJwf2FkV6CUX/2hjmF+Amv1PF8cnNyFJlq3/wOoXQ=;
 b=fmC8WpDUgGbNz9JZl2Zmo6/kXbY51TgsIVIfBnH6/18FBudEki7YGh6OCzR8G7WfSf
 jN2B9d33XRrD2Iek0qyEswbDK/lsdacwvvRxAYDQbqOVwOQaMF++JwTsRIpB16WWEll9
 f4e1h+V2Mple7a95lpjmn0MqbTw3aCEFwhEyPRX1WByvShcRI1P2fgVFFgVH7chmwGF7
 pWLP8TWAP5EOGBcS1626Fo4at9gW/lWm7lkOWOUv0s9FFJg2oIsmJiaSHroVIIKjq+JT
 uGloPlVzjqXHOXm+0PQs8FtLSkTjVniNPtUojtAJEod0tFO2o7PTrwzHww7C1QNnU81j
 qEIA==
X-Gm-Message-State: ABy/qLY8gEdbEJyUdnaiDKWmqB+ThlzVXCYr59RVi3s/JV+GFPuiqL+V
 Dj70mk/HzIJ/wnfVDCBD53cEDLPgq7E6BbS1bZNxCMUvMfpst9ef6hhC3BFBztues0ceL6jgB3D
 o/y0E1A0uCWPjxzth7AdvrYKRWU9sAIdJ9CwunoYQGub4/zA4WcDfQBQ5yEl3kgdSq/HB
X-Received: by 2002:adf:ec0e:0:b0:313:e57b:e96d with SMTP id
 x14-20020adfec0e000000b00313e57be96dmr11872738wrn.36.1689030305907; 
 Mon, 10 Jul 2023 16:05:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFt5rvvgvkeRDAg22sUJmuXzlGhQ2HP2/ZnZYrWG1YNLWdE7ak+ZMIX2kIpW8x8iOnIhiH0Aw==
X-Received: by 2002:adf:ec0e:0:b0:313:e57b:e96d with SMTP id
 x14-20020adfec0e000000b00313e57be96dmr11872727wrn.36.1689030305703; 
 Mon, 10 Jul 2023 16:05:05 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 c3-20020a5d4cc3000000b00311299df211sm578797wrt.77.2023.07.10.16.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:05 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 55/66] include/hw/virtio: document some more usage of notifiers
Message-ID: <661dee7bd08dd93d15b898d43821bb46b2aa422c.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Alex Bennée <alex.bennee@linaro.org>

Lets document some more of the core VirtIODevice structure.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-7-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 631490bda4..c8f72850bc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -150,10 +150,18 @@ struct VirtIODevice
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
+    /**
+     * @user_guest_notifier_mask: gate usage of ->guest_notifier_mask() callback.
+     * This is used to suppress the masking of guest updates for
+     * vhost-user devices which are asynchronous by design.
+     */
     bool use_guest_notifier_mask;
     AddressSpace *dma_as;
     QLIST_HEAD(, VirtQueue) *vector_queues;
     QTAILQ_ENTRY(VirtIODevice) next;
+    /**
+     * @config_notifier: the event notifier that handles config events
+     */
     EventNotifier config_notifier;
     bool device_iotlb_enabled;
 };
-- 
MST


