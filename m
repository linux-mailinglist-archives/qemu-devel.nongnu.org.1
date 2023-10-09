Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3610D7BD361
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:32:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjnz-0006eh-Mf; Mon, 09 Oct 2023 02:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpjnx-0006eG-GG
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpjnv-000484-Nl
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qxIkWegS4m1rDGV1WVbirQjNNXAH2M9EFweSgKA7ZE=;
 b=GBmbVaNtgpGmNhkWgFZDQ91OUNZCr3aZkJFai8Z2gqrmmf2+abZTbtSirBkgHugqEtjQxf
 njg0BpwCrC9DF3fkK1igqo4mCNBJp6wDkYIai6GvAKHkRZYIfHWHJvjKZGbPM36Lsn1/Gh
 QU5sWu1JZbolkVHL0Ohm4BXsxN0YpFA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-XDhy7TF4O9igEX7nk8x5aA-1; Mon, 09 Oct 2023 02:31:45 -0400
X-MC-Unique: XDhy7TF4O9igEX7nk8x5aA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1e1ad195cbbso6302098fac.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696833104; x=1697437904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qxIkWegS4m1rDGV1WVbirQjNNXAH2M9EFweSgKA7ZE=;
 b=k0yPjShh/3lTUFi6a+H5FIHpS2A092gVj8IZyg19+GFmrpR1W3sKuLWbakEiRnnxrr
 VPKJ5R/aUwPVZluw71JgUsorYMzuVnFSENxDgfP9XYz0UI1T28PekQ8FdlInJm9/sKK4
 D6ivNrz350zjhU2Coe3+2e9V3HLU6JUsGu1v95V7YxtxVziASD+3ejlqiBICW7FuIzLr
 lTw1Sv0hSIqxWw7C5Hgpn0xMrm6CJD8TiOSPNXZ+BJS9dleYSqBS1ozSr2+WZ+y75wSV
 BBazborf9rSreZZli8dntmQshZAsuSvvmFwQxrK/egpZyudM5HmIFHjEtR4uwjNax4CR
 LJOw==
X-Gm-Message-State: AOJu0YxXXuZ4FPmMRL+IzddvD2oCwVVgAnKZaelu8b2/mmqN+hAUZLl2
 2Lbg1y5fw16uLzxIux5nKKVDSI0r8VfMP8vMuXzMrSebgTsDiJHp2BQcIRvCrwin6IHzwwoV5FV
 U10PvPQyL3GGvsmc=
X-Received: by 2002:a05:6870:ac1f:b0:1b3:8d35:c85f with SMTP id
 kw31-20020a056870ac1f00b001b38d35c85fmr15986239oab.1.1696833104415; 
 Sun, 08 Oct 2023 23:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Cm0D1aCjkT3rew9UPAoi0qJlbzhLzHatqyhOz8Ks2hG62cMudp2sM8QHCWltDMtW3KalhQ==
X-Received: by 2002:a05:6870:ac1f:b0:1b3:8d35:c85f with SMTP id
 kw31-20020a056870ac1f00b001b38d35c85fmr15986227oab.1.1696833104105; 
 Sun, 08 Oct 2023 23:31:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a0ce152000000b0065d051fc445sm3609601qvl.55.2023.10.08.23.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:31:43 -0700 (PDT)
Message-ID: <afd76927-c523-e53a-4205-966c6082d3a2@redhat.com>
Date: Mon, 9 Oct 2023 08:31:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] vfio: memory leak fix and code cleanup
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, borntraeger@linux.ibm.com, aik@ozlabs.ru,
 eric.auger@redhat.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231009022048.35475-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 10/9/23 04:20, Zhenzhong Duan wrote:
> Hi,
> 
> This trivial patchset fixes a incremental memory leak in rare case,
> and some cleanup on ap/ccw.
> 
> This patchset is based on vfio-next.

Will this apply on the future v5 of Eric ?

Thanks,

C.


> 
> Thanks
> Zhenzhong
> 
> Zhenzhong Duan (3):
>    vfio/pci: Fix a potential memory leak in vfio_listener_region_add
>    vfio/ap: Remove pointless apdev variable
>    vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW
> 
>   hw/vfio/ap.c                | 9 +++------
>   hw/vfio/common.c            | 2 +-
>   include/hw/s390x/vfio-ccw.h | 2 --
>   3 files changed, 4 insertions(+), 9 deletions(-)
> 


