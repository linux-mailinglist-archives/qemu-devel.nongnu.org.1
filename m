Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C123A7D0133
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:12:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXVG-0001ov-JG; Thu, 19 Oct 2023 14:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXVE-0001ca-BI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXVB-00073k-2p
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoOoMySain/rMs1Ox2OzNPuglpE98ci19tAmcSxxEfA=;
 b=WrR+Oppo7NNXGWl7lC54bvoFHgy3D5x5aedJ97LBFfG0TIu8mmmxV6DwYmfNDX1ypBF6R5
 XcXVUIyaVtAsAT8E1c/89NxSuN5crWc7xciCfhnE/keTGwxt1UcozrvxRA6wxw7a3AeSA8
 nvhBhVfoSg5i1Fc2tkfKVsN+tTurdBM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-vTClGII5PiW4k7EXTWhnqw-1; Thu, 19 Oct 2023 14:11:58 -0400
X-MC-Unique: vTClGII5PiW4k7EXTWhnqw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4074cdf2566so16855e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739117; x=1698343917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qoOoMySain/rMs1Ox2OzNPuglpE98ci19tAmcSxxEfA=;
 b=AsmWzXsnlXSkEU65rtrECLIPJE44gsfKkdZIcWzDNaGHw77airmbtBIBeX8fIM8QBg
 zSTmiLGo6GZHjeokWA5dsQVKBlPbavrOdmmRmM9mYrmWV4fbCeYflK25DolwWK19pyu0
 i8ILxHqUFSXbltA+JQra6P+lCjF34Go93hgaTEUwe+sDS177FrA7rxtidIRFfxYe+RGF
 smsc+A1Z+60yhkcq3Vfa8NuNvEG9j+PDnEKn7N6o9ad2SdGVRnGQOpuIOSzlBmGEdQ8l
 HKSlWygwIUIbaP/hKyWO+pCDMbtX/9dY3uLbbKxFBot6iXBM9CVPeMA/PXOgVD8w4Y/3
 xFHA==
X-Gm-Message-State: AOJu0Yz4bavIHm+xjliC9u5upPcTErtyomxk6BZrERRsU+oaPrsbpmdv
 f9JIJF0Lo5Jnb3lCnutuzAQhiO09CDmjahKaJ/8OYSXCRJMFFX9q3gpC/imVpxhPEMW99oSu+rt
 xjRVDssiK5mDT6kE=
X-Received: by 2002:a05:600c:3546:b0:402:ea8c:ea57 with SMTP id
 i6-20020a05600c354600b00402ea8cea57mr2583780wmq.7.1697739116717; 
 Thu, 19 Oct 2023 11:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5MsLU5TF5VEboz/oVOPYaTPAocuK/iPcjmDcWF/jwba362Fp3j7+onGya50vP4sjzgNjBdA==
X-Received: by 2002:a05:600c:3546:b0:402:ea8c:ea57 with SMTP id
 i6-20020a05600c354600b00402ea8cea57mr2583768wmq.7.1697739116281; 
 Thu, 19 Oct 2023 11:11:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a05600c1f9400b004063ea92492sm195242wmb.22.2023.10.19.11.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:11:55 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:11:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 18801353760@163.com
Subject: Re: [PATCH v2 0/2] Vhost-vdpa Shadow Virtqueue Hash calculation
 Support
Message-ID: <20231019141123-mutt-send-email-mst@kernel.org>
References: <cover.1693297766.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693297766.git.yin31149@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 04:47:33PM +0800, Hawkins Jiawei wrote:
> This series enables shadowed CVQ to intercept
> VIRTIO_NET_CTRL_MQ_HASH_CONFIG command through shadowed CVQ,
> update the virtio NIC device model so qemu send it in a
> migration, and the restore of that Hash calculation state
> in the destination.
> 
> Note that this patch should be based on
> patch "vdpa: Send all CVQ state load commands in parallel" at [1].
> 
> [1]. https://lore.kernel.org/all/cover.1693287885.git.yin31149@gmail.com/

Dropped due to CI failures:
https://gitlab.com/qemu-project/qemu/-/jobs/5329820077


> TestStep
> ========
> 1. test the migration using vp-vdpa device
>   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `mq`, `hash` features on, command line like:
> 	-netdev tap,...
> 	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,hash=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,...
> 
>   - For L1 guest, apply the relative patch series and compile the
> source code, start QEMU with two vdpa device with svq mode on,
> enable the `ctrl_vq`, `mq`, `hash` features on, command line like:
>       -netdev type=vhost-vdpa,x-svq=true,...
>       -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> hash=on,...
> 
>   - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
> 
> ethtool -K eth0 rxhash on
> ```
>   - Gdb attach the destination VM and break at the
> vhost_vdpa_net_load_rss()
> 
>   - Execute the live migration in L2 source monitor
> 
>   - Result
>     * with this series, gdb can hit the breakpoint and continue
> the executing without triggering any error or warning.
> 
> 
> ChangeLog
> =========
> v2:
>   - resolve conflict with updated patch
> "vdpa: Send all CVQ state load commands in parallel", move the
> `table` declaration at the beginning of the vhost_vdpa_net_load_rss()
> in patch
> "vdpa: Restore hash calculation state"
> 
> RFC: https://lore.kernel.org/all/cover.1691762906.git.yin31149@gmail.com/#t
> 
> Hawkins Jiawei (2):
>   vdpa: Restore hash calculation state
>   vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
> 
>  net/vhost-vdpa.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> -- 
> 2.25.1


