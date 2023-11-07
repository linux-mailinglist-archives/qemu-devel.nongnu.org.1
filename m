Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D87E47E6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:10:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QXB-0004TR-I0; Tue, 07 Nov 2023 13:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0QX7-0004G7-Md
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0QWt-0002kT-Ia
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699380622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZeZohe8ha4TDCV0R4kFMwuDMTyB2/5/lVuQvcCzo1l4=;
 b=d2Jsw8bAiBfbXduq8kzqg1NpqC4YqdUjf6fAWm1clijdve9BcblsbWZKYz25Fp493IR4Az
 cOJnOMcp9jpHCbZv8gOF3wLwdD03s15Vts9jneywU/JABTFVjxHB6CBqBwpnzZw6Gzi2N3
 GUsy2OlS/ipsxZrO2U7dgv8eI7FlJkc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-9xlBvNr_P2OU91oM1pJ5tA-1; Tue, 07 Nov 2023 13:10:19 -0500
X-MC-Unique: 9xlBvNr_P2OU91oM1pJ5tA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c6f33ee403so56062961fa.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:10:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699380617; x=1699985417;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeZohe8ha4TDCV0R4kFMwuDMTyB2/5/lVuQvcCzo1l4=;
 b=NSnsn4JzQDvK++DQvxv3uCyLRBUju+5vrGo8U0KyG3nocU1W7C0fv6aduyEKFQKZW4
 dY5DO2pci/bblmrx57Irzg7lr0mIY2wUDNXmvB3/vV0PDNCmbi2Y4Hp/hcDsfRC6sXkn
 wQXdN19ila0kr9mYm4OKvaohg3970GjyiiQ9U2/TNjsR8+d3SbSO3ZdipAnZOvdGuxH3
 dwYvSF5bJOZJ3kGj6QU7AkJaSpsMTOMMWH/qEWF2cM/QtQKflLxRCyKO20J21suP1/Ni
 MysnV+WKWwy/SEKY2kYsB2hDuP+PkKclq+8cMVATpfKP/uZ2vGBdCLNE6rSBAW5PIk2u
 YxyA==
X-Gm-Message-State: AOJu0YwWj4FyDFh7o5+lFDvNkwl8tQ0qL8/wZKiqCa1yvQuSKU+aJwDr
 zdAf/ukoBdH0QzsvIMa/D723pHDfsIH6FuwGdLsB0Aa16Mgu/QYFyq80yENvg1BPH0aKJDvuh4d
 JjwNSkDlzHewxDi8=
X-Received: by 2002:a2e:9d8c:0:b0:2c4:ff2e:d6cd with SMTP id
 c12-20020a2e9d8c000000b002c4ff2ed6cdmr26736860ljj.2.1699380617453; 
 Tue, 07 Nov 2023 10:10:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGczSURi+ehjiv6Cz0XiuBUXPmegd/rvZmUQJV5ThpMeoKqJQWXLOVxPx1rF58ofYEgc8ye2A==
X-Received: by 2002:a2e:9d8c:0:b0:2c4:ff2e:d6cd with SMTP id
 c12-20020a2e9d8c000000b002c4ff2ed6cdmr26736834ljj.2.1699380617093; 
 Tue, 07 Nov 2023 10:10:17 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
 by smtp.gmail.com with ESMTPSA id
 g3-20020adffc83000000b00323293bd023sm2990501wrr.6.2023.11.07.10.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 10:10:15 -0800 (PST)
Date: Tue, 7 Nov 2023 13:09:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 virtio-fs@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v7 7/7] docs/system: add a basic enumeration of
 vhost-user devices
Message-ID: <20231107130708-mutt-send-email-mst@kernel.org>
References: <20231107180246.3456598-1-alex.bennee@linaro.org>
 <20231107180246.3456598-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231107180246.3456598-8-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Nov 07, 2023 at 06:02:46PM +0000, Alex Bennée wrote:
