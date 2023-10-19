Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B25577D0135
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXW7-0006mS-EF; Thu, 19 Oct 2023 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXW5-0006VB-DD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXW3-00079s-5D
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogzGSPILxiB5Kai4YD2O7qVhR1otbOlkfN4zLPqc4G8=;
 b=ixuaXjfAxg2Fzoe7RPSCZiuO6e/4y95sbQeEKOMExZQI3uL2/CONxzaxMnOf3X1wPjEC1f
 dblPJoipr6F06JgDeJXUHDUJPUeSM2hSqneKAByCxBkZUguulHRaT7SDyCRF3s58FlRpcH
 y4hiTaFvUFUQMhf7iwOTsDkWwZMYxVI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-4QxYIDz2Mz-LKsVORNlfIw-1; Thu, 19 Oct 2023 14:12:21 -0400
X-MC-Unique: 4QxYIDz2Mz-LKsVORNlfIw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32da87eac93so3087522f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739133; x=1698343933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogzGSPILxiB5Kai4YD2O7qVhR1otbOlkfN4zLPqc4G8=;
 b=Y60YE+Lnhpj5bqkFd5Y1VB1RYjVjyP8sdaSj9UsOo8K3jdSK9NuO85F6wOYxUhUjQP
 F1/x3o6RBSqw/ymoCj488ZwpJ5hraqrk5TJGoNNUeNLwwBjVW6BfRmJqRYt7TmzbgbqW
 LZkET2ny14lwkPvHgIyyT+2o1Mi4fI/HhTsq06ZSnHlwfuZWQas7ofJ+jxkvae3fvhGe
 oSLof0UwCkBhZcXFm2z75i/YiTOQfyrPqwOCqHrsY2r1B5mSQX/G6WL5yXw4wUpjP3sB
 LtPjOhRjT/PWmy2aM8hqpgQ3V/BhmCr/d4bGBZoJT1cj2H6gleelAXB05AW6GujFMtQx
 LdCw==
X-Gm-Message-State: AOJu0YyjgQOLCyw/lD+L22kK4GARN4tCzkebBn6XpqEiXAoipfyaEEVR
 hUpiLcUExWWShF2A/mcNWkNH/z0vw01b7uZi46+bFlfUIktf4jNPqo45dnH7YmF+QZh4+Y6zUdU
 zEQzcu2y8yB1GdXk=
X-Received: by 2002:adf:f9d0:0:b0:32d:a40f:d918 with SMTP id
 w16-20020adff9d0000000b0032da40fd918mr2129616wrr.68.1697739132905; 
 Thu, 19 Oct 2023 11:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtA3zIxHKncd+1pP6wBmUBeFriXaTW/OjPQ14cgkwBKJQJNJJhjoPyhtyjNySjpTnknHP/iQ==
X-Received: by 2002:adf:f9d0:0:b0:32d:a40f:d918 with SMTP id
 w16-20020adff9d0000000b0032da40fd918mr2129602wrr.68.1697739132565; 
 Thu, 19 Oct 2023 11:12:12 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d15-20020adfef8f000000b003231ca246b6sm4999619wro.95.2023.10.19.11.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:12:12 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:12:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 18801353760@163.com
Subject: Re: [PATCH v3 0/3] Vhost-vdpa Shadow Virtqueue RSS Support
Message-ID: <20231019141200-mutt-send-email-mst@kernel.org>
References: <cover.1693299194.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693299194.git.yin31149@gmail.com>
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

On Tue, Aug 29, 2023 at 05:11:14PM +0800, Hawkins Jiawei wrote:
> This series enables shadowed CVQ to intercept RSS command
> through shadowed CVQ, update the virtio NIC device model
> so qemu send it in a migration, and the restore of that
> RSS state in the destination.
> 
> Note that this patch should be based on
> patch "Vhost-vdpa Shadow Virtqueue Hash calculation Support" at [1].
> 
> [1]. https://lore.kernel.org/all/cover.1693297766.git.yin31149@gmail.com/

dropped due to dependency.

> TestStep
> ========
> 1. test the migration using vp-vdpa device
>   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `in-qemu` RSS, command line like:
> 	-netdev tap,vhost=off...
> 	-device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,hash=on,rss=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,...
> 
>   - For L1 guest, apply the relative patch series and compile the
> source code, start QEMU with two vdpa device with svq mode on,
> enable the `ctrl_vq`, `mq`, `rss` features on, command line like:
>       -netdev type=vhost-vdpa,x-svq=true,...
>       -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> rss=on,...
> 
>   - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
> 
> ethtool -K eth0 rxhash on
> ```
> 
>   - Execute the live migration in L2 source monitor
> 
>   - Result
>     * with this series, L2 QEMU can execute without
> triggering any error or warning. L0 QEMU echo
> "Can't load eBPF RSS - fallback to software RSS".
> 
> ChangeLog
> =========
> v3:
>   - resolve conflict with updated patch
> "Vhost-vdpa Shadow Virtqueue Hash calculation Support" in patch
> "vdpa: Restore receive-side scaling state"
> 
> RFC v2: https://lore.kernel.org/all/cover.1691926415.git.yin31149@gmail.com/
>   - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
> loading the hash calculation state in
> patch "vdpa: Restore receive-side scaling state"
> 
> RFC v1: https://lore.kernel.org/all/cover.1691766252.git.yin31149@gmail.com/
> 
> Hawkins Jiawei (3):
>   vdpa: Add SetSteeringEBPF method for NetClientState
>   vdpa: Restore receive-side scaling state
>   vdpa: Allow VIRTIO_NET_F_RSS in SVQ
> 
>  net/vhost-vdpa.c | 63 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 18 deletions(-)
> 
> -- 
> 2.25.1


