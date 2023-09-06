Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9079C793EA1
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtPM-0003mQ-Lv; Wed, 06 Sep 2023 10:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdtPK-0003mH-9F
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdtPH-0003B0-Lc
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694010082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imVa++X5OLO/WkaedTsNde12Gxj6LUkJlnCs9HiFpzE=;
 b=NjZghHsPIxVOgKnhvYZ409RXW181BDl/BAfpgKMdvBMSg6udGCZco99/HcgPVvhzHVZ7/o
 Hg6cpQdBDJqSeaBXu0mncBEcUnocmNeRdWnJY/1L2wghSCiTU2Xkkmo0f5pgjz4nEqaTpO
 8entBS0zrzQkKtQ4tJgeviYlTsAijLg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-X08guzTiO_uguYPmlOBYKg-1; Wed, 06 Sep 2023 10:21:21 -0400
X-MC-Unique: X08guzTiO_uguYPmlOBYKg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b9d3ce1a56so3577795a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010080; x=1694614880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=imVa++X5OLO/WkaedTsNde12Gxj6LUkJlnCs9HiFpzE=;
 b=SerulzAvMDqiUCEEn+n9yRnuDystF1UkJUHl0pkbtH4bULcaYS+w5XjMzO+DLP7CGc
 zim+PZpqE7A/z7ybzLGGHOajiLo+MY6V0Une6ASG+XbycudypjBvDWVnEH0sTHu5dds/
 3pyy3dbaHS6Gw1ZrBFcSQVdosVCODr+yFLvWz/JadEGgDU6qQzVsJ70PXHbR4epV1KoG
 I5mJraR3dnc4dTdbwyGbskgk7ZOnhWin2PlSyLAUwRzVS4dnuXvqzfpiYtzzqEVp6Mvy
 fMHx0gm3bHH9K5+dQ5DNVFyafJ6kVUAo4sO3c6zyQhpYdAiETA3Ne7rmX5UeClAa7x2V
 8rkA==
X-Gm-Message-State: AOJu0Yz58C60Ev4Htfh3qerDdt5ft+0TxAEN5wYNYZA2fI5mFqcli7YU
 LzHhBMhpbRYDQaYkmBjGD5siDNvsws+2JQuBOqX1TTSUVm2C8rkR6n7tonxE7xBqRW6/86iNeDv
 OlPD9XY6oWcnbV3A=
X-Received: by 2002:a05:6358:262a:b0:139:cd0a:989a with SMTP id
 l42-20020a056358262a00b00139cd0a989amr3659388rwc.16.1694010080340; 
 Wed, 06 Sep 2023 07:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3l4x0n1E/B0ROuiYc2zgelBUcQIxc6iBM/1T/EB9REY8v3Jg3PtJBIT/lvSS+PshuWCuFaQ==
X-Received: by 2002:a05:6358:262a:b0:139:cd0a:989a with SMTP id
 l42-20020a056358262a00b00139cd0a989amr3659356rwc.16.1694010079991; 
 Wed, 06 Sep 2023 07:21:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a0cf5d2000000b0064743dd0633sm5478610qvm.106.2023.09.06.07.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:21:19 -0700 (PDT)
Message-ID: <574d6c53-5c5b-b0bf-bc89-dfd097a2cff9@redhat.com>
Date: Wed, 6 Sep 2023 16:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/5] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-4-avihaih@nvidia.com> <ZPIIEYhcwPJLg2Lj@x1n>
 <94038246-216c-3304-3f8b-1fb6f6ed684d@redhat.com>
 <c0a9c367-457f-f55e-df8b-d8542916039c@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <c0a9c367-457f-f55e-df8b-d8542916039c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/6/23 16:11, Avihai Horon wrote:
> 
> On 05/09/2023 19:13, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 9/1/23 17:49, Peter Xu wrote:
>>> On Thu, Aug 31, 2023 at 03:57:00PM +0300, Avihai Horon wrote:
>>>> Add a new .save_prepare() handler to struct SaveVMHandlers. This handler
>>>> is called early, even before migration starts, and can be used by
>>>> devices to perform early checks.
>>>>
>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>
>>> Shouldn't be hard to unify the two call sites for qmp migrate and save
>>> snapshot, but we can leave that for later:
>>
>> yes. It could be called from migrate_init() with minor changes.
>>
>> We could probably move :
>>
>>     memset(&mig_stats, 0, sizeof(mig_stats));
>>     memset(&compression_counters, 0, sizeof(compression_counters));
>>     migration_reset_vfio_bytes_transferred();
>>
>> under migrate_init() also.
> 
> I will send v3 with the above changes shortly.

Good timing. I was going to start working on downstream.

Thanks !

C.


