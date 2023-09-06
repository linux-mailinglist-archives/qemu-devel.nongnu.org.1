Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93780793EFE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtcH-0004Np-Ln; Wed, 06 Sep 2023 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtcF-0004Na-Ol
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:34:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdtcD-0005bp-Bc
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:34:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so3331128f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694010884; x=1694615684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UVZO3vG2bUWSFO0ghbnJsDGxNqi6l1DolSZpMQdtP/Y=;
 b=tw2Ykk94qN/UpoZkyaUyPSz6VZw5iSRhDNQN7XPJbK4iEPrqN4wzFi0554EqJlavXi
 ukOnPNWwwqlbLW+Qoe54ED6ukz4+2P1tX+DJcK4nO5pe0JOligfoLbaaEfKSerjSFTqJ
 HD8OrV3cMbKfu3kazQo3//Fym/O/3rmoQfMUTxNXncsySpkiP2/CqkJImAVTl48N8pRc
 H3kKH8xtB5R5NW9vcJOKEjrQxV8evWhZzfVeGbzXEVH07xrN/GEkRa5LK7cL7DKYYb2s
 KC9eTBtT5umf9/zD/mJiYpB/Vu94cK3IO6B5O+E8eTYeFRupjSPQihQ0FEiyAKaR8Evo
 bc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694010884; x=1694615684;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UVZO3vG2bUWSFO0ghbnJsDGxNqi6l1DolSZpMQdtP/Y=;
 b=b9uk+WC7AfZnwWecWl3p5xAugbdYmPSX3J6cSJKh8dubKunCTla/ip1mIC6H9PREDi
 ksFnoGopCUYfEXY/VClgW64dQCPa2Me7sfKCa4aimTw6IbYJv1HTHJWqVC4SQ7r5E9Zf
 1xiMcduAQK66qB2fq5Fg3GtSAJS7D7CY5tYIHgQgEJrYBH4gFTVMnmaNladDNTretaSu
 1lM9w5lrFyNLPgg8J93PE6yIw6b7v7jEdbPZ1O5gyo/8iTDYYAbnkDnSixtXl8df4sx0
 6stoEQh6lg3kwdIQvsDX2bP2FdKG628AKEBVj35GR07UcZpM4CjQyrB+rzfGNWnIhJWg
 ZFdw==
X-Gm-Message-State: AOJu0YxTC/9v9fDCBlbSTP1WqjF8Lup5y01n9UPPps8HHD5pVqFNG30Y
 IW/K6kVdTxZ/9XKQmf40tEFkNw==
X-Google-Smtp-Source: AGHT+IHRrtUE8O6JKLni/JgItbotoKoOrZUV8MW751izsnlGKEAwQD4IlovHSLMeaXDBfPVVSwrrDg==
X-Received: by 2002:adf:ee08:0:b0:317:5e73:7594 with SMTP id
 y8-20020adfee08000000b003175e737594mr2636800wrn.28.1694010883848; 
 Wed, 06 Sep 2023 07:34:43 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d4e8d000000b0031c6cc74882sm20670698wru.107.2023.09.06.07.34.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:34:43 -0700 (PDT)
Message-ID: <d924d8ab-7452-b3cc-1ee6-309ac915fd59@linaro.org>
Date: Wed, 6 Sep 2023 16:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] target/i386: Split out feature_word_info
Content-Language: en-US
To: Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org
References: <20230811135011.23343-1-twiederh@redhat.com>
 <20230811135011.23343-2-twiederh@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230811135011.23343-2-twiederh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 11/8/23 15:50, Tim Wiederhake wrote:
> The isolated part will be generated by a script.
> 
> Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> ---
>   target/i386/cpu.c                   | 677 +---------------------------
>   target/i386/feature_word_info.c.inc | 676 +++++++++++++++++++++++++++
>   2 files changed, 677 insertions(+), 676 deletions(-)
>   create mode 100644 target/i386/feature_word_info.c.inc

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


