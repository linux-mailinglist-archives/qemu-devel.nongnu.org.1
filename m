Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D953274B097
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 14:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHkSk-0008Dp-Lg; Fri, 07 Jul 2023 08:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHkSj-0008BR-6m
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHkSh-0001lG-CW
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 08:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688732482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYLwY3L0FAIT5b8v8FBv6Ug72RfnfMJzus46uXcZa+0=;
 b=L1qenR+R1eM1UW8IuOLQW53DqHiCUKkMlco7Qin99u2VCu0luNhePGXPgErnP58hRXwzVK
 BdP5ZyKcE89JM++zeU3BWXc4Qg/v90nwxpWXPKRDI4R2hcI0iWTxm3MGoOicDup1ZmeILt
 vkwimjiXv3H1Dcpnu1AlFtgdcaqNlss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-U6kGqw_hOIyrrIkVYn69TA-1; Fri, 07 Jul 2023 08:21:20 -0400
X-MC-Unique: U6kGqw_hOIyrrIkVYn69TA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3143ac4a562so973140f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 05:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688732479; x=1691324479;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYLwY3L0FAIT5b8v8FBv6Ug72RfnfMJzus46uXcZa+0=;
 b=J+sOj7L87RPgTcbNWmzkrQnKdEqTAdEPB7ClCDwWX/s6BoaUh6cFs9ABf8lt7De84v
 o7eyVutJFrQxXwLXk+CHOwAIoZaYrM+9N9T+2G6ARn/cG/WQ/s3O2uuq362qz4GcTyZ6
 w8bHPI2M2dp7ICZb/vYigVvsQk4l5uCt2yRx+aNtHGp6y7NoAx6nGjivJbgO21f+oN7h
 RwqFNUCF8FQk1TgrTDn52QcA7wjVyUC8DTpaRLkCbTFnk0T/MCMho2KDZTESu6KvsfQV
 vL7H8Ov+iTxWWmjFXxSVp2CbAsPy3SVn7GegrmF2yZ5EZZejEgOWRu0LbcI3BgCIaP08
 ZGCQ==
X-Gm-Message-State: ABy/qLb0U3fkouwEM60CqeLbGTmtozGPRj1SgC6kmQfapBecwFqJn2cm
 LbbRd4iXWu3rCXNj7bYX0EbyQOuH8NOFdlclrwJ978z+AIE/jEJVDTLT7r5gNd6Rr0eUvBb2Okm
 33MEgAn7ZqvFUt9U=
X-Received: by 2002:adf:cf0f:0:b0:314:1f6:2c24 with SMTP id
 o15-20020adfcf0f000000b0031401f62c24mr4322452wrj.36.1688732479482; 
 Fri, 07 Jul 2023 05:21:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEQR1AzusKc4tmIrbLt6+IzgJqdojXE9uZjnK9hOjlrCQNh/2PP1MESMkMjrgDwFFkKskUBTA==
X-Received: by 2002:adf:cf0f:0:b0:314:1f6:2c24 with SMTP id
 o15-20020adfcf0f000000b0031401f62c24mr4322428wrj.36.1688732479119; 
 Fri, 07 Jul 2023 05:21:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:3c00:248f:bf5b:b03e:aac7?
 (p200300d82f043c00248fbf5bb03eaac7.dip0.t-ipconnect.de.
 [2003:d8:2f04:3c00:248f:bf5b:b03e:aac7])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a5d4537000000b003141e629cb6sm4314184wra.101.2023.07.07.05.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 05:21:18 -0700 (PDT)
Message-ID: <271fc385-08a0-deda-f8ba-a5a4171543be@redhat.com>
Date: Fri, 7 Jul 2023 14:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/4] virtio-mem: Support "x-ignore-shared" migration
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706100303-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230706100303-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 06.07.23 16:03, Michael S. Tsirkin wrote:
> On Thu, Jul 06, 2023 at 09:56:05AM +0200, David Hildenbrand wrote:
>> If there is no further feedback, I'll queue this myself shortly.
>>
>> Stumbling over "x-ignore-shared" migration support for virtio-mem on
>> my todo list, I remember talking to Dave G. a while ago about how
>> ram_block_discard_range() in MAP_PIRVATE file mappings is possibly
>> harmful when the file is used somewhere else -- for example, with VM
>> templating in multiple VMs.
>>
>> This series adds a warning to ram_block_discard_range() in that problematic
>> case and adds "x-ignore-shared" migration support for virtio-mem, which
>> is pretty straight-forward. The last patch also documents how VM templating
>> interacts with virtio-mem.
>>
>> v1 -> v2:
>> - Pick up tags
>> - "virtio-mem: Support "x-ignore-shared" migration"
>>   -> Fix spelling mistake
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, I queued this to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb


