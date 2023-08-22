Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D107841F7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRN3-0003w0-P9; Tue, 22 Aug 2023 09:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRMz-0003v8-Kn
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYRMx-00032Y-4x
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692710664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSHwHyj/S3HWUDxGe9zEehp8OqSp3d4Rq9vd3yisc84=;
 b=T+GGPiuDz47jP9fBfLRwXfdLNciUiFf7fp2vBTHViwN585rdwCwr5rDpWn6fJ1I/kO6wN+
 186aLdgdbkUhdzYCNMfouAV7v5GBlbf5Js1bFqSqItFfDUatw8pI4VBXiBGmo+OKwoeIUr
 L9p7paR37OEhxAJaqex8VD89DVUxIVE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-oAsFQR_yPlW85IbUsk5ngQ-1; Tue, 22 Aug 2023 09:24:22 -0400
X-MC-Unique: oAsFQR_yPlW85IbUsk5ngQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso29476875e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710661; x=1693315461;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SSHwHyj/S3HWUDxGe9zEehp8OqSp3d4Rq9vd3yisc84=;
 b=CGKFN7FFN8mDkN1Vwp39ZszRRCo+B54v1GE1QO+y3fd6dcraKSntJjmlTLBpKBM5sj
 Jx4ZcaGbqLD2CqJ4b9D7Q5T4unS0W+90xS1plEzOQAO8dkHNtMx6vdikrsQ7DVGuzdjs
 bzxzYmc99FkPPC9X3Hre5i8cnPoihpObPo9agvIuXJ/RGWXXR78fpJNes+DrfT8Sq6Ws
 KQHXpeXAaSlw81Kn+fTO/YvZMYsAIbUJKd3PJEO9KvJzZqJ6qqUldnE7VebJNkGU5Pcn
 R25WTtodVRRkSO/tIRhFSEkSbu+RYIrrZPocS2HgN+IyyYZ6BzbsSYepWswoPZH/yYwI
 gyTw==
X-Gm-Message-State: AOJu0Yx0d3jpc/tjMZ2kDSPunMnNuVtejIXM0G2LO9lfI9YtqJ/CMJDI
 O0obBLbwsM/MzN8r9WfG26IfcWXf6eN4j3im5Vjg9DlC0FEbSNIAYGjyNtlyMNUztmAeZjcilHT
 xmICV1znUu9o/bh4=
X-Received: by 2002:a05:600c:22c1:b0:3f7:4961:52ad with SMTP id
 1-20020a05600c22c100b003f7496152admr7335502wmg.3.1692710661318; 
 Tue, 22 Aug 2023 06:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe/qpqelTN64QmgRR0OGO0S9EeQzfYZ/ZsPLd+a3iZYUJRPrQDY1QsgAdB3wg/vHTaTQN74g==
X-Received: by 2002:a05:600c:22c1:b0:3f7:4961:52ad with SMTP id
 1-20020a05600c22c100b003f7496152admr7335471wmg.3.1692710660926; 
 Tue, 22 Aug 2023 06:24:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:7400:83da:ebad:ba7f:c97c?
 (p200300cbc706740083daebadba7fc97c.dip0.t-ipconnect.de.
 [2003:cb:c706:7400:83da:ebad:ba7f:c97c])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a7bc3d7000000b003fe1fe56202sm16118517wmj.33.2023.08.22.06.24.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:24:20 -0700 (PDT)
Message-ID: <44505654-e67b-3c58-6100-6dca42ce7d33@redhat.com>
Date: Tue, 22 Aug 2023 15:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/9] docs: Don't mention "-mem-path" in
 multi-process.rst
Content-Language: en-US
To: ThinerLogoer <logoerthiner1@163.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-9-david@redhat.com>
 <37073b87.4601.18a1d67f837.Coremail.logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <37073b87.4601.18a1d67f837.Coremail.logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 22.08.23 15:21, ThinerLogoer wrote:
> Hello,
> 
> At 2023-08-22 19:44:56, "David Hildenbrand" <david@redhat.com> wrote:
>> "-mem-path" corresponds to "memory-backend-file,share=off" and,
>> therefore, creates a private COW mapping of the file. For multi-proces
>> QEMU, we need proper shared file-backed memory.
>>
>> Let's make that clearer.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> docs/devel/multi-process.rst | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
>> index e4801751f2..4ef539c0b0 100644
>> --- a/docs/devel/multi-process.rst
>> +++ b/docs/devel/multi-process.rst
>> @@ -409,8 +409,9 @@ the initial messages sent to the emulation process is a guest memory
>> table. Each entry in this table consists of a file descriptor and size
>> that the emulation process can ``mmap()`` to directly access guest
>> memory, similar to ``vhost_user_set_mem_table()``. Note guest memory
>> -must be backed by file descriptors, such as when QEMU is given the
>> -*-mem-path* command line option.
>> +must be backed by shared file-backed memory, for example, using
>> +*-object memory-backend-file,share=on* and setting that memory backend
>> +as RAM for the machine.
>>
>> IOMMU operations
>> ^^^^^^^^^^^^^^^^
> 
> About "-mem-path" and "-object memory-backend-file".
> 
> I have mentioned a error message suggestion, maybe you can consider it? The
> error message related to "-object memory-backend-file,id=pc.ram" is confusing,
> as is shown below: (https://lore.kernel.org/all/2337d9f.16d6.189e8682901.Coremail.logoerthiner1@163.com/)

Oh, I missed that. Let me see if I can clarify that! Thanks!

-- 
Cheers,

David / dhildenb


