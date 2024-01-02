Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E73821E77
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 16:13:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKgRQ-0002zf-Or; Tue, 02 Jan 2024 10:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rKgRP-0002zV-Ms
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:12:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rKgRN-0001xh-0F
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:12:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d76923ec4so33814235e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704208342; x=1704813142; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ltAD2reCi8OLeWksla404AxOzdE3eOZ5sOpyHL6yi1k=;
 b=Ilr/ICOS802k2JypX6kvqbwyADwmH1EiDCgQOz2GIvyX8ns2qlkYI9Sk9ke62U31rq
 WXBhK8IHg+9EBxo/cjYXE1SCwjhvRcue8yvMhCDW4tRgAPHuWeDdZSV5BNm6L+KX8jns
 4tP+wugONEmGwBlrJw7m2K5IrG60yH9xtn2ij82VKam2YjaUEAhbHv3OzQKxw+rlwsdP
 P7pxgvBbOILutXmKlaepI/OK/ufyw5bC1hjAkVq/aOwK+DsglB0acEovFCi6gO413mF/
 7MfepMp1MAuZ82K0Ll9/zxZmE/8U+70rYGKDDDXtq8knHMnwNtLK7yA1qaYNZQyeHdrd
 361A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704208342; x=1704813142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltAD2reCi8OLeWksla404AxOzdE3eOZ5sOpyHL6yi1k=;
 b=HiZo3clFA9sV/KRfdunbQglets5UGaXtJUR1eyJVml6NlRfLInh6mZjZgKTU1hj1Jd
 fD2haQpYBN2whhUcVP80rEaoe2P2SGba35Wbiq5GFPl3XGlrBaWZBUtq5emOjSn2zPWS
 z2R04GubZBbWngmIRVyULB9JPTrBjYZQNKieOSU4jRXnR1JWpQWbVuTmktkAJmmCLYvS
 y3V4dZNg4tE97jIxW7vVKFmK8Ih6V6wZSYqUfAIGvtGKo4mI9Rf+F50V/w/SPaGdaiI5
 o4w1HXWvbi3srQIF8obzMlzIK9qwG3tGdugqm2W0PewyJjSevx24N/gDyGKL+J4yan2P
 M93Q==
X-Gm-Message-State: AOJu0YzdpDpOLxLeXACnmajw8ewtM5DZC+uLUnZDH3d12AtQHvX/UTjI
 rZPjBAmi6ytUkZxOMxtPv5JsvW4kk286uw==
X-Google-Smtp-Source: AGHT+IHkQDIdPkoglL31POYEajFYwKGYQisQBLYF04BABilsKdNKdPHOdX4B89bgiFUvCFlcwEHTLw==
X-Received: by 2002:a05:600c:520c:b0:40d:8a04:a134 with SMTP id
 fb12-20020a05600c520c00b0040d8a04a134mr896655wmb.79.1704208342508; 
 Tue, 02 Jan 2024 07:12:22 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 fc20-20020a05600c525400b0040d6e07a147sm18861462wmb.23.2024.01.02.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:12:22 -0800 (PST)
Date: Tue, 2 Jan 2024 16:12:21 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: Re: [PATCH v13 00/26] riscv: RVA22 profiles support
Message-ID: <20240102-72dbc203ded50b48a3aebb76@orel>
References: <20231218125334.37184-1-dbarboza@ventanamicro.com>
 <a3f0392c-6a1a-4d48-8d55-13348457c345@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f0392c-6a1a-4d48-8d55-13348457c345@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x334.google.com
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

On Tue, Jan 02, 2024 at 08:40:48AM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> Drew brought to my attention the following post on the tech-unprivileged mailing
> list:
> 
> "Architecture Review Committee meeting minutes, 12/19/23"
> https://lists.riscv.org/g/tech-unprivileged/message/611
> 
> Second paragraph mentions:
> 
> "In response to some recent discussion in the Apps and Tools HC about how profiles should
> be represented in GCC/LLVM, the ARC provides this answer: compilers should use a single parameter
> for an ISA string.  An ISA string begins with either a base ISA name (e.g. rv64i) or a profile name
> (e.g. rva23u64) and is optionally followed by additional extensions (e.g.  rv64imac_zicond or
> rva23u64_zfh_zicond).  If the ISA string begins with a profile name, it is equivalent to
> replacing the profile name with its mandatory base ISA and its mandatory extensions; any
> optional extensions in a profile must be explicitly named if their inclusion is desired.
> ISAs are sets, and concatenating strings takes the union, so redundancy is legal (e.g.
> rva23u64, rva23u64_zicsr, and rva23u64_zicsr_zicsr are all valid and equivalent)."
> 
> The takeaways from it:
> 
> - this implementation is compliant with how profiles are interpreted, i.e. a profile is
> considered a set of the mandatory base ISA and mandatory extensions, and any additional/optional
> extensions must be explicitly named;

Yes, it's good QEMU's RISC-V CPU model command line will be consistent
with the above paragraph (and then presumably with RISC-V compiler
"ISA strings")

> 
> - our ISA string format is also since we use the base ISA name + extensions format already.
> This series don't  change/add anything in this regard.
> 
> 
> If we have enough demand for it, I can do a follow-up to add support for the ISA string
> profile format. I.e. this:
> 
> $ build/qemu-system-riscv64 -M virt -cpu rva22s64 (...)
> 
> # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rv64imafdc_zicbom_zicbop_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zfhmin_zca_zcd_zba_zbb_zbs_zkt_svinval_svpbmt
> 
> Would become this:
> 
> # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> rva22s64

We can't do that. The "ISA string" referred to in the above command line
isn't the ISA string specified in "ISA Extension Naming Conventions" of
the unpriv spec, it's the string given to the compiler to tell it which
extensions it may assume when generating instructions.

Thanks,
drew

