Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2B7A73FC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:25:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirZu-0000zE-GX; Wed, 20 Sep 2023 03:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirZq-0000vm-9j
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:24:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirZo-0002YA-0b
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695194686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbLxZs5hp6EZUd06gOFVdm/0T0RHhfbJ9sH9kf2evZ4=;
 b=RgWNAgCdnGJgevqDI4fBv8LennsmFOR218dL6q6fbNyiTBp0PghJHsZEb9wHbzBRbUcnVm
 ycyfSHzVBFqoG9XBx6GgOOTIrKeGbW7ZTayChyxCvmcOuaT7AaochlQIWXUrAQEeg7ssvm
 WVAZO6v+91hixClzWjUgP/M9X/gQxiE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-h94SlGHyPnaypcrtFgTkDQ-1; Wed, 20 Sep 2023 03:24:44 -0400
X-MC-Unique: h94SlGHyPnaypcrtFgTkDQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6564515eca8so48121816d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 00:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695194684; x=1695799484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbLxZs5hp6EZUd06gOFVdm/0T0RHhfbJ9sH9kf2evZ4=;
 b=wQWDoLjhwK8FI4+gOdE8XTKFf+aCLhjBR32HHVfqGn5Rb8pWI4J/pR/oq2fZ97aWQ2
 fh4wISZY2ay69r5Cl+4L4wFmUfUMehONebm6KQQd+KNZWuVVcLZrwkuw9yB3kdaqYatQ
 s9LjP14MF0S3eeKq5VH6Ou/5IswGyApg6Ka2R/solZbTyzcdXFmf7sBovR/kfcfG3R23
 IMXzcXzUfJgvb7y/x0LmsIja60oXi1K0QYMS2OfVrsxL9fRIq5OZP5XqHQDxPBlkXUiE
 7vLKr/j8BH6bwuXtAvK4W24LVuuTZY6bW+nNd0FP6Zih6XRmnehhujw7OnJGuaeti2x0
 ZiwQ==
X-Gm-Message-State: AOJu0YyC/0QvlyRE7A0CSIcR/E8fq8yH1sLltYyidIKoO1J9rIG4fOir
 BGQTkTUgadWUDISrsW1FyCfIlJb45tgrGR5GE8kTKNROyTZjQSL7MguioBHntR1Sf/F3St+tAnM
 BXzUJSrVChW0hMNY=
X-Received: by 2002:a05:6214:5bc6:b0:655:d0e3:5067 with SMTP id
 lr6-20020a0562145bc600b00655d0e35067mr1662052qvb.3.1695194684194; 
 Wed, 20 Sep 2023 00:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnLDcSUSALPEa1t1fvVOzVISspQ6Ao6VFE0lZW2NOJsl+YLSelzDpG5gP8Y+fl6xRgq4D69A==
X-Received: by 2002:a05:6214:5bc6:b0:655:d0e3:5067 with SMTP id
 lr6-20020a0562145bc600b00655d0e35067mr1662043qvb.3.1695194683947; 
 Wed, 20 Sep 2023 00:24:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a0cf4d3000000b00656785f4677sm2840725qvm.0.2023.09.20.00.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 00:24:43 -0700 (PDT)
Message-ID: <bb03dde9-6c3a-a9cb-95b4-2db2d8a71c72@redhat.com>
Date: Wed, 20 Sep 2023 09:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/12] range: Introduce range_inverse_array()
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-7-eric.auger@redhat.com>
 <20230919102926.54f92f47.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230919102926.54f92f47.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Alex,

On 9/19/23 18:29, Alex Williamson wrote:
> On Wed, 13 Sep 2023 10:01:41 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> This helper reverses an array of regions, turning original
>> regions into holes and original holes into actual regions,
>> covering the whole UINT64_MAX span.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - Move range_inverse_array description comment in the header
>> - Take low/high params
>> ---
>>  include/qemu/range.h |  8 ++++++++
>>  util/range.c         | 45 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+)
>>
>> diff --git a/include/qemu/range.h b/include/qemu/range.h
>> index 7e2b1cc447..2b59e3bf0c 100644
>> --- a/include/qemu/range.h
>> +++ b/include/qemu/range.h
>> @@ -219,4 +219,12 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
>>  
>>  GList *range_list_insert(GList *list, Range *data);
>>  
>> +/*
>> + * Inverse an array of sorted ranges over the [low, high] span, ie.
>> + * original ranges becomes holes in the newly allocated inv_ranges
>> + */
>> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
>> +                         uint32_t *nr_inv_ranges, Range **inv_ranges,
>> +                         uint64_t low, uint64_t high);
>> +
>>  #endif
>> diff --git a/util/range.c b/util/range.c
>> index 098d9d2dc0..4baeb588cc 100644
>> --- a/util/range.c
>> +++ b/util/range.c
>> @@ -70,3 +70,48 @@ GList *range_list_insert(GList *list, Range *data)
>>  
>>      return list;
>>  }
>> +
>> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
>> +                         uint32_t *nr_inv_ranges, Range **inv_ranges,
>> +                         uint64_t low, uint64_t high)
> Rare be it for me to suggest GLib, but we already appear to have
> range_list_insert() making use of GList for an ordered list of Ranges.
> Doesn't this function become a lot easier if we take a sorted GList,
> walk it to create the inverse, and return a new GList of the inverted
> Ranges?  Seems the initial sorted GList would be created by making use
> of the existing range_list_insert() function.  Thanks,

I am not sure this greatly simplifies. This definitively removes the
realloc stuff. But to me what complexifies the algo is the low/high
parameter support instead of hardcoding thel to 0/UINT64_MAX (suggestion
by Philippe which I can understand for such helper though). You can see
the diff with

https://lore.kernel.org/all/20230904080451.424731-7-eric.auger@redhat.com/

I will further look at your suggestion though

Eric
>
> Alex
>
>> +{
>> +    Range *resv;
>> +    int i = 0, j = 0;
>> +
>> +    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
>> +
>> +    for (; j < nr_ranges  && (range_upb(&ranges[j]) < low); j++) {
>> +        continue; /* skip all ranges below mon */
>> +    }
>> +
>> +    if (j == nr_ranges) {
>> +        range_set_bounds(&resv[i++], low, high);
>> +        goto realloc;
>> +    }
>> +
>> +    /* first range lob is greater than min, insert a first range */
>> +    if (range_lob(&ranges[j]) > low) {
>> +        range_set_bounds(&resv[i++], low,
>> +                         MIN(range_lob(&ranges[j]) - 1, high));
>> +    }
>> +
>> +    /* insert a range inbetween each original range until we reach max */
>> +    for (; j < nr_ranges - 1; j++) {
>> +        if (range_lob(&ranges[j]) >= high) {
>> +            goto realloc;
>> +        }
>> +        if (range_compare(&ranges[j], &ranges[j + 1])) {
>> +            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
>> +                             MIN(range_lob(&ranges[j + 1]) - 1, high));
>> +        }
>> +    }
>> +    /* last range upb is less than max, insert a last range */
>> +    if (range_upb(&ranges[j]) <  high) {
>> +        range_set_bounds(&resv[i++],
>> +                          range_upb(&ranges[j]) + 1, high);
>> +    }
>> +realloc:
>> +    *nr_inv_ranges = i;
>> +    resv = g_realloc(resv, i * sizeof(Range));
>> +    *inv_ranges = resv;
>> +}


