Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B5978C7A4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:35:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazmX-00080A-9y; Tue, 29 Aug 2023 10:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazmV-0007zs-TE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:33:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazmT-0007fA-MC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:33:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so1292471a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319600; x=1693924400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5MNCHhKUaSJNWbhq7zqf40FNGZbOYQKxHkc3qTW4uug=;
 b=ChN5Owfx7B1FOLTSrOKXD0qLppW3M1xruacD+9w7+EP+5cvz24GPE/IE/DsKO82AFt
 n5w1uOmxKSRkquYxRYnBidqGcM3MOlw9CBxmLxSA3UfCZRMNG5OBDOfCkfBpaNnR4qBX
 sD36mb3vVqX3vPY37p+XX+5xZlZIL8Z/X1zSRXqrPb5G+aUXFN0AJtgicFwU5GJEid1a
 Hx6tnpGqJ1GL9a0YYTdH74v/keQlQGqk8FKK69GrmQGwYIelowyF9NoqjB9uz2Lt8PCJ
 TAvdUg7x8o5S369x0TMG0WSEeuNzyl2EXJc9K7hotb3K+0Kjn2fIQ/nEwuZtOs/fmVgO
 Agew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319600; x=1693924400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5MNCHhKUaSJNWbhq7zqf40FNGZbOYQKxHkc3qTW4uug=;
 b=BxWdiHaPm+kSTA1qONyiDs32kiN3BKq3FcktVZUubJjQDIxAEfCh+7Tv0OGinKUstX
 A1lcLj4Ia88egUKg9lNjvVSmxrgn9yK9FKXBSpMJIY9YJwHiLTvQioWwLWm9va+6W2eP
 xyiw86uMV2xSD9hrd3UxcZvr4OuYk6PvIUfJJq7JOMveg45UGHawNRLkAK65xaFVr+iG
 LvLL5kpujh2XdIWMod2GsquPoKvj7WSNoerx/I1HvgL7JXvyBVoOCki+g0Z8eJhZyxwm
 /g43xU7UjqVP5QW2o/u7RLWwJEyUGW0MOuwo5/F17F5tE/EBgwqw0emL0TEiJt2uVI34
 FaSA==
X-Gm-Message-State: AOJu0YwhuXrVBpqAnutzh2hSX+AycYPJR30s1mg5YajKWA5YRY51/+mu
 S3+C6T/YYRwI9d1LSUh9yqlSeQ==
X-Google-Smtp-Source: AGHT+IHqkUUmc8lqtheoOUVpJIIMSt0ltxbxM52T15ZmMWwF5FptHJ/KxzonG/lis9cJDWHVZgtWAQ==
X-Received: by 2002:aa7:cd50:0:b0:525:4471:6b5d with SMTP id
 v16-20020aa7cd50000000b0052544716b5dmr21444068edw.19.1693319599807; 
 Tue, 29 Aug 2023 07:33:19 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 l20-20020aa7c3d4000000b0051e0be09297sm5735208edr.53.2023.08.29.07.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:33:19 -0700 (PDT)
Message-ID: <68526bca-6054-510e-09fe-f73bf610b005@linaro.org>
Date: Tue, 29 Aug 2023 16:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 36/58] memory: Introduce memory_region_init_ram_gmem()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-37-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818095041.1973309-37-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18/8/23 11:50, Xiaoyao Li wrote:
> Introduce memory_region_init_ram_gmem() to allocate private gmem on the
> MemoryRegion initialization. It's for the usercase of TDVF, which must
> be private on TDX case.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   include/exec/memory.h |  6 +++++
>   softmmu/memory.c      | 52 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)


> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af6aa3c1e3c9..ded44dcef1aa 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -25,6 +25,7 @@
>   #include "qom/object.h"
>   #include "trace.h"
>   
> +#include <linux/kvm.h>

Unlikely to build on non-Linux hosts.

>   #include "exec/memory-internal.h"
>   #include "exec/ram_addr.h"
>   #include "sysemu/kvm.h"


