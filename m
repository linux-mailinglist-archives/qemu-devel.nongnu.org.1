Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3A807606
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:04:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvHE-0001IH-EB; Wed, 06 Dec 2023 12:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAvGc-0001BB-8B
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:01:02 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAvGX-0007or-SO
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:00:57 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1d6f4a0958so212674366b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701882050; x=1702486850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BTHh52QdsbCe6+Hc8YTlK5Ej/ocYjwvShZ16XOGvSag=;
 b=wgGvkQIaRJTB1FSpjmZZ4G1VOibtF+RQuBY4wYDB6laNb9gvIayXGKUsuNzh7lBCl3
 HvK1jEHrGwO8mBH1VcQk4CUg3/Bwzn8OfuViity5xN6lWq3btGp5IDKDNZaZJ/W6Lxrh
 fRxBYQY35vTETU0WgnPEYOAvI9DOQfTBYmF7BHWZ1+q708SY1SgooizkckbMjxTaXuXY
 rlUszBLhVLrpbotxOz3d4qkm2/2pOEUzB3GXepRgmyYvrlSlqtr8SC1kjjVl+NaL/eoO
 +NHCRa2IGH3UgEYsO+QxqSbIfFtUG573jWYm/Y+YZZLDg+5mle+b5yfZAKnpcFuoKdEU
 3iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701882050; x=1702486850;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTHh52QdsbCe6+Hc8YTlK5Ej/ocYjwvShZ16XOGvSag=;
 b=ocGgVYCFCpDRI24fmEL1K/UpZLpLN/BeDrUPs4jPcCy9PhTuMjvaiUMGnH2WAysV6G
 KfM6DeavWekC9GnXX2/WiWmnVYB1O0XogQC9y5VR+t7dPgq5/4IcPwT6UQcONpUJcHlX
 4XHdLOrnrtPu58dcQeB5Es54swSEjGnLuaeOz6791GhPgl9JZ6jZEMgEy+UcFZRbEbAG
 IdrRHJIk7jtbQb3qA08bK2qDRdyu+WaH5zY/rVGmC0IYVWl+jX66rqts6r/6OyI/Oz+Q
 0ZF/cOj8q7PijXD/AzWltV6sL35N2s5U+O+6odvV4eZDwLQvNXKZlvqf/FdqfaATy0k6
 RUXA==
X-Gm-Message-State: AOJu0Yz2Dfm4wCu/S76gxP7noWE8BZQxwTAwUnO5EE6Gxj7u7JQnYlDx
 91mDhNNCFad1702uzznf7agHnQ==
X-Google-Smtp-Source: AGHT+IEqY3DZujTzPxzKSmeTrgBaehAcnMsi9TksHVYj0KTofNRB08ZB7flbBBEH5PFgzliUCl+Gfg==
X-Received: by 2002:a17:906:5342:b0:a1d:b773:ae8b with SMTP id
 j2-20020a170906534200b00a1db773ae8bmr1255872ejo.17.1701882049946; 
 Wed, 06 Dec 2023 09:00:49 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 l22-20020a170906645600b00982a92a849asm174101ejn.91.2023.12.06.09.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 09:00:49 -0800 (PST)
Message-ID: <f73fe5a4-dedc-4013-9b22-7bf25cdd37f1@linaro.org>
Date: Wed, 6 Dec 2023 18:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: sort C warning flags alphabetically
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231206164443.1058339-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231206164443.1058339-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/12/23 17:44, Daniel P. Berrangé wrote:
> When scanning the list of warning flags to see if one is present, it is
> helpful if they are in alphabetical order. It is further helpful to
> separate out the 'no-' prefixed warnings.

I was sure this was already done eh...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> The diff looks horrendous, so look at the resulting meson.build to see
> the benefit.
> 
>   meson.build | 40 +++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)

