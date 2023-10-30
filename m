Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A37DB250
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:45:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJCj-0006xS-7V; Sun, 29 Oct 2023 23:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxJCg-0006xI-Ty
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qxJCf-0001Sy-9T
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698637476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HYaIiw9b2vtfc/AsJzLUcSRALqWBv/yaw7YW8QNvm0=;
 b=MdoacCJyMdnt3I+0orI4I16f2aauKfyBIPfhdGOz5UwolL6pBuDOVfCkWos/ac1mwW3UP8
 +UmWV9FgF/c4f37jPLUtqoB1e1fwTpQEn14tR4GMyHwnnY4zgvXzHO8msfdQO1Lm4NHwYc
 +yLCfJraHmF6GIz7WEQ4bqysdRVbU88=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-K7t1TXh2O2yghJbFlqJ-6A-1; Sun, 29 Oct 2023 23:44:34 -0400
X-MC-Unique: K7t1TXh2O2yghJbFlqJ-6A-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b2f2b9a028so6112757b6e.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698637473; x=1699242273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9HYaIiw9b2vtfc/AsJzLUcSRALqWBv/yaw7YW8QNvm0=;
 b=TXda3rmNvHQ+xSd6J4k36EU5B8iqEJZdRi6ezMZ7iMDHyr2joCFV9wyDS6Kq6V0Rv5
 gXbTb3qOcLzp7IUuM2W1CyDLvYTe93ooMv868HJoCEZIEKTFAxzOtHc7GtiZoU0CTXZP
 xNT+PkVxBxyKjWXG0Ouc0LTxKov4PZ+eHmPvb1qJQaCrQ9oPMhzhDfBgTOyu56YkuuSU
 O7+mKy5rNeZvpt//bWOk/azPIdgf5QoSwuVgCDNfvy3jtME4D+TxfGTls/ISFP/NEK1a
 rEbxvdM4AywdLE1Ssux6BI9Wn8BGNoJqhBIADx45tiIYyKKXJum7zheyCXEqIv9cBgNR
 /fvA==
X-Gm-Message-State: AOJu0Yxt+4n8xIgmSBsLdA7nLKl+pcbxMvjvi7Ie93/AssDe2F6Wq0xg
 MHqwwRcTcTZjrStp9fRls00z8w19BI9HUYZ+ZZCCUx6fsHbH6ovGw59avYTyjGx5BcrVwzSZpwu
 p7zNIxti6z55QJm4=
X-Received: by 2002:a05:6808:1412:b0:3a8:83df:d5a4 with SMTP id
 w18-20020a056808141200b003a883dfd5a4mr12113492oiv.59.1698637473600; 
 Sun, 29 Oct 2023 20:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHppb2xhICKZ1t5iOLLRmgXfq8TVXgvMssSXbZVIaWdV/zfo+wDN86VmGO8wKemS88Eul7BMQ==
X-Received: by 2002:a05:6808:1412:b0:3a8:83df:d5a4 with SMTP id
 w18-20020a056808141200b003a883dfd5a4mr12113486oiv.59.1698637473349; 
 Sun, 29 Oct 2023 20:44:33 -0700 (PDT)
Received: from [10.72.113.184] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a056a000a9000b006c0fdc98c89sm1468849pfl.85.2023.10.29.20.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:44:32 -0700 (PDT)
Message-ID: <166c33ff-700a-2c99-47fc-c3a3ca36d6bc@redhat.com>
Date: Mon, 30 Oct 2023 11:44:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v5 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-12-akihiko.odaki@daynix.com>
 <CACGkMEvY4fjrBgjLMFRNN0LmJ+iQaC=z3KTumwB=+d1Ofz0yzg@mail.gmail.com>
 <9340bcd6-af03-45ce-a147-bac4a493ecc5@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <9340bcd6-af03-45ce-a147-bac4a493ecc5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.972, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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


在 2023/10/27 15:54, Akihiko Odaki 写道:
> On 2023/10/27 16:07, Jason Wang wrote:
>> On Tue, Oct 17, 2023 at 12:10 PM Akihiko Odaki 
>> <akihiko.odaki@daynix.com> wrote:
>>>
>>> vhost requires eBPF for RSS. Even when eBPF is not available, 
>>> virtio-net
>>> reported RSS availability, and raised a warning only after the
>>> guest requested RSS, and the guest could not know that RSS is not
>>> available.
>>>
>>> Check RSS availability during device realization and return an error
>>> if RSS is requested but not available. Assert RSS availability when
>>> the guest actually requests the feature.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   ebpf/ebpf_rss.h      |   2 +-
>>>   ebpf/ebpf_rss-stub.c |   4 +-
>>>   ebpf/ebpf_rss.c      |  68 +++++++++-----------------
>>>   hw/net/virtio-net.c  | 114 
>>> +++++++++++++++++++++----------------------
>>>   4 files changed, 82 insertions(+), 106 deletions(-)
>>>
>>> diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
>>> index bf3f2572c7..1128173572 100644
>>> --- a/ebpf/ebpf_rss.h
>>> +++ b/ebpf/ebpf_rss.h
>>> @@ -36,7 +36,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
>>>
>>>   bool ebpf_rss_load(struct EBPFRSSContext *ctx);
>>>
>>> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct 
>>> EBPFRSSConfig *config,
>>> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct 
>>> EBPFRSSConfig *config,
>>>                         uint16_t *indirections_table, uint8_t 
>>> *toeplitz_key);
>>>
>>>   void ebpf_rss_unload(struct EBPFRSSContext *ctx);
>>> diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
>>> index e71e229190..525b358597 100644
>>> --- a/ebpf/ebpf_rss-stub.c
>>> +++ b/ebpf/ebpf_rss-stub.c
>>> @@ -28,10 +28,10 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>>>       return false;
>>>   }
>>>
>>> -bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct 
>>> EBPFRSSConfig *config,
>>> +void ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct 
>>> EBPFRSSConfig *config,
>>>                         uint16_t *indirections_table, uint8_t 
>>> *toeplitz_key)
>>>   {
>>> -    return false;
>>> +    g_assert_not_reached();
>>>   }
>>>
>>>   void ebpf_rss_unload(struct EBPFRSSContext *ctx)
>>> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
>>> index cee658c158..6cdf82d059 100644
>>> --- a/ebpf/ebpf_rss.c
>>> +++ b/ebpf/ebpf_rss.c
>>> @@ -74,42 +74,32 @@ error:
>>>       return false;
>>>   }
>>>
>>> -static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>>> +static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>>>                                   struct EBPFRSSConfig *config)
>>>   {
>>>       uint32_t map_key = 0;
>>>
>>> -    if (!ebpf_rss_is_loaded(ctx)) {
>>> -        return false;
>>> -    }
>>> -    if (bpf_map_update_elem(ctx->map_configuration,
>>> -                            &map_key, config, 0) < 0) {
>>> -        return false;
>>> -    }
>>> -    return true;
>>> +    assert(ebpf_rss_is_loaded(ctx));
>>> +    assert(!bpf_map_update_elem(ctx->map_configuration, &map_key, 
>>> config, 0));
>>
>> Guest trigger-rable assertion should be avoided as much as possible.
>
> These assertions should never be triggered by the guest as the feature 
> availability is checked at the device realization. Are these 
> assertions still problematic?


I still think it's better to avoid assertions as code could be changed 
by various people so it may end up with such possibility in the future.

Thanks


>
> Regards,
> Akihiko Odaki
>


