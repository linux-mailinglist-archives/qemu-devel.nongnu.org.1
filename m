Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D17D7186
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgX9-0002H5-RH; Wed, 25 Oct 2023 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgX4-0002G1-CX
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:14:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgWx-0006rK-V7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:14:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso9014270a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698250490; x=1698855290; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aTWBnDvBqbBrRgUKRIpeRX4suZ0xDLWPDF07b7QbSE8=;
 b=D8dnsbrjx9du4LohsDd2qB5Tm95VnSpECfY6AXzdomkirEj+0LFl0A9C894BWS7liO
 SLitDVWlkaDJcrQPb7R4YikaFFbKb2AxQBMDXxzVxaxH1+v4Rr13qv1C7Y1BTWknO5Jl
 WLYanNrlLgY5IuLMxOgCPnOeh/DKktqKKIo5Hp+bDJuHnFjdO1DHbVBcKFouQRW9KY4U
 0F0eC/ELmMd+p9DEZUwAeRlfFc6FYQQI+3nSoORkx2VObSgvs+b0ASwPrx72fmpbm78b
 XB2EYDJhrK4SbUn+rws8k9SSvzMdnQMTdZ4Q10PkIG/f1RGXJzw5VApkfUFzA78LiwcT
 oURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250490; x=1698855290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTWBnDvBqbBrRgUKRIpeRX4suZ0xDLWPDF07b7QbSE8=;
 b=HyN8OZNYJE8RpNBGLKth+bxnoiYktEJnQidEYsOFeSMJ5gY7zZbfXtJn2BlWuHvhM3
 7IUXokq70WJVSXhaOtTThWLy6Sks1u8r9+rOhMJPgjoW2/eWgIfsYRhXBLm30dPSB+U5
 78u8ItiVLWr5YXGAjDn7fyR5j3zg8LpbSzgxKWm3cw0mHAG8h+mAOZKZpNiHHQ5XJnKM
 RmJYGd/cphzG5zvWKrw3+SnGMrXVTkLFCEGoOHJWhSfiFqYeF59SB/bH14konwuVlB3R
 DkPKl3I6yZsbpsgznemspdd1oA7tI3s1ieAxrAGinVdFWXqqJXG/WIVDCw27GZ6q2pZN
 IrjA==
X-Gm-Message-State: AOJu0YwHlGtN9Jj7d9PWRChJIckBtShKkKhaBbV15EFxL1ZEZDbAGHU9
 Twed0EArmAxygmnDCA0rh4vfAQ==
X-Google-Smtp-Source: AGHT+IFPC6lq+mKqQ32M5nggvNq/qN3CnSzMP7Eg7OUTnOpbbrceVWkUWVN9iac8qbEO2idsPT5uhg==
X-Received: by 2002:a50:cbc4:0:b0:53e:3a80:e6f1 with SMTP id
 l4-20020a50cbc4000000b0053e3a80e6f1mr10844815edi.32.1698250490259; 
 Wed, 25 Oct 2023 09:14:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 a62-20020a509ec4000000b0053e5f67d637sm10004697edf.9.2023.10.25.09.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:14:49 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:14:49 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 5/9] target/riscv/tcg: add riscv_cpu_write_misa_bit()
Message-ID: <20231025-34515daeb452f08a3a421b88@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-6-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-6-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52f.google.com
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

On Wed, Oct 25, 2023 at 10:49:57AM -0300, Daniel Henrique Barboza wrote:
> We have two instances of the setting/clearing a MISA bit from
> env->misa_ext and env->misa_ext_mask pattern. And the next patch will
> end up adding one more.
> 
> Create a helper to avoid code repetition.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 44 ++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

