Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE9716236
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zXT-0000Tp-Fp; Tue, 30 May 2023 09:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zX1-0000Pe-P0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:36:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3zWx-0005EC-9e
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:36:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-64d3fdcadb8so3261245b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453813; x=1688045813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t8jPazNSpfPhSeygzEZBU9QjUCGFxMyyB9Z7CGy/SKY=;
 b=LJKpwMeMTjsXFAWLUNb7erwVmNmNj6se+h5cZMvJf8x7jorjODtMgyJ4NQxntT07j7
 vscSpmZpRhtI/DEv56iwU5KPqbBKtiK/Vn6Tn4t3dAvpCyQGQWj+LSDNgxXe1+uvr84W
 YsEeMyeLhElINy/+yCP95lWe0dQO+xtlfl/76PAH/5yDlry40O8dyGonKtIGhiVBDWSk
 Efr63QMrvGPF2Ttp3qiXoQi+aDbvlM3N2Zw5QlV2N5JVGJRbAU2FJ/taVsrNjjuYUusX
 mHHtISW7OoNPLuJlif9ckZyjH/2rO58x08Z6EwC0ocd1ID8kxbKLKDPAU2xp08vY442o
 m1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453813; x=1688045813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8jPazNSpfPhSeygzEZBU9QjUCGFxMyyB9Z7CGy/SKY=;
 b=KnjKCrqqU3C+cQZ5YQ3uuAusVOt1XDV6k8mgqzouFuaOPEeWHrssfRao7RIkgjR6QU
 EWp0DG3iiQJG44Qegz/v6+KpU/TQf6Binwyff4PyMGDx1km0vB861Gs0oK1bZFLLWa3G
 BlEXQCM+wDYAwihH8PT3gpcuywQv3lIlOUEpFnrXzHu6VmtlHci0eruIEajxvP8CR8aK
 CgSkmARONewIl1CLH1uYE+KqbCTfSGzYS02UbG5LNOHl5aGz6I0MUDu/1U1snBYHpjHa
 lAbySjO9yLXbRo3n46QsNT8xwKq9mOvJi4QjzsBPXZP1FuTwTPJLxD93XRJuzSs5+ZGK
 A0Vw==
X-Gm-Message-State: AC+VfDwFRKaq0jVb+GQJjZJjno9QPedgK1D0x5RgfmQbZbshqo+ceehW
 hAdZK9IECM/VeCKN4Kvadr0p6w==
X-Google-Smtp-Source: ACHHUZ6RmAv+vK3L8L869XCZqjFutNvMNB5WaxtjIKBSGYgxQIDmoDpJoZtEukTwvMnsXzVFkOuN8A==
X-Received: by 2002:a05:6a20:8f09:b0:10c:2fce:96cc with SMTP id
 b9-20020a056a208f0900b0010c2fce96ccmr3038668pzk.34.1685453812992; 
 Tue, 30 May 2023 06:36:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:35a2:c45d:7485:f488?
 ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 d4-20020aa78144000000b0064d7221529asm1660079pfn.32.2023.05.30.06.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:36:52 -0700 (PDT)
Message-ID: <62d1edd5-b32e-f772-3fdc-3d6ea1712088@linaro.org>
Date: Tue, 30 May 2023 06:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/ppc/Kconfig: MAC_NEWWORLD should always select
 USB_OHCI_PCI
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230530102041.55527-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530102041.55527-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/30/23 03:20, Thomas Huth wrote:
> The PowerMacs have an OHCI controller soldered on the motherboard,
> so this should always be enabled for the "mac99" machine.
> This fixes the problem that QEMU aborts when the user tries to run
> the "mac99" machine with a build that has been compiled with the
> "--without-default-devices" configure switch.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

