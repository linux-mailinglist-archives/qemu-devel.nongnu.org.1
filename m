Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80307594A8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 13:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM5hm-0001eL-GB; Wed, 19 Jul 2023 07:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5hl-0001eB-5A
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:50:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM5hd-0001Rl-50
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 07:50:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3142970df44so6400886f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 04:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689767443; x=1692359443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pkDWq1rvTFtoMklrEy7kTR/2aOapnMiZOTkDhARIyJ0=;
 b=fZgYAp2wYw6OtmD65mmQT1xwV7ZI6BMeJm9f7oPikWx6IyRSb5OdLRFUMts2wVchSk
 L+Wc24131DY6zMt7vRaZiLZQV6OSdjhIUxsJDv8KT0ehHyQORicD8UPoWijYeC1d6/ag
 Yeeaj3F2RJJn2KPoj9lpse0b0+1F5btORDhSlr+w+uDiRHlBcLKYZ1sJmTQj0pZtAify
 I0hdeIyVL9LiJTraSyV/TsLqRSni5RYocCrkTTKwbNpnmjzwbCTFUxHGlBiV1SRrLVqo
 AjYZmUBuEwwIRARs3OrFGR5aPacqR8XYKR46Vi59wG2ZO9w+jGY+sNsS1CtHaJ9UNr67
 0A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689767443; x=1692359443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkDWq1rvTFtoMklrEy7kTR/2aOapnMiZOTkDhARIyJ0=;
 b=JfgyMTV7Nt+mqwCskRFNT//pwSGFaPbLh2YzXmI9ESX4CCVXL39CfgWznPPuYBRQyV
 Uvv7zDlsr0Id1KDZSo5tk4o7/GUcaKARGQ17NrzT0rYXutChefHcyRk9JGpEBd2MaPp+
 LQKACr1MXS+9YQUSOgPBAaazLlXhDLzH+MFon00P4uuH5Zg+ykTQ0aQLtKnx9wYov9Xw
 tNrW1FbmUMNV+m1We+JmoIx94DM7LPxbYYNdKo0K6PjpDSnznDC7OprNdu7PAvpJVEyn
 kPWf3meQwyb+fxNJdig4okea9AEpSje4CQw1T6yl4SuQdi19aC2TAjGhwvi+GL/f2HYd
 L0SA==
X-Gm-Message-State: ABy/qLZGDwQYGuPWM7huntqmQDwbYs9GXymIG9/DFnbK/AmHRr+SnFYK
 NTOztKRuXcpyY2zbp4lAa2EQYw==
X-Google-Smtp-Source: APBJJlEr8QNsKnJfbEfANdSuhrWtKE77frgdIzLv1SzYUszhzOu6q3mncwmFNdPkdLPex/wDJ8wlMQ==
X-Received: by 2002:a5d:6d4b:0:b0:313:e9dc:44d5 with SMTP id
 k11-20020a5d6d4b000000b00313e9dc44d5mr14035270wri.61.1689767443573; 
 Wed, 19 Jul 2023 04:50:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a05600c0ad900b003f9bd9e3226sm1556931wmr.7.2023.07.19.04.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 04:50:43 -0700 (PDT)
Message-ID: <7f0e59a5-aafe-55b8-d78d-a2e9bf7a68e9@linaro.org>
Date: Wed, 19 Jul 2023 13:50:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/8] hw/ide/ahci: PxSACT and PxCI is cleared when
 PxCMD.ST is cleared
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230609140844.202795-1-nks@flawful.org>
 <20230609140844.202795-6-nks@flawful.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230609140844.202795-6-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 9/6/23 16:08, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> According to AHCI 1.3.1 definition of PxSACT:
> This field is cleared when PxCMD.ST is written from a '1' to a '0' by
> software. This field is not cleared by a COMRESET or a software reset.

Interesting, since its origin in commit f6ad2e32f8 ("ahci: add ahci
emulation") PxSACT is reset unconditionally in ahci_reset_port().

As for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> According to AHCI 1.3.1 definition of PxCI:
> This field is also cleared when PxCMD.ST is written from a '1' to a '0'
> by software.
> 
> Clearing PxCMD.ST is part of the error recovery procedure, see
> AHCI 1.3.1, section "6.2 Error Recovery".
> 
> If we don't clear PxCI on error recovery, the previous command will
> incorrectly still be marked as pending after error recovery.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
>   hw/ide/ahci.c | 5 +++++
>   1 file changed, 5 insertions(+)


