Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF67D9066
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:55:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHgH-0005wk-D4; Fri, 27 Oct 2023 03:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHgF-0005wa-DO
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:54:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwHgD-0006Ra-Pp
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:54:55 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso21471745ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 00:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698393291; x=1698998091;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eT6OP/30WH7zVaUtrNgXPoamkRTWd4vmaDI1Zjdk4GQ=;
 b=2aWpeiw2cSTpy/Ki9TT9oafUZxu99ceqTBhYLKt8gHEBreoQH/V+oE/FVyZoDph+T9
 UMjIImICtB2meK+pivueZCBgE1+YsW0jb3qFqBx7msmHLMWuZMBhFsZz58Wc0oG6TQGk
 QOQzvE8ukaRs7fnj7xd8eydkUOsjSo9OU0lmEOeAwMAZmPrzm9BrHqiSa2pP/YTfX9nN
 DwAfogBiTbc4M/xfB53c83E6Yp0PuZRQGUBGq95KxtkAeEvKCXukIjAO0gZ45JxQGQCL
 tSC5TLgU6rKsCRKVYUvBPwgWcUH32cYsyCqZTpLsErJRksfhrtDeKfdSLeimXe6HqxQN
 kvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698393291; x=1698998091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eT6OP/30WH7zVaUtrNgXPoamkRTWd4vmaDI1Zjdk4GQ=;
 b=bHoA2TuyLwrAuEzyX2QTOzTlZZJgI8W9Hk1B0pB7r55kbXlAMJ88uAmH/rSxsiAlTL
 v/l/9rqCV1GDL/d8DtfdOI8TFR2Va6uwA5Bfqp+NM/JH3JTrDqrdqY1QAruZgErF2sXi
 5otDlqU4XlMO72d2CXSPwY3H7Y1isUJbD9EzRFEst2MhsPCzF75vaUphMie72yMTEcwi
 fFsKOevfCpP2ok3kpJijksr2pnQvbhY88mtkGKDsAHPzXSt2lWOP0cu2AHWmnIShNTAg
 PLog1Dp18gK0MPrSDESboJgR+tbBVKwfGVRPH6Rk4kA+3wZcIuQ8pn10rdOFcFshEs7D
 usZg==
X-Gm-Message-State: AOJu0YxpK1qLBPm8GWIkVD5pBdZdje3umXf9xXOObPhx+K6QFZTukpfb
 USOyt+IYnhwhmuR+0y+nTaWYvK6q/nY22YyqtwI=
X-Google-Smtp-Source: AGHT+IH3ZaiDzOr2AAqViXD+bNclfVCi9n8v4Nw7EOTVb5l+7Q5Hns638Rrj4onamM1z5yXu6JfUyQ==
X-Received: by 2002:a17:902:f684:b0:1c7:7c2c:f828 with SMTP id
 l4-20020a170902f68400b001c77c2cf828mr2481104plg.8.1698393290627; 
 Fri, 27 Oct 2023 00:54:50 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 ij27-20020a170902ab5b00b001ca4c20003dsm941329plb.69.2023.10.27.00.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:54:50 -0700 (PDT)
Message-ID: <9340bcd6-af03-45ce-a147-bac4a493ecc5@daynix.com>
Date: Fri, 27 Oct 2023 16:54:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-12-akihiko.odaki@daynix.com>
 <CACGkMEvY4fjrBgjLMFRNN0LmJ+iQaC=z3KTumwB=+d1Ofz0yzg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvY4fjrBgjLMFRNN0LmJ+iQaC=z3KTumwB=+d1Ofz0yzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/27 16:07, Jason Wang wrote:
> On Tue, Oct 17, 2023 at 12:10 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> vhost requires eBPF for RSS. Even when eBPF is not available, virtio-net
>> reported RSS availability, and raised a warning only after the
>> guest requested RSS, and the guest could not know that RSS is not
>> available.
>>
>> Check RSS availability during device realization and return an error
>> if RSS is requested but not available. Assert RSS availability when
>> the guest actually requests the feature.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   ebpf/ebpf_rss.h      |   2 +-
>>   ebpf/ebpf_rss-stub.c |   4 +-
>>   ebpf/ebpf_rss.c      |  68 +++++++++-----------------
>>   hw/net/virtio-net.c  | 114 +++++++++++++++++++++----------------------
>>   4 files changed, 82 insertions(+), 106 deletions(-)
>>
>> diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
>> index bf3f2572c7..1128173572 100644
>> --- a/ebpf/ebpf_rss.h
>> +++ b/ebpf/ebpf_rss.h
>> @@ -36,7 +36,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
>>
>>   bool ebpf_rss_load(struct EBPFRSSContext *ctx);
>>
>> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
>> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
>>                         uint16_t *indirections_table, uint8_t *toeplitz_key);
>>
>>   void ebpf_rss_unload(struct EBPFRSSContext *ctx);
>> diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
>> index e71e229190..525b358597 100644
>> --- a/ebpf/ebpf_rss-stub.c
>> +++ b/ebpf/ebpf_rss-stub.c
>> @@ -28,10 +28,10 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>>       return false;
>>   }
>>
>> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
>> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
>>                         uint16_t *indirections_table, uint8_t *toeplitz_key)
>>   {
>> -    return false;
>> +    g_assert_not_reached();
>>   }
>>
>>   void ebpf_rss_unload(struct EBPFRSSContext *ctx)
>> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
>> index cee658c158..6cdf82d059 100644
>> --- a/ebpf/ebpf_rss.c
>> +++ b/ebpf/ebpf_rss.c
>> @@ -74,42 +74,32 @@ error:
>>       return false;
>>   }
>>
>> -static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>> +static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>>                                   struct EBPFRSSConfig *config)
>>   {
>>       uint32_t map_key = 0;
>>
>> -    if (!ebpf_rss_is_loaded(ctx)) {
>> -        return false;
>> -    }
>> -    if (bpf_map_update_elem(ctx->map_configuration,
>> -                            &map_key, config, 0) < 0) {
>> -        return false;
>> -    }
>> -    return true;
>> +    assert(ebpf_rss_is_loaded(ctx));
>> +    assert(!bpf_map_update_elem(ctx->map_configuration, &map_key, config, 0));
> 
> Guest trigger-rable assertion should be avoided as much as possible.

These assertions should never be triggered by the guest as the feature 
availability is checked at the device realization. Are these assertions 
still problematic?

Regards,
Akihiko Odaki

