Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092FE7CD7DF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2mb-0005nX-4b; Wed, 18 Oct 2023 05:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt2mT-0005mx-FN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:23:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt2mS-0007sL-0o
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:23:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53da72739c3so10944344a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697621033; x=1698225833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ir4Oi4tJmqD6fb/jTTWI/cvH3QiKo4l3/ltMHsKg+ZY=;
 b=ynXjKCQOCzzq62wRzOHslRIBYPt9MMlTgSZ7/H3mHABsuPXLtfFOOX2+r9QQp8Fqv1
 KOIx8z5SvNmxyh25BLgfgxD6BzB4Vjcl1VC/05j25t3yRzWjlAhRh+CP9ULmR/WSypsp
 me+iyJQ1lSPDDdf6ID+pFS8j+eUhP24kId4JmYNUrcESgYLiEqnMdVhS0nO/PkHZaEP+
 thdE/qAba/+f5WiWZLmMzQbYBx3VDehzgmQAZVMgvDgyYZzF8SfYBo0pT3rsXJPKYbAM
 bgccHfl+CaPZkMCCmrL0IuQNo0pgdf/dJU1FuJ/+/NqUjnFqmctuIcXPlJPLdhtKYzt8
 oz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697621033; x=1698225833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ir4Oi4tJmqD6fb/jTTWI/cvH3QiKo4l3/ltMHsKg+ZY=;
 b=BoyKdZ59W8+EgvK3w1RV8bG3J3g2HAERYRckY89IA7/UcUEJFbF3o2pZilLIxUQGNc
 MTMSOkjOrJKzVBkAVf+QcbrKztPyr/k7MVUplluy9FjBJQV1hbOVoO3qcwYNJYuoPJdM
 k1HBMyzIPUf+Odqqnc2aOvyTnBjzHyCj3Cz14NsDstlO8BTedkwQ854tn+dZ2aw5w6va
 69lAAkY+B6aAo3Le6q3wtSOdC7hWne4qsgb2Dxo5FAFB/lpITXXBmys1OPCYBXXNOBFs
 vKdI/zlNdZmJf9hFEx6kDhFU9oc/DAZeP7ZMYO9LXw2U2rcxWKxJY2jxd1rJr0Ntz55h
 7sSQ==
X-Gm-Message-State: AOJu0Yyk9o4+TDokqj4jToE0mPo9tZWNwiObzSesrQfZhnRqqdrgRDGY
 EksXxBGe48KgQtvOPVBcMP9cfw==
X-Google-Smtp-Source: AGHT+IFdtyhb2nxt/WyUa3LcEb9rhTPEgNxnUzKKrg2ctIrT2Erjn5eIC+B2gRn2FnirltbVjgbR0Q==
X-Received: by 2002:a05:6402:27ca:b0:53e:1825:d547 with SMTP id
 c10-20020a05640227ca00b0053e1825d547mr4065360ede.24.1697621033385; 
 Wed, 18 Oct 2023 02:23:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a50fa97000000b0053e5edeff3bsm2419154edr.93.2023.10.18.02.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 02:23:52 -0700 (PDT)
Message-ID: <404e3e4d-f478-bb50-300e-b41248a1d0cc@linaro.org>
Date: Wed, 18 Oct 2023 11:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 11/11] hw/net/cadence_gem: enforce 32 bits variable size
 for CRC
Content-Language: en-US
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-12-luc.michel@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017194422.4124691-12-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 21:44, Luc Michel wrote:
> The CRC was stored in an unsigned variable in gem_receive. Change it for
> a uint32_t to ensure we have the correct variable size here.
> 

Fixes: e9f186e514 ("cadence_gem: initial version of device model")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/net/cadence_gem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


