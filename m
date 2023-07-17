Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE306756219
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMln-0004Ku-0c; Mon, 17 Jul 2023 07:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLMlk-0004K3-82
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qLMli-0003EH-P5
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689594717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4o9T2ZhHwFqQCH+mitCMb5ubOwOy7xSSjrnqcrvBGo=;
 b=F3pBiHFd6XsBxvckOCLMTwBfRMRTFU6Zr+ENbr2d/sRcQdtdFfHLHv4kAleTbRtD9duTvG
 A4HhoseOjx3e2W7h8XzeNQdyQz1Nf3NN7B7GxCIx1hwUvlWZXWsEoRCRLYOogNooA+oPUf
 XWzp6SoWMzfdRV78VNpGtVM2amQAd3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-2MUiib1iPm-Zjue1FXy5ng-1; Mon, 17 Jul 2023 07:51:56 -0400
X-MC-Unique: 2MUiib1iPm-Zjue1FXy5ng-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3142665f122so2724772f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689594715; x=1692186715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4o9T2ZhHwFqQCH+mitCMb5ubOwOy7xSSjrnqcrvBGo=;
 b=T8AQ0cP/8z67QGSu0NMDaWTuQ1QVSqcEtYlaSPunLZBibqw33Rh7ADYC1FAGCRPS6o
 UmJRdmkLXMV1Nf2CfTb/83q37jNOKD8YdUMl4rfytOaOPr53kfhmtAC58DdiGKhfRJzo
 jtgulvJ3YHOCK57CDaBJqdNe/KRfQxFnvEwO/SQmXQyLFsGhjtrhKy3kHcDc/OKpDPmd
 un3lgnaoXqiUXdYmebJO6jK/YJu/f39CCUipjgDjAvz61eGcMOqIg4EtD62IB2YgoYZg
 N4zqKeLZ5YLHZmfKDEqLtRlTxtqie9PtFMs1EO7DSVNPgFxBaelhcES43cWUzRiohQ/Y
 vTbw==
X-Gm-Message-State: ABy/qLaX2LzTEpk53awGGbqKcD5bFzeBPVPzA4bDgekAGM+nV7zr+1lT
 1jOeWpNAggNPCRwwe+M86cxUFHeaYoJa05L9ncKW5T1OWihU0L4J21IgW76DY90qs+oiqLEkn6Z
 dmf9/LAwFGKz04So=
X-Received: by 2002:a5d:4fc8:0:b0:313:dfa2:1a85 with SMTP id
 h8-20020a5d4fc8000000b00313dfa21a85mr11755797wrw.27.1689594715218; 
 Mon, 17 Jul 2023 04:51:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHs3/Vk1doL/jnG17c92FzYiUtev180zRExjJ+8mdJ27pBNHSsawMYPXexpDu8lacKdUQPzw==
X-Received: by 2002:a5d:4fc8:0:b0:313:dfa2:1a85 with SMTP id
 h8-20020a5d4fc8000000b00313dfa21a85mr11755784wrw.27.1689594714872; 
 Mon, 17 Jul 2023 04:51:54 -0700 (PDT)
Received: from redhat.com ([2.52.146.77]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4b85000000b003143add4396sm18961960wrt.22.2023.07.17.04.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 04:51:54 -0700 (PDT)
Date: Mon, 17 Jul 2023 07:51:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Message-ID: <20230717075137-mutt-send-email-mst@kernel.org>
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
 <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 17, 2023 at 11:50:54AM +0100, Peter Maydell wrote:
> On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Eric Auger <eric.auger@redhat.com>
> >
> > When running on a 64kB page size host and protecting a VFIO device
> > with the virtio-iommu, qemu crashes with this kind of message:
> >
> > qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
> > with mask 0x20010000
> > qemu: hardware error: vfio: DMA mapping failed, unable to continue
> >
> > This is due to the fact the IOMMU MR corresponding to the VFIO device
> > is enabled very late on domain attach, after the machine init.
> > The device reports a minimal 64kB page size but it is too late to be
> > applied. virtio_iommu_set_page_size_mask() fails and this causes
> > vfio_listener_region_add() to end up with hw_error();
> >
> > To work around this issue, we transiently enable the IOMMU MR on
> > machine init to collect the page size requirements and then restore
> > the bypass state.
> >
> > Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> Hi; Coverity complains about this change (CID 1517772):
> 
> > +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
> > +{
> > +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
> > +    int granule;
> > +
> > +    if (likely(s->config.bypass)) {
> > +        /*
> > +         * Transient IOMMU MR enable to collect page_size_mask requirements
> > +         * through memory_region_iommu_set_page_size_mask() called by
> > +         * VFIO region_add() callback
> > +         */
> > +         s->config.bypass = false;
> > +         virtio_iommu_switch_address_space_all(s);
> > +         /* restore default */
> > +         s->config.bypass = true;
> > +         virtio_iommu_switch_address_space_all(s);
> > +    }
> > +    s->granule_frozen = true;
> > +    granule = ctz64(s->config.page_size_mask);
> > +    trace_virtio_iommu_freeze_granule(BIT(granule));
> 
> Specifically, in this code, it thinks that ctz64() can
> return 64, in which case BIT(granule) is shifting off
> the end of the value, which is undefined behaviour.
> This can happen if s->config.page_size_mask is 0 -- are
> there assertions/checks that that can't happen elsewhere?
> 
> Secondly, BIT() only works for values up to 32, since
> it works on type unsigned long, which might be a 32-bit
> type on some hosts. Since you used ctz64()
> you probably want BIT_ULL() which uses the ULL type
> which definitely has 64 bits.
> 
> thanks
> -- PMM

Thanks! Eric can you fix pls?

-- 
MST


