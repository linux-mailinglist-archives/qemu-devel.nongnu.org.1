Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3374D9F8
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvJ-0005cN-Lt; Mon, 10 Jul 2023 11:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvB-0005Yn-9s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsv8-0004hm-7X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso51841975e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003324; x=1691595324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VTCVQrd6KCn5j7u4ggdRsXsalHDUZEasAWYhlhI0Zk=;
 b=j+WDoZ1iK16umdVplpNjyby+C0HXEitODI37kGwJGXP8HLOVKe7rt/a/fw7jXjba2v
 zs1wAHlxk/Q0gaA1/EiJk1gIej/DaDqErNIuRsyn+V1aYx2zPQYHF82wztebpRwOgDdR
 wDqaRu8ZbrT7AmcnqHRt5hh/t3t9ctn/KE0KuSYJ1MRNrZYGPsAaBSC6EWxhxA/ELSah
 ssLutXIIMBRxXlihjutw4bgwVOv+fE2at4V0BKhYv7N3unwblarbHdJ1Zs11Q/JzVm2K
 nGkk3S7WpCKhBVvOhtq0iL4/XKlTn9C4IYBO7y1oNaY9ibZp27R/VNPsJVXR0gDmkWip
 wm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003324; x=1691595324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VTCVQrd6KCn5j7u4ggdRsXsalHDUZEasAWYhlhI0Zk=;
 b=AQD3k3NJI4QZDDSXZWhBxuBdCOMOFg1uIOjfFmtT6iFhCMeCbi/ZqmKZ8I7ZoYu0uF
 zA0jGhy8ZF/aQ0B0C2CN9y+s6gl9MK74/Hsi09RB5W0Z2gA5bCJjih9+Iyurx1ouhaRk
 8ZTvbLij1sq9H0iAmYNqzsHJD5RatWQuERiV2Oi3IjB95e8GXcqUsYWJ3VGXJjv7/U7D
 I5XCetaNfmxxmXNTu/ScdXIQG0TGLoH/p6XZ1nh27zsMbBt9EVJuxJ08To5NYEypXTn7
 XNmIdoPVeS+DUhsoU+vPK7SpHXexSizg31mzIRmJ0vCseKtgyBSR8BcZOdMeDrRC8BmH
 O/Aw==
X-Gm-Message-State: ABy/qLZOQFYa9ahz9KR5bvVLJgl+V798ywzjpl/rdKvHorpgX6Y5OLir
 lVvekAP0LwC6i+honSiuL6VBEw==
X-Google-Smtp-Source: APBJJlEThPLrtI5HSKaHJF1TiH1gVbvq3vXCOdS8Kz0qgOEn1E4yhSkoRSWHPcnOasGQn2bBeHeE4w==
X-Received: by 2002:a1c:7502:0:b0:3f8:fc96:6bfd with SMTP id
 o2-20020a1c7502000000b003f8fc966bfdmr11967928wmc.17.1689003324449; 
 Mon, 10 Jul 2023 08:35:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a7bcc13000000b003fa973e6612sm10709182wmh.44.2023.07.10.08.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 503791FFBC;
 Mon, 10 Jul 2023 16:35:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Schilling <erik.schilling@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 01/20] include: attempt to document device_class_set_props
Date: Mon, 10 Jul 2023 16:35:03 +0100
Message-Id: <20230710153522.3469097-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I'm still not sure how I achieve by use case of the parent class
defining the following properties:

  static Property vud_properties[] = {
      DEFINE_PROP_CHR("chardev", VHostUserDevice, chardev),
      DEFINE_PROP_UINT16("id", VHostUserDevice, id, 0),
      DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
      DEFINE_PROP_END_OF_LIST(),
  };

But for the specialisation of the class I want the id to default to
the actual device id, e.g.:

  static Property vu_rng_properties[] = {
      DEFINE_PROP_UINT16("id", VHostUserDevice, id, VIRTIO_ID_RNG),
      DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
      DEFINE_PROP_END_OF_LIST(),
  };

And so far the API for doing that isn't super clear.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/qdev-core.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 06cadfc492..196ebf6d91 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -926,6 +926,15 @@ BusState *sysbus_get_default(void);
 char *qdev_get_fw_dev_path(DeviceState *dev);
 char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *dev);
 
+/**
+ * device_class_set_props(): add a set of properties to an device
+ * @dc: the parent DeviceClass all devices inherit
+ * @props: an array of properties, terminate by DEFINE_PROP_END_OF_LIST()
+ *
+ * This will add a set of properties to the object. It will fault if
+ * you attempt to add an existing property defined by a parent class.
+ * To modify an inherited property you need to use????
+ */
 void device_class_set_props(DeviceClass *dc, Property *props);
 
 /**
-- 
2.39.2


