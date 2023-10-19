Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E967CF438
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPXo-0003XL-Uy; Thu, 19 Oct 2023 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPXl-0003JM-A4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:42:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtPXf-0008Gs-4Q
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:42:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so17321915e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697708529; x=1698313329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bv96NAByx13vsgalOF5LGzpaTwsZOld5KEIy032w7f0=;
 b=CUc9G7BqQOjQSuVT6qkOvkG0w759keudI5vxidzk97ZofcBapbpp8WsebfnGl5pphA
 REs1+ZI7lcEZ8hZTxuXyvgcob0Ed5wYhRAQP9SrE3LthX/dekEzgt9Mdv6JS5PMqArX0
 FLDnI8+xW7tffeXAAWHSLrKSSWj2LJm2/q2uCvFgiphl0SJfl3ZPi8BTG6zKck9IlFOQ
 B07QIrA7sPNdqgAce6/dkCTU28Bjp4EydUnClSghs/pDOScSh7CnDIha7NlKaJOM4uZP
 gNUsnOwa4mBxkvon/AFW/VoFPwUoihui1AJpnwaOrx4kOrq3a3VbChKwhtBugi6oQ2qi
 RTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697708529; x=1698313329;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bv96NAByx13vsgalOF5LGzpaTwsZOld5KEIy032w7f0=;
 b=DEEQV2KM86s7otCuj92CItqmQKga8hsWddr8f5Dw0nMQp6OmJPVeqXaSvvY3va7K5C
 qm+SATrOyHY73Crtdm9Pp0Y4lzcF9WMWij7oc9KkALzKWwhijXg36rKEmyw2Q6grACOx
 6LZPVng+ic/DK5lFqisnvt/MxYFsSModPzX98b53OJDybRai4FTSVhVNFTPiRXXTf2Y0
 3c0jp5TBPVkeGlS2BwiQIgCxRTbLsjwfUveC0apoCSB2Ei9G8dmn4mAdaYjw2T+uyEU7
 wb3PJSKzAIknKY2sds28Yq01XNGO0HQ1NwhCHyYStnP7N1nrEuDl3qQJT5l02mwGfovt
 up0A==
X-Gm-Message-State: AOJu0YzC7daWizz2PZUQ9eX9qrHtlWzBxQbDNEdxntfMENuGMM2hy+DI
 9haL0RGIwZ4VcAn67mzVhqQ5Mw==
X-Google-Smtp-Source: AGHT+IFWxTKFqjPV0ytQ9NWuhm7Yfj20ta7x2pCBO3Lg2+C0zgezI2pQRCy7cBMMHQtQhPCNhMqoSg==
X-Received: by 2002:a05:600c:4507:b0:3ff:233f:2cfb with SMTP id
 t7-20020a05600c450700b003ff233f2cfbmr1371783wmo.23.1697708529430; 
 Thu, 19 Oct 2023 02:42:09 -0700 (PDT)
Received: from [192.168.69.115] (176-131-216-177.abo.bbox.fr.
 [176.131.216.177]) by smtp.gmail.com with ESMTPSA id
 m11-20020a056000180b00b0032db8f7f378sm4065502wrh.71.2023.10.19.02.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 02:42:08 -0700 (PDT)
Message-ID: <5f40402e-8448-c7af-0f76-ff4c08d4affe@linaro.org>
Date: Thu, 19 Oct 2023 11:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 03/61] target/hppa: Remove get_temp_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
 <20231018215135.1561375-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018215135.1561375-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/10/23 23:50, Richard Henderson wrote:
> Replace with tcg_temp_new_tl without recording into ctx.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 28 +++-------------------------
>   1 file changed, 3 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


