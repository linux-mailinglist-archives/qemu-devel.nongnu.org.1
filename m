Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B67C87E2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJDH-0008F2-SK; Fri, 13 Oct 2023 10:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJD9-0008Dt-KX
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:32:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJD7-000090-Jj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:32:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9e072472bso13975985ad.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207535; x=1697812335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2GRxBl/5A2wSLp2ENDHVhxEfhtrOdPfZK2015D2JR8=;
 b=ux2N3dxSdx/63Tz5L0kroa2OrQ1dIJ/ooRSiEEUo0PmUg4S0SBwx5+TMI9PO4kXM/H
 9F0Cq90h3zzxhhBschcTHXROsF3yvQvw6J4kOkxNAL4EI77Ip8M+aCBieuHDEhQ55l/f
 G8L/dFqL9gTKZsQscKS99QTC6Ib5Csa74AKafIbc0RlybNVykWTNHcwY2CI1rin2iYIF
 mCdkaEUaBGjFLFpbSOQCGRCGAHCnoBuTsLjlZshHzmuPNZ3799vr4J8GvStraZfYuxWc
 X9W+c7BW8ZXf1XZr25knnDDqGbuYq+kYRVTa4/m7DPA5zhZ2CdOjElUoKrFjLzM35jFV
 kmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207535; x=1697812335;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w2GRxBl/5A2wSLp2ENDHVhxEfhtrOdPfZK2015D2JR8=;
 b=wUFpfLP2PZoSybUS48q/LuJps9QHvbEhoc4bQdEt6UiNhOUe2DbA56fPKFSdwGIA3x
 wZ3hE88dS0CSdAe+DHF93tDlezNKFChnMm0Dqzl9F4boyPB8UjdyHlf8c1ZAwRrK3a5N
 i7JKzbrDKXZOdwQHqPwC3Z5Hs27WhuVlmb1fno6+XKtLT8/W0KxxspaS+DX5JPrw4auT
 CtFaxH4Oxj5evw5t55CDB2Lmow/cPMKvyFcRDDo1j5SlpW9odlvMn7eKGK1DNfv4zdTx
 NangOg0oOAx+nQMfYpI1P0WnTThxohcne0d+L3E2MFurdNXUJpEZAUki8gaX1AC3GFEI
 Z/rA==
X-Gm-Message-State: AOJu0YzA3xGYDiGCpohNGFfT+Qs0UhClprSeXosEmB6H48nMvbjTSlWa
 jh+lUkOyGohATV5co7jCzZqOTg==
X-Google-Smtp-Source: AGHT+IHewYTlmukZ7j8Py2fWQa6DAFDQV1qRAq6isibXljTIUyQccskbEvvt7QoCi0pXnomtGzZTwA==
X-Received: by 2002:a17:902:d704:b0:1c9:c579:d27e with SMTP id
 w4-20020a170902d70400b001c9c579d27emr7847710ply.52.1697207535154; 
 Fri, 13 Oct 2023 07:32:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.32.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:32:14 -0700 (PDT)
Message-ID: <45b8bccb-66bf-46ba-b2b2-7ef48abde5b1@linaro.org>
Date: Fri, 13 Oct 2023 07:32:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] target/riscv: Move TYPE_RISCV_CPU_BASE
 definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> TYPE_RISCV_CPU_BASE depends on the TARGET_RISCV32/TARGET_RISCV64
> definitions which are target specific. Such target specific
> definition taints "cpu-qom.h".
> 
> Since "cpu-qom.h" must be target agnostic, remove its target
> specific definition uses by moving TYPE_RISCV_CPU_BASE to
> "target/riscv/cpu.h".
> 
> "target/riscv/cpu-qom.h" is now fully target agnostic.
> 
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/cpu-qom.h | 8 +-------
>   target/riscv/cpu.h     | 6 ++++++
>   2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

