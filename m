Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB067F68A2
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 22:20:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6H6F-0003Um-2l; Thu, 23 Nov 2023 16:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6H6D-0003UV-Ni
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 16:19:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6H6C-0000UV-5J
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 16:19:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3316c6e299eso835355f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700774338; x=1701379138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TYXoB9fY4MDS1wUyNZGAd1u3vJHXhGaYlJsjVm+/iuY=;
 b=QEvdpgN0Zck+i6bxWaiqMrszVpQRk8iQZn/TvbilV6w5ZWMQ8orIAW2m1yUHLi2p1L
 OnacowM0daQ3UAb9oBQg/oeEihpizti3lqIivveUZfrag4Z5RoF3mkgbO0yNjwJjs6Iu
 Krlxh0wTObCXiPPDKB3Y3F+NaLITW9q3x4BUNoGFBZZKxMR3D9E9IX8UgDC0giOys8sx
 g9cOd92KHrXe/OIDcgkWxq1DrzjzEQ5mEOL2Ajn38DPjjE7vGnCsAeEWHtdDPKndlmAq
 vL+ST4VKeOjzjQn/dHcg+YzbJn3XvmCVR1cu0A5lz7MVxWpn0FxU6Ld+C1Ur3XyjeHJg
 yIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700774338; x=1701379138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TYXoB9fY4MDS1wUyNZGAd1u3vJHXhGaYlJsjVm+/iuY=;
 b=wSdyK+1OJI8akZ1shV3V99BsFtjb5u9x3x+6H1Z991koLTAY98du2e2i9uRuUFlEb3
 E0jEcdsc+Y6iyfr/EcXQuwgvN8TcHhoA+jEi4t7EVIZ393ZqOzpMyVRUBv2nhxkj26DD
 bLICc1eoj3sxLYTD4QarYPnhfqpwo87/qrndHSAwKr/F4p8NMbNCyer13JVOOI/jVihR
 ky00iibm6pSQpKGFQySwab6SOlvYGL6hzLFZMwXLxTIYtfW1pulV/BZSRyD5P5A42hvP
 L/FXrqp3ihcw6UEXdJhoCvWtwX7xr7VAQz7zDrkI6ogHmuFSuqE0CTapER2IfPXzU7zm
 paNw==
X-Gm-Message-State: AOJu0YxkhnlurXtjJGSJ+/lFKBcgyjEuY04rekS3uzvCkTWR70y1dSAf
 ziXj22liE5teaUfaC53+W3FkIg==
X-Google-Smtp-Source: AGHT+IELu6SHUmAmDuxxk49C46ugXKzhO3k/XHY7Csl2BFIJ4fvBoW5EftL0uSAbouv4fNRByXYcIg==
X-Received: by 2002:adf:f14d:0:b0:332:d2f0:1bb7 with SMTP id
 y13-20020adff14d000000b00332d2f01bb7mr515964wro.59.1700774338037; 
 Thu, 23 Nov 2023 13:18:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d4e82000000b0032d893d8dc8sm2646707wru.2.2023.11.23.13.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 13:18:57 -0800 (PST)
Message-ID: <d8a6abb4-8662-4342-a60f-4b512f1a48c4@linaro.org>
Date: Thu, 23 Nov 2023 22:18:55 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 23/11/23 22:15, Samuel Tardieu wrote:
> This file is the only one involved in the compilation process which
> still uses the /bin/bash path.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   target/hexagon/idef-parser/prepare | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



