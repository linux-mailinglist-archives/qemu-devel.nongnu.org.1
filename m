Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2F2778C18
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUPOV-0004Xi-KI; Fri, 11 Aug 2023 06:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qUPOU-0004XS-9p
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qUPOS-0007h2-I9
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691749758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwdsRepq6N0n1uIesFnapigskQH2uoomgnxs7HHXBqk=;
 b=a5fiGnCpIXMFODlqcTIYwaUi6GfjBI4X8zUcOAdWhBngXxzAro4eqJwA/rnOacuAZPaPRY
 Qc2tZZZC/RkDhG/IMIPlwino0Yi7vZ5z3MErzwzZYJzCuzl1kIpjMgru2TZo9DuDz/VX/c
 bCSfPhUJLdwsYib9qVGiJ0ZkZ0zntH0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-poXAnRsrP0ymB_QmC9XGCQ-1; Fri, 11 Aug 2023 06:29:16 -0400
X-MC-Unique: poXAnRsrP0ymB_QmC9XGCQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31955c0e2adso610977f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691749756; x=1692354556;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vwdsRepq6N0n1uIesFnapigskQH2uoomgnxs7HHXBqk=;
 b=H+JPg3V95muiJkcwoBWrmCZlLNLjhRigF1/avBQdji0RLhbtPceoaB5Gxt9ACI5Plc
 YjZbYrGhouefCVxv5UZRB8bMzOqgbaHf/4xJVqFhK+sOmoLxaZYkqNAh+tlpcXm4vNq6
 d2i1kcAH5uFMFJPwpGCxv4kgh+atjVkn2SAGJ8El8HGmJG05pTB6jKD1YgvL2lT0vkfc
 FFoY0jxGKf93yEEH7wgKebS7zoq+uiiftpEayPwpEiL8c1Csiitzyj62R5Pm9iI064Ee
 kkvomJlAIMTVJsbEs9+kTSUh0uihlVQPuGLebQ9RUtJDKNQmFjs4FUUTCK7YAI1PNubT
 UL2A==
X-Gm-Message-State: AOJu0YxUvCeLeYQyr/Mpz9FFG9y5FYXpB2Mx55bZKtuzNWSoClEX/NOK
 988qQkV8bKG5doD4sgcAL2Zf+UwsB8s97wGXMalpe1mff+Htt8eyK+PV1SLrekOw5x69d9KRHCf
 vRDkkQd/sMa9fSAc=
X-Received: by 2002:adf:f242:0:b0:306:2e62:8d2e with SMTP id
 b2-20020adff242000000b003062e628d2emr1037988wrp.1.1691749755881; 
 Fri, 11 Aug 2023 03:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyFAoqVyNpUxUfcngGDAshzkpyQ0CuBgeHj5us05CVo88k6Z6ivXr7IKN//MBwGp6Xnk0+KA==
X-Received: by 2002:adf:f242:0:b0:306:2e62:8d2e with SMTP id
 b2-20020adff242000000b003062e628d2emr1037978wrp.1.1691749755514; 
 Fri, 11 Aug 2023 03:29:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a5d428d000000b0030ada01ca78sm5049014wrq.10.2023.08.11.03.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 03:29:14 -0700 (PDT)
Message-ID: <6a6abfd7-16c0-ff7f-4af4-314be9307c52@redhat.com>
Date: Fri, 11 Aug 2023 12:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 v3 1/6] vfio/migration: Move from STOP_COPY to
 STOP in vfio_save_cleanup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230802081449.2528-1-avihaih@nvidia.com>
 <20230802081449.2528-2-avihaih@nvidia.com>
 <cc6d0b1c-036f-00f8-41fb-6ef1c59cafa2@redhat.com>
 <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <d870e5d4-dd34-6cdc-7586-971928927869@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.156, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/8/23 08:23, Avihai Horon wrote:
> 
> On 07/08/2023 18:53, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> [ Adding Juan and Peter for their awareness ]
>>
>> On 8/2/23 10:14, Avihai Horon wrote:
>>> Changing the device state from STOP_COPY to STOP can take time as the
>>> device may need to free resources and do other operations as part of the
>>> transition. Currently, this is done in vfio_save_complete_precopy() and
>>> therefore it is counted in the migration downtime.
>>>
>>> To avoid this, change the device state from STOP_COPY to STOP in
>>> vfio_save_cleanup(), which is called after migration has completed and
>>> thus is not part of migration downtime.
>>
>> What bothers me is that this looks like a device specific optimization
> 
> True, currently it helps mlx5, but this change is based on the assumption that, in general, VFIO devices are likely to free resources when transitioning from STOP_COPY to STOP.
> So I think this is a good change to have in any case.
> 
>>
>> and we are loosing the error part.
> 
> I don't think we lose the error part.
> AFAIU, the crucial part is transitioning to STOP_COPY and sending the final data.
> If that's done successfully, then migration is successful.
> The STOP_COPY->STOP transition is done as part of the cleanup flow, after the migration is completed -- i.e., failure in it does not affect the success of migration.
> Further more, if there is an error in the STOP_COPY->STOP transition, then it's reported by vfio_migration_set_state().

It is indeed. I am nit-picking. Pushed on :

   https://github.com/legoater/qemu/tree/vfio-next

It can still be updated before I send a PR. I also provided custom
rpms to our QE team for extras tests.

Should follow Dynamic MSI-X allocation [1] and Joao's series regarding
vIOMMU [2] but first I will take some PTO. See you in a couple of weeks !

Cheers,

C.

[1] https://lore.kernel.org/qemu-devel/20230727072410.135743-1-jing2.liu@intel.com/
[2] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/


