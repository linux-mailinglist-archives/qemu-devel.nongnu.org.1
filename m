Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F0740571
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFsh-0006uQ-Kc; Tue, 27 Jun 2023 17:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFsf-0006tw-4p
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:05:45 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFsd-0000KS-Kc
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:05:44 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso216125466b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687899942; x=1690491942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CGduznZ6msReTC2l/W5laHQoA+Ocs8N2FoxqJmlTDEQ=;
 b=X7L5E/lXPJXq83d7YOX7xyIKEurOFoq2WxZ+4xY9X3+tzsvn8GclrOEvVxA3/d8/ud
 hPrke1X/KuDbfXZUbubbZ0vGkKp2iMIKfbPb/fmULBzkqJU7SzieHz8mhr9eQh7/rjIw
 4JLIBRACg7r37sKS2MpgUA4qkZYV/UUtHoMVrNBBi6m5OBVt4GZFB05FEvLYbm3F+T0o
 Hb6mqxM4dCPsQXZwxMsL7iRYNzOxC5EQRV8YxnRuWfvnPtYipNn0Wa8l6JcO5tuo2Nd+
 8PHfc+f9tbpbHONh//KTCBjF+7B65iS41GY7JAgmBWIXXibJjpFqhOalHxZ9T6QSdCui
 qpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687899942; x=1690491942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CGduznZ6msReTC2l/W5laHQoA+Ocs8N2FoxqJmlTDEQ=;
 b=NQxjK9FlvUQP2Mn7z8wszeTdbMoH1MImBdGXH/+vT3pJOb9gPGjMJxvPVZjUBzf+Wa
 eEAYnelIOTgAGMd2xLzHuBz7+aBRpxtadmbgafY8tyIqbyis4Cl6lQFwSB2F8Q1X2xMZ
 jt8fmniB6ODsPa36nyAZyyk/ybEUU5Rva8dccyNP4m3Xfsu+JNs51p1/JDpOAzjcOiUO
 a7HW3j9LdSTyWcaxNe8lH3u3SRcgVkuLc0yN3K5cHtk7t4BQFZnHNDAJXzFjZdDym0Cz
 qb6+lLMpLfZLJDyPfJvE3xfxahbnq72+HszxFD3NKxqV9oe+2WUfXdQ+Tf1p6WaVkPDY
 w8Zw==
X-Gm-Message-State: AC+VfDwKV9UUObXEwK6p9ChY+I+MhuBr8T4OKbnliBqKDRSSFmdFG8Sh
 uZGRlXnb6TD/JIfPSV063N5G3w==
X-Google-Smtp-Source: ACHHUZ7r61k51kP1rADSd3wJYhKUMWcbe/ZN4zhv3p4NZ3fddNPWA468zULzMw+sn73J1fSUmRs0cw==
X-Received: by 2002:a17:906:6a08:b0:992:44ae:45dc with SMTP id
 qw8-20020a1709066a0800b0099244ae45dcmr1386691ejc.44.1687899941931; 
 Tue, 27 Jun 2023 14:05:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 gl24-20020a170906e0d800b0098e48ad11f0sm3429574ejb.106.2023.06.27.14.05.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:05:41 -0700 (PDT)
Message-ID: <fcc0e5cd-46e3-91c6-960e-f545836c34d7@linaro.org>
Date: Tue, 27 Jun 2023 23:05:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 19/36] plugins: update lockstep to use g_memdup2
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-20-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 27/6/23 18:09, Alex Bennée wrote:
> The old g_memdup is deprecated, use the replacement.
> 
> Message-Id: <20230623122100.1640995-21-alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/lockstep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



