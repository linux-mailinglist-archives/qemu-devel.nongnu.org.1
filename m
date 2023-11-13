Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 910957E9F2A
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:50:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2YGa-0004Ws-6w; Mon, 13 Nov 2023 09:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YGN-0004L2-Hz
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:50:09 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YGM-0004uE-0h
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:50:07 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so9173394a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 06:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699887004; x=1700491804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MIpRLQlxm/uqf99/fywpBLf4yCHs57hMrv/bnK5LrT8=;
 b=fEyK8w/XA5D710w6R2MiSuwxWxuwDNDyCc2OHfubLjA8oxR1H7CdfousQAocbTxkGg
 sO4Nr8O+Z2bN7zRWnFea+w/oMRiMPak/dKxx6OhCDFK/WxJUJBg/gCy1gmGMMFunTae4
 xVw/7mBbIXaAruDxkHE5sBgG4cf2u4F2h0Ta+1gBbAZhJ6U0hkwBZLTQ+xGv0kPe2xqq
 SYZ7ceN9QLS9UfOELLgWRH4EcGASuQupBktC9R4BMN8mH3PRrTAnnyXaWlaM0Y4Ai7nr
 aWbj7jVjuM9p+sMFADQDeah2cODnyJIIUx1od6qkGwCeIRLtNGUj3KHt6O/QUHZ1z1Pk
 Ow/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699887004; x=1700491804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MIpRLQlxm/uqf99/fywpBLf4yCHs57hMrv/bnK5LrT8=;
 b=orOidwmrsMsyO8EbkCi6o/w6gz1sbYF50V4rg31RUZrhslgAgmfOIM7/nw9kVycKzJ
 QxhKs2wRoN3q/VtwUco1MUr1RgXSD7mCdeqbkXAz7uwdOAbTacT8Dnvc5D4M94J2zcfG
 IL1yXp2F/+RmfeINBO7GSasPqroyg6MSv0mEAzmZsfKDH0rAuiiqbj4H97zYkY1mIyDf
 Vsnt51Nwx81+GeSBRxwmHXfndQveX8o3yC9luU+q7OHcOPEaNruneOXiEbeC271ZRMyq
 W7Bk9J4FTBF7cHvBzhwd7S7+2cVspOx9zNnkEoDEtSPgTlE+gXXpuYVYrW/JWlcLug7j
 DwYg==
X-Gm-Message-State: AOJu0Yw4NAy867RXnMBqjHpVzWoiI3nGIeJR3eOIoY8Znd4T/W3TgyIW
 /vy4xvjuKqLc3vs3lM5wZIc6eA==
X-Google-Smtp-Source: AGHT+IGyUj8eQk9LPmMWw5U8Cw/8jlSy8cyKvGBXMMdaGbuodVQIVl4OL167oIKIPF6J7mvpBZMAZw==
X-Received: by 2002:a05:6402:3514:b0:545:52ff:edef with SMTP id
 b20-20020a056402351400b0054552ffedefmr8609252edd.20.1699887004339; 
 Mon, 13 Nov 2023 06:50:04 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 b30-20020a509f21000000b0053d9f427a6bsm3928836edf.71.2023.11.13.06.50.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 06:50:03 -0800 (PST)
Message-ID: <2782df43-d74d-4cf5-af70-cf05dac6e733@linaro.org>
Date: Mon, 13 Nov 2023 15:50:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs/system/arm: Fix for rename of type
 "xlnx.bbram-ctrl"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair@alistair23.me, edgar.iglesias@gmail.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com, qemu-arm@nongnu.org
References: <20231113134344.1195478-1-armbru@redhat.com>
 <20231113134344.1195478-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113134344.1195478-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 13/11/23 14:43, Markus Armbruster wrote:
> Fixes: b65b4b7ae3c8 (xlnx-bbram: hw/nvram: Use dot in device type name)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/system/arm/xlnx-versal-virt.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



