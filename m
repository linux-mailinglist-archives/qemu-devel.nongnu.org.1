Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FD77BA722
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:52:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRZH-0004ui-RE; Thu, 05 Oct 2023 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRZF-0004uP-2d
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:51:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRZC-0005qj-RE
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:51:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405524e6768so11596505e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696524673; x=1697129473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcgahbHnE17dggUchb/4jjo8tpNfa2exTLqgiB72y50=;
 b=aiXZmtojQ+DXOLc6yCO3lyDIx+rvO1XOiDw6viGbkOoUZdxJvlw9xVfqsczbdcoFdT
 wpFgQAQ9KdLl6WLkYE44qLvg+ys4sQ24aG1aKR/An7bHorAV94yLOZAiUuFIkm4WCEAF
 AuK5OS71z08OEYEE3MRKviqI6vET2e9lwJqIO8bdmQ75gBCrQB0ECYqh+hTIxoXLWJLa
 BYX75xOwXNShgNFukvPyVwP0jPI2B0vD9mMh/5M2O9I/MXu/8YP2w67okUmDyfxU5Rjh
 uC9tSnmoCd3F6F/p/jtOZgtCeFdDOSBQEuqRO2wFHIepnhyH/2FPiomc1gIa/F0p3CP0
 dI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696524673; x=1697129473;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JcgahbHnE17dggUchb/4jjo8tpNfa2exTLqgiB72y50=;
 b=HXpIa5YLAkkqM2HFXp5oak90QXRQTuSgOckOHOb0cb/+WiOQqLeGHXxUjNF6RccCO2
 yWZaQEiD8qP+z0+010ZaQ3+Z6SpBqWv6/8K2YEg/qiY9d3dHm/x7NkbJbiHIFpwJj5hj
 g7s/BgOnjEzJCKxwMHrzg5y0s23JzSplBBRJjfDMQZSdT5wDNOjVdsl1lGekOXTZbWQe
 aWKCJkKK5VPPHWOD1b7QsRpP+8JBG0gI0tHK28MJ98IxgjIl2teldANAZqhXaCmy762c
 jCpwUO0q8I7x2INwRgfmz6dcEhposk21Hr72cEVAH1VLgwxasWd/RytaKLi/Ipn+O8Rp
 kqTw==
X-Gm-Message-State: AOJu0YzqYleAX+95U+bAlPXTvTwlKeWpQRvNjUZvRcXlajEonTIHLvRz
 zFoy3C1kkBBN649uPP5hM2XLUl0hxFbIlGmy7lU=
X-Google-Smtp-Source: AGHT+IGpoUyPH9mZUYNQeE2JxsIUTTAnACQRfJ7/05b8QNKCKnaEEN61kWLJZzPsyvcSh939KK5/BA==
X-Received: by 2002:adf:fc4c:0:b0:319:785a:fce0 with SMTP id
 e12-20020adffc4c000000b00319785afce0mr5756838wrs.26.1696524672965; 
 Thu, 05 Oct 2023 09:51:12 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm4148884wmi.27.2023.10.05.09.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:51:12 -0700 (PDT)
Message-ID: <b2c04084-5209-8afb-6efa-8d0ad889fd14@linaro.org>
Date: Thu, 5 Oct 2023 18:51:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/10] tcg/i386: Use tcg_use_softmmu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
 <20231003174356.1602279-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003174356.1602279-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 3/10/23 19:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 184 ++++++++++++++++++--------------------
>   1 file changed, 89 insertions(+), 95 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


