Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E73774F1BE
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEDi-0003Qv-7P; Tue, 11 Jul 2023 10:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qJEDg-0003Pm-3W
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qJEDe-0004Ab-JG
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689085197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqmkekmoG6/keFALgzR4safhPNaxOvsdD6Ucs2CjxfE=;
 b=DIOrrajUVohsX7loHSrAnD8Q08ztx2ZmY22/JtZwyRVFOEz9RyKzVHQ3zv4o/q6nbFI4AL
 uxN5edXZjml42qxhhKP1OXjcLdU9Oad9XudOlHQD1G19wxsevUwGAnyV8LyrxwGy7fUL/C
 E/rZj2t+EPRuvY4Vd4/swPOFKVJbXtY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-HC0i39vnPvafWR3jUK88fw-1; Tue, 11 Jul 2023 10:19:54 -0400
X-MC-Unique: HC0i39vnPvafWR3jUK88fw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b698377ed7so57271011fa.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689085174; x=1691677174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqmkekmoG6/keFALgzR4safhPNaxOvsdD6Ucs2CjxfE=;
 b=j2WXJWVwnNVG/xCJPvqWMe3mPwU8byoagu7BAC2YqiKvkl+OKa+L/ppCLUgkVgPZQJ
 iZQSp+FyQjEYaXMWrL+KYNg30aXlQqeHTbyFgc5XSVRV8ZtLrCPjkYuE1eYyEF1kUkg8
 Y7ieQrlz8RiZcLPkG6VGtFUwMX/tjZ0JFav9BvDx8G6bmr6XHIy0hmTHoCtrBtuAARFP
 ydvaj7faPytbc40OvI/jfwQV3qL7+1tCodLN4/xgMCcOfcTTmqz8iPM6aGLnuTIsRF1l
 k22p46tzLVtDDgoL6/4KYp83LJJG+XgoRGSiTWTQodAgTngHMfaDC0nRHImrChbHM40d
 nHcw==
X-Gm-Message-State: ABy/qLan6cURIt5QguTtMAuqOMP5MdilaX95W0LACOEH0OCihzBH7/kh
 QdTB8ojLb2ddki9Y+jud3LB9/de1cm+hRj8l6IaC5XbeyuTE41lkLOa+a7duq3vbbm3ypIOKuSD
 ktf98qpVkcq0zLpsW37+UfcuGwaoat08=
X-Received: by 2002:a2e:9196:0:b0:2b6:de52:35a with SMTP id
 f22-20020a2e9196000000b002b6de52035amr14597286ljg.9.1689085174068; 
 Tue, 11 Jul 2023 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGTpeaSG8CKvvgVlnbIZcer01IOnojXPyKF+qjaAb7HQtxGTMyTI1y8RahC+zwIcU1jIIeew1NkdgtfMAwm+Mo=
X-Received: by 2002:a2e:9196:0:b0:2b6:de52:35a with SMTP id
 f22-20020a2e9196000000b002b6de52035amr14597261ljg.9.1689085173734; Tue, 11
 Jul 2023 07:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230710100714.228867-1-david@redhat.com>
In-Reply-To: <20230710100714.228867-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Tue, 11 Jul 2023 16:19:22 +0200
Message-ID: <CAMXpfWsD9_UvB6cez9oKZt9PREkVALhX0sQ=Qyok78juME78jQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] virtio-mem: Device unplug support
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, 
 Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series has been successfully tested by QE. Start a VM, plug a
virtio-mem device, resize the device (adding memory) and verify that
the virtio-mem device cannot be unplugged. Finally, resize the device
(removing all the memory) and check that it can be unplugged
seamlessly.

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Mon, Jul 10, 2023 at 12:07=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> Any further comments? IMHO this is pretty straight forward. I'll wait
> a bit longer for more feedback.
>
>
> One limitation of virtio-mem is that we cannot currently unplug virtio-me=
m
> devices that have all memory unplugged from the VM.
>
> Let's properly handle forced unplug (as can be triggered by the VM) and
> add support for ordinary unplug (requests) of virtio-mem devices that are
> in a compatible state (no legacy mode, no plugged memory, no plug request=
).
>
> Briefly tested on both, x86_64 and aarch64.
>
> v2 -> v3:
> - "virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci"
>  -> Add MAINTAINERS entry
>
> v1 -> v2:
> - Reduce code duplication and implement it in a cleaner way using a
>   new abstract virtio-md-pci parent class
> - "virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci"
>  -> Added, use a new aprent type like virtio-input-pci
> - "pc: Factor out (un)plug handling of virtio-md-pci devices"
>  -> Added, factor it cleanly out
> - "arm/virt: Use virtio-md-pci (un)plug functions"
>  -> Added, reduce code duplciation
> - "virtio-md-pci: Handle unplug of virtio based memory devices"
>  -> More generic without any device-specifics
> - "virtio-md-pci: Support unplug requests for compatible devices"
>  -> More generic without any device-specifics
> - "virtio-mem: Prepare for device unplug support"
>  -> Use callback, separated from virtio-mem-pci device change
> - "virtio-mem-pci: Device unplug support"
>  -> Use callback, separated from virtio-mem device change
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Mario Casquero <mcasquer@redhat.com>
>
> David Hildenbrand (7):
>   virtio-md-pci: New parent type for virtio-mem-pci and virtio-pmem-pci
>   pc: Factor out (un)plug handling of virtio-md-pci devices
>   arm/virt: Use virtio-md-pci (un)plug functions
>   virtio-md-pci: Handle unplug of virtio based memory devices
>   virtio-md-pci: Support unplug requests for compatible devices
>   virtio-mem: Prepare for device unplug support
>   virtio-mem-pci: Device unplug support
>
>  MAINTAINERS                       |   6 ++
>  hw/arm/virt.c                     |  81 +++-------------
>  hw/i386/pc.c                      |  90 +++---------------
>  hw/virtio/Kconfig                 |   8 +-
>  hw/virtio/meson.build             |   1 +
>  hw/virtio/virtio-md-pci.c         | 151 ++++++++++++++++++++++++++++++
>  hw/virtio/virtio-mem-pci.c        |  54 +++++++++--
>  hw/virtio/virtio-mem-pci.h        |   6 +-
>  hw/virtio/virtio-mem.c            |  25 +++++
>  hw/virtio/virtio-pmem-pci.c       |   5 +-
>  hw/virtio/virtio-pmem-pci.h       |   6 +-
>  include/hw/virtio/virtio-md-pci.h |  44 +++++++++
>  include/hw/virtio/virtio-mem.h    |   1 +
>  13 files changed, 311 insertions(+), 167 deletions(-)
>  create mode 100644 hw/virtio/virtio-md-pci.c
>  create mode 100644 include/hw/virtio/virtio-md-pci.h
>
> --
> 2.41.0
>


