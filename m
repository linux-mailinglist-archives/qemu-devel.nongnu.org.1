Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A67560EB
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:51:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLp0-0002Cq-7d; Mon, 17 Jul 2023 06:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLov-0002CT-3s
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:51:13 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLLor-0005Gh-Fc
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:51:12 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fdb856482fso1905088e87.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689591065; x=1692183065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OSfY3MWX5ezkd6M6PYHgP6KJJswEkdvFVedFl2YAGCM=;
 b=Lqp9LPytqzW2wOA1VeXqqHj7VAc2ioPy6nAX5JJIYqusREAefaP8j9zipbG+OncJLm
 HKuSut/u/WxUeHABGH9FQIYe3IrYY0j9010SEuFu+V36dWZldbcXPa1UJcOw1HqYt6T9
 MYjUPlS5d0d7eUAiXYCXE1/OGt6r6BksB8FFrjHlDB2nuUkhGhivkPWh3VFtpZXqNxSW
 yheZ81FkXyxsja6fLsd3JMcw3PaHx5GFBd9BjW7m29FtAoeuwcg/u4nBS8u9KliKtXbC
 NrBIYaz6jHDe3LyXK6lffw7eeaGC1Z6VsisIdOIvnYql+FGz3o7fBohy6QCEgSlGFz7G
 taXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689591065; x=1692183065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OSfY3MWX5ezkd6M6PYHgP6KJJswEkdvFVedFl2YAGCM=;
 b=gngOLtGsNxzHTxQdlAvy02DaWFivuHK6jSv3mYWQQ2j3rUWxyrtF5pvVGj9dv+6J0E
 dRHwY/ShlSDQyqwreLhz2bO2Bu60SsPAxn9DazuW6jm5HBDnlwkh4TefiJWXDbOu3PTU
 I4FNDOCV8KQ+MrLP4e24eoEsYbY32jXQYpN7jQ6jw7yJTsh/RUwfbD2LpsCG1xf1V63l
 OO2bLbHUESXUB+xSOYduTXpz8UboFWrzBZGqoq+fF2G03zXnkjNDV73P3zwS6pTKVZyZ
 9QylAki9S3BlWr2jALgYbTSTeIlEZ9m++T6JS4gI0ohTZaQDSknqhbdLkebCCZ+UWONb
 R4BQ==
X-Gm-Message-State: ABy/qLZ1HgTers0WCwXFpCNSlO9p+OB5zdDvnTfvvLbLdzGY2+1mgIgW
 d2M5IP91xAixkMG9JEBkXv8PyD3zk5ji42eHqFiUjA==
X-Google-Smtp-Source: APBJJlERsILDj/Qx+GaND5UOUbzd6d04M0WolFxZ8LyCugSgHKntyH+5VQOutDz9v7z+LpyaIsyKHyTrbGSWYfVrWM4=
X-Received: by 2002:a05:6512:2346:b0:4fb:7447:e71a with SMTP id
 p6-20020a056512234600b004fb7447e71amr7859880lfu.63.1689591065026; Mon, 17 Jul
 2023 03:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
In-Reply-To: <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 11:50:54 +0100
Message-ID: <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> When running on a 64kB page size host and protecting a VFIO device
> with the virtio-iommu, qemu crashes with this kind of message:
>
> qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
> with mask 0x20010000
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>
> This is due to the fact the IOMMU MR corresponding to the VFIO device
> is enabled very late on domain attach, after the machine init.
> The device reports a minimal 64kB page size but it is too late to be
> applied. virtio_iommu_set_page_size_mask() fails and this causes
> vfio_listener_region_add() to end up with hw_error();
>
> To work around this issue, we transiently enable the IOMMU MR on
> machine init to collect the page size requirements and then restore
> the bypass state.
>
> Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Hi; Coverity complains about this change (CID 1517772):

> +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
> +{
> +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
> +    int granule;
> +
> +    if (likely(s->config.bypass)) {
> +        /*
> +         * Transient IOMMU MR enable to collect page_size_mask requirements
> +         * through memory_region_iommu_set_page_size_mask() called by
> +         * VFIO region_add() callback
> +         */
> +         s->config.bypass = false;
> +         virtio_iommu_switch_address_space_all(s);
> +         /* restore default */
> +         s->config.bypass = true;
> +         virtio_iommu_switch_address_space_all(s);
> +    }
> +    s->granule_frozen = true;
> +    granule = ctz64(s->config.page_size_mask);
> +    trace_virtio_iommu_freeze_granule(BIT(granule));

Specifically, in this code, it thinks that ctz64() can
return 64, in which case BIT(granule) is shifting off
the end of the value, which is undefined behaviour.
This can happen if s->config.page_size_mask is 0 -- are
there assertions/checks that that can't happen elsewhere?

Secondly, BIT() only works for values up to 32, since
it works on type unsigned long, which might be a 32-bit
type on some hosts. Since you used ctz64()
you probably want BIT_ULL() which uses the ULL type
which definitely has 64 bits.

thanks
-- PMM

