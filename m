Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D67BDDAF
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpq2H-0001hY-EV; Mon, 09 Oct 2023 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpq2B-0001fZ-U7
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:10:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qpq28-0004AD-6j
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:10:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so43792435e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696857050; x=1697461850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b3CGzq2N9bRGbRcWI3hWghCnKaONhewEtm+3ihpADCA=;
 b=Ozxl2tTuwQU1G16Oq/qZZOb+DgVOBXEezGHdmF1efzHm8Sp8nJ3nZrikVPBceyWyVC
 503H4OEaN+LyWHztrOERkzgTmiroyObSNqcpoI//cqNNztNLbhEbFBfK8fG2VOZnKFUa
 RRvPrrz21s836LJiFLq3lwzZEIPDCjZesfH/hDX7JRYnj5U91xPT/VGhvkHzZ2zNleY7
 BZYPqAiX5Zo0IjA6YfbC+0rkYVEuDHgzqSO0qoTHm5tacml5DV/GGAMVLZWfaJlF6vBy
 TAMvxzT9+MJ6ii3SDtjNwFb3VL6xwSpvdzbAqDKiu6uGe/Dw4cgzF8dz9b0QHe3+lJ+g
 tPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696857050; x=1697461850;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b3CGzq2N9bRGbRcWI3hWghCnKaONhewEtm+3ihpADCA=;
 b=vqmJCyeE6xWqGGG/gzUxGZHbOCfzx3PX3IUVT6S3NUsgs5AX5edAnwXYODHcvOV69s
 uh/u3y8NxVEGthOhzFzsA/HUZfxtrlA3EF8TAPovSvRKVaapP5sUSzuvcRrXPD19HuEW
 oIkL+6qEdQxgad9lpVZbpLLOdaUmjhJuK060YXKt5YNCxakbwAkuR5oxLi9NYwHZMQl3
 w6MzrXEGVFcPFBS3MN2vS75HKUTMm2PcTYXLm3m1973e6pSMbcMrGTQsg+JB/JUyVDM1
 3wW8cvDLa3S/DZbJGTrrSI80+W/znXlzCjWSNhUTYFi6n4bDo/SmdI4/LIjoU3h4IQGt
 4J1w==
X-Gm-Message-State: AOJu0YzYTtjWZHcR2MGkbw6Rw0z+I+TYhKbQueqKjLECvlXxw6vQ7DIM
 s4R7inUrK2HB5PmIrczDsmG3WEhyuy5Up7O8VMw=
X-Google-Smtp-Source: AGHT+IG3YgzlsthDezKx03xsGw95GhvC5Zbndy9mWXFvDmEydIBJq8sS0BcMlp8eNelDZ4q4mVC+3g==
X-Received: by 2002:a05:600c:2298:b0:406:4573:81d2 with SMTP id
 24-20020a05600c229800b00406457381d2mr13018761wmf.39.1696857049564; 
 Mon, 09 Oct 2023 06:10:49 -0700 (PDT)
Received: from meli.delivery (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b004065daba6casm13486000wmi.46.2023.10.09.06.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:10:49 -0700 (PDT)
Date: Mon, 09 Oct 2023 16:07:08 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
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
Subject: Re: [PATCH v4 2/6] hw/virtio: derive vhost-user-rng from
 vhost-user-base
User-Agent: meli 0.8.2
References: <20231009095937.195728-1-alex.bennee@linaro.org>
 <20231009095937.195728-3-alex.bennee@linaro.org>
In-Reply-To: <20231009095937.195728-3-alex.bennee@linaro.org>
Message-ID: <29j9y.3s4zl7gjb21@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
>diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>index 51c3f97c2d..d0b963199c 100644
>--- a/hw/virtio/meson.build
>+++ b/hw/virtio/meson.build
>@@ -18,8 +18,15 @@ if have_vhost
>     # fixme - this really should be generic
>     specific_virtio_ss.add(files('vhost-user.c'))
>     system_virtio_ss.add(files('vhost-user-base.c'))
>+
>+    # MMIO Stubs
>     system_virtio_ss.add(files('vhost-user-device.c'))
>+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
>+
>+    # PCI Stubs
>     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
>+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RNG'],
>+                         if_true: files('vhost-user-rng-pci.c'))

Is there a reason why the target was moved to system_virtio_ss from 
virtio_pci_ss?

>   endif
>   if have_vhost_vdpa
>     system_virtio_ss.add(files('vhost-vdpa.c'))
>@@ -34,10 +41,8 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-
> specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
> specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
> specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
>-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))

Was this accidental? It's not added anywhere else, only deleted.

>@@ -57,7 +61,6 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', 
> if_true: files('vhost-user-fs-pc
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
>-virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scsi-pci.c'))

Same here

Manos

