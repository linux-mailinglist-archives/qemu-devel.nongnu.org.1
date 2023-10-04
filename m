Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48F7B7B62
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxsi-0005Eb-Mh; Wed, 04 Oct 2023 05:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxrt-0003Pz-T7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxrq-0007jb-J7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696410505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8zzgbmGxjQIikDZJdsLWoj3bPCkZiXfK9GZbCg9Luk=;
 b=BLmTbn95XXyx7L/fNbmxf705BWfNDIyqHMGpQXliIaP7sAaIoDuhFa2zAeI+qyqWKgyc04
 a/dbO6oPF/SRM6s0rW+IkRkNkyEtrRWE7DMZxhKHfkxL+qQhT3blU9xDDY4T7V+Jg2/C+I
 Fc309IhhdBls8N9LQ9N8+FC7UDbN9Z0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-LyiaQDbnPjuO95Okzk1hMQ-1; Wed, 04 Oct 2023 05:08:21 -0400
X-MC-Unique: LyiaQDbnPjuO95Okzk1hMQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4054743df06so13547995e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410500; x=1697015300;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8zzgbmGxjQIikDZJdsLWoj3bPCkZiXfK9GZbCg9Luk=;
 b=ekBbpG0Sa1xDrk9CP9qgRYmATYltKn1dv1GhXxT7CTODsanBr94MhAxNW1o+DvyS3l
 L7Z9nVbKR55mtgATBDyPypO7eST103EICoKbtGREIFGXgWdp91/VLonaUoEiRS2qfI1S
 7xQ5515zLuqbJkE6WV9+3nQLNyo3Gjks16NmgyPnVl1ehrUlrHhr/rZg2Bb8KDq+0fO+
 k49GM8bFCFNc+FlA7J9eJ+HOilQSZVpqRBPG8rCOmd75mcgkrGjd3acmHzBkIeUCeAkX
 Ejom/HdyYRrOSjk7qezyhSUT21dunwiWdLSi3dBIYRwntSAhS5Zrt1qq8PF6IOFc1KBq
 j/5w==
X-Gm-Message-State: AOJu0YxgNMCExTYiErNLZXEglKZ9Bp6OQFZL5QKzf+mp54+qStE7zSTc
 I2HDti6rdgwYqwy2LQr/XeTJWNtqDuFrHTbgeFqDmL0UPIqYuz2a0heaAjIbj4eKFxig/Y1agL4
 0RudPScXnaCFLP78=
X-Received: by 2002:a7b:c387:0:b0:3f9:b430:199b with SMTP id
 s7-20020a7bc387000000b003f9b430199bmr1645130wmj.15.1696410500377; 
 Wed, 04 Oct 2023 02:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmV/Fuhl0jeGUwnYHCpv39o4WoUrlUsh2WSKoDz3uPCwaHIpHC/fC+Fn1bnZvlqldj+3Iq9g==
X-Received: by 2002:a7b:c387:0:b0:3f9:b430:199b with SMTP id
 s7-20020a7bc387000000b003f9b430199bmr1645118wmj.15.1696410500039; 
 Wed, 04 Oct 2023 02:08:20 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b0040644e699a0sm980882wmo.45.2023.10.04.02.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 02:08:19 -0700 (PDT)
Date: Wed, 4 Oct 2023 05:08:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pci: features, cleanups
Message-ID: <20231004050719-mutt-send-email-mst@kernel.org>
References: <cover.1696408966.git.mst@redhat.com>
 <aa1bc6ef-e444-7ec4-683d-5f437007bfe0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa1bc6ef-e444-7ec4-683d-5f437007bfe0@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 04, 2023 at 10:54:35AM +0200, Philippe Mathieu-Daudé wrote:
> On 4/10/23 10:43, Michael S. Tsirkin wrote:
> 
> > ----------------------------------------------------------------
> > virtio,pci: features, cleanups
> > 
> > vdpa:
> >        shadow vq vlan support
> >        net migration with cvq
> > cxl:
> >       dummy ACPI QTG DSM
> >       support emulating 4 HDM decoders
> >       serial number extended capability
> > virtio:
> >        hared dma-buf
> > 
> > Fixes, cleanups all over the place.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> 
> 
> > Philippe Mathieu-Daudé (6):
> >        hw/virtio: Propagate page_mask to vhost_vdpa_listener_skipped_section()
> >        hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
> >        hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
> >        hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
> >        hw/virtio: Build vhost-vdpa.o once
> >        hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]
> 
> Woohoo \o/ thanks for merging this!


😳


