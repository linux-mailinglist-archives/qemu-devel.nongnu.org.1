Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20FBF7ABE
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 18:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFHH-0008Vl-9F; Tue, 21 Oct 2025 12:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBFGm-0008Lz-NC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBFGg-0003jO-E0
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761064284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DN5Kj7beOW1WXeHp490VMw02KqEfV1aQ0N2QPzsnpMY=;
 b=Wy9hj38lMzS2C5/NYeZs7oQQVzocx6IdY8bvFBygScr/xWjJAQLgyj6DiJ05aEYWFsyFHN
 yoDOW825XrM2c9VVaIb1TvWKAq2Y5vgbhEJFUbSkJv1mROQidyu/1zPZnBMXVYfFdcwV1S
 OJCha3L6n4c/3dnIRfnnwcMk/WTwDnA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-2Z3WtM-uPgO5MV0fEidADA-1; Tue, 21 Oct 2025 12:31:22 -0400
X-MC-Unique: 2Z3WtM-uPgO5MV0fEidADA-1
X-Mimecast-MFC-AGG-ID: 2Z3WtM-uPgO5MV0fEidADA_1761064278
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-471144baa7eso25157705e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761064278; x=1761669078;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DN5Kj7beOW1WXeHp490VMw02KqEfV1aQ0N2QPzsnpMY=;
 b=GkklaxTVh075mQiTvlOg65L1sTJ991rm7UId6uzKBLWwvLeQvyG0ysPO2VCQbrVJyb
 AbbxfGqRbuPGrlfY4Tl0WQyWlT8VDj0bVr8vtAAIypJ+IM8pmW41UGX106qcx79l3DYk
 Mv9NpvpwcntVW6aSNOUYrrqzx4WxjN9GqmwXNDPooj858IpqGBY5fci2X5HeBVlLQkEJ
 4OvvXNUBku1SxCVAnIBzhlUZRuiRt4re1zeJe8AwcCbcPNISLj1yeS9xmeGVqxgOh4pf
 XIM5bn2EXB8qCxGCTBHUR8tGoqV3SQG2NJAlrdGOIxwhhjFWxpepICaysf3DYWokaRxy
 Gasg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzBggOPiflGs/WKVNzL1PgsAfZh92ThOODXwQQmc1epji0Wx1I0r7qVq1zJEig1DZfev6AN1jIupNO@nongnu.org
X-Gm-Message-State: AOJu0YzHUsLZ6R+9PSBX9lYVo1H5eAK4uVYZZW96HGeMtUGj20VNuAYx
 uLufSQ1PQ6Ex+UG8U0gC99HAVaKUXcEXEQdR636YKCvqAo35uHnu/XmNdyluI/32xlh3t8EqFF5
 wDbQM0wcGLNSNZ2ja+S6/sA71R72VjFrdJ43mg0z1nf4zON9bbyyvV8V2
X-Gm-Gg: ASbGncuV8LdE/LIi4pDpmslZOtkZfnFK6GeBzx8Szq8epfVM3YBs/EJmj4dmfYNPzKn
 5shzaN4q8eXZFbLXLgUuy+1uUHrl43MCpRpu8vh7PIoMrt/UTOeqZ2w7rIsbaR+Dvof1lX/w723
 CtK4jY7rJ6do35ppoApB52GE+ztyF3imI0Ix4hzsrJL+fq1GlwaEGy4vnQTPc9+E15Hjwo9SG0j
 SYVcb5sG823EPjju4HYZJzLi3F3sjOxYUbdpD7cykdxEh3rCtqSDOLSgegVFSLzSmFtQULacGvl
 PXs6yDoyKU+4Zx2pXMgmhrLzV9V20PqiYUZPAPjJm2Pgd7qryBbaits6G24MXfON9sC3jTBEOsS
 78IAuAQkZIxVkxqWJHgo1ctA0q8XbT8eQ4R2V3w==
X-Received: by 2002:a05:600c:1d9c:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-47117917babmr144701285e9.31.1761064278329; 
 Tue, 21 Oct 2025 09:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCT9lDPboO9ag33cYriNYPlBdk8AL2tqo8GqRxX+0rfxOA20xwxCFnSgWcOE9TeIT+XD1Pg==
X-Received: by 2002:a05:600c:1d9c:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-47117917babmr144700945e9.31.1761064277852; 
 Tue, 21 Oct 2025 09:31:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428c62fsm671495e9.8.2025.10.21.09.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:31:17 -0700 (PDT)
Message-ID: <c5381a4d-74b2-4352-b3f3-c0d39a438dd6@redhat.com>
Date: Tue, 21 Oct 2025 18:31:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/vfio/migration: Check base architecture at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Anton Johansson <anjo@rev.ng>,
 Alex Williamson <alex.williamson@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251021161707.8324-1-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251021161707.8324-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/21/25 18:17, Philippe Mathieu-Daudé wrote:
> Inline vfio_arch_wants_loading_config_after_iter() and
> replace the compile time check of the TARGET_ARM definition
> by a runtime call to target_base_arm().

What's the value of a runtime check of target ARM ? Please explain.

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Supersedes: <20251020222315.68963-1-philmd@linaro.org>
> Based-on: <20251020220941.65269-1-philmd@linaro.org>


OK. Will consider when this is merged.

Thanks,

C.



> https://lore.kernel.org/qemu-devel/20251020221508.67413-5-philmd@linaro.org/
> ---
>   hw/vfio/vfio-helpers.h      |  2 --
>   hw/vfio/helpers.c           | 17 -----------------
>   hw/vfio/migration-multifd.c | 12 +++++++++++-
>   3 files changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
> index ce317580800..54a327ffbc0 100644
> --- a/hw/vfio/vfio-helpers.h
> +++ b/hw/vfio/vfio-helpers.h
> @@ -32,6 +32,4 @@ struct vfio_device_info *vfio_get_device_info(int fd);
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
> -bool vfio_arch_wants_loading_config_after_iter(void);
> -
>   #endif /* HW_VFIO_VFIO_HELPERS_H */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index 23d13e5db5f..9a5f6215455 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -209,20 +209,3 @@ retry:
>   
>       return info;
>   }
> -
> -bool vfio_arch_wants_loading_config_after_iter(void)
> -{
> -    /*
> -     * Starting the config load only after all iterables were loaded (during
> -     * non-iterables loading phase) is required for ARM64 due to this platform
> -     * VFIO dependency on interrupt controller being loaded first.
> -     *
> -     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> -     * the right place in VFIO migration").
> -     */
> -#if defined(TARGET_ARM)
> -    return true;
> -#else
> -    return false;
> -#endif
> -}
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index e4785031a73..b0eea0de678 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -16,6 +16,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
> +#include "qemu/target-info.h"
>   #include "qemu/thread.h"
>   #include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
> @@ -44,7 +45,16 @@ bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>       }
>   
>       assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
> -    return vfio_arch_wants_loading_config_after_iter();
> +
> +    /*
> +     * Starting the config load only after all iterables were loaded (during
> +     * non-iterables loading phase) is required for ARM64 due to this platform
> +     * VFIO dependency on interrupt controller being loaded first.
> +     *
> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
> +     * the right place in VFIO migration").
> +     */
> +    return target_base_arm();
>   }
>   
>   /* type safety */


