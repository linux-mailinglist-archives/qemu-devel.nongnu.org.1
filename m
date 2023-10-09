Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792E7BE176
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:50:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqeR-0000fn-A8; Mon, 09 Oct 2023 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpqeL-0000c5-CC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:50:21 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qpqeI-0002Yp-Fs
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:50:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-405417465aaso43782765e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696859416; x=1697464216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIXU1tIQfEO5O4jUROwjakCAV+8cGPWt76AAUbUDMJI=;
 b=MdxRT1EawZ/vHCvJe1/zN9KeMZ/cyrN5HJCbi2FIUDRkRdnjpaiKrSF3iqbEIzYLcH
 B7htkMHIO0aOC1QmizDDf+UPlfmQgY8B9blF4GPPmtlx5moCSWiIOD5z/DJK+AxSDLVp
 DZ7/7iIkfTr6ikBF7xTGofk8y779eTwWDjbWbB5oJQWICWE25cUCjO14DUgAF4nK8BIZ
 R8P2zlO26kalncgwKnf0VVCGLTq9Gjdr++m3T2U1IVIq9ndCCqdMxXpauj7V2INJoGxL
 t7gr6ParVya7cjvCEv1lNOLW1jPg01Qoz7Mk+CQautcPcXSr/92pN2jaaMR8yxYk1fxz
 S9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859416; x=1697464216;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TIXU1tIQfEO5O4jUROwjakCAV+8cGPWt76AAUbUDMJI=;
 b=M1QJJ+nhEgub0Ml9bquXXEA1GD00bYD1t0QfztIxQDWgC8xXh3jZ6B7gQ1vKq00uas
 /rfu0aiqSF9+Tp+K5JFoweAVJmQ73f9qptqnL1LuMDoias1J2WN6hB5Og4/idHKalQY3
 1/2ofTOH/Zsa52hBXbkXWA+8xLRmTSTMek4F1DBHuvOioStLEPNIhYVaRXG3r6XrUSv4
 Fqz4x3FBfYV7yqPaG1E09iEZ0DGS8J/MhkIGMz2aSPHDabIbR8IHRoOgdfvApekGFS5X
 oAt8lRfNLReJHprLT5ig4RzDrJ2o64fCkAf6jurwOiaIsQa6gvvfacuKRZHo9e2GINMc
 h3KQ==
X-Gm-Message-State: AOJu0Yy7P4Md2J3QGNKSxaLr//PNP7LDjGo8FlcnnxjnXKZ2G8i+deD6
 bzAT6PeTIux8Gme844+Mxlr+6w==
X-Google-Smtp-Source: AGHT+IEVhIH71AodAEIucEd9qbS7iDCWL1mReVuiXKr1JQFxn14KUgY6h951RMqbE/sWxj0s4OKOeg==
X-Received: by 2002:a05:600c:2116:b0:405:4743:de12 with SMTP id
 u22-20020a05600c211600b004054743de12mr14152968wml.21.1696859415864; 
 Mon, 09 Oct 2023 06:50:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm13504537wme.47.2023.10.09.06.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:50:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C87621FFBB;
 Mon,  9 Oct 2023 14:50:14 +0100 (BST)
References: <20231009095937.195728-1-alex.bennee@linaro.org>
 <20231009095937.195728-3-alex.bennee@linaro.org>
 <29j9y.3s4zl7gjb21@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake
 <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, Paolo
 Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>, Viresh Kumar <viresh.kumar@linaro.org>,
 virtio-fs@redhat.com, Gonglei <arei.gonglei@huawei.com>, Markus Armbruster
 <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Raphael Norwitz
 <raphael.norwitz@nutanix.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v4 2/6] hw/virtio: derive vhost-user-rng from
 vhost-user-base
Date: Mon, 09 Oct 2023 14:48:50 +0100
In-reply-to: <29j9y.3s4zl7gjb21@linaro.org>
Message-ID: <87y1gbq50p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Mon, 09 Oct 2023 12:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>>diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
>>index 51c3f97c2d..d0b963199c 100644
>>--- a/hw/virtio/meson.build
>>+++ b/hw/virtio/meson.build
>>@@ -18,8 +18,15 @@ if have_vhost
>>     # fixme - this really should be generic
>>     specific_virtio_ss.add(files('vhost-user.c'))
>>     system_virtio_ss.add(files('vhost-user-base.c'))
>>+
>>+    # MMIO Stubs
>>     system_virtio_ss.add(files('vhost-user-device.c'))
>>+    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('=
vhost-user-rng.c'))
>>+
>>+    # PCI Stubs
>>     system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhos=
t-user-device-pci.c'))
>>+    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_=
RNG'],
>>+                         if_true: files('vhost-user-rng-pci.c'))
>
> Is there a reason why the target was moved to system_virtio_ss from
> virtio_pci_ss?

So we build it once, virtio_pci_ss is still:

  specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci=
_ss)

which means we build it once for every target which is overkill.

>
>>   endif
>>   if have_vhost_vdpa
>>     system_virtio_ss.add(files('vhost-vdpa.c'))
>>@@ -34,10 +41,8 @@ specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', i=
f_true: files('vhost-user-
>> specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virti=
o-pmem.c'))
>> specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost=
-vsock.c'))
>> specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('=
vhost-user-vsock.c'))
>>-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio=
-rng.c'))
>
> Was this accidental? It's not added anywhere else, only deleted.

Oops yes. Didn't mean to delete the in-tree emulation. Will fix.

>
>> @@ -57,7 +61,6 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS',
>> if_true: files('vhost-user-fs-pc
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-c=
rypto-pci.c'))
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virt=
io-input-host-pci.c'))
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-in=
put-pci.c'))
>>-virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-=
pci.c'))
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-=
balloon-pci.c'))
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pc=
i.c'))
>> virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-scs=
i-pci.c'))
>
> Same here
>
> Manos


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

