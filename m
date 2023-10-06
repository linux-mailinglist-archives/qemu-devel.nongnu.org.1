Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E67BB49E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:56:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohYg-0000Md-Fo; Fri, 06 Oct 2023 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qohYO-0000Lj-Tt
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qohYM-0005ZJ-VS
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696586126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H2QJ/s3SpBQxhuU4qYU9T8XhzOwpmavpMhuP32cE/c=;
 b=euv8dvOKAfvtuHoSkaZ6VqgD28Th3DFBM8Xw6aJJ/Wi6WE8UnZOj/rjkuvMjWg7WPzA949
 hxcFIawDUxjgixuoO4P6MuRULOfIN8UaHXURaDDTtPhKG1TCSOzHI2coPluIm24ufxtgWM
 0cU2TKzQWBUVe3avENT+wkQrVx2Mss8=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-4jXqyiJNNli0g9xjSDx-eg-1; Fri, 06 Oct 2023 05:55:24 -0400
X-MC-Unique: 4jXqyiJNNli0g9xjSDx-eg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-49a9e67d024so705369e0c.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696586124; x=1697190924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0H2QJ/s3SpBQxhuU4qYU9T8XhzOwpmavpMhuP32cE/c=;
 b=eSwBwKjnXOAYkwSVI4i84YpNN4PM/orwusFiNsVymWzMlK/FEZL0LZIsVMelHeV71I
 wVLYHFknNjN749y6crJPmGke0++4nDcx/l+QgK85UNMfBx/ZmfaYdpVA7oNSSWfwjShs
 LWvaXNxAiPNqh0E76/H+nJ2NXad3nSoCv3IFJE0i+IPYnzD7kPtRet9rbrV9KZYqkVFA
 A/odOSDUxp5BRaXjIgnASvQ+LlvfB6vTBKzWV4s3MpeohLN2YSkmaccDJ4nSQ5ZJuQYJ
 TiW/qAopLcQH95gjtqB4Caap/xVac3VYdWX3I4eXHjNyd9yoWEq64VweLSH0R6EcPBEZ
 mqgA==
X-Gm-Message-State: AOJu0Ywp52O9TgIlCLGQryZ8DJz+BKpaZexaPGgPd0661SJplqkFS4Ml
 U6Vcb0e7E5RaZXVmAQlOR8yG3vtM7AHmOINAn5upBr+ZvaoI+nb4RCQkMl9NXTR/3xMUChW1Cqp
 i9XX8D0Aq8PLihUo=
X-Received: by 2002:a1f:a9d0:0:b0:49d:92e0:9cd1 with SMTP id
 s199-20020a1fa9d0000000b0049d92e09cd1mr7329146vke.11.1696586124019; 
 Fri, 06 Oct 2023 02:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpKeCYbo0dLxxtag45LyvYtJWdVNdypBb8mIdREbRnpqFz1cM2oeqNV79IzxNYTPw0LITdzw==
X-Received: by 2002:a1f:a9d0:0:b0:49d:92e0:9cd1 with SMTP id
 s199-20020a1fa9d0000000b0049d92e09cd1mr7329139vke.11.1696586123644; 
 Fri, 06 Oct 2023 02:55:23 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 e15-20020ac5c98f000000b0049971fc9efcsm337417vkm.29.2023.10.06.02.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:55:23 -0700 (PDT)
Message-ID: <6f175ff8-5c23-62ed-a909-4b60fa230545@redhat.com>
Date: Fri, 6 Oct 2023 11:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/ppc: Clean up local variable shadowing in
 kvm_arch_*_registers()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20231006053526.1031252-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231006053526.1031252-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 06/10/2023 07.35, Cédric Le Goater wrote:
> Remove extra 'i' variable to fix this warning :
> 
>    ../target/ppc/kvm.c: In function ‘kvm_arch_put_registers’:
>    ../target/ppc/kvm.c:963:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
>      963 |         int i;
>          |             ^
>    ../target/ppc/kvm.c:906:9: note: shadowed declaration is here
>      906 |     int i;
>          |         ^
>    ../target/ppc/kvm.c: In function ‘kvm_arch_get_registers’:
>    ../target/ppc/kvm.c:1265:13: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
>     1265 |         int i;
>          |             ^
>    ../target/ppc/kvm.c:1212:9: note: shadowed declaration is here
>     1212 |     int i, ret;
>          |         ^
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   target/ppc/kvm.c | 4 ----
>   1 file changed, 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