> Make it clear the vhost-user-device is intended for expert use only.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231009095937.195728-7-alex.bennee@linaro.org>
> 
> ---
> v5
>   - split vhost-user-device out of the table
>   - sort the table alphabetically
>   - add sound and scmi devices
> v6
>   - add note re vhost-user-device
> v7
>   - fix patching description
> ---
>  docs/system/devices/vhost-user-rng.rst |  2 +
>  docs/system/devices/vhost-user.rst     | 70 +++++++++++++++++++++++++-
>  2 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/devices/vhost-user-rng.rst b/docs/system/devices/vhost-user-rng.rst
> index a145d4105c..ead1405326 100644
> --- a/docs/system/devices/vhost-user-rng.rst
> +++ b/docs/system/devices/vhost-user-rng.rst
> @@ -1,3 +1,5 @@
> +.. _vhost_user_rng:
> +
>  QEMU vhost-user-rng - RNG emulation
>  ===================================
>  
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> index a80e95a48a..c6afc4836f 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -8,13 +8,81 @@ outside of QEMU itself. To do this there are a number of things
>  required.
>  
>  vhost-user device
> -===================
> +=================
>  
>  These are simple stub devices that ensure the VirtIO device is visible
>  to the guest. The code is mostly boilerplate although each device has
>  a ``chardev`` option which specifies the ID of the ``--chardev``
>  device that connects via a socket to the vhost-user *daemon*.
>  
> +Each device will have an virtio-mmio and virtio-pci variant. See your

and ccw eventually?

> +platform details for what sort of virtio bus to use.
> +
> +.. list-table:: vhost-user devices
> +  :widths: 20 20 60
> +  :header-rows: 1
> +
> +  * - Device
> +    - Type
> +    - Notes
> +  * - vhost-user-blk
> +    - Block storage
> +    - See contrib/vhost-user-blk
> +  * - vhost-user-fs
> +    - File based storage driver
> +    - See https://gitlab.com/virtio-fs/virtiofsd
> +  * - vhost-user-gpio
> +    - Proxy gpio pins to host
> +    - See https://github.com/rust-vmm/vhost-device
> +  * - vhost-user-gpu
> +    - GPU driver
> +    - See contrib/vhost-user-gpu
> +  * - vhost-user-i2c
> +    - Proxy i2c devices to host
> +    - See https://github.com/rust-vmm/vhost-device
> +  * - vhost-user-input
> +    - Generic input driver
> +    - See contrib/vhost-user-input
> +  * - vhost-user-rng
> +    - Entropy driver
> +    - :ref:`vhost_user_rng`
> +  * - vhost-user-scmi
> +    - System Control and Management Interface
> +    - See https://github.com/rust-vmm/vhost-device
> +  * - vhost-user-snd
> +    - Audio device
> +    - See https://github.com/rust-vmm/vhost-device/staging
> +  * - vhost-user-scsi
> +    - SCSI based storage
> +    - See contrib/vhost-user-scsi
> +  * - vhost-user-vsock
> +    - Socket based communication
> +    - See https://github.com/rust-vmm/vhost-device
> +
> +The referenced *daemons* are not exhaustive, any conforming backend
> +implementing the device and using the vhost-user protocol should work.
> +
> +vhost-user-device
> +^^^^^^^^^^^^^^^^^

The distinction between "+vhost-user device" and "vhost-user-device"
will be lost on all but the most astute readers.
I propose to just removing this part for now. Developers can
subclass vhost-user-device just as easily.



> +The vhost-user-device is a generic development device intended for
> +expert use while developing new backends. The user needs to specify
> +all the required parameters including:
> +
> +  - Device ``virtio-id``
> +  - The ``num_vqs`` it needs and their ``vq_size``
> +  - The ``config_size`` if needed
> +
> +.. note::
> +  To prevent user confusion you cannot currently instantiate
> +  vhost-user-device without first patching out::
> +
> +    /* Reason: stop inexperienced users confusing themselves */
> +    dc->user_creatable = false;
> +
> +  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> +  rebuilding.
> +
>  vhost-user daemon
>  =================
>  
> -- 
> 2.39.2


