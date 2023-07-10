Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3C74D9FC
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsvO-0005ip-TF; Mon, 10 Jul 2023 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvM-0005ha-AD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qIsvG-0004lk-3A
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:35:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so47533885e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689003330; x=1691595330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMtJa+hYr6z5Kv+bBMUl2RqQsO6glkaKRsQk48984cQ=;
 b=sDe6ctuBgcDWCsfWevwenPhgSZyso/28vlWvRb4lgnBGZcnReLxEHyKxPSy9Fs3Dh7
 Qens4omJTbJYj+JQmE2PTQtoVeyNwLE9b1zmowPRdkvFFvYbWFWzqnNLmWjGHpaXG1h9
 ocp5v4d0fhG4yOEKpQ5ykvguh+x47rohxhTiJTeadNdnieVAcnEq40hbPeYOVrpZpjj1
 mHPzyHS1sefKNd/2WMc9FY6zsTCouFTXOhoxmfNM8oBU4Gk59bbZLXO3cQTratn3DuOL
 UUViAmtCLvNlxeSZPV+0dH1Hh6Bj6AfsbCVKo/6YxcmBNpzhVyvouB8zpCELK7N6uhFD
 Hllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003330; x=1691595330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMtJa+hYr6z5Kv+bBMUl2RqQsO6glkaKRsQk48984cQ=;
 b=O0D+eAiV15BsoAmMNFpar7xADG/Js7x2O9P597+pXAIlhuk1tNUP1l1J0fxvLSeYY+
 OuATjt4cGOxpybnaQQ+Nv93DSpC7utPUcoUX0amFcx9ivQjMTE8GhG0QS/6cfLfz5WuP
 Om2fYoWalu1IXdN+4AR4xk1cvUkx4tnQ0YlfqvJGH0W+TwikT0ysby5wUpyKJVPUW8+b
 WTqfywNM4rMobj1eRhQo9NBQvA9wOoos7KQHruVmNN797nHqMZRQ9p9x3ZceGeILv6Ok
 WpUaiKZfgLNuX+nl5S+Hr3vxuuiRmHDPysnHi2T2pBy7lVI4SpC8lSe8skyh2YUbPVsX
 2FlQ==
X-Gm-Message-State: ABy/qLYpATz5nZMFphuHBmT4ZLS6us9XWBsEGlraq439B2LZrOvmGyqq
 s3TZ1fCAVWhz57qMRqkQQWB1cw==
X-Google-Smtp-Source: APBJJlFpxRO1NtHN+W2zGl/1NWv3luHzvjZ0w2nux/I+BPFRjLD1krpCiiTwLBDjP5BSx0DFz339tQ==
X-Received: by 2002:a7b:cb97:0:b0:3fa:93b0:a69c with SMTP id
 m23-20020a7bcb97000000b003fa93b0a69cmr10757760wmi.24.1689003330640; 
 Mon, 10 Jul 2023 08:35:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a7bce95000000b003fc06169abdsm211102wmj.2.2023.07.10.08.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:35:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF5B61FFC0;
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
Subject: [PATCH v3 05/20] include/hw/virtio: add kerneldoc for virtio_init
Date: Mon, 10 Jul 2023 16:35:07 +0100
Message-Id: <20230710153522.3469097-6-alex.bennee@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/virtio/virtio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 0671989383..631490bda4 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -219,6 +219,12 @@ struct VirtioDeviceClass {
 void virtio_instance_init_common(Object *proxy_obj, void *data,
                                  size_t vdev_size, const char *vdev_name);
 
+/**
+ * virtio_init() - initialise the common VirtIODevice structure
+ * @vdev: pointer to VirtIODevice
+ * @device_id: the VirtIO device ID (see virtio_ids.h)
+ * @config_size: size of the config space
+ */
 void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size);
 
 void virtio_cleanup(VirtIODevice *vdev);
-- 
2.39.2


