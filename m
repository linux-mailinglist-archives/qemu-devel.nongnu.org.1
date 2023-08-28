Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB378B889
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qai4s-00065I-Nf; Mon, 28 Aug 2023 15:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qai4q-00064t-Tr
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:39:08 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qai4o-0001gH-R6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:39:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so21441055ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693251545; x=1693856345;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zIooUgTblWVCDshj70uQvPPMX4nHbJCLCcr1ZbtnLAg=;
 b=HB38fsBwh5oHGUa5di5mfEhk549Bu9nyvYecsXEzr+o6ErSNe/+etCVKA5zY/mQ3wG
 tzNz54uacHaOF5bKwRg3vKQth2har/yiip99hCFGJ1T2npqXDPoG3+lYqmpLyUByl3j2
 GA616B7GwsXAlyuNWNKMpeZOOe6RPYpCB+rc9Xg1j/BOQdGRaKTvIqY9WY8j6GDqdq1D
 Wd9gvzwqBHsl/G0e3ZNBeRV5PtOMwX1fEvEfaqf8vKAKLbUQ+Y/jDJuyCjUHg77/Pltp
 Ff2pMg3kA0bCd9qqwAjaCVCLjvXADMIgtCyE396NkHoWPSDa8inn84WUx0CLE1bgMf5/
 ryrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693251545; x=1693856345;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zIooUgTblWVCDshj70uQvPPMX4nHbJCLCcr1ZbtnLAg=;
 b=J2RfzuxfHbQVeWOW67U5OAWCif0WoQQ4U6NGIbAODLjdopydPqH0dZdmkGHnzS2mfb
 3xpcUF9MxTP4idnzq1lDN9yOiF/QRGt0+6EC3ACePyGwxedG8mrsYKjPGYvOs9Kdayx5
 utAlzYsViu1BGgUOAURn6y5PFOr1+d/M859B5Fgd9TN5ptVwdaRyFyhay0ZBqtjXPNyg
 2kAaUzTM/XvViDUcKcaLvfhrdO/38LNN8Fg8tYEKorWii6WkIzNFQITsGha/3Lh6OpE2
 RVmzW+9ubKv/i9Ihxso4wr92XZACXPADiUogvcAp/ETA0L+O8Aab2TPxCYXXdFrEXjxi
 9n2Q==
X-Gm-Message-State: AOJu0YzB41xLb3/O6B3poS07yZ+jG4sHKx7z1ZCsVKGc4k/O+lUTZO8E
 qIkh7mPKD2ywS7wCdp2q+JtWNQ==
X-Google-Smtp-Source: AGHT+IHhL7h4rJaTrV/7AkP8N+RA3GilBDd7TASbeuFlR/os4AY6A6UVaMFUyfnAAnIAskd1nnb+Lw==
X-Received: by 2002:a17:902:e751:b0:1c1:fc5c:b330 with SMTP id
 p17-20020a170902e75100b001c1fc5cb330mr227310plf.12.1693251545147; 
 Mon, 28 Aug 2023 12:39:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a17090332cf00b001a6d4ea7301sm7756338plr.251.2023.08.28.12.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 12:39:04 -0700 (PDT)
Message-ID: <69d01734-d6bd-47e1-1dbb-2bdb26b32689@linaro.org>
Date: Mon, 28 Aug 2023 12:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/11] Lower TCG vector ops to LSX
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
References: <20230828152009.352048-1-c@jia.je>
 <8d4941d2-77e3-f9de-302f-b3f9d14141dc@linaro.org>
In-Reply-To: <8d4941d2-77e3-f9de-302f-b3f9d14141dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 10:29, Richard Henderson wrote:
> We should probably improve tcg_gen_not_vec to try NOR.  This would support loongarch64, 
> and allow the special expansion in PPC and S390X to be removed.

Hmm, no.  The tcg optimizer does better when NOT is supported directly.
There is a whole series of fold_*_to_not patterns.

It's what I get for looking at this for a long time.

Anyway, it would be good for LSX to expand NOT(x) via NOR(x,x).


r~

