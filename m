Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE02827F09
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:06:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6Bp-000311-1j; Tue, 09 Jan 2024 02:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Bm-00030U-Gp
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6Bk-0005y1-Jp
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ms8mec23jFd0Kg6MnFCmO89OHH+nziWUMSlALmMngeo=;
 b=PkCCZLAPE7kanjr+K5GVz8lAT1p5ciQvw8CNQ+99Ypjgo+VkrzG+sS6Is2D8BdLbjsvmxO
 aXZPtJ95jOL8CGUW+owmHsGf3pPXsddW2BJczNQY9dLhG8CXPg3y1rV89QRNWtdpwA39KV
 kG3WfttOai1r7euEM5Melsg3WsdYk3Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-XsJLKS_SN7mU1y2Mnvei1A-1; Tue, 09 Jan 2024 02:06:12 -0500
X-MC-Unique: XsJLKS_SN7mU1y2Mnvei1A-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-427cf4a843cso22591011cf.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783972; x=1705388772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ms8mec23jFd0Kg6MnFCmO89OHH+nziWUMSlALmMngeo=;
 b=Sy7RgdnyQGDGo/TMVMmZSKXVORksFaaF+aHhKJNb4rcLLIuur7IQVhHe2vhqKkoqD9
 zHEI6jBEu95EkBaKiowhBLk/WrCuUW+Olv4z5F6b2MHTZsrLAHva2ePAKhkYGnmOCUBH
 +a3ZUvyIlGvstdFmE1QAhzLsHOBpCERTD1/uRfWw7olGNZl1uQly8u2OK5wmhtwXI8Wl
 +hAfUCzNg+T8pXVsma5e8hh72qMbCKM56e7HYaTINBDcwaNtb/06lusHhrk/XIMZl3QD
 OLo+a5VVwTCCo69t3+DJS8ZDeE0XHLb21QRs+Jb7bqwYp0NbDK3HNiUyAGkfUjgZxUWA
 2gHA==
X-Gm-Message-State: AOJu0YxnybngdsnK60ELBxRNv9WTJgc/NNZq3vHyLxby5g1EfCRNEuoK
 /9O9WoExVYO7QzOEeKM+rJlPuPMLuOk4fSDFEfoTb+OpWv/kHGKO6NdFItg6h/pl1zC94MFOT+X
 RJwaPnIqbJB4FUKWufedh+Yw=
X-Received: by 2002:ac8:594e:0:b0:429:a32a:9e9e with SMTP id
 14-20020ac8594e000000b00429a32a9e9emr651355qtz.78.1704783972118; 
 Mon, 08 Jan 2024 23:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbsOdkwcJ1u557NrgaFmplJsBdWKBOghVcR9L/2WI//0sHr1UsxWtrT5ef60bGatL9ospfgQ==
X-Received: by 2002:ac8:594e:0:b0:429:a32a:9e9e with SMTP id
 14-20020ac8594e000000b00429a32a9e9emr651348qtz.78.1704783971840; 
 Mon, 08 Jan 2024 23:06:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05622a428e00b0042997333149sm605370qtb.63.2024.01.08.23.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:06:11 -0800 (PST)
