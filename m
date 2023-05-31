Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB6718B58
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ScP-0001Vo-KO; Wed, 31 May 2023 16:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ScH-0001HU-7I
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:40:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4Sbq-0003mi-2d
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:40:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso1095475e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565592; x=1688157592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AO6SLfobAhRU8wjQdcOM77CoB8S2Q0x1N8/B5RDXYO8=;
 b=VWbgn57lIfRNNcZwBKffUB1IOwR7WopI1wF2llz/Uh9LeHbP0hKlGOyaqX1R6kpAcf
 nqNraTydHYKkeSia+vvd5ex2W8Jx44v6Tvb1CeTNhMMrdvnWr0kdL2CrtGaGqSv9QYkH
 8wScjUCVio3u2ZN4b8AT3q07JIznrNMXH8v4/ZElUsYAPdjsefyKsZJ3Wga+a8kJfngy
 K+zevVALre04LqdnFm4NPfa5tIRmcrJhzwCajOToP03+WJvHCH1Grtf1bbWU8w3vHJXx
 wlwy6DJEecr9FiZJK/2FdUvutT6YexSrNlpcmqT+MZnGNLhHgPFlF4lu1HW2VGRx6mAW
 94HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565592; x=1688157592;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AO6SLfobAhRU8wjQdcOM77CoB8S2Q0x1N8/B5RDXYO8=;
 b=BJCiMhQ10qWY3Ioh6or/2vjGClUzWJZNVQtL8XXGeNwmlmCZsL0H6v1zSKC9P8vQzi
 6w4lyENgiau1wvqT8cNYvXEEJJ8vQfeq/PmFyGtcflduUO65ckWGKJNmM6wWVwNT2hc9
 UIMAFg/HAN5d5aSRqzjnmRUJuPPcqwq1CpMDelcCBBbZkjlzdFXRXUnnav+cX4MHwU3F
 g/lOsx4ADHWZTghsyEuk7ADjZwuJomneBLVydikHC9H9T52Z6DprCsUgJeKt8mKPLMi9
 tRbSUUG/xqqAJL/KbYFClPrXtO79binGnKvkA5s1d29vQOUKNk7Ltb0hmKlma2pbOPte
 RkVA==
X-Gm-Message-State: AC+VfDwJAq+KirZjej1qj+CV6I5EY4/jL708pKXK+lINY8SlohPakPij
 2eBcDrjZBHUYEm9jVBYi3IcM1YAy4mrUbFougnc=
X-Google-Smtp-Source: ACHHUZ4E+kHHY92qaLVFHe+SIyFxk1qpGkv0N24t6GYn3ojtsSeBIUEQWm6r+ev38ezK7J8vSeY1fA==
X-Received: by 2002:a1c:7301:0:b0:3f4:2267:10c0 with SMTP id
 d1-20020a1c7301000000b003f4226710c0mr391325wmb.28.1685565591719; 
 Wed, 31 May 2023 13:39:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a05600c294b00b003f6129d2e30sm25507481wmd.1.2023.05.31.13.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 13:39:51 -0700 (PDT)
Message-ID: <816d1209-09ba-7d28-95c7-5381be0b2c06@linaro.org>
Date: Wed, 31 May 2023 22:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 00/10] hw/virtio: Build various target-agnostic objects
 just once
Content-Language: en-US
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20230524093744.88442-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Michael,

On 24/5/23 11:37, Philippe Mathieu-Daudé wrote:
> All patches reviewed.

Could you take this series via your virtio tree?

Thanks!

Phil.

> Less controvertial than my first approach [*] which caches
> the access_is_big_endian value in VirtIODevice state, this
> series just remove a unnecessary / pointless dependency on
> "virtio-access.h", allowing to build various virtio objects
> once for all targets.
> 
> [*] https://lore.kernel.org/qemu-devel/20221212230517.28872-11-philmd@linaro.org/
> 
> Philippe Mathieu-Daudé (10):
>    softmmu: Introduce qemu_target_page_mask() helper
>    hw/scsi: Introduce VHOST_SCSI_COMMON symbol in Kconfig
>    hw/scsi: Rearrange meson.build
>    hw/scsi: Rename target-specific source set as
>      'specific_virtio_scsi_ss'
>    hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in Kconfig
>    hw/virtio/virtio-mem: Use qemu_ram_get_fd() helper
>    hw/virtio/vhost-vsock: Include missing 'virtio/virtio-bus.h' header
>    hw/virtio/virtio-iommu: Use target-agnostic qemu_target_page_mask()
>    hw/virtio: Remove unnecessary 'virtio-access.h' header
>    hw/virtio: Build various target-agnostic objects just once


