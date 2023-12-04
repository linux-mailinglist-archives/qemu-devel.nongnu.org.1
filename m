Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50525802B1B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:55:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0zk-0005cj-5E; Sun, 03 Dec 2023 23:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0zh-0005cQ-HQ
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0zg-0005EP-7H
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdKJBSB8SWlkhKkke+4UGVqN6RjryXRG8SYwMu15ntY=;
 b=QThjf1Z+sAl1tO6IfAUOzJIq1gMsMCUYFknZjAU1nWMNvZrE+lgBWEl47VdPXcnwUw5iSV
 s/aoq+kNz48D28tZAbIa0RK4S3Tr8ME7urf6lq2v3Tx7NkhCcL5bjWtbN2avVDnCzuidni
 3QWRI+wBqrprgTFSD6Q53pTiYixk8Ss=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-6Ie14jXBO2m4lfSSKoEQXw-1; Sun, 03 Dec 2023 23:55:42 -0500
X-MC-Unique: 6Ie14jXBO2m4lfSSKoEQXw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5b9344d72bbso2839223a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665741; x=1702270541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rdKJBSB8SWlkhKkke+4UGVqN6RjryXRG8SYwMu15ntY=;
 b=JZajhHv+9gOwumo0lvXcUkcsEr1hOGsxTvafrGbgK5mA7AkOBytY2Srv9M32sNAFGB
 aT+QJeNTHnGJcScfB8diUowfzyFxijCYbaR3rrxwBZO4xvLFLIpxj/y2IBSHaJsqxdo1
 0W4D5z2/aprHotIWX9ZQvf8LahRQ1FKNlKObc2sgZwBze/m1mZF6Kt1M6Rkq0PVe26aQ
 fMns+xinUsdCXYULK6p5sCjiPJM8vDP1v96eXUeY8MEKPS/HMfWxus0QbL4H1HYMaY6i
 XGSa++oHtpaIjuuyxDmBc2P3zoIFZ5+4fs6CSkxHrYF8vJqXniXIfrLfI8ddU6I6kc5H
 aXEA==
X-Gm-Message-State: AOJu0Yw05dHd5APxsOrHCFJllgjea+mQyPR9jw2IP+3dHgSBBW39l3oR
 t2rVGqPeHKoJXvGd38f6OxjRKQIureJBYI3Aw/rEg0Yzci9LkV3IWfI13jYtgH4GtaI36l6Kfat
 roxbacHC8FeIn1m0=
X-Received: by 2002:a17:903:181:b0:1cc:449b:689e with SMTP id
 z1-20020a170903018100b001cc449b689emr4168550plg.20.1701665741132; 
 Sun, 03 Dec 2023 20:55:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHygh5XZVoJ5Ree4D7TgMlXedy1mdLBqzH5NtMofj56N/SXL8G3wM+qd1rx8CNp33pkWLMaEA==
X-Received: by 2002:a17:903:181:b0:1cc:449b:689e with SMTP id
 z1-20020a170903018100b001cc449b689emr4168536plg.20.1701665740862; 
 Sun, 03 Dec 2023 20:55:40 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:55:40 -0800 (PST)
Message-ID: <9a0b4af4-a91d-49a3-a05a-abb073ac8ecc@redhat.com>
Date: Mon, 4 Dec 2023 14:55:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 14/25] backends: Use g_autofree in
 HostMemoryBackendClass::alloc() handlers
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
 <20231120213301.24349-15-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> In preparation of having HostMemoryBackendClass::alloc() handlers
> return a boolean, have them use g_autofree.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/hostmem-epc.c   | 3 +--
>   backends/hostmem-file.c  | 3 +--
>   backends/hostmem-memfd.c | 3 +--
>   backends/hostmem-ram.c   | 3 +--
>   4 files changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


