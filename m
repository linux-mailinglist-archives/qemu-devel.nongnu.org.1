Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9181C437
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 05:40:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGXL4-0004a7-0V; Thu, 21 Dec 2023 23:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rGXL2-0004Zy-0T
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 23:40:44 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rGXKz-0008Jd-TY
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 23:40:43 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28be024282bso995890a91.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 20:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703220040; x=1703824840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bdXhCiT1frXdCTamKyXnEQdzGUhWCebSnAqW9uzXk18=;
 b=ir8GVlUO5+jq7JA/IppkYRhR2/TOm+8uP+KzPx5QaW1j9l77dVbVrffLVWglSm8V/K
 R8/GBiFMsktvySzKlecCxpXt+KN7JMp0jZ2oQWp058gfEEK5ZZ43R51OSif+S94HrFqz
 91Rw4S4wy7rzro/ibdTBD5AO2sSmGIUCV44SJVP2JP00cLO+00gq48NG+bTSzbg1rio3
 Cdgyrez5RUI34SGqP5BhIanLD7EINUB7GmcUwDcRRb/JehISg4vmIw85YXSAKcYGOPdc
 aMJvlXl0rNZMUkwm/QsbjbdKB9rEWxSnZJIT6xj2Zr01ZzIUc1PBuWxPS98AVmPKEouO
 VO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703220040; x=1703824840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bdXhCiT1frXdCTamKyXnEQdzGUhWCebSnAqW9uzXk18=;
 b=RP885iuCFtdpNOPfOli0c09nKv8nDeonYpG1alzj8GZGTV11BZJInOs4DAATWBt2sX
 Jx3ZbGWf7P1sWq0FZhoVyK0W/E4RRP0lW7X+RNuWKvjvaIVXXW4gz1MmfG+XB9splBN/
 Ls+HxDSBV6+GeTe4U0tdgd5vz6YsvKtO8DX8Y8YhS1MfzNeDz+kPfsqcWEmR+RBZZpTZ
 WlkuLYVPghVbnfin1uWK+fmhwJpFbPD4PpYsqGQheRgNPqV464y3MemU+GIslD1pWO1o
 F7QNHe4iR5OOf3OPUw14p7UExRArcaUd+HImPiSaRPR+ZWZcoThJ1O2GphZE6CpkkB0n
 DSUg==
X-Gm-Message-State: AOJu0YwF49ljQ6tZYzTpdOFbuuv/xbkPc7Kk6VHZuJgPCN9vW3V6xRLf
 nRj6wmGNtvVX7tJRbfyrVTUeAhxAmxFfgQ==
X-Google-Smtp-Source: AGHT+IGa3k/4MeyUvDKJzhgfSSczeie6SsYTF1sKK7CfbE6bzQ9nQ7a7TmOYg/EzIxi2SYYObVSFJw==
X-Received: by 2002:a17:90a:3ec7:b0:28b:8137:e6df with SMTP id
 k65-20020a17090a3ec700b0028b8137e6dfmr515829pjc.16.1703220039969; 
 Thu, 21 Dec 2023 20:40:39 -0800 (PST)
Received: from ?IPV6:2001:8004:5170:1dd0:f3d2:7d7a:220f:5fe7?
 ([2001:8004:5170:1dd0:f3d2:7d7a:220f:5fe7])
 by smtp.gmail.com with ESMTPSA id
 q61-20020a17090a754300b0028b41108ed9sm2897126pjk.50.2023.12.21.20.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 20:40:39 -0800 (PST)
Message-ID: <18451041-c186-4e33-be31-3bfd4cf5b401@linaro.org>
Date: Fri, 22 Dec 2023 15:40:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] target/riscv: move 'cbom_blocksize' to
 riscv_cpu_properties[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20231221175137.497379-1-dbarboza@ventanamicro.com>
 <20231221175137.497379-12-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231221175137.497379-12-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 12/22/23 04:51, Daniel Henrique Barboza wrote:
> +const PropertyInfo prop_cbom_blksize = {

static?  Same for cboz in the next patch.


r~

