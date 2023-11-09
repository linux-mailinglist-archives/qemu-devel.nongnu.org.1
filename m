Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9272F7E69A9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 12:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13Ea-0007BF-UW; Thu, 09 Nov 2023 06:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r13EZ-0007Aw-Em
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 06:30:03 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r13EX-0003OK-On
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 06:30:03 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so123851166b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699529399; x=1700134199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c8TcyBbp+Yviab9Y8RcMNHbDHJfw9cI7XiRM6Soj/Kg=;
 b=yQnDoppzEypDVUNpdTZOpq5oKwboxd1ekqeUy2f3joMBsABG0e5aA6eOpAOaHlZv27
 QoAdHi7b9A+1atfTAdc2fOvw6By87QXWLR4x7KXcm3BHNUfZQUtrHfkRr9FREf7mLRCY
 ZHyqR2Usl/agxuXWoczJyKApn4iv070agIDy5jg4OL5NPFPoAn1g02j0Ug7znDIY9Usm
 33ij+0Nxaokennj9OiL9uWyfgtsL3xiw6BHdV2CevufpHDnpitBnu7oa8/97A9FUqRNO
 sb8zcIncPlJgiIo7KjEbDfVRNJp+V+zNHG+dVZ0gWcNRkd7A1LWbwsXQayP2LmDPJ14m
 5QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699529399; x=1700134199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8TcyBbp+Yviab9Y8RcMNHbDHJfw9cI7XiRM6Soj/Kg=;
 b=TmiLgRazLFdt+oDb/ctbrrBCtZjg7RON6jAz3t8OC7e4ovc6XbESXwFeqkj2GjwSc0
 6sQzY55oxKUX4YZIDRkEPRgpg8GC0bvfR1CqTTVNOV8zDEd2IkCxti4YyPT8lRXPgei0
 d2kRv2WY1V7rKeslAn2B/8Yo7mSWm7PUbRmJpO3lS8+VRsA1MVX2yQe53bGmd/kjER+o
 7ULMtU8ZO60upGvpn37JiHKOYa5JUSKj8K4GoNB/qPvQSw08zU/2xSOtT2qiVFTsSaqf
 FS5GlD5aRRMHE5ID6u0MEHcfpFFX36USmDup7oIrjB2rYoUeapvCN07gjG79p0T3MohD
 q8Zw==
X-Gm-Message-State: AOJu0Yxt4PTBt+1L6hhcJGJgaPhEYNuJ4/zdVWTYMxkkFx0bc+Hs60rO
 XnYf+UFdoASCeDvPySLteYvUng==
X-Google-Smtp-Source: AGHT+IHPwIun80/qgbY4UnbT9AQApyMRn4QDe+aKbRmO5gbuEwI/2e0EaDkpAKWDd4fQqV0+KYFOjQ==
X-Received: by 2002:a17:906:ee81:b0:9dc:21c7:9ae5 with SMTP id
 wt1-20020a170906ee8100b009dc21c79ae5mr3885325ejb.26.1699529399138; 
 Thu, 09 Nov 2023 03:29:59 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 ha14-20020a170906a88e00b009ddb919e0aasm2418310ejb.138.2023.11.09.03.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 03:29:58 -0800 (PST)
Message-ID: <637d2ed0-035c-42ce-9e73-4d2fbe07da46@linaro.org>
Date: Thu, 9 Nov 2023 12:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/35] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 28/10/23 21:45, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


