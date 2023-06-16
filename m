Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE87329A3
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 10:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA4c4-0007CJ-53; Fri, 16 Jun 2023 04:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1qA4c1-0007Bm-1M
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:15:17 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1qA4by-00056I-V3
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:15:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b52bf6e659so2879655ad.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 01:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1686903307; x=1689495307;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgB3lhZX+xrq91uN1rfRRA4Yo5zSXGBPIKI4XR6EYHc=;
 b=jH5phApCUktCyO0YT4p9x2+dSJvO2tf4K3QDWCyKFgaSs5thy1NqshTbDs13fvIQWJ
 0Hm1a46BO+gbKDyDcKzxbS8Hst1BL5MR+QXn4dQ94GOv8btsgL2lA5R8+htKAOmZkEQ1
 2IyWntXx0rh5i6D7EttK2R2wTDyZx2yehyC+RPx971LK0PuHOz4gGJCTaktYt74AvAnK
 X0te4Rq6F/BkeUqzj1C8YKPlq46YQNAmiC0Is9yg3kr/BGxqhMvCXGExJffMF17k5fVw
 WtaFpQbkYmykPNRAb8YQQHekjCDVoSMW0Yg+h0Ap2zKomXw9NWTQYeljfF2iGxaMGMVG
 oEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686903307; x=1689495307;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LgB3lhZX+xrq91uN1rfRRA4Yo5zSXGBPIKI4XR6EYHc=;
 b=PbavWS7z9fcYumRO43NFoZmtCofL0irMkPr6x8UnW7ScPFzM+WE73o/DnEylIcVdHE
 jkXZLDK/HFQ+XkTU6xv0ecN1CreJaosjjmCELL3pQZpTttw8i/8qwMQnLRtrd/EQVg9P
 RzoGmBg7CFCTWqtNVczI8Sx79/iYXJ9qQlMriBEsKuTQ+LkRMMM45SvjiCQFu/5zrPIw
 NsVpt0rEPlnFvNJDMVtfX5rFVBMnm4oJ7rcWDeQvZz3KPy0oGeEpzlbZY0a/5taYA4YQ
 rB7dPTgqF6b3y1x+4KyjUjymRH04k1RR0iSErOdBFthQop8ki80EZVKf8k3A1S05sURJ
 vqiQ==
X-Gm-Message-State: AC+VfDwDsvepRZp8Ir/J99QmBsn8plDiiG+fqGSVDNf7H9/MNTExT/5V
 nlWIvl1UWOgivVmGljHsS8ZWYQ==
X-Google-Smtp-Source: ACHHUZ6r9cKEKYOsL+okkKmI60Hf9CkpLEuHU/7cTxWBgVhqNfAsYuqap118T9m12J+BHnvy1Y2MSQ==
X-Received: by 2002:a17:903:11c7:b0:1ae:7631:7fa9 with SMTP id
 q7-20020a17090311c700b001ae76317fa9mr1178633plh.37.1686903307240; 
 Fri, 16 Jun 2023 01:15:07 -0700 (PDT)
Received: from [10.94.53.13] ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a1709028c8b00b001ae0152d280sm15120448plo.193.2023.06.16.01.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 01:15:06 -0700 (PDT)
Message-ID: <93b9e037-9c26-e37e-3327-bc7f91e18ad2@bytedance.com>
Date: Fri, 16 Jun 2023 16:15:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v8 0/6] migration: reduce time of loading non-iterable
 vmstate
From: Chuang Xu <xuchuangxclwt@bytedance.com>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
References: <20230317081904.24389-1-xuchuangxclwt@bytedance.com>
In-Reply-To: <20230317081904.24389-1-xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=xuchuangxclwt@bytedance.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi, Paolo,

A few months ago, Juan told me that this series requires your or someone 
familiar with memory API's feedback.

Could you please review it and provide some suggestions?

On 2023/3/17 下午4:18, Chuang Xu wrote:
> In this version:
>
> - delete useless line change.
> - update comments and commit messages.
>
> The duration of loading non-iterable vmstate accounts for a significant
> portion of downtime (starting with the timestamp of source qemu stop and
> ending with the timestamp of target qemu start). Most of the time is spent
> committing memory region changes repeatedly.
>
> This patch packs all the changes to memory region during the period of	
> loading non-iterable vmstate in a single memory transaction. With the
> increase of devices, this patch will greatly improve the performance.
>
> Here are the test1 results:
> test info:
> - Host
>    - Intel(R) Xeon(R) Platinum 8362 CPU
>    - Mellanox Technologies MT28841
> - VM
>    - 32 CPUs 128GB RAM VM
>    - 8 16-queue vhost-net device
>    - 16 4-queue vhost-user-blk device.
>
> 	time of loading non-iterable vmstate     downtime
> before		 112 ms			  	  285 ms
> after		 20 ms			  	  194 ms
>
>
> In test2, we keep the number of the device the same as test1, reduce the
> number of queues per device:
>
> Here are the test2 results:
> test info:
> - Host
>    - Intel(R) Xeon(R) Platinum 8362 CPU
>    - Mellanox Technologies MT28841
> - VM
>    - 32 CPUs 128GB RAM VM
>    - 8 1-queue vhost-net device
>    - 16 1-queue vhost-user-blk device.
>
> 	time of loading non-iterable vmstate     downtime
> before		 65 ms			 	  151 ms
>
> after		 19 ms			  	  100 ms
>
>
> In test3, we keep the number of queues per device the same as test1, reduce
> the number of devices:
>
> Here are the test3 results:
> test info:
> - Host
>    - Intel(R) Xeon(R) Platinum 8362 CPU
>    - Mellanox Technologies MT28841
> - VM
>    - 32 CPUs 128GB RAM VM
>    - 1 16-queue vhost-net device
>    - 1 4-queue vhost-user-blk device.
>
> 	time of loading non-iterable vmstate     downtime
> before		 24 ms			  	  51 ms
> after		 9 ms			 	  36 ms
>
>
> As we can see from the test results above, both the number of queues and
> the number of devices have a great impact on the time of loading non-iterable
> vmstate. The growth of the number of devices and queues will lead to more
> mr commits, and the time consumption caused by the flatview reconstruction
> will also increase.
>
> Please review, Chuang
>
Thanks!

