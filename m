Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1387497B1
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKgy-0001mV-Qw; Thu, 06 Jul 2023 04:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKgV-0001jE-AD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKgT-0007Sf-NY
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688633393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+x0mUPg9tkUNdnOnly5upPmO36Mdqg9jKQ8gcked0X4=;
 b=AwQzYY47vP42Xgzmj/YPJtpKo37d5VJbqdZpS5IuI2urFt+tIDg9SHI//D8/5MuLJWfKSd
 aWQa2X+5K/Zr25h8sug1hiFCPvqMxTJV6UnA9aQVK35tC8vj2xf35/l8QoyjCx4sk1ML7/
 1orWOPxitqN/JB2cIeMB6OclK2/pSJA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-r-tz5bYfNs-pY_B4RIpJWg-1; Thu, 06 Jul 2023 04:49:51 -0400
X-MC-Unique: r-tz5bYfNs-pY_B4RIpJWg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b700e51e93so4560331fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633390; x=1691225390;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+x0mUPg9tkUNdnOnly5upPmO36Mdqg9jKQ8gcked0X4=;
 b=ZE0jSIU2ZzWicGMRtwKbWSnkp1u0XBwYulcV31IsfQDfAuLvC2xi2RYJy448KTjl5l
 k3rgmRhLQdBQ9ZZFVlgn0dh4KwyQb3hzpEyJrZ7o+QZdKo/IhEJBV7TgKfD08ucMJlO+
 UKhJXIh3zwErEU7Ts/4PBPsKFn7I78AxgA30PqSvoyD0NRH9CHZ12AJ6EoadqE4h4LRx
 NvWi1RbM0tASnP/tNtjC6Ujn25xi6qtVjAOb37JDkVl9+19f5rSg3lrwgdAXuamq8zQ1
 NpRwAaWSWBULbTElduxxJ6/MO4FTAMkQ/EfL6Pln5uYFmZqSE2TLS8u3MFShDDDb9ePF
 2eRg==
X-Gm-Message-State: ABy/qLal/0oOSDrJYt268OZTe3dyBD7cJ4GAP5pOtXYpUYNrO90CZjOc
 nTfj/E5aPpNIzsaMggKzLpFCTeu0NkpQKvNkzvKeEfGPTAcnjVMt/SWlRrBD6KyFMkNhgOmugtV
 NOFAofMxlAxCMba80CesEdYqSqj8DnX5u0MUt2uzVTTh7OnV5hrIMhOz63wGzKSZk/ge0bCs=
X-Received: by 2002:a2e:9004:0:b0:2b6:a44d:e255 with SMTP id
 h4-20020a2e9004000000b002b6a44de255mr805479ljg.0.1688633390498; 
 Thu, 06 Jul 2023 01:49:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjHEdKZJ7thHSfJ7CVY+n4y98iFtsYkeYFxbzMzpDrdYnwSPLvK84+DoUNZyVFoqbkxM65UA==
X-Received: by 2002:a2e:9004:0:b0:2b6:a44d:e255 with SMTP id
 h4-20020a2e9004000000b002b6a44de255mr805460ljg.0.1688633390098; 
 Thu, 06 Jul 2023 01:49:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc852000000b003fba6a0c881sm4418357wml.43.2023.07.06.01.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:49:49 -0700 (PDT)
Message-ID: <be03090f-7203-bd70-b984-dd797718a86e@redhat.com>
Date: Thu, 6 Jul 2023 10:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230706075612.67404-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

>   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +            /*
> +             * We'll discard data from the actual file, even though we only
> +             * have a MAP_PRIVATE mapping, possibly messing with other
> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
> +             * change that behavior whithout violating the promised
> +             * semantics of ram_block_discard_range().
> +             *
> +             * Only warn, because it work as long as nobody else uses that
>

I'll fixup

s/work/works/

-- 
Cheers,

David / dhildenb


