Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49555768D1A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 09:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQMxv-0000G3-D5; Mon, 31 Jul 2023 03:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQMxo-0000Dn-LW
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQMxm-0002Cr-Ee
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 03:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690787105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyPzxjw4nq3YiXm4Q+Ua++OzWzr5VCkFsBcMiFNYTAo=;
 b=PSA8KPlWj3PfQuObwKNmNDJhSC8zbGwfyb5Xrew1iKZeYG2BEIjyoeuAL96XrEhYd/rwAY
 hmqWzE26vSUEv10Fe4g6F7S8HuM3npOTulXp49GXCevPZLJxEiO/6JhZSM0s1J8Bw+ucid
 BPmLon686Btk26x+A9fpLMA0AZ53kFw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-TyWmXzjqOASitiwpZ-WUgA-1; Mon, 31 Jul 2023 03:05:03 -0400
X-MC-Unique: TyWmXzjqOASitiwpZ-WUgA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe11910e46so12278295e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 00:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690787102; x=1691391902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zyPzxjw4nq3YiXm4Q+Ua++OzWzr5VCkFsBcMiFNYTAo=;
 b=EFJ1jC/8EocYHHH1kB+6Mw+hLxvlylBL3p11h3yVGHiS8oU04Mxyq5pmWGvGuIsDgn
 9EPFd7HaEuoq4vSWIwWP+BiyTGAuJ9THCUDf+nj+/wAsaHV2wlqK/lUyAinPrQVTkTFw
 av2ykBFH3KJC4gSZchGs8dQPCwQ7GbefXiaCjmofQPBKMd+Baki8j1ryjWivmRPlpzwZ
 XH8Cltrl+WSKdmt6irQboUax8YEEdkfc1Di+KVaD31fSvlRMALmJvYQ/5JaTKrNG67n2
 u+//N135Qei6I4KAgkBG7i5yrnPlRB4jgeFAi7HAPe4mVd0MiXY57TqohlNYrgh/earn
 TZyQ==
X-Gm-Message-State: ABy/qLayGYaBorWrB8qMrT4fqzQ2tRNn0HewYaPerF2UENwMRPULQ2/9
 sB6fJSqovX+WSktOIQRZwQBLK36/va0yotu3+vrhEF7oPX0dF/Y/dlfnq/gYRP3PNS2Lq/CHjrC
 LJLUcIp4oKMboBDI=
X-Received: by 2002:a05:600c:20c4:b0:3f7:e660:cdc5 with SMTP id
 y4-20020a05600c20c400b003f7e660cdc5mr7258056wmm.9.1690787102351; 
 Mon, 31 Jul 2023 00:05:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEycIzw0ZcdYaNi2sf8mzOeGbZhx2LV/J/1SaoB2xM4U/CRWgW4xmna8X82HgoQ2KkQPyCf0g==
X-Received: by 2002:a05:600c:20c4:b0:3f7:e660:cdc5 with SMTP id
 y4-20020a05600c20c400b003f7e660cdc5mr7258036wmm.9.1690787102040; 
 Mon, 31 Jul 2023 00:05:02 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a7bcb55000000b003fe0a0e03fcsm7801083wmj.12.2023.07.31.00.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 00:05:01 -0700 (PDT)
Message-ID: <ddc55863-2a74-dfa2-a28b-a7592ee2f3e2@redhat.com>
Date: Mon, 31 Jul 2023 09:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/6] vfio/migration: Move from STOP_COPY to STOP
 in vfio_save_cleanup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-2-avihaih@nvidia.com>
 <dc2365df-4e71-e2d8-988d-f74431800123@redhat.com>
 <26daa2db-13fd-3705-fbbf-22b8643dc9ee@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <26daa2db-13fd-3705-fbbf-22b8643dc9ee@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/31/23 08:32, Avihai Horon wrote:
> 
> On 30/07/2023 19:25, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 7/16/23 10:15, Avihai Horon wrote:
>>> Changing the device state from STOP_COPY to STOP can take time as the
>>> device may need to free resources and do other operations as part of the
>>> transition. Currently, this is done in vfio_save_complete_precopy() and
>>> therefore it is counted in the migration downtime.
>>>
>>> To avoid this, change the device state from STOP_COPY to STOP in
>>> vfio_save_cleanup(), which is called after migration has completed and
>>> thus is not part of migration downtime.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>
>> Have you tried this series with vGPUs ? If so, are there any improvement
>> to report ?
>>
> Not with a vGPU.
> But I tried it with a ConnectX-7 VF and I could see up to 6% downtime improvement.
> I mentioned this in the cover letter.
> Do you want to mention it also in the commit message?

This is not necessary.

Thanks,

C.




