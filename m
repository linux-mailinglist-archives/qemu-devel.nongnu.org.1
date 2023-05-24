Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855CB70EF68
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1iw3-0000mV-Nd; Wed, 24 May 2023 03:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1iw1-0000m6-Bi
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1ivy-0004FY-Us
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684913361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxksY84E2BG9AQy9FMweEQ46ibilAROlIsrCOTj/YZw=;
 b=Cou2oRcDoR9RuCbSjC/2VG9yaG5cylXPO42YJShJQquPsdiy/05UvJfUPlZUX6vjoE1pmL
 CaH0VLHFkQGwLXJRS9rwxwOTwyxilxnK2oxcV4bJ/z43yvSe1GX+YuuAbLxvSN1YWMlQIo
 YWecgSeeqt/nlclpBn/rzYjB8/oymq0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-1r9BpkIROeG6d9AiGvhK3Q-1; Wed, 24 May 2023 03:29:20 -0400
X-MC-Unique: 1r9BpkIROeG6d9AiGvhK3Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f518f2900eso4157485e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684913359; x=1687505359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxksY84E2BG9AQy9FMweEQ46ibilAROlIsrCOTj/YZw=;
 b=ZjaqgJqyg6YXy+q6MoYEVlZOr4J/RrMPcLOljvp3089a/SqF0V9YeuOj6rKdWvZFTo
 U37qRF42Fp1RS+HMDeHua+W4xhFHw/V6NrjvWqJSx3j/EwptSiVb1qVc2D5lXc1Soa+w
 pRJkxO4YcRok5jtGb1yY8Eyds3tqIsG19g5qO4p9KZ+alEu8MC61o0qTfCZu7LPP7Kjd
 S/APWuWPpw7rKllphqRGXUUCWDnWX78Gz1B5d2fELOhQdV15Ii87VOtqjuVXUtZKCF+i
 K5zpOCQUCY9s24dI2KtK0QVkpqSq0hFUuQQYB/o+qKAsaxMm38BBQOCv5thbvrcNdgyi
 Xkpg==
X-Gm-Message-State: AC+VfDxqO99mxedILpG2XC8QLNoOOgd/78Yu0si/cd1+0f4MvaHJ4M07
 9rrQ3Gz/wLzv6C7o9kJ1nU6fL5bsDihfCZUDbiL06OwxCycs0hRTjmyOPNdrR2kI15pbPMlBQX1
 jDq/EJqL4bbVuIAM=
X-Received: by 2002:a5d:6509:0:b0:309:3db8:51e6 with SMTP id
 x9-20020a5d6509000000b003093db851e6mr11948893wru.35.1684913359095; 
 Wed, 24 May 2023 00:29:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50NV2cowc74uhzUTranXYwGXg4MwKoegPoxtbV8znT2NsbU/b6l3QAZCen3i9mscZiDWq3jw==
X-Received: by 2002:a5d:6509:0:b0:309:3db8:51e6 with SMTP id
 x9-20020a5d6509000000b003093db851e6mr11948859wru.35.1684913358810; 
 Wed, 24 May 2023 00:29:18 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 o14-20020a5d58ce000000b003062675d4c9sm13305778wrf.39.2023.05.24.00.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:29:18 -0700 (PDT)
Message-ID: <b9a1db8d-8800-3103-c6ca-076d5b14919a@redhat.com>
Date: Wed, 24 May 2023 09:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 09/11] hw/virtio: Remove unnecessary 'virtio-access.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-10-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> None of these files use the VirtIO Load/Store API declared
> by "hw/virtio/virtio-access.h". This header probably crept
> in via copy/pasting, remove it.
> 
> Note, "virtio-access.h" is target-specific, so any file
> including it also become tainted as target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/block/dataplane/virtio-blk.c | 1 -
>   hw/s390x/virtio-ccw.c           | 1 -
>   hw/scsi/vhost-scsi.c            | 1 -
>   hw/scsi/vhost-user-scsi.c       | 1 -
>   hw/scsi/virtio-scsi-dataplane.c | 1 -
>   hw/virtio/vdpa-dev.c            | 1 -
>   hw/virtio/vhost-vdpa.c          | 1 -
>   hw/virtio/vhost-vsock-common.c  | 1 -
>   hw/virtio/vhost.c               | 1 -
>   hw/virtio/virtio-crypto.c       | 1 -
>   hw/virtio/virtio-iommu.c        | 1 -
>   hw/virtio/virtio-mem.c          | 1 -
>   12 files changed, 12 deletions(-)

Very good catch! I checked that it compiles and links fine with this change, so:

Tested-by: Thomas Huth <thuth@redhat.com>



