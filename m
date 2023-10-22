Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A17D24B8
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 19:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubqf-0003uh-2b; Sun, 22 Oct 2023 13:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubqT-0003nB-S9
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:02:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubqR-00055J-FM
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:02:33 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cac925732fso13349345ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697994149; x=1698598949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rXUpJf5do0dED6ctZbsxdneBwFfcERUGOkZ17jLbgqo=;
 b=LtcOT/OQEjKj8yQMEFd1HV6zRiklpzdSZCwTpFoZbSf5Q6RWEfKFXirryVthOYRgiu
 MZZBRucbJDfF6us29O6TehgWnKoe9QfG0IlUXDUkolwuwVBlN4LtMke8tj71/ATPTL6X
 +MdtmlEgQn1afnypRb/JFi4GIBYT+xzXH4o7KB2qLZROeMfBPRvUoCugp53/B2tZCiz1
 teNPTNVfR8eZEExd05BFnRfbZ0/RUzFKkj/9hSjKeRgK0Z3VAYD2s7ObhcJNj1PCTCvD
 is1zMe0jy5Vy2cM4cwcy1ftFK4ew+KmMVHx6eyjJLAXpMJVToKp5yPwohhfeWr0gBE7B
 Np6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697994149; x=1698598949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rXUpJf5do0dED6ctZbsxdneBwFfcERUGOkZ17jLbgqo=;
 b=JCTUKfgVhGfknZHoF/bvd+8O032fUaCz3Lf1strJiH8z/sLGNt8kAxWZuxIUjiLaT5
 xscOa4WddRN7XBISmAxNcENpCr0NCyOWMgA2XHXf2i5n60pShKzxc6mBwCmZLywnOj85
 Tq39KRZ81w9WFuHOrSS0/87Y6GPv0f1olAWK4cn0h/ep6JjIrJveo3ef1JlnV4jZyoEG
 hoydxTqtt1dxqV29RL3mjRvnRtachZuz9aaSWb3RDu+PBjK7SQZHoAYAPI+AXQO+j8KE
 4CCF1sI8TVHhI+spmNtel3qOYMjzrLXFNIqWGCoBkDW7W91rpF/ly+UBY/DeA5x8Gqv0
 jCtA==
X-Gm-Message-State: AOJu0YxMWTZhXmv7y1G6flH6phb0hE1qk/QpsOsLd2sFdBON33Fwf2S0
 miU7qaJxMM/bkuaqEGlmbxUgxCS2nYcChhd96ac=
X-Google-Smtp-Source: AGHT+IG1o4D9nGp11tiDpIuH/R5TDZmlk5byx66C7D3FWZ4De6BC+8g3TAHlJtE3XUtHYHJbAv8d2w==
X-Received: by 2002:a17:903:278a:b0:1c5:d063:b70e with SMTP id
 jw10-20020a170903278a00b001c5d063b70emr5206639plb.53.1697994148835; 
 Sun, 22 Oct 2023 10:02:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001c74718f2f3sm4646941plb.119.2023.10.22.10.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 10:02:28 -0700 (PDT)
Message-ID: <b1c8751e-6913-429e-a5cf-d228a78b5f77@linaro.org>
Date: Sun, 22 Oct 2023 10:02:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] hw/isa/i82378: Propagate error if PC_SPEAKER
 device creation failed
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
 <20231020171509.87839-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020171509.87839-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/20/23 10:15, Philippe Mathieu-Daudé wrote:
> In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
> we neglected to give a change to the caller to handle failed
> device creation cleanly. Respect the caller API contract and
> propagate the error if creating the PC_SPEAKER device ever
> failed. This avoid yet another bad API use to be taken as
> example and copy / pasted all over the code base.
> 
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/isa/i82378.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

