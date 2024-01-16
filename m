Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCECA82FB8D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 22:58:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPrR0-0001gx-Av; Tue, 16 Jan 2024 16:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrQy-0001gp-E8
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:57:24 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPrQw-00016h-TC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 16:57:24 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a29058bb2ceso1101586466b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705442241; x=1706047041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HVPPAYHCIENuL1YBoYMaIbqkd3lI7P/8ky/zZJ44dhY=;
 b=uhSu5HIG9napjxFxHpQR0KlwWNTY9rFEdG6sNGAVoa2KQeFtwHIsWNLy2WPZPGHBB9
 cy0+RPDVW7ys2I8naAahqyE+o5F54l62uuEbDZqvx38XwChqpO9y6QkdIF2vsUFwNZoa
 U3gqv7eNF8YZ14nJYbZKAoKhk9sMP/ZX8CiBEpZIK0ylSWnaTT/exIVKKcZU+YFSwv5q
 4+10lP7NQE4UN4toSekoCOPz6aeXbwcPvJgICk91ckQqxRBV4kNpBaNS9xVVUKM3b/eR
 iNpbXAoxdDc1SW7sfkcN/81AkFOGP0MwT/w+UAt4epWE8lf4LyXJbiZ4BHS0er9ZDxmK
 YH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705442241; x=1706047041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVPPAYHCIENuL1YBoYMaIbqkd3lI7P/8ky/zZJ44dhY=;
 b=IMAJIeNBgmp4ABGXwNESwYGqLkktW4+QVaED7feznz/yb1WTmuLaDsViCF0cZuAtoQ
 JuavQ8D6p5zijZB4X0IgI+tw6le/TMMzAaV9DsVfTOiwxrna37wX3yIBepn6+MKAhtyu
 6MCsAVtgeLUUgtNlUQou1Ih8ceM6BFF5lPvpQrJo9zzgwTc2UNG8WbONquZtWCjT6F8d
 71juvlDhgFGt9AeNBGIWalxdhzIbTnzci/j9DEjSXh/Jaj+1t3qNbKa6yhXy4/JhvJnS
 3+5aLoqEmOZ5e1JcUcKMvkV58rwWPV9dOkkilMgLMUI1w3jYZoGYn1pL5CehFipnOema
 +98w==
X-Gm-Message-State: AOJu0YyIHMSJESptbtM5IvdtKttX7nlkX0kwSlznv63VmiAW+RT5De8v
 hUkg9GTjRPCeLmxDEdXyJPOGJg4VIvH3aR9tKkGmmxZVAZI=
X-Google-Smtp-Source: AGHT+IHkL3Voak8rIeciYt8hbO9xKA2Diyx83lNUBrQMPzIcNR+t+h9RoxOjl1aFO6/6NadwXS7tfQ==
X-Received: by 2002:a17:907:c5c7:b0:a2d:3d9e:d838 with SMTP id
 ts7-20020a170907c5c700b00a2d3d9ed838mr2268226ejc.205.1705442240943; 
 Tue, 16 Jan 2024 13:57:20 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm6937206eja.24.2024.01.16.13.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jan 2024 13:57:20 -0800 (PST)
Message-ID: <928f3a01-071f-43fc-a0d2-c5d787e07aaa@linaro.org>
Date: Tue, 16 Jan 2024 22:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 36/38] tcg/s390x: Add TCG_CT_CONST_CMP
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-37-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 10/1/24 23:44, Richard Henderson wrote:
> Better constraint for tcg_out_cmp, based on the comparison.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h |  6 +--
>   tcg/s390x/tcg-target-con-str.h |  1 +
>   tcg/s390x/tcg-target.c.inc     | 72 +++++++++++++++++++++++++---------
>   3 files changed, 58 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


