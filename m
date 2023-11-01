Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B55657DDE32
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:13:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy79o-0005j8-OY; Wed, 01 Nov 2023 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy79k-0005iZ-Vr
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:04:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy79i-0007m8-PD
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:04:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32db188e254so4388398f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698829493; x=1699434293; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MO9B0R7Shwr827oL+bH7ZWxS0k7NUZgu+FJBW4q/RnM=;
 b=gpn35zsWzIqsg0idZxliUg82airZAzC/bneqiixfPZ2dyokH41CXhP17dfY1m+aEZF
 9Syg9HBgJjE8iUHGzcjYA163WM4+RvFQs9m6rb6zofzA6PYVWHb5ajHfj2U5mgpoG5t/
 nOOm8Q9HVtARpSyUxG6oU5tLQEYxXHGcN2jvHEDbfWbxRvGRpj7s1gkJOJf8e4/KZKDs
 1IpOFRnfj17Eb+vNrF+CrgWHTBihx2HWXg3sGenYkUgvLDSjTlFmuO7NWT02dJml675n
 84CWXvMpY+F4czfal6+hOOjBtYn5p9NrlQjQ/X2tBT2f44+KyaT6M89OUr/JsVhuO71e
 LbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698829493; x=1699434293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MO9B0R7Shwr827oL+bH7ZWxS0k7NUZgu+FJBW4q/RnM=;
 b=vtr21ojc+qCdk1WrUSwjNPfkATZRZgkouflSSFNfDieIvjiul4Rc8ZQeO00tdWwnJD
 KD0feHXfvXUr4VJcvyuFfC5yLQTPrmKtRmVeEDUBPSChF8wVFm+slAWRHq4HWUoBJgVs
 ZYXgsq2VNx65/wMgY1mo7RHM1fUjMINScw+c+JIE4AT/2uFAFubjyHDGd0o8DxGQrhjk
 VM4Z2E5jftvb++fWhq+076/ZfR5q+a/QNDG0XRVgJAXtc9ANyGPHrg5adheSDyYWZoNO
 3lRkE5G16jul02816zzavSHauMVb/xRE/2LmU1XLRpMJ4weEOFr7rsnFx9P6mBunq/t1
 4/RA==
X-Gm-Message-State: AOJu0YzXx9FN4mJZrX8JMbvsOMvM3aX0FXhwMmnK88lalTP/QBVODT2Y
 PJgVvotlxXb8casVCt8ZRmMTOw==
X-Google-Smtp-Source: AGHT+IHWR83/znWDYdB29ztl+VTRXCBfApccmwEHAjd8buLdweAolg/T0Xwt+jRoCgLBUxwd0kftJQ==
X-Received: by 2002:a5d:43c3:0:b0:32d:a476:5285 with SMTP id
 v3-20020a5d43c3000000b0032da4765285mr10939771wrr.31.1698829493084; 
 Wed, 01 Nov 2023 02:04:53 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a5d6706000000b003232380ffd7sm3631682wru.102.2023.11.01.02.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:04:52 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:04:51 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 05/16] target/riscv/tcg: add 'zic64b' support
Message-ID: <20231101-d3052159641c3d81a06d2ba5@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031203916.197332-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x430.google.com
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

On Tue, Oct 31, 2023 at 05:39:05PM -0300, Daniel Henrique Barboza wrote:
> zic64b is defined in the RVA22U64 profile [1] as a named feature for
> "Cache blocks must be 64 bytes in size, naturally aligned in the address
> space". It's a fantasy name for 64 bytes cache blocks. The RVA22U64
> profile mandates this feature, meaning that applications using this
> profile expects 64 bytes cache blocks.
> 
> To make the upcoming RVA22U64 implementation complete, we'll zic64b as
> a 'named feature', not a regular extension. This means that:
> 
> - it won't be exposed to users;
> - it won't be written in riscv,isa.
> 
> This will be extended to other named extensions in the future, so we're
> creating some common boilerplate for them as well.
> 
> zic64b is default to 'true' since we're already using 64 bytes blocks.
> If any cache block size (cbo{m,p,z}_blocksize) is changed to something
> different than 64, zic64b is set to 'false'.
> 
> Our profile implementation will then be able to check the current state
> of zic64b and take the appropriate action (e.g. throw a warning).
> 
> [1] https://github.com/riscv/riscv-profiles/releases/download/v1.0/profiles.pdf
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c         |  6 ++++++
>  target/riscv/cpu.h         |  1 +
>  target/riscv/cpu_cfg.h     |  1 +
>  target/riscv/tcg/tcg-cpu.c | 14 ++++++++++++++
>  4 files changed, 22 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

