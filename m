Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A4E7E207F
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:54:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyBl-00031O-7g; Mon, 06 Nov 2023 06:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyBi-0002mV-Vn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:54:39 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyBh-0006u2-Fp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:54:38 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso60155111fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271675; x=1699876475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UpeLeoVrUpGe7PzmhvxWoXoE6AOR7c4RgF4TyIgOELg=;
 b=o/gKbZRpfvIub4OZzymwzkcN200pMAFZqIa/cMv2XSMobQ+TErhjZUrBFieZnFV9dF
 M6DrbsiRb1diY9xPDGfm/1X2EOURXCziZRB8x4hUNYo3bV1G7D8emUBiRjX9sLuHQu0W
 cl2jynZ3cXvuFPZfLjwv6R3GldSlj5//qDDXsEcHdy7uYc4BInQOulWSGilvdUYwr22i
 n2xQFD32NFpe+DtAobqZA8si6LQFV37yFWVouBr+JKRqhcnyjJDsoPMg6mcZ7iBbTFie
 7nBWVOI6Whkdq4pNnALFv5TBzImGOSU+qfarJP08ipx6T/59NQqq1zOFgcmCJCTypJ/f
 60Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271675; x=1699876475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UpeLeoVrUpGe7PzmhvxWoXoE6AOR7c4RgF4TyIgOELg=;
 b=nH/yVg86hdnPyhf9vKaX/Kuk7poKa8fbKwW20sHg+qyJ3YW8UN7XKclGOZdbswCsaN
 c4SGPsJ6vrxAKmN2FArMBEuQlm/F6R8D6+oilGupADwx+f5sASPgqj9KpcGdbCdUkUNk
 Lamoqrlcad7bm1vFdunUden6JNLDQBfpTEJ8YlK8trsF/Rkob99uqJH3yCgYrppOqIKF
 vcCvzqkVrMRi3dXtkieHmaJDbBQUq0hy7mrIDYruklHss2fAQBrwrWn0nBvxN8eLaBBI
 jPlHHBqI7GbkDq0MsKixMpXKcpu9dT2Pj3GHWqxL4ZPJhKQ0qeBatcM2RqGrsFqXaHAy
 lH0A==
X-Gm-Message-State: AOJu0YxBdLINssJu8nDJ88zigLIFPvCav82fqOh6DVeotH0MqfXFlWPm
 jtRxmsX/nl3aWTfNK/04Z2Eoog==
X-Google-Smtp-Source: AGHT+IFt2fzJYrYptOuIiqEdi5WDfHcBkuIV90HEMR8jH+BW0Tavpk0mXBG57C78vFbn8N+aIwMg5w==
X-Received: by 2002:a2e:9f13:0:b0:2c6:ed5e:bbf0 with SMTP id
 u19-20020a2e9f13000000b002c6ed5ebbf0mr9862972ljk.34.1699271675622; 
 Mon, 06 Nov 2023 03:54:35 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 er14-20020a05600c84ce00b0040472ad9a3dsm11671950wmb.14.2023.11.06.03.54.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:54:35 -0800 (PST)
Message-ID: <6d75a0be-6700-bc1b-9120-3b8948f84270@linaro.org>
Date: Mon, 6 Nov 2023 12:54:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 02/71] target/arm: Constify VMState in machine.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/machine.c | 54 ++++++++++++++++++++++----------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


