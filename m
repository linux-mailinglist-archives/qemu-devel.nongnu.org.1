Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F805780DC1
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:13:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05v-00052f-TQ; Fri, 18 Aug 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWxEL-0003wQ-Us
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:01:26 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWxEH-0002qu-1L
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 07:01:25 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so1122507e87.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692356456; x=1692961256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jWR/H3Fx3maf4deZQaN0CobAw+W+WIoK9ipv1S9tXQE=;
 b=vUoKh0hXFHP6Hx0KDiOWFoyDJSji99TW5xf5egsdUyYhh85BvZ25q/slkmGlPfNATX
 F/buvQk8FySJFlZuVPO/esA3OZE87PYoGSgkArGjsRUvD+cy0A2eFklixOQkYxCRRt74
 CnUeYC1AMpAQ/zfwP9PTx0izhU4SFMqmOrXY+1aTWb3Ym7zl5f1u/kj9diwbOWWXtU7U
 KzoPjuk19xviwmPLXet2GBGB3gVWeqMoPVwYqj//v+VTeg0AWJI98c+Z3P53rrlH21tF
 hK7Obun1zQBPwQXEz3WIQ+PwpkR1+9vYVKWzjMCTOlJ3i6MzgzNtc3Ndt4aXwDS7miOn
 4guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692356456; x=1692961256;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWR/H3Fx3maf4deZQaN0CobAw+W+WIoK9ipv1S9tXQE=;
 b=ebYJgpLsO3U35xfqcek7d899m/3vb54yO5nDdndA40YYeifnzwO6SgEhN4pd9G2KbF
 PuxJ2CvPdjvTFaq3Sm8JbH+w4No6puHfiZBuqrvchT/sFv7CxtsMkgrZ+kK6+330Bwij
 oeRIKeXQ8ZBT6ZCrfZ9cwk8suGpEG1DC6eTe2Fsx+joDlsSB1bOq6vprIvaQZg8yj7g2
 38n407NZscb/VKtNEydnCotyk6kl5ploSqx+cu1VA08x6ga5+7Tis6aS/XubW8aLKkCa
 U4TTmt+vPNHXVoL51Gfpyd7Q4f0t31A+oGgQmL408axf4mTfNQVyH4J7+HrHpS0J2v3z
 d8HQ==
X-Gm-Message-State: AOJu0Yy9I1fgwp3bX1g7GUKB4dTeGGXRxlbhv9uZpbzxl/m62boDIE3+
 6ppeqWqn4MKqIin7GJAxK7C2lA==
X-Google-Smtp-Source: AGHT+IGTA9ukeQULAkqEkLGQXPxCl3ViVT5DpeQTuiQ7DPbmop9W3DIbltCd0j3DVJvZt2n8pl1nrg==
X-Received: by 2002:ac2:4f0a:0:b0:4fe:8f0:6aa with SMTP id
 k10-20020ac24f0a000000b004fe08f006aamr1549632lfr.49.1692356455709; 
 Fri, 18 Aug 2023 04:00:55 -0700 (PDT)
Received: from [192.168.24.175] ([92.88.170.62])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a7bc044000000b003fe2bea77ccsm2442611wmc.5.2023.08.18.04.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 04:00:55 -0700 (PDT)
Message-ID: <e24e67e0-fd01-6374-3bb7-1a73a35b48da@linaro.org>
Date: Fri, 18 Aug 2023 13:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/6] hw/virtio/vhost-vdpa: Use target-agnostic
 qemu_target_page_mask()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230710094931.84402-1-philmd@linaro.org>
 <20230710094931.84402-5-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230710094931.84402-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping?

On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
> Similarly to commit e414ed2c47 ("virtio-iommu: Use
> target-agnostic qemu_target_page_mask"), Replace the
> target-specific TARGET_PAGE_SIZE and TARGET_PAGE_MASK
> definitions by a call to the runtime qemu_target_page_size()
> helper which is target agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost-vdpa.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a3dd7c712a..2717edf51d 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -14,6 +14,7 @@
>   #include <linux/vfio.h>
>   #include <sys/eventfd.h>
>   #include <sys/ioctl.h>
> +#include "exec/target_page.h"
>   #include "hw/virtio/vhost.h"
>   #include "hw/virtio/vhost-backend.h"
>   #include "hw/virtio/virtio-net.h"
> @@ -23,7 +24,6 @@
>   #include "migration/blocker.h"
>   #include "qemu/cutils.h"
>   #include "qemu/main-loop.h"
> -#include "cpu.h"
>   #include "trace.h"
>   #include "qapi/error.h"
>   
> @@ -313,9 +313,11 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>       Int128 llend, llsize;
>       void *vaddr;
>       int ret;
> +    int page_size = qemu_target_page_size();
> +    int page_mask = -page_size;
>   
>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> -                                            v->iova_range.last, TARGET_PAGE_MASK)) {
> +                                            v->iova_range.last, page_mask)) {
>           return;
>       }
>       if (memory_region_is_iommu(section->mr)) {
> @@ -323,14 +325,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> -    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
> +                 (section->offset_within_region & ~page_mask))) {
>           error_report("%s received unaligned region", __func__);
>           return;
>       }
>   
> -    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
> +    llend = vhost_vdpa_section_end(section, page_mask);
>       if (int128_ge(int128_make64(iova), llend)) {
>           return;
>       }
> @@ -396,23 +398,25 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>       hwaddr iova;
>       Int128 llend, llsize;
>       int ret;
> +    int page_size = qemu_target_page_size();
> +    int page_mask = -page_size;
>   
>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> -                                            v->iova_range.last, TARGET_PAGE_MASK)) {
> +                                            v->iova_range.last, page_mask)) {
>           return;
>       }
>       if (memory_region_is_iommu(section->mr)) {
>           vhost_vdpa_iommu_region_del(listener, section);
>       }
>   
> -    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +    if (unlikely((section->offset_within_address_space & ~page_mask) !=
> +                 (section->offset_within_region & ~page_mask))) {
>           error_report("%s received unaligned region", __func__);
>           return;
>       }
>   
> -    iova = ROUND_UP(section->offset_within_address_space, TARGET_PAGE_SIZE);
> -    llend = vhost_vdpa_section_end(section, TARGET_PAGE_MASK);
> +    iova = ROUND_UP(section->offset_within_address_space, page_size);
> +    llend = vhost_vdpa_section_end(section, page_mask);
>   
>       trace_vhost_vdpa_listener_region_del(v, iova,
>           int128_get64(int128_sub(llend, int128_one())));


