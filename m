Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3D70312F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZre-0002io-T3; Mon, 15 May 2023 11:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pyZrc-0002iT-QU
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:11:52 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pyZra-0006li-Qh
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:11:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3062b101ae1so8423361f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684163509; x=1686755509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wldi7SZBf0ZVtxp2Y7J/5g3LhFRoQE7xPIC3ZwsnZBA=;
 b=QL/EzOwngUQ3w3/kY0LPuuHUxVm04b04IA3Vqsgi1Fl6MHyFscBasKVDCiZEPxw99e
 sXTo4tearh0hxCDo3jpbPt01EI8O8uFoNT4fJbXHsBQf+iWAGQT5KYvJ143+RoPs7YdI
 MaK0IvFRGztEGBgL84rdca3Rt70Pn1gtnbmdmm5IkJ2LWW8lFZZqoB4YEeiR+EcSBALg
 JddIaAGaZT0HVH6YgvkNsfL3g9D7pUNxYaaVBx+u7qpPQ/RAEV3QO/yh+U6SaTIorCJG
 SugpXAxpehx6THQ/aLhh8sgirMtKXRl69ocj3FjwcMdsjqYVfCAedIqcsVsy4UxcNCam
 XiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684163509; x=1686755509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wldi7SZBf0ZVtxp2Y7J/5g3LhFRoQE7xPIC3ZwsnZBA=;
 b=aLjRCYDCYs2nw/aWjud4haB9WmQf+fEDSJVCiYJ3HC6x0D2WvVKgvz3k6+ls3GrJkM
 4IhdfWNfDUYEcZusLFoM0v9Jz4P+x000+THc8K4ePgPDelbquhpsrZT2jHfyU+eDo954
 T8StI474jHVASGE1XazunQNKldeQymhkUT5VInE6gqsxf7qXnZiQohssjT0PLoe7XMCf
 X3Np6d2gNnNCEJYrGOUYIL/50cff3uFOl8l0rOcWHrCa+31+TigxeQ2pnrBGIuVH58lU
 h14ZqPEb4wvfZ4xXn/jcsTlxXCkfGO6UrpmXTG36BBbDTImfJrs/N+AnF3neeGM3QagX
 y1UQ==
X-Gm-Message-State: AC+VfDzkN7fJdbhINmnLoTFRFf3xn0hoUeB+BAfKUy52mMcQOLlnDTok
 d7M3a+ktVMEIsFpPJJDjGq/HCg==
X-Google-Smtp-Source: ACHHUZ55UR8NWh8ySDiClBucg2yohP0sTWjC0+nwVYjNHhvRvCz2w0rQPDMC6B6SUYQOdbCM+/NgaQ==
X-Received: by 2002:adf:ea85:0:b0:307:834f:7159 with SMTP id
 s5-20020adfea85000000b00307834f7159mr25273036wrm.4.1684163509207; 
 Mon, 15 May 2023 08:11:49 -0700 (PDT)
Received: from [192.168.30.216] ([81.0.6.76]) by smtp.gmail.com with ESMTPSA id
 h4-20020adff4c4000000b003078bb639bdsm34225wrp.68.2023.05.15.08.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 08:11:48 -0700 (PDT)
Message-ID: <38957cc8-4f57-167b-2ad3-35a7dc0af0f0@linaro.org>
Date: Mon, 15 May 2023 17:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] Maintainers: add myself as reviewer for sbsa-ref
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230515143753.365591-1-marcin.juszkiewicz@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230515143753.365591-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 15/5/23 16:37, Marcin Juszkiewicz wrote:
> At Linaro I work on sbsa-ref, know direction it goes.
> 
> May not get code details each time.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



