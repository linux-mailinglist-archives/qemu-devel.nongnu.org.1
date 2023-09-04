Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845F6791995
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:22:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdASr-0003UW-Gh; Mon, 04 Sep 2023 10:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdASh-0003Tm-MW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdASe-0004wU-Q8
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:21:55 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-SQ97QZMlPDOluOUc_jnJGw-1; Mon, 04 Sep 2023 10:21:50 -0400
X-MC-Unique: SQ97QZMlPDOluOUc_jnJGw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-64977a67bcbso18094086d6.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693837310; x=1694442110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWvLz8BVYIumQ4/T1XxOpStetVPA0USBRzqlFOyXLAg=;
 b=Q1FSlFQT2biVczKHMCWEbcLPjIpZDPer0BPiMOOqPcLvNkiAnxIG4IpeSIM4WQb4ay
 bqvEbFwXBo9qwK7ffnOaXLRq9z/Y2F/HS/XW03KHANjwMZZD/W5pk23Cx4y44gDKSOHh
 9/7qUnpUBHGbb2/UorQovDgHXBrY25TpN0brk+YsKJPGNHFPy1eteiJvdm9+vTxkw42/
 QXOtXWme8uaEV27Cc3H2QGO0mu0PF18jLsNWozM/VATTEAuevChBFtUjv4ZsTTwDJrxu
 n0XSE/Nq27sHOQCjd/Q94qkf5zZJfNLe9BQyoX+CV8hn1fsw30de9rzIZrXB94jQIeJ+
 oY/A==
X-Gm-Message-State: AOJu0YyT0Fwb6EsZ622xYqi5qPZH8bOwqw8NUY4brJxNkcv9yFhesl4q
 n7n3gIe7XuDsuZ4v37zYcZZwWtRQ6KKgV4Vi1DvXWx9gvnkvwtNriJZpZPlmiw8/Ug/csyeECgp
 xSWBvmGg7PixE4Yc=
X-Received: by 2002:a0c:e2cd:0:b0:64a:b51c:8123 with SMTP id
 t13-20020a0ce2cd000000b0064ab51c8123mr9838860qvl.8.1693837310270; 
 Mon, 04 Sep 2023 07:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtzjvp9vZS4+83cloposEs4JyC8yiHw26iTZXv/lZcNcAJFccLf4GUZYcnRvhCSe/pbWItRw==
X-Received: by 2002:a0c:e2cd:0:b0:64a:b51c:8123 with SMTP id
 t13-20020a0ce2cd000000b0064ab51c8123mr9838838qvl.8.1693837309937; 
 Mon, 04 Sep 2023 07:21:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a0cb292000000b0064f5daff23fsm3650038qve.15.2023.09.04.07.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:21:49 -0700 (PDT)
Message-ID: <1851c339-949c-24f0-78a3-ee4aaf62afb4@redhat.com>
Date: Mon, 4 Sep 2023 16:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/13] range: Introduce range_inverse_array()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, jean-philippe@linaro.org,
 mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-7-eric.auger@redhat.com>
 <91d32bd0-73bf-ee50-ccd1-bd010a4263cc@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <91d32bd0-73bf-ee50-ccd1-bd010a4263cc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Philippe,
On 9/4/23 10:18, Philippe Mathieu-Daudé wrote:
> On 4/9/23 10:03, Eric Auger wrote:
>> This helper reverses an array of regions, turning original
>> regions into holes and original holes into actual regions,
>> covering the whole UINT64_MAX span.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/qemu/range.h |  3 +++
>>   util/range.c         | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/include/qemu/range.h b/include/qemu/range.h
>> index 7e2b1cc447..fc1d3dabe6 100644
>> --- a/include/qemu/range.h
>> +++ b/include/qemu/range.h
>> @@ -219,4 +219,7 @@ static inline int ranges_overlap(uint64_t first1,
>> uint64_t len1,
>>     GList *range_list_insert(GList *list, Range *data);
>>   +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
>> +                         uint32_t *nr_inv_ranges, Range **inv_ranges);
>> +
>>   #endif
>> diff --git a/util/range.c b/util/range.c
>> index 098d9d2dc0..11c4ff0b78 100644
>> --- a/util/range.c
>> +++ b/util/range.c
>> @@ -70,3 +70,38 @@ GList *range_list_insert(GList *list, Range *data)
>>         return list;
>>   }
>> +
>> +/*
>> + * Inverse an array of sorted ranges over the UINT64_MAX span, ie.
>> + * original ranges becomes holes in the newly allocated inv_ranges
>> + */
>
> Most of the functions are described in the header; could you move this
> description with the declaration?
this is the case for all static inline primitives but not for
range_list_insert(), hence that choice. Now I don't have a strong opinion.
>
>> +void range_inverse_array(uint32_t nr_ranges, Range *ranges,
>> +                         uint32_t *nr_inv_ranges, Range **inv_ranges)
>> +{
>> +    Range *resv;
>> +    int i = 0, j = 0;
>> +
>> +    resv = g_malloc0_n(nr_ranges + 1, sizeof(Range));
>> +
>> +    /* first range lob is greater than 0, insert a first range */
>> +    if (range_lob(&ranges[0]) > 0) {
>> +        range_set_bounds(&resv[i++], 0,
>> +                         range_lob(&ranges[0]) - 1);
>> +    }
>> +
>> +    /* insert a range inbetween each original range */
>> +    for (; j < nr_ranges - 1; j++) {
>> +        if (range_compare(&ranges[j], &ranges[j + 1])) {
>> +            range_set_bounds(&resv[i++], range_upb(&ranges[j]) + 1,
>> +                             range_lob(&ranges[j + 1]) - 1);
>> +        }
>> +    }
>> +    /* last range upb is less than UINT64_MAX, insert a last range */
>
> In order to use this new function with variable range sizes,
> can we pass UINT64_MAX as an 'inv_range_upb' argument?
Indeed I hesitated to bring enhanced comodity by letting the caller pass
the upper bound and allow values less than UINT64_MAX. But I was afraid
this would complexify the implementation, hence the current choice. I
will have a look & see.

Thanks

Eric
>
>> +    if (range_upb(&ranges[nr_ranges - 1]) <  UINT64_MAX) {
>> +        range_set_bounds(&resv[i++],
>> +                          range_upb(&ranges[nr_ranges - 1]) + 1,
>> UINT64_MAX);
>> +    }
>> +    *nr_inv_ranges = i;
>> +    resv = g_realloc(resv, i * sizeof(Range));
>> +    *inv_ranges = resv;
>> +}
>