Message-ID: <b7291ce6-8c42-473c-b406-f65e9ec9fa31@redhat.com>
Date: Tue, 9 Jan 2024 08:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] docs/migration: Split "dirty limit"
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Yong Huang <yong.huang@smartx.com>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-8-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Split that into a separate file, put under "features".
> 
> Cc: Yong Huang <yong.huang@smartx.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/dirty-limit.rst | 71 ++++++++++++++++++++++++++++
>   docs/devel/migration/features.rst    |  1 +
>   docs/devel/migration/main.rst        | 71 ----------------------------
>   3 files changed, 72 insertions(+), 71 deletions(-)
>   create mode 100644 docs/devel/migration/dirty-limit.rst
> 
> diff --git a/docs/devel/migration/dirty-limit.rst b/docs/devel/migration/dirty-limit.rst
> new file mode 100644
> index 0000000000..8f32329d5f
> --- /dev/null
> +++ b/docs/devel/migration/dirty-limit.rst
> @@ -0,0 +1,71 @@
> +Dirty limit
> +===========
> +
> +The dirty limit, short for dirty page rate upper limit, is a new capability
> +introduced in the 8.1 QEMU release that uses a new algorithm based on the KVM
> +dirty ring to throttle down the guest during live migration.
> +
> +The algorithm framework is as follows:
> +
> +::
> +
> +  ------------------------------------------------------------------------------
> +  main   --------------> throttle thread ------------> PREPARE(1) <--------
> +  thread  \                                                |              |
> +           \                                               |              |
> +            \                                              V              |
> +             -\                                        CALCULATE(2)       |
> +               \                                           |              |
> +                \                                          |              |
> +                 \                                         V              |
> +                  \                                    SET PENALTY(3) -----
> +                   -\                                      |
> +                     \                                     |
> +                      \                                    V
> +                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
> +  ------------------------------------------------------------------------------
> +
> +When the qmp command qmp_set_vcpu_dirty_limit is called for the first time,
> +the QEMU main thread starts the throttle thread. The throttle thread, once
> +launched, executes the loop, which consists of three steps:
> +
> +  - PREPARE (1)
> +
> +     The entire work of PREPARE (1) is preparation for the second stage,
> +     CALCULATE(2), as the name implies. It involves preparing the dirty
> +     page rate value and the corresponding upper limit of the VM:
> +     The dirty page rate is calculated via the KVM dirty ring mechanism,
> +     which tells QEMU how many dirty pages a virtual CPU has had since the
> +     last KVM_EXIT_DIRTY_RING_FULL exception; The dirty page rate upper
> +     limit is specified by caller, therefore fetch it directly.
> +
> +  - CALCULATE (2)
> +
> +     Calculate a suitable sleep period for each virtual CPU, which will be
> +     used to determine the penalty for the target virtual CPU. The
> +     computation must be done carefully in order to reduce the dirty page
> +     rate progressively down to the upper limit without oscillation. To
> +     achieve this, two strategies are provided: the first is to add or
> +     subtract sleep time based on the ratio of the current dirty page rate
> +     to the limit, which is used when the current dirty page rate is far
> +     from the limit; the second is to add or subtract a fixed time when
> +     the current dirty page rate is close to the limit.
> +
> +  - SET PENALTY (3)
> +
> +     Set the sleep time for each virtual CPU that should be penalized based
> +     on the results of the calculation supplied by step CALCULATE (2).
> +
> +After completing the three above stages, the throttle thread loops back
> +to step PREPARE (1) until the dirty limit is reached.
> +
> +On the other hand, each virtual CPU thread reads the sleep duration and
> +sleeps in the path of the KVM_EXIT_DIRTY_RING_FULL exception handler, that
> +is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
> +obviously exit to the path and get penalized, whereas virtual CPUs involved
> +with read processes will not.
> +
> +In summary, thanks to the KVM dirty ring technology, the dirty limit
> +algorithm will restrict virtual CPUs as needed to keep their dirty page
> +rate inside the limit. This leads to more steady reading performance during
> +live migration and can aid in improving large guest responsiveness.
> diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
> index 0054e0c900..e257d0d100 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -7,3 +7,4 @@ Migration has plenty of features to support different use cases.
>      :maxdepth: 2
>   
>      postcopy
> +   dirty-limit
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 051ea43f0e..00b9c3d32f 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -573,74 +573,3 @@ path.
>        Return path  - opened by main thread, written by main thread AND postcopy
>        thread (protected by rp_mutex)
>   
> -Dirty limit
> -=====================
> -The dirty limit, short for dirty page rate upper limit, is a new capability
> -introduced in the 8.1 QEMU release that uses a new algorithm based on the KVM
> -dirty ring to throttle down the guest during live migration.
> -
> -The algorithm framework is as follows:
> -
> -::
> -
> -  ------------------------------------------------------------------------------
> -  main   --------------> throttle thread ------------> PREPARE(1) <--------
> -  thread  \                                                |              |
> -           \                                               |              |
> -            \                                              V              |
> -             -\                                        CALCULATE(2)       |
> -               \                                           |              |
> -                \                                          |              |
> -                 \                                         V              |
> -                  \                                    SET PENALTY(3) -----
> -                   -\                                      |
> -                     \                                     |
> -                      \                                    V
> -                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
> -  ------------------------------------------------------------------------------
> -
> -When the qmp command qmp_set_vcpu_dirty_limit is called for the first time,
> -the QEMU main thread starts the throttle thread. The throttle thread, once
> -launched, executes the loop, which consists of three steps:
> -
> -  - PREPARE (1)
> -
> -     The entire work of PREPARE (1) is preparation for the second stage,
> -     CALCULATE(2), as the name implies. It involves preparing the dirty
> -     page rate value and the corresponding upper limit of the VM:
> -     The dirty page rate is calculated via the KVM dirty ring mechanism,
> -     which tells QEMU how many dirty pages a virtual CPU has had since the
> -     last KVM_EXIT_DIRTY_RING_FULL exception; The dirty page rate upper
> -     limit is specified by caller, therefore fetch it directly.
> -
> -  - CALCULATE (2)
> -
> -     Calculate a suitable sleep period for each virtual CPU, which will be
> -     used to determine the penalty for the target virtual CPU. The
> -     computation must be done carefully in order to reduce the dirty page
> -     rate progressively down to the upper limit without oscillation. To
> -     achieve this, two strategies are provided: the first is to add or
> -     subtract sleep time based on the ratio of the current dirty page rate
> -     to the limit, which is used when the current dirty page rate is far
> -     from the limit; the second is to add or subtract a fixed time when
> -     the current dirty page rate is close to the limit.
> -
> -  - SET PENALTY (3)
> -
> -     Set the sleep time for each virtual CPU that should be penalized based
> -     on the results of the calculation supplied by step CALCULATE (2).
> -
> -After completing the three above stages, the throttle thread loops back
> -to step PREPARE (1) until the dirty limit is reached.
> -
> -On the other hand, each virtual CPU thread reads the sleep duration and
> -sleeps in the path of the KVM_EXIT_DIRTY_RING_FULL exception handler, that
> -is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
> -obviously exit to the path and get penalized, whereas virtual CPUs involved
> -with read processes will not.
> -
> -In summary, thanks to the KVM dirty ring technology, the dirty limit
> -algorithm will restrict virtual CPUs as needed to keep their dirty page
> -rate inside the limit. This leads to more steady reading performance during
> -live migration and can aid in improving large guest responsiveness.
> -


