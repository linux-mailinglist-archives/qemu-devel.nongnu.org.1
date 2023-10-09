Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B457BE0FD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:46:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqZx-0005oy-FY; Mon, 09 Oct 2023 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpqZa-0005nc-CS
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:45:30 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpqZV-0001Se-Ae
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:45:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so44034395e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696859119; x=1697463919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t1DiSb0LrC9q9htqBj6ofwydaLZ5m4RuEkq7RIb1IZk=;
 b=dRVXSR+PR57LgWrgWw2XylTs1+QYJk61hW+Ek3y4pVBWLikgfeaCzU/9VE1XWXG7q/
 l5XK013/4XjAU2mTK3vblkdi0dWCGfdVDkMLIEZSb1MSMmRvmdhSBXwrJk84rKvwVz+Y
 znbwuygly5xcfrtWWehW0Jv8D+nJvmLi+me4B8w/i3zPDrAXIW6bxxkVTQ7DjIhpbbEQ
 ys7hOf932OlauzXfUVhzZOH3ULSXoBtk+6gJfQSqadRIHXTeiV8X6BhMevDxg+dGawNA
 UXZGJ+CkwyGzO17pslkq8v9P5dxx2wHAe6r5Lxz+JQd79V4LIcU6p4YcMlnhB+M/T6m1
 w0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859119; x=1697463919;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t1DiSb0LrC9q9htqBj6ofwydaLZ5m4RuEkq7RIb1IZk=;
 b=ZuCyLeT0CziF1GyER0Ic0oPxgg6zFhVISWrPOhwHSt4d+crzpW5xOVZPy9FBq5bFD4
 xzfRHSvDuIJgEGexTy4z3giI2puGKNcCnIBear/V1aKYSgu8jBBiYayEA82MdzTItuxg
 +FpXU6ipOWg/GdGA6dwv4mTGNF1QbHm06tpuV/NItq89PIN6Zx1KpkI5wzMgxgZrA03X
 M2++IX4YHtqYavs1lyDSev9Haskz0TPKcbEfnIHDaSEZXH+oumf+6YZsmv+virYK3tz/
 T//iTtHkuHiPMNso0p/ASHEHZDN2JfO//4uN5x+UYILFqGg+ACktT96HBUR28hcKElzN
 Zhjw==
X-Gm-Message-State: AOJu0Yy0ZHqorjhQHGitbGB7LqWAHnJ5Lx/qlXVSbRAy3eWbNeOY7YP1
 DAH5gxrPe1bq1KG7hLBhBtLnsw==
X-Google-Smtp-Source: AGHT+IHkiZiEqeCekzIVAZDZEi4kWav2d4EIbXJUEUA1wqPeGzY9uMy1glOMvPfMg6gKmxjS57dv9g==
X-Received: by 2002:a7b:c5c9:0:b0:403:272:4414 with SMTP id
 n9-20020a7bc5c9000000b0040302724414mr13673195wmk.0.1696859119083; 
 Mon, 09 Oct 2023 06:45:19 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 9-20020a05600c020900b003feea62440bsm11179448wmi.43.2023.10.09.06.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:45:18 -0700 (PDT)
Date: Mon, 09 Oct 2023 16:38:32 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Viresh Kumar <viresh.kumar@linaro.org>, virtio-fs@redhat.com,
 Gonglei (Arei) <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Subject: Re: [PATCH v4 6/6] docs/system: add a basic enumeration of vhost-user
 devices
User-Agent: meli 0.8.2
References: <20231009095937.195728-1-alex.bennee@linaro.org>
 <20231009095937.195728-7-alex.bennee@linaro.org>
In-Reply-To: <20231009095937.195728-7-alex.bennee@linaro.org>
Message-ID: <29kvg.2djvd962r2cx@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Mon, 09 Oct 2023 12:59, Alex Bennée <alex.bennee@linaro.org> wrote:
>diff --git a/docs/system/devices/vhost-user.rst 
>b/docs/system/devices/vhost-user.rst
>index a80e95a48a..0f9eec3f00 100644
>--- a/docs/system/devices/vhost-user.rst
>+++ b/docs/system/devices/vhost-user.rst
>@@ -15,6 +15,47 @@ to the guest. The code is mostly boilerplate although each device has
> a ``chardev`` option which specifies the ID of the ``--chardev``
> device that connects via a socket to the vhost-user *daemon*.
> 
>+Each device will have an virtio-mmio and virtio-pci variant. See your
>+platform details for what sort of virtio bus to use.
>+
>+.. list-table:: vhost-user devices
>+  :widths: 20 20 60
>+  :header-rows: 1
>+
>+  * - Device
>+    - Type
>+    - Notes
>+  * - vhost-user-device
>+    - Generic Development Device
>+    - You must manually specify ``virtio-id`` and the correct ``num_vqs``. Intended for expert use.

May be worth specifying they are `VHostUserBase` interface fields since 
it's not directly obvious if you come across this before reading the 
vhost-user-device code.

>+  * - vhost-user-blk
>+    - Block storage
>+    -
>+  * - vhost-user-fs
>+    - File based storage driver
>+    - See https://gitlab.com/virtio-fs/virtiofsd
>+  * - vhost-user-scsi
>+    - SCSI based storage
>+    - See contrib/vhost-user/scsi
>+  * - vhost-user-gpio
>+    - Proxy gpio pins to host
>+    - See https://github.com/rust-vmm/vhost-device
>+  * - vhost-user-i2c
>+    - Proxy i2c devices to host
>+    - See https://github.com/rust-vmm/vhost-device
>+  * - vhost-user-input
>+    - Generic input driver
>+    - See contrib/vhost-user-input
>+  * - vhost-user-rng
>+    - Entropy driver
>+    - :ref:`vhost_user_rng`
>+  * - vhost-user-gpu
>+    - GPU driver
>+    -
>+  * - vhost-user-vsock
>+    - Socket based communication
>+    - See https://github.com/rust-vmm/vhost-device
>+

There's also:

- hw/virtio/vhost-user-scmi.c
- hw/virtio/vhost-user-snd.c

