Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75674E1F3
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwO-0002eo-V4; Mon, 10 Jul 2023 19:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwN-0002Wc-0O
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwJ-0004aQ-HR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gchxlBA+cB22tJPCzqHzEwVhVGuwa/sdVVkoeiXPLUI=;
 b=G2mU1m/X4XbvivAUIsXsvsYRY+yX0mxuj6Jzu7OUBkkVWyv9pdR4e0EIOwsYAnVd3q9/d9
 YpaNPtgveE2SXMzGclktkq9d9JfyMSDCqD4wjfBRSv++9SDBuI5ZTienby34kWlIcfKYEd
 DHqNUU+7Cycy/DLRBtOYttoVrknCHtg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-7o4Kbhw3Mta-FYhKux5faw-1; Mon, 10 Jul 2023 19:04:56 -0400
X-MC-Unique: 7o4Kbhw3Mta-FYhKux5faw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbfc766a78so24389635e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030295; x=1691622295;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gchxlBA+cB22tJPCzqHzEwVhVGuwa/sdVVkoeiXPLUI=;
 b=aGP38018cSoUpKTXNn1rIQ38JFuzRgy/NuqPV5ahUZrA+aWGUCIWi2m/mele0U2hPk
 qIh/ql+UUiWVRziE2eAcBQwUj3UY++8keHEXNlwACP9iVp3I7wg/UJKUemHPkvxLvuTl
 6lKMrDQkO1Wplc8tUhV2MUrUsNaslQwL+SPj/UPxU06/JPDPRSsqankkDiXq8NZiM7bP
 eZrm2S4kAVLQVgZyl8Jae84XqcsqQhpaBpnSMSTuIm1pOCu3J6qlrKu9cWULrGiAcFyE
 23y2erg73bxsWAGZC3/l8EjyeCJCHYpHH8tON4SHX3qMXojvjw7KYx4tMeHd41DqSXGE
 XWGQ==
X-Gm-Message-State: ABy/qLZD2CzGctMhNWBX+Y8LKdhQ3okJ5qOoZqySHl1XjV8gPUKTlAlJ
 8SDxZUeCI9VKyjC3iaklr43gT8FLSaYe3jFWh6aBINi5h2+68R9AhrXdZdr2WFPah+ShHLdxzD/
 5LdVt2WfXhATjxESPGUauE3BGTYrQIKGqqNbYZmy8Y4MrS0jM1Pm7AN+FT/SxFtRYpwXH
X-Received: by 2002:a7b:cbd8:0:b0:3f9:9a93:217f with SMTP id
 n24-20020a7bcbd8000000b003f99a93217fmr11257220wmi.3.1689030294797; 
 Mon, 10 Jul 2023 16:04:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG70jLAfa+GG4erWaNxXLwkJxPxnpjRU9bN9vKPimsTGOTtuhz46IXtj7L3bD+4f/43d0Y1eA==
X-Received: by 2002:a7b:cbd8:0:b0:3f9:9a93:217f with SMTP id
 n24-20020a7bcbd8000000b003f99a93217fmr11257202wmi.3.1689030294415; 
 Mon, 10 Jul 2023 16:04:54 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 a25-20020a1cf019000000b003fbb346279dsm919922wmb.38.2023.07.10.16.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:53 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 51/66] include/hw: document the device_class_set_parent_* fns
Message-ID: <c378e88218c9679d7df8230c9f988b22a6cbdc1a.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Alex Bennée <alex.bennee@linaro.org>

These are useful functions for when you want proper inheritance of
functionality across realize/unrealize calls.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230710153522.3469097-3-alex.bennee@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/qdev-core.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 196ebf6d91..884c726a87 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -952,9 +952,36 @@ void device_class_set_props(DeviceClass *dc, Property *props);
 void device_class_set_parent_reset(DeviceClass *dc,
                                    DeviceReset dev_reset,
                                    DeviceReset *parent_reset);
+
+/**
+ * device_class_set_parent_realize() - set up for chaining realize fns
+ * @dc: The device class
+ * @dev_realize: the device realize function
+ * @parent_realize: somewhere to save the parents realize function
+ *
+ * This is intended to be used when the new realize function will
+ * eventually call its parent realization function during creation.
+ * This requires storing the function call somewhere (usually in the
+ * instance structure) so you can eventually call
+ * dc->parent_realize(dev, errp)
+ */
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
                                      DeviceRealize *parent_realize);
+
+
+/**
+ * device_class_set_parent_unrealize() - set up for chaining unrealize fns
+ * @dc: The device class
+ * @dev_unrealize: the device realize function
+ * @parent_unrealize: somewhere to save the parents unrealize function
+ *
+ * This is intended to be used when the new unrealize function will
+ * eventually call its parent unrealization function during the
+ * unrealize phase. This requires storing the function call somewhere
+ * (usually in the instance structure) so you can eventually call
+ * dc->parent_unrealize(dev);
+ */
 void device_class_set_parent_unrealize(DeviceClass *dc,
                                        DeviceUnrealize dev_unrealize,
                                        DeviceUnrealize *parent_unrealize);
-- 
MST


