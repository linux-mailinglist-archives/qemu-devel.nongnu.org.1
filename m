Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E474B420
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnKb-00083L-5F; Fri, 07 Jul 2023 11:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHnKY-00082r-J4
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:25:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHnKW-0004hk-W8
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:25:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbab0d0b88so27953425e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743507; x=1691335507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pq5rOSjo84qNYMYnGvkPqfDjHSVDoIcIKZWcz6gNrYk=;
 b=rkXTpIQtwSWCQHzdlgyLdKQtEgkmQnNMyMZUxfvxwUjj5R8zx2JjIWeYmzdB3zVJle
 werOUJ5Kpr/p315V/2iYqga4HLt8yd9lhiglq9DZGgp61E4skCQwlxY+a5peHYbqfJLP
 4jbUSSJCjQz9Ouzon4PJZsPRCr056JDdKNd92eAAVskwGBpXorDYqeS/wvaq8Pdat20x
 fO3eepyFV0Axx3rwELB/iCCd6QaYhpKRzKycxwBJfjLNE0G44dePyJbkPrTbPcf7Shvd
 RJwIVUpAhUqcbD+zeh6NN86B5wup5RPGDb1Kc2R/uUAy3IZX5mlgu2NIGTk0WSwPPvGC
 qhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743507; x=1691335507;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pq5rOSjo84qNYMYnGvkPqfDjHSVDoIcIKZWcz6gNrYk=;
 b=XzVnVjHyOb6z/GsUvUi4dVHPQw0DyTX3DJutLlfj11S84cpRvzj8cSS3ni6xwCWCOv
 qHmZH5LvNDcbnXP5RI3cNn4RQYfPcnNtLTjh7ZG/KQSGWbHXlk78wAtnjyWVCzO++3Fj
 cqYQLZgDiFx+zNEdwzFfTTr65tQdadXiVfCjG5A/IYEWpFxAPhi98tm7BJZag33fyY/6
 ASPiuYhVcLRi3yV64O7KVOHCiucd+ZZhvxjjk8iZsWvcfZJHToqUmAcNU4UxQo7JB1VR
 jjuIsoNttzPnlgeVs5jkke2VxRja5ApZlnR5yYCUIBjE428KLKnnGLVCCKTi3kfg30QW
 fJPw==
X-Gm-Message-State: ABy/qLbZilYzDzSUXMWD9R3t1AlI5G2K4YqaMK7XaNXRuCVDaJUmys1/
 rqyrPEKVLuH3WXjycIIDlln1cA==
X-Google-Smtp-Source: APBJJlHZ4s10/iq5YXJvr349eJXlONjK1bnF1iehlmn/KB0U+25gJ/v55c0EhaO90xd6wlc4VDmYdg==
X-Received: by 2002:adf:f08f:0:b0:314:1f0:5846 with SMTP id
 n15-20020adff08f000000b0031401f05846mr7621310wro.19.1688743506817; 
 Fri, 07 Jul 2023 08:25:06 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 f19-20020a7bcc13000000b003fa973e6612sm2743921wmh.44.2023.07.07.08.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 08:25:06 -0700 (PDT)
Date: Fri, 7 Jul 2023 16:25:06 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, clg@redhat.com, bharat.bhushan@nxp.com,
 peter.maydell@linaro.org
Subject: Re: [PATCH v2 0/2] VIRTIO-IOMMU/VFIO page size related fixes
Message-ID: <20230707152506.GB4060098@myrica>
References: <20230705165118.28194-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705165118.28194-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
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

On Wed, Jul 05, 2023 at 06:51:16PM +0200, Eric Auger wrote:
> When assigning a host device and protecting it with the virtio-iommu we may
> end up with qemu crashing with
> 
>     qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>     with mask 0x20010000
>     qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> This happens if the host features a 64kB page size and constraints
> the physical IOMMU to use a 64kB page size. By default 4kB granule is used
> by the qemu virtio-iommu device and this latter becomes aware of the 64kB
> requirement too late, after the machine init, when the vfio device domain is
> attached. virtio_iommu_set_page_size_mask() fails and this causes
> vfio_listener_region_add() to end up with hw_error(). Currently the
> granule is global to all domains.
> 
> To work around this issue, despite the IOMMU MR may be bypassed, we
> transiently enable it on machine init done to get vfio_listener_region_add
> and virtio_iommu_set_page_size_mask called ealier, before the domain
> attach. That way the page size requirement can be taken into account
> before the guest gets started.
> 
> Also get benefit of this series to do some cleanups in some traces
> which may confuse the end user.

For both patches:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


