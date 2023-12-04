Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3F802B39
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA1Ce-0007RT-9W; Mon, 04 Dec 2023 00:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA170-00042T-61
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA16y-0001lF-O5
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGnIUK3zSJXAxMdd7aMNLjAWeg7/5KSLFErHzAl47Us=;
 b=Nahhik4cysD44MCvVu5mftEDHfpUTYTj4xrn2ZXhuIMY+/ZzcgYFG5oSUokqYojfx5RCtX
 715v2PD0kHa0OszxF59rpcePg9bWpZYUj/yE3Wl8HV5GHmo0iDMxSMAe95V5HdSuKiOo8I
 a9bbAWFh+y3KfieyhmqVyzL3E2S33FU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-AyffWNxtPfCSlXB2w2YH_A-1; Mon, 04 Dec 2023 00:03:14 -0500
X-MC-Unique: AyffWNxtPfCSlXB2w2YH_A-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d053282390so13538875ad.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666193; x=1702270993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGnIUK3zSJXAxMdd7aMNLjAWeg7/5KSLFErHzAl47Us=;
 b=MTrNMoc8JmI/zQMmuo/c7Cs/CYQ2yKmCzSpdTAsBzvqyF/PpxQatQVsGvEVGux1LUV
 thePGNvPlcsyGr6c7DEH3E1xSL77Hd4aLpM0Ra2URdMMtz6mh4Z3c5Hw6Q7cnwptTchP
 bwuaW4rhp0tqFvje1z8nSFWXLJ78F03zXHmGcl+PwUaAJsTVS/QwxpDutLFtdQWTQkvz
 Sq5pZXhaUHF/PeKJqkpL1W3DnhSaW42B/B43vi5GaSaT+E0dwzZ+0RwjPDn1ZQdrZRtF
 eFT2hejlKCjWYjItS7++thqvB2qHHs8C75Z3zItp6lJ2gDVMOX7x7oczhwtMzIV6xNfz
 UP4Q==
X-Gm-Message-State: AOJu0Yy+j9Ece3kLRUglGapMxYffbgPBsdn8wL6qAdxlcdA59z2PeKq9
 aiTzbXYChScmRkeZNWNGWzlUT3KTKvp3IrzFawc3pV+N9Vb16z8ogR/LLsCy0bqmRvFkiwUEHQ2
 iKl9lrPRe6U7lhf8=
X-Received: by 2002:a17:902:9048:b0:1d0:6ffd:f223 with SMTP id
 w8-20020a170902904800b001d06ffdf223mr917899plz.121.1701666192992; 
 Sun, 03 Dec 2023 21:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEWZPGnhPPEpao6oGIIzb72oVM71Uf2ygvxbl7GDwSZs4xUj7WyiVhw/ULoFD2X1l62iTf5A==
X-Received: by 2002:a17:902:9048:b0:1d0:6ffd:f223 with SMTP id
 w8-20020a170902904800b001d06ffdf223mr917887plz.121.1701666192677; 
 Sun, 03 Dec 2023 21:03:12 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:03:12 -0800 (PST)
Message-ID: <d49e9d47-09e1-497f-9da9-11b0a181edd8@redhat.com>
Date: Mon, 4 Dec 2023 15:03:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 24/25] hw/nvram: Simplify
 memory_region_init_rom_device() calls
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
 Peter Xu <peterx@redhat.com>, Joel Stanley <joel@jms.id.au>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-25-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-25-philmd@linaro.org>
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, arg5, arg6, errp;
> @@
> -   memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp);
>      if (
> -       errp
> +       !memory_region_init_rom_device(mr, owner, arg3, arg4, arg5, arg6, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/nvram/nrf51_nvm.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


