Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD77179D1
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4H2Z-0000Y8-ER; Wed, 31 May 2023 04:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4H2U-0000Xs-UL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:18:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q4H2S-0000IM-NY
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685521115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jLNLr9vekYHc7/JoUTkR+3hAcTBryyHd+d8SAXNJ4s=;
 b=HUs7/39Zs0IQMEniJvXsM6M2J0ixUcQyFh2RJ08TrBEouT3pH3Jf5t2jtC9kAVQ/8ktS7r
 lgmNM7xTf8RAVi/TrDVTYZ9VXAeHFu02BURZFIhvbZD8WYnmBEJMw+ZKxrJNp6MBc/dUWv
 EuprPZzs/+HtTFR4DKP0X6yq2hC+cl4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_p3R78jFM1m5HCwRuUnD0g-1; Wed, 31 May 2023 04:18:34 -0400
X-MC-Unique: _p3R78jFM1m5HCwRuUnD0g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30b218c0bbbso508304f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685521113; x=1688113113;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8jLNLr9vekYHc7/JoUTkR+3hAcTBryyHd+d8SAXNJ4s=;
 b=b9xRzDKNtSeXgNLI8OzVlWYtNF437Km0t00xF+5s4sX61TKaNuxE2zqNi227jlWVS6
 DY+McDJ3nNHw43RzhfbMq5HoFdU957KJSpwL8YhAwDZGb1U+jXYbk7e05Gs4ws4iioKY
 xI8Am9tU9bud1SN+8VwFq+zQOxqwf+NqNFYWq+ZplvKAsyXyk3KWcq8OAA87CnsZjSDb
 4sFidFYwijGq4UN+Dgaidx6p7+kpMfzAHI4d9sOH0+IuKBZenaUtqHq5Zeki/qoA8cvk
 7vYK/oh0s/a9iec/b505lgECHjLGtodbL0Tvg6IjBZk7a63t4Pa/xpqP9NVaIhC7C5Gt
 niAA==
X-Gm-Message-State: AC+VfDxi+MLj3IlnGB22FtqcshuzdnLWHeokkrdvGt0QPeQ7KF8ZWcpH
 i7+1tLrx3e77LJ23Bc4KIHlXWey8CFixkrpTypHOZKp5ZZuHKDP5ZeCWvC/U+XyHOdnrKOaRFis
 bhO25z10k99oYnMc=
X-Received: by 2002:adf:e64e:0:b0:307:c3bc:536 with SMTP id
 b14-20020adfe64e000000b00307c3bc0536mr3625309wrn.64.1685521112837; 
 Wed, 31 May 2023 01:18:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oiqcEDr6UnkNJoXGUVZf/QmqJ+8h59gtI7vP9PCuzO60VGlMnUHzGLDSqgp8yTboJMnUbtw==
X-Received: by 2002:adf:e64e:0:b0:307:c3bc:536 with SMTP id
 b14-20020adfe64e000000b00307c3bc0536mr3625283wrn.64.1685521112486; 
 Wed, 31 May 2023 01:18:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26?
 (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de.
 [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
 by smtp.gmail.com with ESMTPSA id
 p12-20020adfcc8c000000b0030adfa48e1esm5930781wrj.29.2023.05.31.01.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 01:18:32 -0700 (PDT)
Message-ID: <6d07d41c-ca39-e6a9-50df-9e6d4dd3604e@redhat.com>
Date: Wed, 31 May 2023 10:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuanchu Xie <yuanchu@google.com>,
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
References: <20230525222016.35333-1-talumbau@google.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v2 0/5] virtio-balloon: Working Set Reporting
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26.05.23 00:20, T.J. Alumbaugh wrote:
> This is the device implementation for the proposed expanded balloon feature
> described here:
> 
> https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
> 
> This series has a fixed number of "bins" for the working set report, but this is
> not a constraint of the system. The bin number is fixed at device realization
> time (in other implementations it is specified as a command line argument). Once
> that number is fixed, this determines the correct number of bin intervals to
> pass to the QMP/HMP function 'working_set_config'. Any feedback on how to
> properly construct that function for this use case (passing a variable length
> list?) would be appreciated.
> 
> New in V2:
> =========
> 
> - Patch series is now: header file changes, device changes, QMP changes, HMP
> chagnes, and migration changes.
> 
> - Exmaple usages of QMP and HMP interface are in their respective commit
> messages.
> 
> - "ws" -> "working_set" throughout
> 
> Motivation
> ==========
> As mentioned in the above message, the use case is a host with overcommitted
> memory and 1 or more VMs. The goal is to get both timely and accurate
> information on overall memory utilization in order to drive appropriate
> reclaim activities, since in some client device use cases a VM might need a
> significant fraction of the overall memory for a period of time, but then
> enter a quiet period that results in a large number of cold pages in the
> guest.
> 
> The balloon device now has a number of features to assist in sharing memory
> resources amongst the guests and host (e.g free page hinting, stats, free page
> reporting). As mentioned in slide 12 in [1], the balloon doesn't have a good
> mechanism to drive the reclaim of guest cache. Our use case includes both
> typical page cache as well as "application caches" with memory that should be
> discarded in times of system-wide memory pressure. In some cases, virtio-pmem
> can be a method for host control of guest cache but there are undesirable
> security implications.
> 
> Working Set Reporting
> =====================
> The patch series here includes:
> 
>   - Actual device implementation for VIRTIO_F_WS_REPORTING to standardize the
>     configuration and communication of Working Set reports from the guest. This
>     includes a notification virtqueue for receiving config information and
>     requests for a report (a feature which could be expanded for additional use
>     cases) and a virtqueue for the actual report from the driver.

Could the config update be modeled using the config space instead?

Is the report asynchronous to the request, or how exactly do requests 
and reports interact?

> 
>   - QMP changes so that a controller program can use the existing QEMU socket
>     mechanism to configure and request WS reports and then read the reports as
>     a JSON property on the balloon.
> 
> Working Set reporting in the balloon provides:
> 
>   - an accurate picture of current memory utilization in the guest
>   - event driven reporting (with configurable rate limiting) to deliver reports
>     during times of memory pressure.
> 
> The reporting mechanism can be combined with a domain-specific balloon policy
> to drive the separate reclaim activities in a coordinated fashion.
> 
> TODOs:
> ======
>   -  A synchronization mechanism must be added to the functions that send WS
>      Config and WS Request, otherwise concurrent callers (through QMP) can mix
>      messages on the virtqueue sending the data to the driver.
> 
>   - The device currently has a hard-coded setting of 4 'bins' for a Working Set
>     report, whereas the specification calls for anywhere between 2 and 16.

Can you briefly summarize what a bin is, how one would decide how many 
bins one wants and what the whole purpose of a bin is?

Thanks!

-- 
Thanks,

David / dhildenb


