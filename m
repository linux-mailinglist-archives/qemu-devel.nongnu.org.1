Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF9573FC23
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE82X-0006Wt-8b; Tue, 27 Jun 2023 08:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE82R-0006WQ-Np
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:43:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE82M-0001X9-36
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:43:19 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-98e1b1d1698so387841566b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687869792; x=1690461792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oiGMShFqsK5vy0r+ZoVprgd+7ONOa51b6TZq+l7w8nA=;
 b=N9jYqZxdR661UImV0f2eqz9etcpnHRQWFJOWqbKzx+pPrr0rGpTyRrmz5XuUcm1Jel
 baeVg/QwQJBCIEde+fmbP7LG4Izl1AuD0EKT+rEyp5sfJSH192El68xs7rbT6+K4WH9y
 IfQhrB0iGU5wf9XPYsYmDFUbqjvN0yAjtDAbR5RKLJJX7UPC2owKWr4ScVk8mulj3v1M
 rUlnRkKpW+k6Vp3tBKcP/u8zcAy+nchDJTbp1UFf/jwRX/gpGEnEqqlo9lImfk5IYIgt
 /E/zRUzGds4zgAE/1m6/1FiPOwoCYKzmruujyCiOPEFDktm5hG65u6lqnFuN24x3EXwg
 3F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687869792; x=1690461792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oiGMShFqsK5vy0r+ZoVprgd+7ONOa51b6TZq+l7w8nA=;
 b=YWJDreDEMae9Tlf1TeBNVXrpD4Ud/JXBENLFu4Um1eAy460fw+nF/DtFQfpxJy4h1H
 d83s6Hde7A/DoGDH7UHFyATJ03k6WK9Ca44jOMnM/NBEJg+GurHI77b1zDTmO/JdBNew
 UH0Z4e0cEYsrFSigwQ/FeNOnadDkXdOP0oNhs0I1ddP5R9nVyC6dFbIlTr7Gz5wyUHCu
 fsEcZqdHfzKKLhs4nc5L0sqSMdEX60eYqPXo18GMGMnzzhp1Y2yy4c0pOVC/x+iRfe0f
 QJlMP03CDY6KgKZHIC5nh1KeiQI+/3xkl8rxlabHMx1d4QL1IQGlqf0DuODS8dla+6nq
 sBwQ==
X-Gm-Message-State: AC+VfDz1g3nV76milnsuHhoJnLsTeTehmA6txwLn/65v64SgTnX7a8pS
 G5eEDPoCOGrD/2qZLliU0GJ8h8AMLY1ZSXqOROI=
X-Google-Smtp-Source: ACHHUZ6zoAvKTmIUPl7vS48VUGVb/8NUBU9FbZNA+3XvIM6YbbuEMppTKmcZbeQKq+uiXwT/1/ecVw==
X-Received: by 2002:a17:907:c0a:b0:96f:d345:d0f7 with SMTP id
 ga10-20020a1709070c0a00b0096fd345d0f7mr28092609ejc.62.1687869792013; 
 Tue, 27 Jun 2023 05:43:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 kg1-20020a17090776e100b0098e2eaec395sm3430672ejc.130.2023.06.27.05.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 05:43:11 -0700 (PDT)
Message-ID: <9d54d187-dd61-9d48-01bc-d0d6a44d119e@linaro.org>
Date: Tue, 27 Jun 2023 14:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 15/16] accel: Rename 'cpu_state' -> 'cs'
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paul Durrant <paul@xen.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230624174121.11508-1-philmd@linaro.org>
 <20230624174121.11508-16-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230624174121.11508-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 24/6/23 19:41, Philippe Mathieu-Daudé wrote:
> Most of the codebase uses 'CPUState *cpu' or 'CPUState *cs'.
> While 'cpu_state' is kind of explicit, it makes the code
> harder to review. Simply rename as 'cs'.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/hvf/x86hvf.h |  18 +-
>   target/i386/hvf/x86hvf.c | 372 +++++++++++++++++++--------------------
>   2 files changed, 195 insertions(+), 195 deletions(-)

Per IRC chat:
Tested-by: Peter Maydell <peter.maydell@linaro.org>


