Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404D7DDE55
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:20:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7OZ-000081-5b; Wed, 01 Nov 2023 05:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7OX-00007P-HM
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:20:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7OR-00027a-7b
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:20:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4094301d505so22172805e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698830405; x=1699435205; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xBjhJ5h56RysEJavvjefa4FFMqiMf0Olmr+Ynb5EgOk=;
 b=d25o8Rnbu8fjGKazQl6XmXd8sS1irglqq6Es+RrE2jpwakH9uqce1M9fq8u56D2Aty
 azNCZ+cJWPtbtjUy3J9u0vRbiZSNiP3O18gSmGsHgQhePWqUvUaEqpSNAnKE8Ne7Y9pM
 4dQsENgvZKI7R0MZ9aoUGX49Mvqf5CV8u0hxGi0r12wsnz0B/uoz5WPt8ejJP/YFo+7U
 U1eusaaFTl67PUqduRDeoyNO4eAZeFajbreDCQoWECW/XuZU9SI9oJSOSL2E5UGMIpel
 6woTNFCF5EZFol4CiQZhf7M5LDV5IKwdEN0ylTrRVhWjmQgiknB/IsF2lojVCmt0V65E
 uaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698830405; x=1699435205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBjhJ5h56RysEJavvjefa4FFMqiMf0Olmr+Ynb5EgOk=;
 b=Bv1c9DqIY2M9o17fM4xt9iMkB11vWwVAa7biNIVcDRdw8wQ4Azmc8t30zufeq74Fkn
 CbHX4clbbPcIpRC5q8CzFLNbP7lyh9bxgKjr60VCApd5ioSnW7/BHZGj43o0stK65cpr
 hVA9IPXNvY8EP2e/mW952uYrjBm7Z/UagmucTXntIA02dNF01J1GlQCJVpF7P9HSiv7z
 HlSW6vmGIBacYOckArWagVp9oUyagJ643C8au8c9cUS3vNYPXGsTTFiR2iP1i49JSt02
 G3ceo2q8FpXrC9X85ECROgqtGP3qBGYEDMOfGKFek3/fNERu/3A/7rsUOV2LUbhQE9Zw
 T5Ug==
X-Gm-Message-State: AOJu0YyljsFjliP8DeERWPwq5sfta3Zh9h9C5x+OSDRjXIOVGhgyonIq
 uGmq2pfrj6Dnh1dou+wnoDABcw==
X-Google-Smtp-Source: AGHT+IG4GeJ0/INF8AFnrSQgEUfhPwgwUkZaUoccIFuT76bP5/XrDK91exdtyTU8pz5LhzwDJjfXQw==
X-Received: by 2002:a05:600c:198a:b0:406:8496:bd8b with SMTP id
 t10-20020a05600c198a00b004068496bd8bmr12993942wmq.9.1698830405650; 
 Wed, 01 Nov 2023 02:20:05 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a05600c444c00b0040641a9d49bsm886889wmn.17.2023.11.01.02.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:20:03 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:20:03 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 02/16] target/riscv/tcg: do not use "!generic" CPU
 checks
Message-ID: <20231101-ec7856944e5893c9ce4c536b@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-3-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031203916.197332-3-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Oct 31, 2023 at 05:39:02PM -0300, Daniel Henrique Barboza wrote:
> Our current logic in get/setters of MISA and multi-letter extensions
> works because we have only 2 CPU types, generic and vendor, and by using
> "!generic" we're implying that we're talking about vendor CPUs. When adding
> a third CPU type this logic will break so let's handle it beforehand.
> 
> In set_misa_ext_cfg() and set_multi_ext_cfg(), check for "vendor" cpu instead
> of "not generic". The "generic CPU" checks remaining are from
> riscv_cpu_add_misa_properties() and cpu_add_multi_ext_prop() before
> applying default values for the extensions.
> 
> This leaves us with:
> 
> - vendor CPUs will not allow extension enablement, all other CPUs will;
> 
> - generic CPUs will inherit default values for extensions, all others
>   won't.
> 
> And now we can add a new, third CPU type, that will allow extensions to
> be enabled and will not inherit defaults, without changing the existing
> logic.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

