Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52386800931
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r91Eg-0002jD-D0; Fri, 01 Dec 2023 05:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91Ea-0002YQ-Es
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:59:02 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r91EU-0004U5-S6
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:58:57 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50bc8e37b5fso2820107e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701428333; x=1702033133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kBgEHer+ht0dHaP6LJn8O1147TeXZtstiObP4o2ORIE=;
 b=yyYBidxIwnP/yECByAwEj1U8ScmGdnOSohVSKzyBsjPuUDynXQJDmnP/6yp1nSq8q5
 w3bbQoHhgDD2nAuOdBGyyVjuX/GXBoFPj2ZcqeGrNi3S1IhlsjzuDiYOk6vDjF66v1Wp
 asaUT7FrQPV0/ioRrMwK52JQQMtJu0K5S3BM/xoqb+Mz+fNJDbFKTzJ5JNhS3dYp+pRy
 RPrIXVV9wsJTkL4aG3jaLgvBYVDEIbyHUDVfyCqsOvhI/XgJfZVOvTQrFUiSfCW9wKRO
 SvyZDEXQwEGwOqxq12gjnkCYv5/7JwdEy5XgfKJiYEU3rhXueR+sttFKiqPiEjV8BBgK
 VOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701428333; x=1702033133;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kBgEHer+ht0dHaP6LJn8O1147TeXZtstiObP4o2ORIE=;
 b=duG0UxjcbkVUf31t4fxdpozC1AB8KwPvjJDLWDgTQkb8Yxi6Ggfej0qm1tLDFodknj
 0s1vj3ob12sp6hN88p6b/Gimr8+G38srVfQTY+4DOWJ0t0yhWnUcsO74Cg9Y+8Ashd8p
 tgs3pOr4llyZeKqsOlAEujtCfkD/o3CAJ/fOnlnfhNhlxUMoKAOm8AQfBeJh6LNQZCxM
 b0msWAMDB/OCqja6p2Ax3W8lkF/DkbAwC1Hphz9FLl97gFShB4hYNdlelHVTq8qtupBa
 nkIQZFH632D4cxgJMqMvO3etiOjvD+QtWLxmhKVVMnS2U2n3pbAL9aK0x/c82KtGkDlJ
 4eOg==
X-Gm-Message-State: AOJu0YyVApiZd5zNZ+7wgt91RMiZzGLYQDQUlqo8yPcAMKtFscwvWAMZ
 QR1p+Hyn0FDhnXgyRH75p0h0Ww==
X-Google-Smtp-Source: AGHT+IFFwM1ZKy97oak8J+Rv7ndWdysgnH6YMTw9IM1ZOw/7O+SBo5Jv9glACV8c6uZ3wTh7JlJkaQ==
X-Received: by 2002:a05:6512:3ca2:b0:50b:cf6d:fe33 with SMTP id
 h34-20020a0565123ca200b0050bcf6dfe33mr912018lfv.58.1701428333107; 
 Fri, 01 Dec 2023 02:58:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a05600c348d00b0040b5377cf03sm8725717wmq.1.2023.12.01.02.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:58:52 -0800 (PST)
Message-ID: <33f3cdfa-fe4a-4512-bf87-5b26e2fc2c81@linaro.org>
Date: Fri, 1 Dec 2023 11:58:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/9] machine: Print CPU model name instead of CPU type
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, b.galvani@gmail.com, strahinja.p.jankovic@gmail.com,
 sundeep.lkml@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, vijai@behindbytes.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231129042012.277831-1-gshan@redhat.com>
 <20231129042012.277831-5-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231129042012.277831-5-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 29/11/23 05:20, Gavin Shan wrote:
> The names of supported CPU models instead of CPU types should be
> printed when the user specified CPU type isn't supported, to be
> consistent with the output from '-cpu ?'.
> 
> Correct the error messages to print CPU model names instead of CPU
> type names.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v8: Use g_autofree                                        (Phil)
>      Relace 'type' with 'model' in error messages          (Gavin)
> ---
>   hw/core/machine.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


