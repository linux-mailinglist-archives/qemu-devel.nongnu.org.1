Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26FA718B6F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Smr-0000GT-W6; Wed, 31 May 2023 16:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4Smq-0000Fm-17
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4Smd-0006M6-5J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685566262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ca+LllBtIFFp9a8BpUlQw+NqiE3XwGl9bJLEUmKFa4=;
 b=K9z22K6lLxLNx1d0aVrnZd9lK1ryM0MPelqv3slRo+QAiTXw4YuaNk321O1+fhckwsqR+A
 gGNu9c232dtQG3q9tb7eXzVPaPbA35Ib0AqFRUhBWjXSqXkLsUseH/LmqcxELYq3rYCRDm
 enxuAMaUVixZZLoHnQmxCelOb89fd2o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-io1fWgDvNWKxYn8l8SV-wg-1; Wed, 31 May 2023 16:51:01 -0400
X-MC-Unique: io1fWgDvNWKxYn8l8SV-wg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30aeef6f601so43799f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685566260; x=1688158260;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ca+LllBtIFFp9a8BpUlQw+NqiE3XwGl9bJLEUmKFa4=;
 b=Qehi0JDApmqPbpSzmns29lvK6ZObLt52sQ+M30Xe/7R+gbYXUBUUy+sDEwDdhmaeBP
 ogRDWx+JrVIAb6XPQtqjsiRvEcQgY5I0GoBJdpPE/bFtAtWARJ+JaZD+m6UnExsX8nyw
 rpbAj+lt9gtVyNQkx49dew2si4RGH4cqeeZjAeqbD87YnPFrR3S+AVtzbuYqC7sJai/A
 UkBDt/viJkGvnlSYiqcWjxiGcgdOLAa7tqjERPgI2ScsAX+18SejNg6y+N6KGTSLxPCv
 1FXLLPDz9cJpd7PNnLHj8/p852Zvk/Vtpq1e25XU+ugIt8fYod0B4GKrIs8s1XRD20TG
 zxzQ==
X-Gm-Message-State: AC+VfDxyu3xii3D5YU01X3zFfq8Xz9EDD+QfP3yTJeYpQtGtC9Ai0d/Z
 AD3aDk7BbC0OhdFI0HyfPSG7E/7NgZwsEYPYy02QxiJ6U3L8rP/862SuYwSMy/Vl6JzDF3gN8rt
 8xT+1wrcNd+hSuzo=
X-Received: by 2002:a5d:6e56:0:b0:30a:e892:e2d0 with SMTP id
 j22-20020a5d6e56000000b0030ae892e2d0mr230372wrz.46.1685566259865; 
 Wed, 31 May 2023 13:50:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5zic3g/6NA/Y6n81NRdMNGlt6V0Yo4ywbd6C1L1ZSYDuazCvdKzxcK4pD4GC2ZkMfKzT5rEg==
X-Received: by 2002:a5d:6e56:0:b0:30a:e892:e2d0 with SMTP id
 j22-20020a5d6e56000000b0030ae892e2d0mr230350wrz.46.1685566259609; 
 Wed, 31 May 2023 13:50:59 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe390000000b003048477729asm7930297wrm.81.2023.05.31.13.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 13:50:59 -0700 (PDT)
Date: Wed, 31 May 2023 16:50:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/10] hw/virtio: Build various target-agnostic
 objects just once
Message-ID: <20230531165040-mutt-send-email-mst@kernel.org>
References: <20230524093744.88442-1-philmd@linaro.org>
 <816d1209-09ba-7d28-95c7-5381be0b2c06@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <816d1209-09ba-7d28-95c7-5381be0b2c06@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 10:39:48PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> On 24/5/23 11:37, Philippe Mathieu-Daudé wrote:
> > All patches reviewed.
> 
> Could you take this series via your virtio tree?
> 
> Thanks!
> 
> Phil.

Will do, in next pull. Thanks!

> > Less controvertial than my first approach [*] which caches
> > the access_is_big_endian value in VirtIODevice state, this
> > series just remove a unnecessary / pointless dependency on
> > "virtio-access.h", allowing to build various virtio objects
> > once for all targets.
> > 
> > [*] https://lore.kernel.org/qemu-devel/20221212230517.28872-11-philmd@linaro.org/
> > 
> > Philippe Mathieu-Daudé (10):
> >    softmmu: Introduce qemu_target_page_mask() helper
> >    hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
> >    hw/scsi: Rearrange meson.build
> >    hw/scsi: Rename target-specific source set as
> >      'specific_virtio_scsi_ss'
> >    hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in Kconfig
> >    hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
> >    hw/virtio/vhost-vsock: Include missing 'virtio/virtio-bus.h' header
> >    hw/virtio/virtio-iommu: Use target-agnostic qemu_target_page_mask()
> >    hw/virtio: Remove unnecessary 'virtio-access.h' header
> >    hw/virtio: Build various target-agnostic objects just once


