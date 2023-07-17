Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F03997569DB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRhF-00037h-2b; Mon, 17 Jul 2023 13:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLRhD-00035i-5f
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:07:39 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLRh9-0001e6-VY
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:07:38 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fb863edcb6so7713791e87.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 10:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689613653; x=1692205653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+DkjQKAxtsjyjgKk8q2Ve2hZeKhjAYd51K2Tdy9a3iU=;
 b=a3cwgL6ERhwt513fml574g5OjBYZ633gerse1scrKULZ7K5VSBzGkLoWP2IN1E5gIQ
 wPszLJ6mFOkcsBdQmggSDWEgh4OEzw12ds4BT/MPVynv+U7j9J5qQ6P9zCG6/ZJSECXd
 b85gt+T7XIem92sTkGjRSxYibKVwtlqSimesBsC0ABgghX6yOoviz6x296WYdy25LOuJ
 unMjIHn2t9ifOqL4oPsRMvqT0ZUpw6oMJp+URPw/BB0ziKm/zWbNN5XH3w+r05MP3wEB
 2pjeylKTZnwUFEEOuE121LBO4Uugpt0l2MyO9W4Fj5EoXoS9BCi/2HfJ3ckACE0zJCGI
 avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689613653; x=1692205653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DkjQKAxtsjyjgKk8q2Ve2hZeKhjAYd51K2Tdy9a3iU=;
 b=b9kQqNrNwMSU3yTKpLzSjgLM3CpGeNA3cDBUIrIUYSAZ0HMBDwkV8ZNLK3vGCzaCzD
 iQzjN36QecSyLiKI/LkDjeLGUL1LiNGgakLvJm5zZp0dgS2yKGl3gcQsQ0lP6+cw9jAt
 CfOEX1Bh8sSODvd/Xcs5gUtO/TvJT1iRAsiEzI9PHvx8dZ5oUNqPbA8ENZtqBB89TG5h
 OlSm44/wh8X41krHf15xBJ+kmwkjSVQGcmVzW4X0JU3gkQeZy2+UmtxD6+6KcrYby1VR
 B5JkehYwPszTcJHrnLfu0b1N6v/tsWpAP/GTM4g7gE8uL1z4CIyZXEJxAjYj1U659MBa
 Oriw==
X-Gm-Message-State: ABy/qLZOyMgksT/NfDWlpPlazthRA/gEvHqF128XTQnvGGJQ3EXiZtrw
 yRa5px1zAd0EAyXyYVzruMlOr99Bn1n6uYcUeqAp/A==
X-Google-Smtp-Source: APBJJlFBmQiQ0Kh6RUnGgNYvf6BGQT8X3vjrBl0iBYtt4Vukc9lW75bclfaL8qsGlE2mBNY/5W64PK6WnRuMtbNo0yM=
X-Received: by 2002:ac2:4570:0:b0:4fd:c882:bb42 with SMTP id
 k16-20020ac24570000000b004fdc882bb42mr509262lfm.15.1689613653486; Mon, 17 Jul
 2023 10:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
 <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
 <e59937b4-6965-2ff3-cc9f-a44ba589a5a3@redhat.com>
In-Reply-To: <e59937b4-6965-2ff3-cc9f-a44ba589a5a3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 18:07:22 +0100
Message-ID: <CAFEAcA-f_e0pKQ8fx5_ELd_snBo55DQ6BO8naBUazZ=nP3KHnA@mail.gmail.com>
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
To: eric.auger@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 17 Jul 2023 at 17:56, Eric Auger <eric.auger@redhat.com> wrote:
>
>
> Hi Peter,
> On 7/17/23 12:50, Peter Maydell wrote:
> > On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
> >> From: Eric Auger <eric.auger@redhat.com>
> >>
> >> When running on a 64kB page size host and protecting a VFIO device
> >> with the virtio-iommu, qemu crashes with this kind of message:
> >>
> >> qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
> >> with mask 0x20010000
> >> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> >>
> >> This is due to the fact the IOMMU MR corresponding to the VFIO device
> >> is enabled very late on domain attach, after the machine init.
> >> The device reports a minimal 64kB page size but it is too late to be
> >> applied. virtio_iommu_set_page_size_mask() fails and this causes
> >> vfio_listener_region_add() to end up with hw_error();
> >>
> >> To work around this issue, we transiently enable the IOMMU MR on
> >> machine init to collect the page size requirements and then restore
> >> the bypass state.
> >>
> >> Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Hi; Coverity complains about this change (CID 1517772):
>
> thank you for reporting the issue
> >
> >> +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
> >> +{
> >> +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
> >> +    int granule;
> >> +
> >> +    if (likely(s->config.bypass)) {
> >> +        /*
> >> +         * Transient IOMMU MR enable to collect page_size_mask requirements
> >> +         * through memory_region_iommu_set_page_size_mask() called by
> >> +         * VFIO region_add() callback
> >> +         */
> >> +         s->config.bypass = false;
> >> +         virtio_iommu_switch_address_space_all(s);
> >> +         /* restore default */
> >> +         s->config.bypass = true;
> >> +         virtio_iommu_switch_address_space_all(s);
> >> +    }
> >> +    s->granule_frozen = true;
> >> +    granule = ctz64(s->config.page_size_mask);
> >> +    trace_virtio_iommu_freeze_granule(BIT(granule));
> > Specifically, in this code, it thinks that ctz64() can
> > return 64, in which case BIT(granule) is shifting off
> > the end of the value, which is undefined behaviour.
> > This can happen if s->config.page_size_mask is 0 -- are
> > there assertions/checks that that can't happen elsewhere?
> To me this cannot happen. The page_size_mask is initialized with
> qemu_target_page_mask(), then further constrained with
> virtio_iommu_set_page_size_mask() which would call error_setg if the new
> mask is 0 or (cur_mask & new_mask) == 0
>
> What can I do to give coverity a hint that page_size_mask cannot be NULL?

You can assert() it if you believe it to be true and you
think an assert() would help a human reader,
or we could just say "this is a false positive" and
mark it that way in the Coverity UI. We don't need to
change things purely to make Coverity happy.

> > Secondly, BIT() only works for values up to 32, since
> > it works on type unsigned long, which might be a 32-bit
> > type on some hosts. Since you used ctz64()
> > you probably want BIT_ULL() which uses the ULL type
> > which definitely has 64 bits.
> agreed.

Looking more closely at this, the file is not entirely
consistent about how it handles the page_size_mask:
 * in virtio_iommu_translate() we call ctz32()
   and then use an open-coded 1 << n on that
 * in virtio_iommu_set_page_size_mask() we call
   ctz64() and use BIT()
 * in virtio_iommu_freeze_granule() we call ctz64()
   and then use BIT()

So I suspect it's actually true (or at least assumed)
that the granule value can never be 32 or higher, as
well as it being non-zero.

thanks
-- PMM

