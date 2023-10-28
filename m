Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CECD7DA8F1
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwp2M-0001r8-Fg; Sat, 28 Oct 2023 15:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp2K-0001qy-Ie
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:31:56 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwp2J-0001wc-4U
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:31:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso2908555b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521513; x=1699126313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Km9pRtszTOXM0cmX2P9QcZ33obc1r8STUPYjn3u+O20=;
 b=Pfkw5se2pjYihaizvJPT4EbutBTpraqGoCC4GNikniOpTCPgY+TcHG8JjjjhBruMXi
 0kobLjMmHPnEQD9LcgVbbB8N6gNAaqan8Sh0s3XjDFAuyxODP2IC/tKdlR3c+sYiO5Js
 4U4UebLd/m8nO1fRIzKKJKm8xDZXIbZuRNWQoOg0vqeBhlzstJgCXvesWpdi3i+NVRoc
 U6oWOP3DQ7ZgRQmGKlzEED5iJ0dz4cQu7M+AotdxJ7BC3XpFsKRKK8gtVkvF+S/p3p6T
 6lRvELPz6AoWULBOswaJUVk16AWG918MPHDaPrPUrJMrhQGyJhGsmSwdIEXlZRDyI8s5
 cOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521513; x=1699126313;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Km9pRtszTOXM0cmX2P9QcZ33obc1r8STUPYjn3u+O20=;
 b=REOXBobniJewfnxk/5ykxeerGNG9QPSstDKLZPwf6HnsODROYHl4lSzTxc2EeC8F1R
 P900NywrHeS0o7g0QFblcxPss14QKbRRL26+kSuhLwAOpJmb6XYOIvrnmZ2rBRy83d53
 qRVFDi4bFh4MWa1TZ99I/FcIO7KcQ+mqlJDctzoQQ9qgWOhdlRVTu3CUcTnKHj0KUMzM
 +9r1GYD5HzqU91wwCohMMJq2I0Sc6v1jgVYB+bnJmX73htv87N6su1usTROHCLz8Ftnr
 b9MJLDz3LkbYa8FFLOTJ0AfnTmx5kwEoD7OeDZGuDboTJg42O32SiZXop37+LNqTlPuJ
 bU0w==
X-Gm-Message-State: AOJu0YxsKH8BLsb4vBbuHVg1Ioz1JoPG/ZtolCupvUBM+pJvu1UGdX8d
 21g9JsxdIffCZpSdBacUvOAUNw==
X-Google-Smtp-Source: AGHT+IFa/N4viDxCAmTJJRe5JqmEoOr5iDcHZX1jvlgxdD8OH4VLDOnYlT1fmBQy0AACAnzmKs0q1w==
X-Received: by 2002:a05:6a20:7f9e:b0:15e:bf2b:e6d3 with SMTP id
 d30-20020a056a207f9e00b0015ebf2be6d3mr7254146pzj.46.1698521513618; 
 Sat, 28 Oct 2023 12:31:53 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a170902ea8300b001c3267ae317sm2073072plb.165.2023.10.28.12.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:31:53 -0700 (PDT)
Message-ID: <6666d860-3e00-4c27-80fd-9b580654a9d7@linaro.org>
Date: Sat, 28 Oct 2023 12:31:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] semihosting: fix memleak at semihosting_arg_fallback
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:33, Alex Bennée wrote:
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> 
> We duplicate "cmd" as strtok may modify its argument, but we forgot
> to free it later. Furthermore, add_semihosting_arg doesn't take
> responsibility for this memory either (it strdup's the argument).
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <03d81c56bfc3d08224e4106efca5949d8894cfa5.1697801632.git.quic_mathbern@quicinc.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   semihosting/config.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

