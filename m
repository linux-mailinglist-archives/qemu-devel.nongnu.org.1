Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3767D71BB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgjq-00024C-Su; Wed, 25 Oct 2023 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgjp-00023v-3k
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:28:09 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgjn-0001GK-HO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:28:08 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso874573866b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698251285; x=1698856085; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3SI1HDQRYn5vEk3Jxs0ZfjcgDJQfz/8c5MwAMN+n82E=;
 b=nhhyAbe2YE93dx/Smf/y7J/cDte9Rqzp9ZlwKCQ4mhsu6iSc6h9R+u1hJVT/Jctiax
 AnJ/dKMx/+w+0LqjygEcrgUPti0/8DPWk6jTCCevL2gcSY3sYuAGePb6gcrerTWW8o7l
 FQ9gv9SyVa1rlFWa23EU2VlZ+iH3tyV3JeGDE37/DhGF6Hsyzq2pjrDTUlKcFppNV/rk
 r6ehFmhx1hZ7t0HCzdOvbG/bSuJWT02+Xdvkn+o3OZVZBE8Hk7QysPlUFgfOvFBpprr5
 dupPUp1GBqF182HIYXlltc6gH3BmNW0uDc4RNz+9YjuYPiY/APm7xSWpDdrjgTj+i+ps
 A0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698251285; x=1698856085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SI1HDQRYn5vEk3Jxs0ZfjcgDJQfz/8c5MwAMN+n82E=;
 b=RUFseUoh91ily6ZdrKiqwfDWuvzMXs3Qv21y5uDwpSN5hAo9D2PmWkylxM1MkJBgXs
 IlhjQD4iV8+7zvS4mn9QAHGvgTgmXYQkY4YeQmHEdiFCe3loAeUhJ1tCuPZrk7OlM3bE
 8gmVuIJzG+Hwac2DAhw5K21ZfBzKGcBFEdxAhERDTiM4qtEqe664rqQPDi0VHBmz2E+y
 v2qCei4hJiqVC+aopbGFZd3Xeb0wRuXz6vSP+BC1IBAOIPmsR/NtQIgW8vc+KQVfoQWt
 3G39rj0fwIoBqUmJ4iCi4ZlpTOh+APVzN2vhQ/9KeLCB48Z9SIHeAw6b8GtF/rvRQpc+
 1Dng==
X-Gm-Message-State: AOJu0Yzd/61kI1nM/4qkvfUPMRaZhbahdjDGiuZTB33Q9YvuRNB78ug4
 3TXLVH7kW9oKk3GmTN1kpvo61w==
X-Google-Smtp-Source: AGHT+IGllsRs2OU5FQV2P4rzbLWC6hU4Eqn7yaG67yLUJZ+XfURruSkQ8Q6cqlNdcZ4easqKnZmGBQ==
X-Received: by 2002:a17:907:980c:b0:9bd:a75a:5644 with SMTP id
 ji12-20020a170907980c00b009bda75a5644mr13607887ejc.16.1698251284915; 
 Wed, 25 Oct 2023 09:28:04 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a170906d29200b009b2c5363ebasm10088849ejb.26.2023.10.25.09.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:28:04 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:28:03 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 9/9] target/riscv/tcg: warn if profile exts are disabled
Message-ID: <20231025-8fa7e3ae7b0d41ae96e2e2d1@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-10-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-10-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62b.google.com
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

On Wed, Oct 25, 2023 at 10:50:01AM -0300, Daniel Henrique Barboza wrote:
> Enabling a profile and then disabling some of its mandatory extensions
> is a valid use. It can be useful for debugging and testing. But the
> common expected use of enabling a profile is to enable all its mandatory
> extensions.
> 
> Add an user warning when mandatory extensions from an enabled profile
> are disabled in the command line, like we're already doing with RVG.
> 
> After this patch, this will throw warnings:
> 
> -cpu rv64,rva22u64=true,zihintpause=false,zicbom=false,zicboz=false
> 
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zihintpause
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicbom
> qemu-system-riscv64: warning: Profile rva22u64 mandates disabled extension zicboz
> 
> Note that the following  will NOT throw warnings because the profile is
> being enabled last, hence all its mandatory extensions will be enabled:
> 
> -cpu rv64,zihintpause=false,zicbom=false,zicboz=false,rva22u64=true
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 57 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

