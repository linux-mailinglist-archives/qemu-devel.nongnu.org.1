Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8677C7DC7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:39:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBnu-0004ka-BC; Fri, 13 Oct 2023 02:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qrBnk-0004kG-Re
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:37:36 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qrBni-0008AL-Oh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 02:37:36 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so2972812a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697179052; x=1697783852; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JTTktyRt5LJ1ZpecwVd9SqwAsMX9yluoJGv75RIwSN4=;
 b=bCE0GYRl5tpJsRUwP3zWDOgdBRp/3lmHJ9iCtiNn5Tj3YB3QI8U/YubhIn84R6LlJt
 3FpOEtjUphFu1GC+SVAoL/l5kA+mtKYywGFnFmwkuqco+cf9DomNJZquNPwYA6eAmlxt
 sQ3h2rk+vIHn/OPtbM9M22hTv3fuliqHaTJhvd325QWsphW369eDT+2XTu8EM+39Ku85
 ICXfxCH88Xq8ysTNhdNxx/9oQxwl3ByEOIJGKjjxGs1Sus7IriXD+1GRie7L4U1BEuBE
 KY39WSnl3QQ+e1R2lpwZKZMIiif7ChImyxkcxuMshqkptA4ZxUD5YqNBDCD2nE6tnN0H
 md9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697179052; x=1697783852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTTktyRt5LJ1ZpecwVd9SqwAsMX9yluoJGv75RIwSN4=;
 b=SV/DMbxZecPcQa2OOVZ7Ks6d4snzOc/V/Oz+M0VCefz77zR9MoPygGq0u4FSP5w11U
 w4mG/EfPx1GHcVdY8EbYOORqvp7pLLMfkem8m+GYkdE9CriZqkHz8cFUY7rQL9yWYKvA
 hzZ2XPa4Y/p8jM3SAFwDkTbyUUqqg8hbLl66iy0PwMwiR3N3KavuhEPjJtVuIweOrlvm
 MaUps9p+Rnszflvl9r18/qk0V4X5L1XfE6QKYUcvmNbPP+ZS3levBLIMu1puNOA4Qp8Z
 AgJ1bvnc/kQM9USR+K31iOrJ9U5oF99jVJSZlm2wE5zTQpzmyxxglxf6AzlWyNFz4d8k
 wF7g==
X-Gm-Message-State: AOJu0Yy7JEGKHwPVNsESG3UBujqOgR4bI3xdIEjulD0fF/nRrCrCCvQs
 1tPW37UL0ZSBFr26KmGs1aqs5w==
X-Google-Smtp-Source: AGHT+IHzDbQq3hD4QRBBpK255an6gEDXtDDdDvzoexPy0olV4UCgceQ/4u4a+IALcOH96VnHM0eFag==
X-Received: by 2002:aa7:d94e:0:b0:527:fa8d:d40b with SMTP id
 l14-20020aa7d94e000000b00527fa8dd40bmr22102825eds.26.1697179052343; 
 Thu, 12 Oct 2023 23:37:32 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 cy7-20020a0564021c8700b0053de19620b9sm2756616edb.2.2023.10.12.23.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 23:37:31 -0700 (PDT)
Date: Fri, 13 Oct 2023 08:37:30 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH 0/4] target/riscv: rename ext_i* to ext_zi*
Message-ID: <20231013-f1376faaa53cd1336bfe7233@orel>
References: <20231012164604.398496-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012164604.398496-1-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52c.google.com
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

On Thu, Oct 12, 2023 at 01:46:00PM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> This series renames the following internal extensions flags:
> 
> ext_ifencei, ext_icsr, ext_icbom, ext_icboz
> 
> To add a leading 'z':
> 
> ext_zifencei, ext_zicsr, ext_zicbom, ext_zicboz
> 
> This was proposed by Andrew Jones. The motivation, in his own words:
> 
> "I'd prefer we name the booleans with their 'z' to improve grepping.
> When one wants to search for uses of zifencei, I imagine they're more
> likely to do 'grep -i zifencei' than 'grep -i ifencei', particularly
> because the 's' is maintained for S extensions. "
> 
> 
> Aside from that, these are the only 4 Z-extension flags that don't use a
> leading 'z' in their name, so there's also the benefit of making
> everything equal.
>

For the series,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

