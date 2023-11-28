Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265187FBB10
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:15:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7xvS-0002uF-Nl; Tue, 28 Nov 2023 08:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xvQ-0002tv-LC
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:14:52 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7xvP-0002v3-8j
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:14:52 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a02c48a0420so752673566b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701177289; x=1701782089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6in//SQBjP9VE9IpQ2Qfw/3JXEDnJcufiZRfIQ08CVk=;
 b=XwSl73UtXVlm3C/lV0n/0ffb8CRmNtwMGU8hiVsSGllBcc5Y2WpI4qazvOIkgMMENs
 6coCYBSRSSZmKxyQdk479NUt8+a6tO0MtJMN4MJ2En+h9Fe/io7cE+ieZP6tZS77ZIAa
 IqOqNFzv4KWZrMYf8w6FJ25fO2JB0HGDsqO3Q+P7Zd3mrT7cSUSrfNLDn0Vs0d2cVAlk
 SntEEScHVwY68MAUO5nJU/vfkYB+fQuW1vleELxXTZpsZItCruOVtkI5m9vT4TGIkgKm
 iDRXMA+elCgkuOPYSZpGYdKgCST/DaBFrCHj3EyyUd9LRrLCD/gblb4EtMVNUX1ZFJ7q
 5rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701177289; x=1701782089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6in//SQBjP9VE9IpQ2Qfw/3JXEDnJcufiZRfIQ08CVk=;
 b=MX5/QQbn6GdjTYjYV6eJujq7eWU6ZG1aJlu24fTC6dnBJ4zw0Aes3f8p6OedmWOaYb
 3VMMjU7vSRKRmdOZQkTFyO0vQ7mORdRZVo9Ajfn1k1u1javLoUB6HeFKue2R9vWjlY0D
 tLLh3jhcXb1vOaWnPgidvCOIjuC1rHg96GmDy0BePBE38o21vzFQBBR3PbLK0EJrUAE9
 1ojGQU8znNmZ1IkVwLy0Lm/6cT30LNBTf8itcS/e8HW4f6m5WoYTNDdi/T8PfJ+grIHR
 hYWBJOKOGfSwAnDz19gojirie91NTvVVSYIR0DuM41Xl0eOrWIWBkrtQq3bn4lBsPTTX
 W1OA==
X-Gm-Message-State: AOJu0YzP0Tyh+brk7Jm+VctYbSGg+YOfZZwHvMMLYKacSaDVKwK1UsiX
 Xt8eXBDiXRy6zQc0lnO1HtIyH0qtTzQuAbiGAso=
X-Google-Smtp-Source: AGHT+IHKkipjK3+WzXuiwPpkdrqvZ/wX6wLOBB6CQMVuNQj7aoYAcm/7pnvOYfqf1Ypz4FN5L+875w==
X-Received: by 2002:a17:906:1358:b0:a00:7d00:66d7 with SMTP id
 x24-20020a170906135800b00a007d0066d7mr10584143ejb.18.1701177289662; 
 Tue, 28 Nov 2023 05:14:49 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 j20-20020a1709064b5400b00a11e9036cffsm1202811ejv.195.2023.11.28.05.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:14:49 -0800 (PST)
Message-ID: <759b274c-bb58-4b3c-a504-9769e799e6e8@linaro.org>
Date: Tue, 28 Nov 2023 14:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon/idef-parser/prepare: use env to invoke bash
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>
References: <20231123211506.636533-1-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123211506.636533-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 22:15, Samuel Tardieu wrote:
> This file is the only one involved in the compilation process which
> still uses the /bin/bash path.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   target/hexagon/idef-parser/prepare | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks!

Phil.


