Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 531007BCE44
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 14:02:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpST5-0005te-Us; Sun, 08 Oct 2023 08:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpST3-0005tB-H4
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 08:01:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpSSy-0000Ua-Jk
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 08:01:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so3559743f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696766458; x=1697371258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BTUGhTt7YvfaHjG+AkUNaJ/r8WLsMqAzTWKqgysdkr0=;
 b=DrAkQT/aUE7gqPBwH41iEZ+ungVS37IiHqtuOHbwizjIlUPm2ZIbJktU2QBXirgzwR
 eR58tK8SgUbAPVldm6OSyorOZQ5UmSNchezoDp5T/IopE43GviPpvcys7I8f/CN7yKPd
 niu8VfktXLT3Q+ke4uEQsncStM9Xql2YOFeRVtoct23wtbrhviXp7jg0sCn23i6qQODX
 d8bKVK13edUaoNNBeyN4iKOrS/y/vB9elnOufZ4MjbRYiqrnvxGpuWrjaeWWp8tysHuk
 WmItZqjoPAT6csWzzje8Dki7E6TWnmbFoqp+l5rOa7vhK9PlbypL0gXqUeaNUQeVMElX
 K3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696766458; x=1697371258;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BTUGhTt7YvfaHjG+AkUNaJ/r8WLsMqAzTWKqgysdkr0=;
 b=fFZ9vja7CSwIMtQse6byVtriR9nzCgE/NrDcsl3EArqDc29qLUH53mvtuxdcw2t+E0
 jU5lYpODWRIyAjdcLDHFl5rzLB1JJALklgh+2xzXvM708rbkZZmvrYiAXtzx+PwWBTIc
 r/xssws6WJK/KY8YJ6RtfjUBHg3TeUFy/Y4/TwLKZDFCnBsLEMf78C7nD6nlHaa5QR90
 mD4zHTNquRrM+pRdWm7fofQQxVd9nefdBg8krooGWRdQxkwmHde1w/QAP9AcgP1Arsyf
 TKKDxdyK0MXaNfuXec8sAqoZumWcJl/BfoRtzvz+e5x17DTFmKm431YOjP0WrkYZSVMW
 P8wQ==
X-Gm-Message-State: AOJu0Yw/Fi9nCNl+h2c7yYWFmRPlMd7PMp3e9cM3aUYStEmzp8EYwIOx
 6O5LmxYAdz2exgbWM8FOgXDHeg==
X-Google-Smtp-Source: AGHT+IGkNbfUjSEGg7Swme9O5NsVkpZ8d9pJEGd/YHcgULS0ujkdUSdMKqj+lhNYQHK1AOpk8JzcBg==
X-Received: by 2002:a05:6000:10c7:b0:31f:f893:e07f with SMTP id
 b7-20020a05600010c700b0031ff893e07fmr11395676wrx.12.1696766458120; 
 Sun, 08 Oct 2023 05:00:58 -0700 (PDT)
Received: from meli.delivery (adsl-194.37.6.162.tellas.gr. [37.6.162.194])
 by smtp.gmail.com with ESMTPSA id
 k17-20020adff291000000b003143867d2ebsm6634219wro.63.2023.10.08.05.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 05:00:57 -0700 (PDT)
Date: Sun, 08 Oct 2023 13:46:09 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org
Cc: Li Feng <fengli@smartx.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v7 3/5] vhost-user-scsi: support reconnect to backend
User-Agent: meli 0.8.2
References: <20231008091220.870171-1-fengli@smartx.com>
 <20231008091220.870171-4-fengli@smartx.com>
In-Reply-To: <20231008091220.870171-4-fengli@smartx.com>
Message-ID: <27ldj.4hqzhrkvm1st@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Li, I have some trivial style comments you could possibly address 
in a next version:

On Sun, 08 Oct 2023 12:12, Li Feng <fengli@smartx.com> wrote:
>diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>index df6b66cc1a..5df24faff4 100644
>--- a/hw/scsi/vhost-user-scsi.c
>+++ b/hw/scsi/vhost-user-scsi.c
>@@ -39,26 +39,56 @@ static const int user_feature_bits[] = {
>     VHOST_INVALID_FEATURE_BIT
> };
> 
>+static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>+{
>+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>+    int ret;
>+
>+    ret = vhost_scsi_common_start(vsc, errp);
>+    s->started_vu = (ret < 0 ? false : true);

-+    s->started_vu = (ret < 0 ? false : true);
++    s->started_vu = !(ret < 0);

> static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t 
> status)
> {
>     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
>+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;

-+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
++    DeviceState *dev = DEVICE(vdev);

>+static int vhost_user_scsi_connect(DeviceState *dev, Error **errp)
>+{
>+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>+    VHostUserSCSI *s = VHOST_USER_SCSI(vdev);
>+    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>+    VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
>+    int ret = 0;
>+
>+    if (s->connected) {
>+        return 0;
>+    }
>+    s->connected = true;
>+
>+    vsc->dev.num_queues = vs->conf.num_queues;
>+    vsc->dev.nvqs = VIRTIO_SCSI_VQ_NUM_FIXED + vs->conf.num_queues;
>+    vsc->dev.vqs = s->vhost_vqs;
>+    vsc->dev.vq_index = 0;
>+    vsc->dev.backend_features = 0;
>+
>+    ret = vhost_dev_init(&vsc->dev, &s->vhost_user, VHOST_BACKEND_TYPE_USER, 0,
>+                         errp);
>+    if (ret < 0) {
>+        return ret;
>+    }
>+
>+    /* restore vhost state */
>+    if (virtio_device_started(vdev, vdev->status)) {
>+        ret = vhost_user_scsi_start(s, errp);
>+        if (ret < 0) {
>+            return ret;
>+        }
>+    }
>+
>+    return 0;
>+}


-+    if (virtio_device_started(vdev, vdev->status)) {
-+        ret = vhost_user_scsi_start(s, errp);
-+        if (ret < 0) {
-+            return ret;
-+        }
-+    }
-+
-+    return 0;
-+}
++    if (virtio_device_started(vdev, vdev->status)) {
++        ret = vhost_user_scsi_start(s, errp);
++    }
++
++    return ret;
++}

[skipping..]

>+static int vhost_user_scsi_realize_connect(VHostUserSCSI *s, Error **errp)
>+{
>+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;


-+    DeviceState *dev = &s->parent_obj.parent_obj.parent_obj.parent_obj;
++    DeviceState *dev = DEVICE(s);

>diff --git a/include/hw/virtio/vhost-user-scsi.h b/include/hw/virtio/vhost-user-scsi.h
>index 521b08e559..b405ec952a 100644
>--- a/include/hw/virtio/vhost-user-scsi.h
>+++ b/include/hw/virtio/vhost-user-scsi.h
>@@ -29,6 +29,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserSCSI, VHOST_USER_SCSI)
> struct VHostUserSCSI {
>     VHostSCSICommon parent_obj;
>     VhostUserState vhost_user;
>+    bool connected;
>+    bool started_vu;
>+
>+    struct vhost_virtqueue *vhost_vqs;

 +    bool connected;
 +    bool started_vu;
-+
 +    struct vhost_virtqueue *vhost_vqs;

See https://www.qemu.org/docs/master/devel/style.html#qemu-object-model-declarations

The definition should look like:

struct VHostUserSCSI {
    VHostSCSICommon parent_obj;

    /* Properties */
    bool connected;
    bool started_vu;

    VhostUserState vhost_user;
    struct vhost_virtqueue *vhost_vqs;
}

