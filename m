Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8374A7D7185
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgWX-0001iD-LP; Wed, 25 Oct 2023 12:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgWP-0001VK-Bm
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:14:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgWH-0006eT-Uu
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:14:12 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so9231583a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698250448; x=1698855248; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fXop011peQW4iG59wCJj+9d9E4GL3D2Y+4Otu2WCPug=;
 b=ZXYOGf6AyBWZFCuN65KKgv27DRauxDf2LSLuhVDtWgsQRygMKwZ4xltz2ee5vWAX3i
 mvyQb8XUhJgjACTcOqycYuzjZyQq2BBJPgPc5Rgxay2qNmp4YxKGDZCQRD812acfZ3K6
 vUbs+bbPUH/1m075U7bnuCoyk7B4FpCtkOq3t+7mH0sT3CittaR8ksKnZOC/068BSMjm
 Egm10D3XWb1NeuH30mCkm3uOgQqihiHH0b4s6ehYHcVQIsQ70m9GdFK39cl7357QrtHl
 QUwSDJOXSQbyJ21QEctxQvwQQtIuaEiBR6RNzw0ANft+Ab3lwzE2AdIKRgIleI7Ps43F
 iuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250448; x=1698855248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXop011peQW4iG59wCJj+9d9E4GL3D2Y+4Otu2WCPug=;
 b=jNTPDITQf2O/ppapWyY5LX9VWRt84u92TySJJDQvmYVIEG8XpgTDjyayWOcr5o+7Vo
 8sLVTBY64xH1s/wEa0nkw2ciwZGH2c+HesBkIp50yy2dwK0QU2Tgzciu5Jw8YAx3UPB5
 LQn16ArExRNKidh7tgTzyDHDqfK/YY9Jsgk7B8cU1LIwn+2Ib1xH4ref+91ej3SXuGh1
 ApHc1OhRfNV/dWI5USX0JRtCUCQ+NTPLmArs12VXT0BgsspXlfCSzJr5/O2HcK4soA6m
 WqO3fAV9T6EX+LHOXZ+6qOhP08e9N0F5ojQ7dxcmfDfzFQYhP1GyorgkP+OWkz29Qpmq
 qK0A==
X-Gm-Message-State: AOJu0YxQ21aAkB53U6ksZgjFKoEFUiHNpyUSdH7UAvHGItKChBK3Q9aq
 qo3adXg7NOUoIwjvBemG5dpSSA==
X-Google-Smtp-Source: AGHT+IH7iv9XobPVuyisLLsfDg9bByD1EUu+BBp0UY6p2ybaLINE8RpuP61FI7sX9NV4eAtVpU5mdw==
X-Received: by 2002:a17:907:3e1f:b0:9bd:a65e:b594 with SMTP id
 hp31-20020a1709073e1f00b009bda65eb594mr14563498ejc.3.1698250448173; 
 Wed, 25 Oct 2023 09:14:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 26-20020a170906011a00b009ae69c303aasm10087066eje.137.2023.10.25.09.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:14:07 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:14:07 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 4/9] target/riscv/tcg: add MISA user options hash
Message-ID: <20231025-c1044818992ebc741dc8186b@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-5-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 25, 2023 at 10:49:56AM -0300, Daniel Henrique Barboza wrote:
> We already track user choice for multi-letter extensions because we
> needed to honor user choice when enabling/disabling extensions during
> realize(). We refrained from adding the same mechanism for MISA
> extensions since we didn't need it.
> 
> Profile support requires tne need to check for user choice for MISA
> extensions, so let's add the corresponding hash now. It works like the
> existing multi-letter hash (multi_ext_user_opts) but tracking MISA bits
> options in the cpu_set_misa_ext_cfg() callback.
> 
> Note that we can't re-use the same hash from multi-letter extensions
> because that hash uses cpu->cfg offsets as keys, while for MISA
> extensions we're using MISA bits as keys.
> 
> After adding the user hash in cpu_set_misa_ext_cfg(), setting default
> values with object_property_set_bool() in add_misa_properties() will end
> up marking the user choice hash with them. Set the default value
> manually to avoid it.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

