Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC46E7472D8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgEp-0004q0-MA; Tue, 04 Jul 2023 09:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGgEl-0004pa-8o
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:38:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGgEf-0003d8-U3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:38:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so47641625e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688477908; x=1691069908;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/auR+vBnOTSzMNHItZpcdNJ69aQsa2SyR4xnE05Mp44=;
 b=PKZZ3/dbjC6b3H4ESirmgvISkJ0QsQWG1HxK4cA8/gVr4rn59wEoGs/TwUgJQibyHt
 mP6JoqlQ3msBCwpm8VK88JXd8XgK/zAm2T5EXoEZCzFxsU/C20+ZFx0rXs01/upXhdib
 NXz3nX6vd/PqmKMDkQj9T68ARMWk8+3NHT2gRUrhdAknXbTlcOcWFUAjDSjE8thSJK15
 wGYNrAEm5uSvJ8ofm7lxvK36QcXmWZaIC7RilSGuKDkqY47kwNSZPPqPeWe1NagxV1SF
 UD+newWLcuC3Zk9S9+P7kZJBN65rImGBWYKcw2husQW9HSmBoPnDt1+cL37dabP/NgeJ
 dm3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477908; x=1691069908;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/auR+vBnOTSzMNHItZpcdNJ69aQsa2SyR4xnE05Mp44=;
 b=GlwybX9SSSdSGa+fTQGyv02RMmycnH5Cj/1NTxvltQHAPMm6iH9cIAEnRvHHrU2Lq9
 5RwLahSwWufBwR9GRJMneZdfKT1w2lCpUL54X6GqwnfCLXQ3VPHvYcjaHcvcY95K8r5L
 c2eM2zNmVl+dRHYSMbP16uOxqV2nN9GvRjp1sRW21GPvQdS/MwbBuWGrTbl6o/JQp97n
 nIfyRNWmv9o5JOZD25hGMU2hVc1JmjxlrOH00Q/gMUg3aZctICLVtVcZWtIZNgPJe5/J
 7zdlQQPVHzJrdIDlYXLjdueYOlnFvrPD6M4acfA3yFHU3Fl2yrMWflUjOTpqF2r8Dy1Y
 VfUQ==
X-Gm-Message-State: AC+VfDzpcl5W7FwZby7pQdS9PziHg/Zlrfc1dQGKeFKeEMDPDyLJQ4Zi
 rRSsILem7S/Ifwhkm3LhHr4S1QEfwpnTsNMSBC4LkK/M
X-Google-Smtp-Source: ACHHUZ5Hj7W+wQUQhP7j/I+7TLHqoMaNBjpaebhGIG0Emi9KFGMfZcIfJ7JoqByiBJ8wufKhl2grdg==
X-Received: by 2002:a05:600c:2145:b0:3fb:415f:a85b with SMTP id
 v5-20020a05600c214500b003fb415fa85bmr17645112wml.3.1688477908464; 
 Tue, 04 Jul 2023 06:38:28 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm16004962wml.15.2023.07.04.06.38.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 06:38:28 -0700 (PDT)
Message-ID: <84a1162b-84d4-6f9d-4594-5ae43fd3c7b8@linaro.org>
Date: Tue, 4 Jul 2023 15:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: add PCIe node into DT
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-devel@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org
References: <20230626075207.623535-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA-K_2SLxbq90TpUyzLpiC0U2WVJe7ffaC_TH66K-=GV4A@mail.gmail.com>
 <b26c98d3-3e9f-331e-acbd-ae0c451e0ed3@quicinc.com>
 <CAFEAcA_rg4CbE1Y9mTQmPs_KBqb-S=3Z5Hh78gbVUD6R7DR0hg@mail.gmail.com>
 <CAFEAcA8mk0upQUqXsdm3YXvRjAJc+6npkXAWWLtHS+3A8bMJKA@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8mk0upQUqXsdm3YXvRjAJc+6npkXAWWLtHS+3A8bMJKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

W dniu 4.07.2023 o 15:21, Peter Maydell pisze:

> Just to be clear about the status of this patch, I don't
> have a problem with the code changes, but it does definitely
> need a much clearer commit message to explain why we're changing
> the way we handle the PCI controller. So I'm dropping this from
> my to-review list on the assumption there will be a v2.

Sorry for delay. There will be v2 version of it. I am busy with sorting 
out EDK2 side of GIC ITS enablement.

> We could also do with expanding the commentary in the source
> file to clarify the design approach we're using w.r.t. what
> we do and don't want to put into the "dt" blob, but that would
> probably be best in a different patch.

Already on todo list.

