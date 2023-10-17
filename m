Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1067CC0B5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshLD-0004VQ-Sv; Tue, 17 Oct 2023 06:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qshLB-0004Uv-QT
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:30:21 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qshLA-00048W-5m
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 06:30:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e84912038so4437382a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697538618; x=1698143418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kNbnFa9htf3hryIoUCW32MC3TYr8SKRmplfK6c9yYOE=;
 b=a63omeVdGCHRP5dV9EomZBvNcotMwv7UovwT3rUpI9eWNUKg6sB4fdLupdGqWUBIxd
 n4uESyl1ygdwT8F38RsOl9ATr9UciHaQLeF8F35QjSpzT8FmmygZCF8iFNHWKMMOosi0
 wON4HOl6VWj/gtKxVvjQNkRM5w1SWwP+RsD5+3PiCJrw+3hkwfFBfYgkYP2Pz4ChB+oa
 1gRsj8uZGqHdIfGZgStd1HOcqMOFSHlJ1IX0Ng0PXYDSqDzfFNA6XDBXbhnJyS/DaSm0
 Ac28ySr34A/1f7V4UnvjKYMpaTqqYuXuZaUu7UQ7mfcnX4a7NwPBB1+IYd8sJNDVoP86
 uGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697538618; x=1698143418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kNbnFa9htf3hryIoUCW32MC3TYr8SKRmplfK6c9yYOE=;
 b=ggvXQ0d9OE5VTwdMBfmQmR+ZcooUkf3all6Ov3qMsvv71Ad6HwKt35d/zSF04Y8EVn
 Mfj+ffUyxMC0y1ES0lyZj1sAu5GnHa9BUEenajnrg5Krq08Zro5R3EaqfAse2Qh+nUGU
 rFCCL7HWdrkJEmczxZ+nE0KTbA8/MKb+0hEmq5Hp+g1yyDLWG8sqcSAcPEDOhSN9ANbu
 OQRXJ2Iq8c0DqMEJ4L2+85A5fp/RgL1YjbpJtD2IH2dtIJqO2UtfTe81abhhxcdy32bG
 mpvIP7fCDk90V5rm3f0iF738S3lFGflNjv+scswO3Dq4zb+0IpDXaegLyoG8MkiwolYR
 k5BQ==
X-Gm-Message-State: AOJu0Yw6/DWW+/c01FxKuLFKic4r+p3v3ijVESv3xrUQK3TRr5bv2txb
 JsRbpTi7jpFb6k6XRlz3hZU5Dg==
X-Google-Smtp-Source: AGHT+IFpsDAvsDDI4F/Uij9Ka1KyZQR8tBrzRRiM532qU5jMZdwZn+A1iiWk1tR4xJEJjZdIQc+UxA==
X-Received: by 2002:a05:6402:520b:b0:526:5c70:7318 with SMTP id
 s11-20020a056402520b00b005265c707318mr1484090edd.6.1697538618336; 
 Tue, 17 Oct 2023 03:30:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 cq23-20020a056402221700b00533dd4d2947sm942363edb.74.2023.10.17.03.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 03:30:18 -0700 (PDT)
Message-ID: <e76c87cd-8a70-7552-9922-bb17a9d8aeeb@linaro.org>
Date: Tue, 17 Oct 2023 12:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 64/78] hw/mips: add fallthrough pseudo-keyword
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
 <4e6afd01831a38c59d09f8f0483b304b7329f4aa.1697186560.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4e6afd01831a38c59d09f8f0483b304b7329f4aa.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 13/10/23 10:46, Emmanouil Pitsidianakis wrote:
> In preparation of raising -Wimplicit-fallthrough to 5, replace all
> fall-through comments with the fallthrough attribute pseudo-keyword.
> 
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/mips/boston.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


