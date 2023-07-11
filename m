Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00974F3BA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 17:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJFRE-00045S-Vf; Tue, 11 Jul 2023 11:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJFQw-0003qk-0N
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJFQm-0006Ro-Ik
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 11:37:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689089854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBX3KMRDL+j9kGd79s3lBmaWqhN5Pi3Nld7WdspJqfE=;
 b=L4dh1QYQqL4UDNOYVz29jvKLJGSUtBxNW7gOGL9J5zb63jkwfWK9XtZuqf8oQgPyGQECUa
 zxdgY5pqPaITX2xTEHFHBXM0keYbfv1ebc4dyjBoTvKnaFGIWWxACQ5PQbuSLkKchUd9u6
 0OGUp5D7jQr3y4LDTOuiEqC1PYoFyGM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-1SA01u7YN3iyAry1JIySnQ-1; Tue, 11 Jul 2023 11:37:33 -0400
X-MC-Unique: 1SA01u7YN3iyAry1JIySnQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso35201715e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 08:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689089852; x=1691681852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBX3KMRDL+j9kGd79s3lBmaWqhN5Pi3Nld7WdspJqfE=;
 b=kiSC6p/47CcpkEYLwTmzZVJ2su78h9uDYO2PAythVYxMaESYBWnKCKeeWUlSvr1SuS
 Pkzg8QWaErcYE6h+fA0tmbfmqgQAindGQum5GwKUV9fLMoQ/SvMbPHwQSG9FxGFVFpYh
 5r7BaZeKb3nF0I3vCAzCwMoLKQFuLXIxidqKruSdNT7EkIp069NwAYiFqqG0ZUlfPBah
 HHWHSoSm6xfdgtP12AD5clHyxqti2dYJc58bPfQLNYJlMjpzpEEjktH7WLZQicZGBF21
 HnlbhG0+1Dqo8UwNGjf5YPis81Aaa3MXICxiMC0wMp+h83rEbHKInvsi6UFCfGI13vxi
 6Qqw==
X-Gm-Message-State: ABy/qLZ1ET2ZJg/FvvrKQghfKom8BpJ3S/cB8ei6mkoaEkGonvAouID+
 1/h7lwHTZ4zlsYi+JrT4W1ClypPmB7fubqD38phZi+OkYHdVnFKY0HGI1IqfEFaW8/ei56ksqkD
 n9W8shOD2cS6Sp+M=
X-Received: by 2002:a05:600c:378b:b0:3fb:ffa8:6d78 with SMTP id
 o11-20020a05600c378b00b003fbffa86d78mr11004917wmr.36.1689089851916; 
 Tue, 11 Jul 2023 08:37:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEuqr7E7WQ/HQF9uU/TkWYAAcCsF5uxvovdWEB0AKQcPoZwdv+c1KnJ246aIZogMnF/ujnG9A==
X-Received: by 2002:a05:600c:378b:b0:3fb:ffa8:6d78 with SMTP id
 o11-20020a05600c378b00b003fbffa86d78mr11004895wmr.36.1689089851568; 
 Tue, 11 Jul 2023 08:37:31 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 x10-20020a05600c21ca00b003fa96fe2bebsm2809870wmj.41.2023.07.11.08.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 08:37:30 -0700 (PDT)
Date: Tue, 11 Jul 2023 11:37:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v4 0/7] virtio-mem: Device unplug support
Message-ID: <20230711113716-mutt-send-email-mst@kernel.org>
References: <20230711153445.514112-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711153445.514112-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 11, 2023 at 05:34:38PM +0200, David Hildenbrand wrote:
> One limitation of virtio-mem is that we cannot currently unplug virtio-mem
> devices that have all memory unplugged from the VM.
> 
> Let's properly handle forced unplug (as can be triggered by the VM) and
> add support for ordinary unplug (requests) of virtio-mem devices that are
> in a compatible state (no legacy mode, no plugged memory, no plug request).
> 
> Briefly tested on both, x86_64 and aarch64.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


feel free to merge.

> v3 -> v4:
> - "pc: Factor out (un)plug handling of virtio-md-pci devices"
>  -> Add stubs to fix arm64 compilation under mingw
> - Added Tested-by's
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
>  MAINTAINERS                       |   7 ++
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
>  stubs/meson.build                 |   1 +
>  stubs/virtio-md-pci.c             |  24 +++++
>  15 files changed, 337 insertions(+), 167 deletions(-)
>  create mode 100644 hw/virtio/virtio-md-pci.c
>  create mode 100644 include/hw/virtio/virtio-md-pci.h
>  create mode 100644 stubs/virtio-md-pci.c
> 
> -- 
> 2.41.0


