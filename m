Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA9F73B07A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCZpG-0003wk-Mt; Fri, 23 Jun 2023 01:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZp4-0003w0-S7
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qCZp2-0006mz-FX
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 01:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687499943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0rg4toHcIOekD0NUmSceylkzCBwF+0TVsgA23XXFhU=;
 b=d3JB68yYtnJ5e6HcNdw4BeqsTwuUFhWZ18d8535YBJvI+/B3KP1MYGcgk6ST84CWf2I0+4
 VrQ/f4qBKkPz4U6YQfAOqJFrIYudnKbrjLEl1/9dgBWSOnspH31Tp6DA0pJelbhMTHEc0f
 ugdJ7aBnbhZjPEiVqqNWiC5MmZ1sl0s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TbiyOBoZPs65ngOtBFVF9A-1; Fri, 23 Jun 2023 01:59:02 -0400
X-MC-Unique: TbiyOBoZPs65ngOtBFVF9A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31283f4d22fso130652f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 22:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687499941; x=1690091941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s0rg4toHcIOekD0NUmSceylkzCBwF+0TVsgA23XXFhU=;
 b=BhXPmtpu1mCxOObZmNq7gy91ypWTmLf+4K3NT2zTQLqYiJFpH7kOXFSkB2b14134Ug
 ItUzxnvMWt01fC7iGaHl3fWKfdi7aTQcxlKaRapDTJ8mxY1Vz3i6d/Pc2lJsze3P60VO
 iIr1Zw5Tdh4FeyuHkKQIcu5zxJ2XBeFwslnzolpb5nE+wVelwOgikYPgkX0DAJlmS5HW
 Jn0diD4TzwayMd1K3RCCfvqcghpdGO5XFpqN5jBmdqDm653kvNQRAxeLKf7A57vFYj5w
 ijYo3ro01raAUUzhflsRR3JRI8THN1UgvXrm6rmnDZpj7+prIG4/nkcuiP4nFxkdfWc2
 VjNA==
X-Gm-Message-State: AC+VfDxPovPF1jLiHkxSJn04XWbmTj4DNP/kNuwOQsJVThoZfWOcuox3
 BbArNRI1vAQ0n6vPE3bjuiLNi16SLYmLWpXK2QNqC8dBwfLnRs5BrNszlbTY2dQ5FNOVqeBJmpG
 xzHGqWWDu1kddfNc=
X-Received: by 2002:a5d:44c6:0:b0:30f:c7f1:30e9 with SMTP id
 z6-20020a5d44c6000000b0030fc7f130e9mr15752992wrr.5.1687499940879; 
 Thu, 22 Jun 2023 22:59:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rAJDgG2SCv4uRFmA+lLA/iX+Co1Hk0G3MMcEmpaq6ddATz3LvmpO+KD+4VEesOWtaMU0vFA==
X-Received: by 2002:a5d:44c6:0:b0:30f:c7f1:30e9 with SMTP id
 z6-20020a5d44c6000000b0030fc7f130e9mr15752985wrr.5.1687499940623; 
 Thu, 22 Jun 2023 22:59:00 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 p8-20020adfe608000000b0030ae849c70csm8659216wrm.37.2023.06.22.22.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 22:58:59 -0700 (PDT)
Date: Fri, 23 Jun 2023 01:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1 0/5] virtio-mem: Device unplug support
Message-ID: <20230623015740-mutt-send-email-mst@kernel.org>
References: <20230613150210.449406-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613150210.449406-1-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 13, 2023 at 05:02:05PM +0200, David Hildenbrand wrote:
> One limitation of virtio-mem is that we cannot currently unplug virtio-mem
> devices that have all memory unplugged from the VM.
> 
> Let's properly handle forced unplug (as can be triggered by the VM) and
> add support for ordinary unplug (requests) of virtio-mem devices that are
> in a compatible state (no legacy mode, no plugged memory, no plug request).
> 
> Briefly tested on both, x86_64 and aarch64.
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

Lots of duplication pc/arm. Which is not new but do we have to keep
growing this?  Can't we put at least the new common code somewhere?

What do ARM maintainers think about it?


> David Hildenbrand (5):
>   pc: Properly handle unplug of virtio based memory devices
>   arm/virt: Properly handle unplug of virtio based memory devices
>   virtio-mem: Prepare for unplug support of virtio-mem-pci devices
>   pc: Support unplug of virtio-mem-pci devices
>   arm/virt: Support unplug of virtio-mem-pci devices
> 
>  hw/arm/virt.c                  | 60 +++++++++++++++++++++++++++++--
>  hw/i386/pc.c                   | 66 ++++++++++++++++++++++++++++++----
>  hw/virtio/virtio-mem-pci.c     | 42 ++++++++++++++++++++--
>  hw/virtio/virtio-mem-pci.h     |  2 ++
>  hw/virtio/virtio-mem.c         | 24 +++++++++++++
>  include/hw/virtio/virtio-mem.h |  2 ++
>  6 files changed, 183 insertions(+), 13 deletions(-)
> 
> -- 
> 2.40.1


