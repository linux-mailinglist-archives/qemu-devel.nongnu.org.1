Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 181077598A6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8MC-0006QR-Tx; Wed, 19 Jul 2023 10:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8MA-0006Px-NH
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM8M8-0000q4-AE
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689777643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQM4omtIX032wHeWEte4BKfaloDdmGz4VlMwAQDBa7c=;
 b=SikDxprgv32BzI0QNVrfdXuX5xjXIrlP/DgZNTOuqCp90BjnZ64IDTFGB0lHl6oa/rg9lR
 DRc/nllg9vKVYw33tb21a1a+SgCUMmfPY7m6bCR4RtfA1C1QRTTIMbA27GC3jxL9jA4jOa
 VyOnPJ1tiXBm6eqMm/tu56NRm4OQD3o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-gtOMfeBmNPCeNQUO3voMtw-1; Wed, 19 Jul 2023 10:40:42 -0400
X-MC-Unique: gtOMfeBmNPCeNQUO3voMtw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-316f24a72e9so3129414f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689777641; x=1692369641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oQM4omtIX032wHeWEte4BKfaloDdmGz4VlMwAQDBa7c=;
 b=DPWM6eQsDmYqSPc1gvlOy52glJl9FpkI6sy/42EvolIKr/yxoHl/FFISqX7dVvbXY3
 l/LHowzbXQRPWwmAdQBMeqqqooJ8+4atkSecqZrLryuRlS0N6a19ObjBBe/SSKZysqag
 2FmTJekL2tWlRFv8jHJufVAoEAAJ7THOEZRNwMiQhLz+gqfak5ji70h2HTE2eKPiHKmW
 S7nlX+Q/Y4wHiMq7ENnDflm656/e6CavS/0HvDMhWzI6j6qv7HLynFV18rc9+P9BEVeN
 HRSJHvOlxVpwmQucSxWWr6s8HJiAk2FBrV9bYO0AwyrNv6Sz2TX0a2sRXokkQHvUW6RI
 Rq9A==
X-Gm-Message-State: ABy/qLY/QwEswLgDZnkxhKwXHAcJqXyJQD3yUKVZMcIq4rLTwhOQXIWH
 BrJ5cNvlrs+9qy+tPrApSWs4Ebyzu26gZry/8msovf93jzwYWj+wnigNohcjwzqnWkN6aMqaiQC
 mi7Ihuh+qOmfTe7c=
X-Received: by 2002:adf:ef87:0:b0:313:dee2:e052 with SMTP id
 d7-20020adfef87000000b00313dee2e052mr61533wro.26.1689777641172; 
 Wed, 19 Jul 2023 07:40:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFi7bUqIMizDDoxmXiY3zSHRWoRsf2FeHbtFqagm1KJB242OmLqC5RWJVNFGyHAzl1vAs8ymg==
X-Received: by 2002:adf:ef87:0:b0:313:dee2:e052 with SMTP id
 d7-20020adfef87000000b00313dee2e052mr61521wro.26.1689777640914; 
 Wed, 19 Jul 2023 07:40:40 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 m16-20020adff390000000b003063a92bbf5sm5534618wro.70.2023.07.19.07.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:40:40 -0700 (PDT)
Message-ID: <470ce12b-7ac8-b8b3-59ef-c5a8142bd865@redhat.com>
Date: Wed, 19 Jul 2023 16:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 14/14] tests/tcg/s390x: Test VCKSM
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-15-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-15-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/vcksm.c         | 31 +++++++++++++++++++++++++++++++
>   tests/tcg/s390x/vx.h            |  2 ++
>   3 files changed, 34 insertions(+)
>   create mode 100644 tests/tcg/s390x/vcksm.c

Tested-by: Thomas Huth <thuth@redhat.com>



