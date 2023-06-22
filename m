Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6FD739F92
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIa7-0007wJ-Vx; Thu, 22 Jun 2023 07:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qCIa6-0007wA-Gp
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qCIa4-0002fR-Rg
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687433666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9xyGCr8+osi8WX9VO3/83C2qIndsOFOywBJZ16awu0=;
 b=Pr8VX4EEdgVi5+hHoT4wUkbDdC2YxyhMZr8rKf69uZ0xtfWd7n6EvnbustkNkTSV+SnFdq
 UFqpmQSMbKeasNirU9tvbCkq+eJjGmOHQG/dPskbu8hgXgOCr4PxbD5GPhl20rMdF7FPyJ
 HDapgNStoKq1jhE15fiuIUolx8OKC1Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-23rRJaunPfSrzgiwzTFpDw-1; Thu, 22 Jun 2023 07:34:25 -0400
X-MC-Unique: 23rRJaunPfSrzgiwzTFpDw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so3544343f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 04:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687433664; x=1690025664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s9xyGCr8+osi8WX9VO3/83C2qIndsOFOywBJZ16awu0=;
 b=jpo8ZXQTRqsG8SQe55AN/oixG5imLCf4Q4/V6zGIox8wdMsV5iZsyMJbUahLJ1caLI
 kjsOLkDXcS5t718c4u286wjav4j1ahdhcVBfVz6P59qtdRtxE8BwlaegKi+b1AVX+4QI
 I0j2WVKEhedKPPLITMAcPtHIrMuD482hGzqxe8kvBO9FlGLgIHNFBgQWGgQ0MY4AEXQw
 8JD23PbRzXc35vpZqc9yHHqAfsg993054M6xSXwGMDVmK+ZkqOfZTjpWZYRJarvrmGCA
 P4XZ2irQjkGa9WzzwqyKkyIsextvccHuhH0J5RCMwgOyj3MzSM5/RnxG8iIQHICTvUWz
 1ASg==
X-Gm-Message-State: AC+VfDwQCESiXZXsreThYRsm3zMYoWgxFDssX6hrOy4CSsqRzlsQx7tQ
 DhKLltpeBbRUPgFBVNJaLXGI+QpSuo/FyEUJlhBWaIFjszJUtu0y4+nL31X/Z2OGTcXDxOB1i91
 hlHolXJ7gbhmluEk=
X-Received: by 2002:a5d:514e:0:b0:30f:c5aa:4ee2 with SMTP id
 u14-20020a5d514e000000b0030fc5aa4ee2mr16261270wrt.37.1687433663948; 
 Thu, 22 Jun 2023 04:34:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Va7jbmBaOmq8+5bxSOSLHg32+npP85FJZq32+uXnqO1PGAT3rV1eVW36XI/RaqE1zoSBNmA==
X-Received: by 2002:a5d:514e:0:b0:30f:c5aa:4ee2 with SMTP id
 u14-20020a5d514e000000b0030fc5aa4ee2mr16261258wrt.37.1687433663631; 
 Thu, 22 Jun 2023 04:34:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 x6-20020adff0c6000000b00307972e46fasm6773314wro.107.2023.06.22.04.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 04:34:22 -0700 (PDT)
Message-ID: <5f1c5fa6-20a4-a29e-3381-728ea0aa1797@redhat.com>
Date: Thu, 22 Jun 2023 13:34:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 0/8] migration: Add switchover ack capability and VFIO
 precopy support
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20230621111201.29729-1-avihaih@nvidia.com>
 <20230621132848.79c9b674.alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230621132848.79c9b674.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/21/23 21:28, Alex Williamson wrote:
> On Wed, 21 Jun 2023 14:11:53 +0300
> Avihai Horon <avihaih@nvidia.com> wrote:
> 
>> Hello everyone,
>>
>> The latest changes to migration qtest made the tests run non-live by
>> default. I am posting this v6 to change back the switchover-ack
>> migration test to run live as it used to (because the source VM needs to
>> be running to consider the switchover ACK when deciding to do the
>> switchover or not).
>>
>> Changes from v5 [7]:
>> * Rebased on latest master branch.
>> * Made switchover-ack migration test run live again (I kept the R-bs as
>>    this was the original behavior when they were given).
>> * Dropped patch #8 (x-allow-pre-copy property). (Alex)
>> * Adjusted patch #9 commit message according to drop of patch #8.
>> * Added R-b to patch #9 and Tested-by tags to the series.
> 
> I think Cédric is going to handle the pull request for this, so...

Yes. I have a branch ready with this series and a few other fixes. Unless
Juan want to handle it.


Avihai,

QEMU seems ready to allow migration when support is available in the
kernel now and so, we can set "x-enable-migration" to true by default.
Are you OK with that ?

There are still some blockers, multiple devices, viommu, these will be
removed with future changes.

Thanks,

C.


> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 


