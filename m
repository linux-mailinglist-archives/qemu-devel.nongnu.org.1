Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CB723E37
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TI7-0007Vh-DK; Tue, 06 Jun 2023 05:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6TI5-0007Uy-0B
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:47:49 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6TI3-0004VZ-Go
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:47:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-977c72b116fso462276966b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044866; x=1688636866;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BK85sWq1xBOn+HFp35f6XF2KYdwVycQ6chTZ8IOqpIM=;
 b=AOKBt6kE7TjF1otGSICtLsnVAplYHkZJdAwZ51w3hGoSFgqjPEofcR0NI6DVx5UYOq
 av9GCkjzB9WrQk9Z1O3HVtyLfu+VTky7iSpbvypJM+jmLCXC5CfqcQecDqOECZYI7t7v
 hpTvqCi5vyoXlHIi/wjiUvdPO06DBiZlPARyiv5K4MhEw20Q8QCKnU1KE8Ja7K6mP7rW
 iER5xJRcDyx4NEH43QFsijQI5NlOOJhAPnxUYRqBwPM4KG5S+rfdAlAUbocWRKWJM4Jb
 elOs3neoIhBwzCPc+E4sicz7ornS/NgKXVfYPnV/cOqJUah1S5OBJj5m3zM+2GOqgypt
 taKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044866; x=1688636866;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BK85sWq1xBOn+HFp35f6XF2KYdwVycQ6chTZ8IOqpIM=;
 b=kFzdc3CN7GxnDh8AkcMt+rItf/1WeSv3zulS0IOzNmDwEw6ABWCZeLanhWKzHFW0yA
 Vn2TxwPfCEsEKmu1JXaGFRCUcSOOR3QHIwqwNkU09rPnJY9b2SHSXuHhrHWibsbgghd/
 v4lgRzyBKwAsQcmaG5d1anOunVumXmref2fwK9FPulHZM1Xhy4ek1+6gPmrLC8uCLbW4
 NI+GEkNbczgdk9VjqNTwmSVkSLuHlsg1IGs5g45WIOOYMlA5JhUMz5wBIV5B2IecR9Hk
 fYEqwiTkugwjLPtP0Ncs6eRlR5xHNHr8HofpR0XacNx/8rtwID4JxpAskERlowxdtKtR
 d4sw==
X-Gm-Message-State: AC+VfDyB2e4PiGCPRm28y9+9a7PcxNtTCQWlzsBwo8FSyity6dTYHpl1
 Of8PDkxhAMc0aArXlOZT3g6ulA==
X-Google-Smtp-Source: ACHHUZ7fpQVPSP3jspAz7lETcLKW4IWwHEBYI/6zJAJshCHHn16A30/d1+5qgQF4BARGkmN317Bu0g==
X-Received: by 2002:a17:906:58cd:b0:977:cbc4:f7e4 with SMTP id
 e13-20020a17090658cd00b00977cbc4f7e4mr2027440ejs.29.1686044865828; 
 Tue, 06 Jun 2023 02:47:45 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 y26-20020a17090668da00b00947ed087a2csm5313674ejr.154.2023.06.06.02.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 02:47:45 -0700 (PDT)
Message-ID: <1fc502fa-8363-5a5b-0697-f3001c7ab773@linaro.org>
Date: Tue, 6 Jun 2023 11:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
References: <20230605095536.117384-1-wangyuquan1236@phytium.com.cn>
 <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230605095536.117384-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

W dniu 5.06.2023 o 11:55, Yuquan Wang pisze:
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses XHCI to provide a usb controller with 64-bit
> DMA capablity instead of EHCI.
> 
> Signed-off-by: Yuquan Wang<wangyuquan1236@phytium.com.cn>

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Without EDK2 changes Linux behaves same way (no USB found), with EDK2 
changes (EHCI->XHCI) Linux gets USB devices.

