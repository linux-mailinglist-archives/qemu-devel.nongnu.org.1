Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B057D24B4
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 19:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubpP-0002f7-Kc; Sun, 22 Oct 2023 13:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubpM-0002dJ-KD
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:01:24 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubpK-0004yK-CU
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 13:01:24 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d45f5658fso1984299a91.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697994080; x=1698598880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=226gkJeucjnhEuFxWD8av9viZOUQWw3DRXfkYa9gtuE=;
 b=ZGIvtUgLPJF+8OCWJuBJ9/8AXz1NI0DTjvixFumVuCCgUCZM4mh1LTrk2o4giGLQE8
 JHgyfEpi0SIFp+qoqUfHKTLH/1jWhjElN15tnsTsXPUpMZXstnPHg+e7VcRh/puwRW3x
 LDEAOUz6XNY30qiEt8N1V+A1524aPnwFqJBUTSNBbcPTv0+ZfNo3XyOpD2t/v70auwne
 FP5rS3jL2r931sxASm/oFDmwSixpPae5t8/g9Ku9e/L5OKcLdbmqgeq/s8MCPdUU/I3r
 bSP+LIEA6L/WQOYXcCTlYSlF+3R7EYpiJXtUGgwnM2rARU5Tm35IStPQAqLL1vqaFI5K
 AkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697994080; x=1698598880;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=226gkJeucjnhEuFxWD8av9viZOUQWw3DRXfkYa9gtuE=;
 b=QmUg3e4xJu5iZ5u9coJpbbTF2A6IEMWHKiCpxk4agcCGyR56PmlqaR+1WwPB8ztSaz
 0/ybKOHfvsuXVoxKJBI5vVQUepXCXm4Z7JmAuVHrSKxQZjUcBRX2V4cmGkRyArwoy32q
 HQmTTTSkA0IhH0qhNCrffQIK0lQH9bHt6oGaW93ACZ8B33VSEOzkrS6HP8UD2RhNMvUE
 C9TBHCmRxSFscSr9PDbAL2wGnZHBnV6aw819HYKjhnAykqvvU1A0If7yyQTqrutpyr1I
 4jtnVfnmmcbxezBTcJu+UqCRiJzrVi7/1VSzfAluUh43bZ0Z15H1TLJknSrcfiVzVDar
 oW+g==
X-Gm-Message-State: AOJu0Yx1BMan+HSt5RnRtFrFLpNELnlKKzBPLDYZJDGFe4I8oN/gMzjO
 vP71+PHWKpLzvfohZN+fCquBaQ==
X-Google-Smtp-Source: AGHT+IGExisFMZlPui3snUTw1wrobEAWH2U0W09/g8P0VVaZTKtanvKiUWThm1x/SJiXNmly1++gIA==
X-Received: by 2002:a17:90a:4b0f:b0:27d:20f5:3629 with SMTP id
 g15-20020a17090a4b0f00b0027d20f53629mr7043080pjh.46.1697994079974; 
 Sun, 22 Oct 2023 10:01:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ix4-20020a170902f80400b001c74718f2f3sm4646941plb.119.2023.10.22.10.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 10:01:19 -0700 (PDT)
Message-ID: <4cd885cf-5b06-431b-9bdc-41a08d1da573@linaro.org>
Date: Sun, 22 Oct 2023 10:01:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] hw/i386/pc: Propagate error if HPET device
 creation failed
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231020171509.87839-1-philmd@linaro.org>
 <20231020171509.87839-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020171509.87839-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/20/23 10:15, Philippe Mathieu-Daudé wrote:
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

