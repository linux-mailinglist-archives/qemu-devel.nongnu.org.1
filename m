Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4852774DA00
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:37:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvc-0005t9-Pu; Mon, 10 Jul 2023 11:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvQ-0005lo-Vd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvB-0004jr-JF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso47804215e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003328; x=1691595328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5nrdE1EbWfnKTXnpPgJZ0uBCr/0VA1ZCTtf34qEAwI=;
 b=OrGn7Nwjm+XbE+PNmSMJuXVthHH3ULc6N4kPsnLW92+NTRe49XPenOJcvcj+rac9Pt
 nVKbFaUa4sjJBQ5JMRiOtgrIVvCNWGvOPL1tNcAW4f4tOH/emMZuKxg7rRXyDxt7iER4
 EVh843PUSJyRGBg3xZ2xsIqDnW8rBcSrOAnhBIdapzKLBQsvkCG7acr4Oq+d69200Srw
 WAsJ6ZdhbU8XMqnISdOThSNRm8ngNvfiGC5+pbMHzTRiBD+XPPnMyUiJhMWsDe9+zFNk
 fdGqiHCURsd4iiM3nGDx0bqt3xGWg0iHSBm2E2YXRApK8AGI5dMq9qV0vcb1IsF4Oe5i
 GRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003328; x=1691595328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5nrdE1EbWfnKTXnpPgJZ0uBCr/0VA1ZCTtf34qEAwI=;
 b=Vkt/evEk+WlNCeWHtndPovCzdkEDQ7jeOmtOoU3RJPql67qFm00fhaiYfs5Seyme45
 FxGsUkKJubGZeO+yNcevQgrVw6NTooU/empc1fT1LNnXI4riWbo0NHrPFesNC1jR2nPR
 myJ5HT1saXyhV5LNCYyYXgH66/ezGn4f+28tDWwphg3/8b5ZgLdchqrEGExg+gg2/dU0
 fm/NWisgnM4iudMaX+8zTo1V+UdbX0R5SJ7odTmlwzCXHJdbavd32Qg2EstWzz60D6vI
 +JA08hCEHEVJ+rQvUNe3SvLL7FdoeSLk/coGIWYGH8OWXGxsE7NF3f8kp+x5O9azJyBE
 QJ1A==
X-Gm-Message-State: ABy/qLbVKBwRsXAqrU5Tg+8YeXEMGSAz2u/bsa4mSLxEcyTv2WWp1gjY
 /OToef6myA0EA3iln8YpjGnQ4g==
X-Google-Smtp-Source: APBJJlFS94vJXjvQDDdVVQLTVYH7a8E/Gy9xFX1037O0tVu9QhClYcnwbGbyGPq3m/YAuUQujIjmSA==
X-Received: by 2002:a05:600c:378b:b0:3fb:ffa8:6d78 with SMTP id
 o11-20020a05600c378b00b003fbffa86d78mr8100846wmr.36.1689003327693; 
 Mon, 10 Jul 2023 08:35:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a05600c218e00b003fa96fe2bd9sm10643485wme.22.2023.07.10.08.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68AF61FFBD;
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
Subject: [PATCH v3 02/20] include/hw: document the device_class_set_parent_*
 fns
Date: Mon, 10 Jul 2023 16:35:04 +0100
Message-Id: <20230710153522.3469097-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710153522.3469097-1-alex.bennee@linaro.org>
References: <20230710153522.3469097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These are useful functions for when you want proper inheritance of
functionality across realize/unrealize calls.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2


