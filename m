Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4982E2B6
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 23:48:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPVkt-0008Pg-8Z; Mon, 15 Jan 2024 17:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVkn-0008NN-2l
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:48:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPVkl-0002Lx-7A
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 17:48:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d5c1c1cf58so12324825ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 14:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705358902; x=1705963702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8BcNm4OkgiEyC2mPtuoUrCmMWzBMZ0qH1fxINjOp72M=;
 b=GTH6lKjZaN/UXRMmKcfQFguh92S0N2Zb5/6Q5Kc7yk6U5b+owH5QY0uu9lePkiDpER
 r1X+EGhupk/Y+k1EkIHD6BdZT/pl0lctWFZFi3JEtOwzPs4r3y8Gex//cvG06kUC8BoV
 hDXWJyL+SfrzY62+fd78CK/W719ArmvqfraduQ4C4b8e0LzVIMh2bi/vsZ56HnfB7Z8g
 fEVZfF3AYFxA/Ejm9UAnsXTIrDTHSQWcJQpOgHPr67fHcjKjCNZxqp5AphYWPouvUKg+
 cXX29qkOEIwSU51rdieIEgEHAmOT4u3xvAHPWEOUH+j1SMit92zmDNixXN+I3Hs3d1cG
 yylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705358902; x=1705963702;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8BcNm4OkgiEyC2mPtuoUrCmMWzBMZ0qH1fxINjOp72M=;
 b=uNFVCxEmBp6XgZeN1jf8AH62uv/QIBtRxb+utG2FMG7v1dKXx9GJxKLTQ/YehA8Uif
 YwfSMCcB03TDFttlpD/noPE6mSyG/FdhIYAWF8JUqUb7+DboK89SZqS6ts082gwzMGxv
 W+77WfM8SFioqNUzDkzfqauovl0hz8nWpTogsc6iihFkhuv1SK4HYgbRjTHoIZuvXxYk
 wuLgQGubjylegyWbCKWKcOM3y1yPiH+Al2mTKe6nf2I1PDPKTxykJ68/z7bpC6Wr+iHB
 bUrmf8tfREAyiWFd23+/DprmYYdInu+i+btasbagkBl4v/P2j/XwpDNftLEGjH7ttOH+
 tKPg==
X-Gm-Message-State: AOJu0Yyhrqy3JuRTqBsoMyS3ACIQEqGmyzj9ClWqbGqj/uXcWO3Z3Mmh
 q/xmjQ6UEBbUs4a1yobJluhh6oY4P8OCqw==
X-Google-Smtp-Source: AGHT+IFwKxbmffZu4sFlEBXEXB5WgkKgDLkh/AYJImpevFIUW71HKYI95H/onxlHmGCFWsnROsZd2Q==
X-Received: by 2002:a17:902:f54a:b0:1d4:e6d0:34db with SMTP id
 h10-20020a170902f54a00b001d4e6d034dbmr8612289plf.19.1705358901770; 
 Mon, 15 Jan 2024 14:48:21 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:85fe:4dd3:358e:ec4?
 ([2001:8004:2738:1dd9:85fe:4dd3:358e:ec4])
 by smtp.gmail.com with ESMTPSA id
 j190-20020a6380c7000000b005b529d633b7sm8583022pgd.14.2024.01.15.14.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 14:48:21 -0800 (PST)
Message-ID: <6265ec79-151a-4e01-9e59-29b1d27de318@linaro.org>
Date: Tue, 16 Jan 2024 09:48:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] target/riscv/vector_helper.c: use 'vlenb'
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-8-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-8-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Use 'cpu->cfg.vlenb' instead of 'cpu->cfg.vlen >> 3'.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

