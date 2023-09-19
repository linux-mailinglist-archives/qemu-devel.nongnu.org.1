Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DD7A68EE
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidbU-0003Y0-NP; Tue, 19 Sep 2023 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qidbS-0003Xc-9t
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:29:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qidbQ-00025B-Jh
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695140971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSpyt9yaHxXmhZl+ScKvKwZjGb7cAU2iZGF6XKcSbrY=;
 b=fUZRwt9Ow38lyNJnCPEkkkQ8P3G6RCi34c5QNGIC4drJlBatSIjjQBHIb10lPBfiXdBUsy
 7g9sf/pVTDYTE6QYAlDYNLuKmMyWlfYRX10MlxHBLnaYwsrqzYDZqLI8l9IwHUTgpfF+P/
 t+F++OM8svXVyeWf0VNzBQXvSLAgiOo=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-lqIV7RVxPbSP9ZD7fK2luA-1; Tue, 19 Sep 2023 12:29:29 -0400
X-MC-Unique: lqIV7RVxPbSP9ZD7fK2luA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-79524453b83so494079239f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695140968; x=1695745768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSpyt9yaHxXmhZl+ScKvKwZjGb7cAU2iZGF6XKcSbrY=;
 b=D0xYanj5HYhw5hB543PpLpE6ErUH92Ew6QBjjaHksLQykYw/zy6ksoznuxZOS4DnKf
 q8xOW1trCl2WDE5T11MTEiOrAHSAn81dbOSgdEbSmXvhCHT9kdwBADDNLLvunanWOjhc
 +BQseWNXvhYPrO2YCXbLix28m6c11GIDkXZyNqUJo+bFIEHmFfC2qMqrXpfePTwxHwUy
 57YOcrHYYpS/Yf9TPRg21QNtmAWqOjtKjhMfUXiK2tRLceI0hifwzsVPgM3OFp2AEUwQ
 8DXG4B5ssqJdiE2ml0Qz1ULul9UB3GCKOhUa/bOIbP3udccZK0hAKt1oXf/r81Tirf5M
 OSMg==
X-Gm-Message-State: AOJu0Yzm+6QjVxsRscpQrSHTnrek7oTogYr0voUVF470yMaCoJPP5cej
 /wwee/NljFL9fbpBr+WSzYvFYGCmijR8Am3VxwU6pVApWnsXU7uARBQf61x70eKCUBHKY8hNCqw
 Jfgs8ZBAewNqsmrc=
X-Received: by 2002:a5d:87c6:0:b0:790:c3d0:8f87 with SMTP id
 q6-20020a5d87c6000000b00790c3d08f87mr356254ios.19.1695140968381; 
 Tue, 19 Sep 2023 09:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl+RUX02YgswOlpACNoyCku4XYfKfP+G01H5iH26O78iXYybwcOWR2eIeHS1QX3rV8gNB4IQ==
X-Received: by 2002:a5d:87c6:0:b0:790:c3d0:8f87 with SMTP id
 q6-20020a5d87c6000000b00790c3d08f87mr356226ios.19.1695140968053; 
 Tue, 19 Sep 2023 09:29:28 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 l4-20020a6b7f04000000b007835a305f61sm3301527ioq.36.2023.09.19.09.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:29:27 -0700 (PDT)
Date: Tue, 19 Sep 2023 10:29:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 06/12] range: Introduce range_inverse_array()
Message-ID: <20230919102926.54f92f47.alex.williamson@redhat.com>
In-Reply-To: <20230913080423.523953-7-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-7-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 13 Sep 2023 10:01:41 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> This helper reverses an array of regions, turning original
> regions into holes and original holes into actual regions,
> covering the whole UINT64_MAX span.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - Move range_inverse_array description comment in the header
> - Take low/high params
> ---
>  include/qemu/range.h |  8 ++++++++
>  util/range.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/include/qemu/range.h b/include/qemu/range.h
> index 7e2b1cc447..2b59e3bf0c 100644
> --- a/include/qemu/range.h
> +++ b/include/qemu/range.h
> @@ -219,4 +219,12 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
>  
>  GList *range_list_insert(GList *list, Range *data);
>  
> +/*
> + * Inverse an array of sorted ranges over the [low, high] span, ie.
> + * original ranges becomes holes in the newly allocated inv_ranges
> + */
> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
> +                         uint32_t *nr_inv_ranges, Range **inv_ranges,
> +                         uint64_t low, uint64_t high);
> +
>  #endif
> diff --git a/util/range.c b/util/range.c
> index 098d9d2dc0..4baeb588cc 100644
> --- a/util/range.c
> +++ b/util/range.c
> @@ -70,3 +70,48 @@ GList *range_list_insert(GList *list, Range *data)
>  
>      return list;
>  }
> +
> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
> +                         uint32_t *nr_inv_ranges, Range **inv_ranges,
> +                         uint64_t low, uint64_t high)

Rare be it for me to suggest GLib, but we already appear to have
range_list_insert() making use of GList for an ordered list of Ranges.
Doesn't this function become a lot easier if we take a sorted GList,
walk it to create the inverse, and return a new GList of the inverted
Ranges?  Seems the initial sorted GList would be created by making use
of the existing range_list_insert() function.  Thanks,

Alex

> +{
> +    Range *resv;
> +    int i = 0, j = 0;
> +
> +    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
> +
> +    for (; j < nr_ranges  && (range_upb(&ranges[j]) < low); j++) {
> +        continue; /* skip all ranges below mon */
> +    }
> +
> +    if (j == nr_ranges) {
> +        range_set_bounds(&resv[i++], low, high);
> +        goto realloc;
> +    }
> +
> +    /* first range lob is greater than min, insert a first range */
> +    if (range_lob(&ranges[j]) > low) {
> +        range_set_bounds(&resv[i++], low,
> +                         MIN(range_lob(&ranges[j]) - 1, high));
> +    }
> +
> +    /* insert a range inbetween each original range until we reach max */
> +    for (; j < nr_ranges - 1; j++) {
> +        if (range_lob(&ranges[j]) >= high) {
> +            goto realloc;
> +        }
> +        if (range_compare(&ranges[j], &ranges[j + 1])) {
> +            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
> +                             MIN(range_lob(&ranges[j + 1]) - 1, high));
> +        }
> +    }
> +    /* last range upb is less than max, insert a last range */
> +    if (range_upb(&ranges[j]) <  high) {
> +        range_set_bounds(&resv[i++],
> +                          range_upb(&ranges[j]) + 1, high);
> +    }
> +realloc:
> +    *nr_inv_ranges = i;
> +    resv = g_realloc(resv, i * sizeof(Range));
> +    *inv_ranges = resv;
> +}


