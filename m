Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB0718F59
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 02:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Vkg-00020s-Nk; Wed, 31 May 2023 20:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Vke-00020Q-1i
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:01:12 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Vkc-0006j0-Fa
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:01:11 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6af8b25fc72so275879a34.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685577669; x=1688169669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YOg40mEM46tVmUiecyCiQsUHCka1oLuprmF+c+0pqMQ=;
 b=HIqvsj+ojm5rROA59wGR+FjoDYEPZtW8Qfw1gFnGp4ylfVWOJlb75E091pxSTT+12v
 DnuAt0EDm6o19pgN+nWMaqC7hY3aftf4ICOvCYQAY6rzMS7HEFlFzuBDqFz85nd28DXr
 zhCNEikjh5ln15jfl4kspMTXGRmSfQfHkNpgGdtdLD8/VilRuu1EoZsfgqVrCujh3x4w
 RK6Po1J6Ib6RPRK9gAM+cq70Szs6zgyMnM3LRRke0VYkcwEcW0pB/I3JnfNm78ZCe+tY
 +CMnMNdq97h+oM/QfwhANe74aUXdixqluzUT3l0u59TIjWC7ujlkcL5lmUN/UevNunaE
 3Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685577669; x=1688169669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YOg40mEM46tVmUiecyCiQsUHCka1oLuprmF+c+0pqMQ=;
 b=Yyt8SJ7zinGfs/QVSZPwCmgH6Vwr5PdvBH7/FPuwACNVL7ErI+wK6KkPNaG28otIT2
 XRlY6D1qZKFoNn9lPDVU6vpTIqF3OEHRDJ3rD20bBosoIfya1GbcvQNijiYXFJMaEqAg
 ZszIDcOCJdF+cDJcjdarjZK5G2zTvN58t1LpnyTgmC//AGG9SmX+z5K/QCywKUJXWXa8
 tvlkypVzb+BWc3LytaT7x40O9NjW8zOHdJALOkTcvG+yHZQYfgWjPYOYPBV3wunaShfw
 QFbRUtNM507/oJTTjqMvvg9RaY6o3PQVZFprsu5O6Y8NDiglHg5DQM+Hx0LUJZNVTcBI
 yhDw==
X-Gm-Message-State: AC+VfDznzIOepBpty03tJxpMMgPD66iycOo8lvvKUwZqXw18GijJ2kWA
 fXTjjbL8B+NFiWnBeg19dkv6Xw==
X-Google-Smtp-Source: ACHHUZ4jfKwFT+1XqaziiuI/QYaATFFequuwEXRqYjpuzHj4G3TX4mDO4i9ufI5T1K2QgSgYhkm5Ng==
X-Received: by 2002:a54:4593:0:b0:38d:fdf2:962e with SMTP id
 z19-20020a544593000000b0038dfdf2962emr5507036oib.23.1685577669222; 
 Wed, 31 May 2023 17:01:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 iz17-20020a170902ef9100b001aad714400asm1954922plb.229.2023.05.31.17.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 17:01:08 -0700 (PDT)
Message-ID: <b4859236-58eb-7709-235f-5096aeb9861f@linaro.org>
Date: Wed, 31 May 2023 17:01:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-3-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/30/23 01:35, Fei Wu wrote:
> +/* TBStatistic collection controls */
> +enum TBStatsStatus {
> +    TB_STATS_DISABLED = 0,
> +    TB_STATS_RUNNING,
> +    TB_STATS_PAUSED,
> +    TB_STATS_STOPPED
> +};

I don't see what PAUSED or STOPPED actually do.
As far as I can see, stats are either being collected or not: a boolean.


r~

