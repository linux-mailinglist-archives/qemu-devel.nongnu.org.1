Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CDE802B17
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:54:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0y1-00048R-O5; Sun, 03 Dec 2023 23:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0xz-00047Z-LY
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0xx-0004qT-FN
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbEawc7USmtnp14plmlC0rvvHbMjnG4ZLzYRjmxUA7k=;
 b=fREqeviQgFdeIl3jFLO51W9OzKhrJINbv6KUPuxkiFCOvIYDabDuyufx0/+abKZDDG0JYG
 webpA+02pqMaU0pXdHGOv5JR58YrFeItwW4un7+ekNfCMxjPEo2fJwmVe0P2RzQ+j69FGY
 NM7ffquKPzE6SgUID2rS/g1pUErq1Gw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-F__EGe9bNYmaB00F29CHqA-1; Sun, 03 Dec 2023 23:53:55 -0500
X-MC-Unique: F__EGe9bNYmaB00F29CHqA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d0737b7262so4208615ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665634; x=1702270434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbEawc7USmtnp14plmlC0rvvHbMjnG4ZLzYRjmxUA7k=;
 b=KOWopn9ASA6B/i1xVOwBWr7cNIRHvqoWlulLBhPgvz/d/JfXfTBgKYZ9zueJYFr6Cw
 Lv7UgnGAT1PDrCYfOz+H6UnlgOZlOQSm/Xz2ksaN2qYKd7+XazpTEi61NtWaezlReOvt
 r6SyCUxIt4HMHC4UPmKpYUIJ68wnvTbybsymLbWo3FKCYYXB0XJkLBqc+iD0bnX19ipw
 +1QdXswmCPYVLZ+/W6XcHz6dn+97bpoHlJ/bvRl+FVJ7n6P0BbxfuTmwaJQlGP+PyISY
 Qo1P1+2fJOBZb2IAg/IFbSQR2hVL+GJWpFTxiGp/CZLhZBcZOTVUaI4pHl6MdXlQGeie
 Wxhg==
X-Gm-Message-State: AOJu0YxQy6/HPUlrcNH8+g9+5yGI/HLT/ih5o3XZEYvJACcHfwmED180
 MDksNECPc/QQFZW3nxQ4A14t8bF6AGyUEc5rSxpmSHplroYS5QcaHI3TGiSoiQGP01BHk82ATGc
 3+NB01e9Ur0mDHq7k5UUUssY=
X-Received: by 2002:a17:903:124f:b0:1d0:8613:3cea with SMTP id
 u15-20020a170903124f00b001d086133ceamr926501plh.0.1701665634231; 
 Sun, 03 Dec 2023 20:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1gwavmWaSSHMt5CBdso4KjefA+n21/eT+ijrVTQuGa/Njc4lsY/24ZR/RtXkXWxFzi7U0mg==
X-Received: by 2002:a17:903:124f:b0:1d0:8613:3cea with SMTP id
 u15-20020a170903124f00b001d086133ceamr926488plh.0.1701665633977; 
 Sun, 03 Dec 2023 20:53:53 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:53:53 -0800 (PST)
Message-ID: <5c89221e-b320-4842-9e20-ddd27fe13645@redhat.com>
Date: Mon, 4 Dec 2023 14:53:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 12/25] memory: Have
 memory_region_init_ram_from_file() handler return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-13-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 4 +++-
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 

s/cpu_exec_realizefn()/memory_region_init_ram_from_file()

Reviewed-by: Gavin Shan <gshan@redhat.com>


