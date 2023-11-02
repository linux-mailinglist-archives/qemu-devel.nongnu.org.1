Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A07DF13C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVvV-0007MV-SV; Thu, 02 Nov 2023 07:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVvL-0007ME-UQ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVvJ-0000SC-Hf
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698924699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMRpf7JoHGCknk7o4VI6vElDC3z7uXe8jqFC2300Iv8=;
 b=h1UigerzKUIbRAT4wA0e5PrH2Tz+T2Ckan3ymfeYBgXMUIyNTdiQmCcP9EOutAbRo02U5/
 Nitd20tcPZDz+ZVOMxMZ6U6EkFBXhLCBJnOgDjqptVcJMhIhsU/iGltYrWMowtjlJUXWma
 ORMwLEHmNxPEWnE2p9RvB53rbwbWaVA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-YderZ2IzOEKDwXoRMoeo9w-1; Thu, 02 Nov 2023 07:31:37 -0400
X-MC-Unique: YderZ2IzOEKDwXoRMoeo9w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32dc767e619so378009f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698924696; x=1699529496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMRpf7JoHGCknk7o4VI6vElDC3z7uXe8jqFC2300Iv8=;
 b=aoARCsvFDmYU4EOhiKipN+Xbuo/D6nt56ELHcJofutdaFINfOGBMOMAb3/oiDSHtYI
 vZmRWr20xFDIwpodOPoJkAc0UkzDyeW5RHbSUEu/t63Cp4cpW8AS7g2paefeTAWnsTN9
 9p41tjvvns2k3YnxMuupkW+GZwY7zg+DyOgvWrqYAvpAIWuG68YlwHBAozFtwffpyZfU
 sLJ8mtPIrKrXbyzbfYbyEd4uwwNtEJ2qLw3GASFTCzNlLHTBKzGzPCP1UUXpLaSHd8Io
 0ExpuyaTLRMsY62J2f8FL27Q95X/a6+qfUuES/Tx+wukofJTbUaGqDEOR/MyGA4bLSBx
 tXjg==
X-Gm-Message-State: AOJu0Yz9bLdf6ygNVPoyNXdpNTEKiDsSEIdo8hBT/uramVTvHYrMCck1
 rZ6uaoOIS5YvAeRF9QOvjQtY41N2CnmGEg0GmbR0knMtOAGo5Ghu+AvkZYrCEtYTtY87O0vgjC+
 jh4MEX7b1djtBluE=
X-Received: by 2002:a5d:6d0d:0:b0:32f:7d60:d62e with SMTP id
 e13-20020a5d6d0d000000b0032f7d60d62emr17588483wrq.27.1698924696357; 
 Thu, 02 Nov 2023 04:31:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgIkyx+VsVoTUupJwBeREKQmqXH15rXn9qJWOXBbmqFBF1v+CpfzP1UVoXXDCs64wktZub3A==
X-Received: by 2002:a5d:6d0d:0:b0:32f:7d60:d62e with SMTP id
 e13-20020a5d6d0d000000b0032f7d60d62emr17588451wrq.27.1698924696016; 
 Thu, 02 Nov 2023 04:31:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a5d6149000000b0032da319a27asm2241472wrt.9.2023.11.02.04.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:31:35 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:31:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 den-plotnikov@yandex-team.ru, yc-core@yandex-team.ru
Subject: Re: [PATCH v8 0/4] pci hotplug tracking
Message-ID: <20231102072800-mutt-send-email-mst@kernel.org>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005092926.56231-1-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Oct 05, 2023 at 12:29:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Main thing this series does is DEVICE_ON event - a counter-part to
> DEVICE_DELETED. A guest-driven event that device is powered-on.
> Details are in patch 2. The new event is paried with corresponding
> command query-hotplug.

Several things questionable here:
1. depending on guest activity you can get as many
   DEVICE_ON events as you like
2. it's just for shpc and native pcie - things are
   confusing enough for management, we should make sure
   it can work for all devices
3. what about non hotpluggable devices? do we want the event for them?


I feel this needs actual motivation so we can judge what's the
right way to do it.


> 
> v8:
>  - improve naming, wording and style
>  - make new QMP interface experimental
> 
> 
> Vladimir Sementsov-Ogievskiy (4):
>   qapi/qdev.json: unite DEVICE_* event data into single structure
>   qapi: add DEVICE_ON and query-hotplug infrastructure
>   shpc: implement DEVICE_ON event and query-hotplug
>   pcie: implement DEVICE_ON event and query-hotplug
> 
>  hw/core/hotplug.c               |  12 +++
>  hw/pci-bridge/pci_bridge_dev.c  |  14 +++
>  hw/pci-bridge/pcie_pci_bridge.c |   1 +
>  hw/pci/pcie.c                   |  83 +++++++++++++++
>  hw/pci/pcie_port.c              |   1 +
>  hw/pci/shpc.c                   |  86 +++++++++++++++
>  include/hw/hotplug.h            |  11 ++
>  include/hw/pci/pci_bridge.h     |   2 +
>  include/hw/pci/pcie.h           |   2 +
>  include/hw/pci/shpc.h           |   2 +
>  include/hw/qdev-core.h          |   7 ++
>  include/monitor/qdev.h          |   6 ++
>  qapi/qdev.json                  | 178 +++++++++++++++++++++++++++++---
>  softmmu/qdev-monitor.c          |  58 +++++++++++
>  14 files changed, 451 insertions(+), 12 deletions(-)
> 
> -- 
> 2.34.1


