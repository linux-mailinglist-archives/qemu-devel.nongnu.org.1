Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE97F0B75
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:38:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4w2W-0000Ce-0W; Sun, 19 Nov 2023 23:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2U-0000CP-26
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:38 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r4w2S-00039U-Gj
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:37:37 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso3538354b3a.1
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 20:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700455055; x=1701059855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBpKSrlAkKXf6rultbFnaIQsV4HRFQIvdhScRurtvXE=;
 b=tG+peU1gAYKohDfr3AczmxcmznhUpxaBzDn0UkBYwW6uh6VJdyEIEqIwyCzg2ot3XS
 fJF3LxeBx01fHFhrHchH3xlTaroii/z3pBrda9JRpXePMpG/jKTihjWlFZXtscfPbeZj
 7grZFBLVxfh13nU5Vpt/x1plRYbzqBS1Upis6sKE91bOH3AG8b2+nRoinf4xd8MBar9Q
 fVP9PxZBG9C27ubbdB5iJ3nTWiMGnBc2fkkbJovVL4vGnI1D6NH85YkuihyNY1PAtWAW
 Kzop/jWav0KrFMPP8XVFYy5hUbfNojDUcItSoxJpsaNfpP45D6o3WICS2L7mvok+Cv0U
 FX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700455055; x=1701059855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBpKSrlAkKXf6rultbFnaIQsV4HRFQIvdhScRurtvXE=;
 b=XJvLEwC/Kn23l11KyRJzTTQuGu+KN+xIw3QHynbTXiGV7RQP/YL8+ql60ktInSFlFO
 V8ejFT//tPjLBTqSGnR/wb86k/ooizDKj+kK3TvElHDym1J7ESn6apgvTJQUkP/2HyE/
 nFPD53Cgr2PTDmBjq1AnzLPlwQmFdI5Fk5nwHCPDlBoDy7BCYP0YfP1WCTjuEo8sm3Cu
 02SuHWD2GOdz6kHXk3NXNBpKIihyKPCXcpu+tDico8h94n+0/CFbn6eBHrRH5BkRprAX
 bC6qKhxFWKSroj4CJ2NT4kCZyUh9LbVFuxhiSJ3UGu+3RPKZUREPsMnHRfOdELwwrvnu
 omiQ==
X-Gm-Message-State: AOJu0YzSPm7WvWzLYFAmJg10Ou+TQbqwMcoPnfSYLXI0ayUubsn/fyf2
 HeXoDLKR8pfKIqSSzF3LzUu7T8L8OMtBPMrW3EgXfeApW62IdQ==
X-Google-Smtp-Source: AGHT+IGXaQnJLLeaQPf5m2PAm+A6qaw0QdyU0Flpt/fZj/G8hsP9S+VcSiRLFwY+Gsht/re1bOnu+g==
X-Received: by 2002:a05:6a20:938e:b0:15d:b407:b0a0 with SMTP id
 x14-20020a056a20938e00b0015db407b0a0mr8477856pzh.26.1700455055031; 
 Sun, 19 Nov 2023 20:37:35 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-202.hinet-ip.hinet.net.
 [211.75.219.202]) by smtp.gmail.com with ESMTPSA id
 s41-20020a056a0017a900b006926d199fdcsm5035991pfg.190.2023.11.19.20.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 20:37:34 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/4] hw/virtio: Support set_config() callback in
 vhost-user-base
Date: Mon, 20 Nov 2023 12:37:18 +0800
Message-Id: <20231120043721.50555-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120043721.50555-1-leo.yan@linaro.org>
References: <20231120043721.50555-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=leo.yan@linaro.org; helo=mail-pf1-x430.google.com
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

The Virtio input device invokes set_config() callback for retrieving
the event configuration info, but the callback is not supported in
vhost-user-base.

This patch adds support set_config() callback in vhost-user-base.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-user-base.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 78cfa9a5bb..a83167191e 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -140,6 +140,22 @@ static void vub_get_config(VirtIODevice *vdev, uint8_t *config)
     }
 }
 
+static void vub_set_config(VirtIODevice *vdev, const uint8_t *config_data)
+{
+    VHostUserBase *vub = VHOST_USER_BASE(vdev);
+    int ret;
+
+    g_assert(vub->config_size && vub->vhost_user.supports_config == true);
+
+    ret = vhost_dev_set_config(&vub->vhost_dev, config_data,
+                               0, vub->config_size,
+                               VHOST_SET_CONFIG_TYPE_FRONTEND);
+    if (ret) {
+        error_report("vhost guest set device config space failed: %d", ret);
+        return;
+    }
+}
+
 /*
  * When the daemon signals an update to the config we just need to
  * signal the guest as we re-read the config on demand above.
@@ -337,6 +353,7 @@ static void vub_class_init(ObjectClass *klass, void *data)
     vdc->unrealize = vub_device_unrealize;
     vdc->get_features = vub_get_features;
     vdc->get_config = vub_get_config;
+    vdc->set_config = vub_set_config;
     vdc->set_status = vub_set_status;
 }
 
-- 
2.39.2


