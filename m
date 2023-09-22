Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD07AAE28
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVy-0004nw-VJ; Fri, 22 Sep 2023 05:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVp-0004lk-Ct
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVn-0003Nq-92
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4aZIa2PSQ4iemAt8feI7jH/a2bDufHqmAyu5oMZZBw=;
 b=VGZPgvpMlB9CVraeRPqfV6ZfWIAmyswUMSm4HEpmY6pDZO9LfdLMp7FHjrJefMulda31J1
 fFnAX4lUdy2AfFEjQgUqm8SVueSz87VCl3HEkkRHX3plG/J2pIIfIJ5YvJAy2IiQwCcYOa
 0ue3mIlil1cuk3h67sDWeKRCDeVsB0w=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Ow_j-ZOqPxqhUHwnNZN7yA-1; Fri, 22 Sep 2023 05:31:44 -0400
X-MC-Unique: Ow_j-ZOqPxqhUHwnNZN7yA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5033420dd31so2367058e87.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375102; x=1695979902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4aZIa2PSQ4iemAt8feI7jH/a2bDufHqmAyu5oMZZBw=;
 b=aNKrAixbVaPfBPVvMr7kHUB6A8fuXrQJnOObS4AKeOZX2niMZSUs9UC7k1/FXj4a9S
 h2VkEaTIrmaTOEYCKh3t1MmNkHj+0KQs7+Bop0XLrcm6ozw2h+V1Cq/b/MZQ+TGWyDd2
 BdssIWkdAF8T9sz6au9N4xobwn6HxiOUIhUqDqnDyjSJMdS04uK4THX8KQ8rP/HKLaHk
 kh9vBOpkcnoKpM4fLLMI6jgjOtTM64wN/VBfMB9pDhwHAzBeML8jMl4hwn0PIMyJOTdm
 F4V7qA1U+hG0iuHK/7VNPEpGOuHsAoqaALZheQ/dpE9Xa8LOoz1JLhnmBVOLke2bshHB
 oj7Q==
X-Gm-Message-State: AOJu0YxXeq4VwE/6UCkVb5SV3U4H11sWlW3WJyg+Yw5BzVnWOlSUxN18
 1/1BYyA22jJWEvwPErdkP0u4fTt0/HKRLQH4VXDlPnphg2n5iHaf8qMZLNK6kjLI+bWEZQeq4we
 NbckpEXavdZPyZMdVe54Q5qJ///7V/STIlXiZwNh5Hw2W4alOtmzIosmLqlxqmvObM8saJZ6NlG
 o=
X-Received: by 2002:a05:6512:ea1:b0:501:c3ee:62ec with SMTP id
 bi33-20020a0565120ea100b00501c3ee62ecmr8732246lfb.12.1695375102350; 
 Fri, 22 Sep 2023 02:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwa6TBXl2hxb4RJX8wd/lxTZYttPGiqdahERbG2RZn8rFz8ObTJxBXGny7+YremHhOlfAZcw==
X-Received: by 2002:a05:6512:ea1:b0:501:c3ee:62ec with SMTP id
 bi33-20020a0565120ea100b00501c3ee62ecmr8732225lfb.12.1695375101955; 
 Fri, 22 Sep 2023 02:31:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c464300b0040536dcec17sm3394150wmo.27.2023.09.22.02.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 08/12] hw/display/xlnx_dp.c: Add audiodev property
Date: Fri, 22 Sep 2023 11:31:21 +0200
Message-ID: <20230922093126.264016-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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

From: Martin Kletzander <mkletzan@redhat.com>

There was no way to set this and we need that for it to be able to properly
initialise.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <16963256573fcbfa7720aa2fd000ba74a4055222.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 43c7dd8e9cd..341e91e886f 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1385,6 +1385,11 @@ static void xlnx_dp_reset(DeviceState *dev)
     xlnx_dp_update_irq(s);
 }
 
+static Property xlnx_dp_device_properties[] = {
+    DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xlnx_dp_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -1392,6 +1397,7 @@ static void xlnx_dp_class_init(ObjectClass *oc, void *data)
     dc->realize = xlnx_dp_realize;
     dc->vmsd = &vmstate_dp;
     dc->reset = xlnx_dp_reset;
+    device_class_set_props(dc, xlnx_dp_device_properties);
 }
 
 static const TypeInfo xlnx_dp_info = {
-- 
2.41.0


