Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0192802AFB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:47:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0qg-000602-Hj; Sun, 03 Dec 2023 23:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0qU-0005uw-CM
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:46:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0qS-00004u-Uy
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4kXdObeEtLtxRoYNcLehjsHCdjrSdjq3cH/wfmO/qic=;
 b=VT+DRh5WshrqyQ4LRJCnypuruyzKZpBElp0bohJxwkrrxKrQ1SC1sW7GfCbnrHvgDoMAGF
 JiKQhgyKS73zIv+XR0EAIrAlAjSWgTlLOy5XBOWdjn4fT7vXhvysSvM7RAfjk+ACAyApBd
 jx++ndF6S+JlMEa/vlrRheXeBmHlzoM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-gZCUpyB8PNWXGOBND-73oA-1; Sun, 03 Dec 2023 23:46:10 -0500
X-MC-Unique: gZCUpyB8PNWXGOBND-73oA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d05f027846so12203335ad.2
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665169; x=1702269969;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kXdObeEtLtxRoYNcLehjsHCdjrSdjq3cH/wfmO/qic=;
 b=ofq8mS4TvLD3oQw8DPX/OJKv1AmsHUWFbQ097OczQQuwu/+j5lk5a+6B/OKhOH7Qhz
 Ky/nflzpJNDn3oNVIvQWr0cSWTQAULevd73l+UGX4qxsocoINJKl3A4gnYYxQ78XtTOu
 9YvmYCIjRWxKUZuF0a93EcE78E7vEuO4vUraT4k4XySxD4JbqA5PzWNaIecOeLV/mTnQ
 DgKMyZG3AxHBKd1QFul1FeMuu+J+ju3fUbZ3Pz5bIVTZsXS/lZ/MIGo1PPJUIvxONJ/4
 vjA2cEMO3so21LqUY0ReN0WPpmiM+ZHdjTj18+LdLhRYm/BkpKfi4RU2VSmxNNBlcOD1
 spIg==
X-Gm-Message-State: AOJu0YxSnC3Z88mU11lXl6mPtvv77KvReMcLV197aDsDVgTxGYoDxjLb
 kQMmdmRUR2YBtos0L7jcAFMkRvRNv/CXXL0vAtXHmwuSiv/SZ+RJ0wvhwfzw218ojNr+3mJfCFM
 T0PQhdfJsmqb9UF8=
X-Received: by 2002:a17:902:bd48:b0:1d0:aee3:59fd with SMTP id
 b8-20020a170902bd4800b001d0aee359fdmr294634plx.55.1701665169668; 
 Sun, 03 Dec 2023 20:46:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc+e2IBeufTr+CqO14KxD05FdAMK10VJLg367eFUtGqtVC391U61YB6XtQDRmoGPdEB6QgxQ==
X-Received: by 2002:a17:902:bd48:b0:1d0:aee3:59fd with SMTP id
 b8-20020a170902bd4800b001d0aee359fdmr294617plx.55.1701665169389; 
 Sun, 03 Dec 2023 20:46:09 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:46:09 -0800 (PST)
Message-ID: <cbfb5140-6007-45f2-84bd-63232c24f858@redhat.com>
Date: Mon, 4 Dec 2023 14:46:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/25] memory: Simplify
 memory_region_init_rom_nomigrate() calls
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
 <20231120213301.24349-5-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-5-philmd@linaro.org>
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
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp);
>      if (
> -       errp
> +       !memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp)
>      ) {
>          ...
>          return;
>      }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/memory.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


