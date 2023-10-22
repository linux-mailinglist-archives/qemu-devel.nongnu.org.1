Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56987D24B5
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 19:02:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubq6-0002xp-L7; Sun, 22 Oct 2023 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubq0-0002x6-5S
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:02:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubpy-00052V-Kv
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:02:03 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0ecb9a075so14900995ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697994121; x=1698598921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNG+cHdEX01alDGC5bm/XBQ3INhLkHitYoqZThWUcAo=;
 b=bh7Z58uKcfTlDgFjgvfsEBMoav60+AhjuoFGYoS7+5sMuNNgKNxecEiEHLrjxNY8Jp
 Gcn9UhdCxRn9NVfrJ85qWIEGG+gKgsWKsnvutM7yRxCGlFJQZWCE31RHV6OoBATfKijS
 C2VASN6aFP78ks2KAo3/3CBAtMCjFQ1ytb0hBzhrDaYt6ZgWkGrChsH26awAiecHsQyP
 cdU6GSt6qF1ONWul8WfqNz55WBEVrlZPJN5ctukhwWgTGeSoWu9u1Wci0TDBpmMIeLa3
 9GRla84BUYGgHOrBDW+sx9bzQw8sg2ARFTT8qEjNZpjqeqYveatHEfZaBbQ6iGK9OnNn
 fwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697994121; x=1698598921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNG+cHdEX01alDGC5bm/XBQ3INhLkHitYoqZThWUcAo=;
 b=aIQhzVVbYrQrlscr05Ip2cEvr14ZX/lwMMcB0O//+DRC+EGNaz48JH7u4o3Pl2xirw
 bgFF3s8+y3ZQwShH5baQQUuUWErB8yihVDIXDNvwe8CjX97oX/HaH1aguutPQQz6H+sA
 ckChoSHpRgrJ81VD6q48cas3VVcpr228oVYlwW9NMqqeLsLWb3Q6EBzcMimMXgv/YlgM
 nf6OoNt7D/raMhhWOortTaON1g0O0V9QXfdTLVYGyl+4RXql4GQS+BjQkaKaCfGJWDde
 /7FKJ73DWb/CScktBkalwd0EkI2aunhpf6NT54spNFDB/zHD8FOhxDp4+SOswAyw4cqd
 U10g==
X-Gm-Message-State: AOJu0YxAfsXnNdmg5DwBWNsZMP/harxLt3OIAhFX1irDDixRUZ45UKok
 LqrFsxncvp/We6o3L1sHsSxw+w==
X-Google-Smtp-Source: AGHT+IHIw6Tr5X5glnW/UMKX/71Ry5NpyRD7F8/PTX1Y1nbcef6fZy9M0kSaTgTNxkq9hvr5wGhBMg==
X-Received: by 2002:a17:903:1211:b0:1bc:e6a:205f with SMTP id
 l17-20020a170903121100b001bc0e6a205fmr6238525plh.20.1697994121261; 
 Sun, 22 Oct 2023 10:02:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001c74718f2f3sm4646941plb.119.2023.10.22.10.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 10:02:00 -0700 (PDT)
Message-ID: <8bf4381a-cc71-4421-832d-096ba2abb7ac@linaro.org>
Date: Sun, 22 Oct 2023 10:01:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] hw/i386/pc: Propagate error if PC_SPEAKER device
 creation failed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231020171509.87839-1-philmd@linaro.org>
 <20231020171509.87839-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020171509.87839-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/20/23 10:15, Philippe Mathieu-Daudé wrote:
> In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
> we neglected to give a change to the caller to handle failed
> device creation cleanly. Here this can not happen because
> pc_basic_device_init() uses &error_fatal. Anyhow, do the
> proper error reporting to avoid bad code example spreading.
> 
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

