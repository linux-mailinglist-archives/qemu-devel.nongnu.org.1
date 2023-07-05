Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278C747E9D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 09:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxIS-0003Hs-MD; Wed, 05 Jul 2023 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGxIQ-0003Hb-VR
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGxIP-0002Sb-5J
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688543488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ro7mU21YY2SXEeO1UoQW5Md/4cRkZftspqYHfuY4OGY=;
 b=IvE8PIVXZE+1+AED+lXduHNwkgiBFo6l3avPLfpqrkH0HzAY3R44R8uX+cNaCccMK5/vhY
 HszQ6qc4DpBdbipGYeKZFTE3wiBYMdBMBo0JbAajpmgSJ3z0annmUnKP+JUWuXC8QU+xWO
 Gr8VacADIapr02EFtlZDZkpAR7J4mao=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-1HSJz-YjO8-eOWCY_9PCmA-1; Wed, 05 Jul 2023 03:51:26 -0400
X-MC-Unique: 1HSJz-YjO8-eOWCY_9PCmA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-402391ed8ceso74554201cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 00:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688543486; x=1691135486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ro7mU21YY2SXEeO1UoQW5Md/4cRkZftspqYHfuY4OGY=;
 b=NiC33l+u3zlNnCFPONwGdZX1g/C+tq0ZMNvPJ+SKLlrCCTRPLTRXuKumxI440EbDMm
 WuOyDra5dphSf6A9WIl893KlQmjLypVTtHs1ZaQkRvXrQc8hhgKZlt0uhI2BJX9SXz+u
 P7Aba1AC3cV2zMjxVXi4Lr8Ls4mJLCSzQLleYpyQ2g+FLcN36heEGeGkwET3/Q1yO2kI
 IEAdwE08sn1RW70mh9UYX9tMVHJSvZt/wCyHci6GkTYyLXU/tKzpJnmcUqV8VXpfmLFv
 lrijdOMCh2PLa5PW0FyjP1IoSB9FLBlVHaO0+y5L3lcO2sLX2YSwV06qD632IJGHvtDc
 lcMw==
X-Gm-Message-State: AC+VfDzsw4Zm7GWqoi3i6dpqNjRI500KdTFZgWIB/3IJPwhqhcoCa0Qb
 GiEK0lyllUGCGQBYCPJg6gxZmMU7KJCydzu50TvT/hQYT6sjvrlbjLLSGBve0SxQ91GZxtaDKa9
 AI6nYsF13AIEnamw=
X-Received: by 2002:a05:622a:12:b0:3f8:58d:713 with SMTP id
 x18-20020a05622a001200b003f8058d0713mr19710152qtw.55.1688543486468; 
 Wed, 05 Jul 2023 00:51:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7koeDnpRWDZel6YWHnvSu282UCoxhamRxX1xjAsmb2bo4GO5GFvp48oUD5onQlzowvtL+kEQ==
X-Received: by 2002:a05:622a:12:b0:3f8:58d:713 with SMTP id
 x18-20020a05622a001200b003f8058d0713mr19710140qtw.55.1688543486211; 
 Wed, 05 Jul 2023 00:51:26 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 fz22-20020a05622a5a9600b00400a9edf297sm7459162qtb.26.2023.07.05.00.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 00:51:25 -0700 (PDT)
Message-ID: <fdaeb719-a061-6838-8075-f5ffd6dc856a@redhat.com>
Date: Wed, 5 Jul 2023 09:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org,
 Mark Kanda <mark.kanda@oracle.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230705071523.15496-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/07/2023 09.15, Stefano Garzarella wrote:
> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> 
> That commit causes several problems in Linux as described in the BZ.
> In particular, after a while, other devices on the bus are no longer
> usable even if those devices are not affected by the hotunplug.
> This may be a problem in Linux, but we have not been able to identify
> it so far. So better to revert this patch until we find a solution.
> 
> Also, Oracle, which initially proposed this patch for a problem with
> Solaris, seems to have already reversed it downstream:
>      https://linux.oracle.com/errata/ELSA-2023-12065.html
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> Cc: qemu-stable@nongnu.org
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   include/hw/scsi/scsi.h |  1 -
>   hw/scsi/scsi-bus.c     | 18 ------------------
>   hw/scsi/virtio-scsi.c  |  2 --
>   3 files changed, 21 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


