Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B6D802B2A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:02:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA15p-0001tV-PX; Mon, 04 Dec 2023 00:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA154-0001ak-7t
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA14z-000109-6I
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qO+ATsPxkLJU5h4QwQwi4wkLsnuKUqTnlbH2XG3bLG0=;
 b=cI0qLmOxKGAANr9kdpF0tWF0OazSgz6V6yqogRPyJvCt77NjKq1QiMj3bGr0opMKeRB/Mo
 M+45enDGxbQQJ+aMxHuJd6etvtRGrgGJ+auhSL1syTFe77UAczU1YuqKulvQ/qOkjuU1Nw
 an7fWSNzU5rldocsgrAQy8ujqZ5jPFg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-tXilThaSMPelfqEhdxdjdg-1; Mon, 04 Dec 2023 00:01:04 -0500
X-MC-Unique: tXilThaSMPelfqEhdxdjdg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-286a4fc4e9eso1114754a91.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666063; x=1702270863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qO+ATsPxkLJU5h4QwQwi4wkLsnuKUqTnlbH2XG3bLG0=;
 b=qD1uGT72FIKtUz+LrKx4eO/BQBhXps/IaiL2QbZ+sasx9SW8JqDHsumSclM2Gp9Vzr
 UADE84B6sn735RehYTo8ptzMNu442q9aULydGbnesDbVdk5tas4txAmkr1GRIahFKyRB
 Z//f2IgLb+x3Xv6o/FFcJrorHIAyR6Nz3ivyqE36gGss8g8EbgRaDugAc+LS2O48sL8H
 N+E0dQ7lOo+9jZAy9cCSwLprS3xQB99M9/uTWUM9lyF5RmtX8hTZxox7NadfolGXrBmo
 1rK7xUHeuThgoxb/l+8huEsvGpegxrk+8hEop2/3UOlk+6CWeCrsSyT3akyQ+ma7GqAJ
 cLHA==
X-Gm-Message-State: AOJu0Yz7AnzsRbv8K1bw4jbzR/QJhFZ+EBVpyzxvHRH3NaIDB/ljZJx0
 AqMwuxVU7tUbpW0f4f1vrkEPqjSze4wODMD2D8aBNmF2YTI+CEot64pKpnYLdjKzllvnIs1pePl
 7zFArT5K+DYRPLd0=
X-Received: by 2002:a17:90a:474e:b0:286:6cc0:caea with SMTP id
 y14-20020a17090a474e00b002866cc0caeamr2096475pjg.97.1701666063400; 
 Sun, 03 Dec 2023 21:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz0cGKN9KVyX6NgTYe+TvhYkoPZr9qAPlFJ4iGkikWbHN533S7bjMPeSgOMJgL3diLOzM8Pw==
X-Received: by 2002:a17:90a:474e:b0:286:6cc0:caea with SMTP id
 y14-20020a17090a474e00b002866cc0caeamr2096465pjg.97.1701666063158; 
 Sun, 03 Dec 2023 21:01:03 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:01:02 -0800 (PST)
Message-ID: <1d94ce20-8c1a-4726-9ec8-3d6c9d3659a0@redhat.com>
Date: Mon, 4 Dec 2023 15:00:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 20/25] hw: Simplify memory_region_init_ram() calls
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
 Peter Xu <peterx@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-21-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_ram(mr, owner, arg3, arg4, &errp);
>      if (
> -       errp
> +       !memory_region_init_ram(mr, owner, arg3, arg4, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/aspeed_ast2400.c | 6 ++----
>   hw/arm/aspeed_ast2600.c | 6 ++----
>   hw/arm/fsl-imx25.c      | 6 ++----
>   hw/arm/fsl-imx31.c      | 6 ++----
>   hw/arm/fsl-imx6.c       | 6 ++----
>   hw/arm/integratorcp.c   | 7 ++-----
>   hw/arm/nrf51_soc.c      | 7 ++-----
>   hw/ppc/rs6000_mc.c      | 7 ++-----
>   8 files changed, 16 insertions(+), 35 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


