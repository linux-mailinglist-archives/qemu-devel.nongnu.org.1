Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8587D2C76
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quq7L-0000xf-A3; Mon, 23 Oct 2023 04:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quq7C-0000wO-HS
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:16:50 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1quq79-0008R4-WA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:16:46 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so4321299a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698048994; x=1698653794; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ua6AplhSfno5kR4OGPkJ/zUoF3YsKJs/3C6w/z0590=;
 b=TfItSOPogz6DSHWiay47kSoPDmPVGwHDC8bzfmJS8BYfIHiXhH5XhAMGlKQyh/t5QX
 3OoEI3lPfljbnkhOTFS0GaQLy55cqd64gHPbPjprAABSytdrlJWpTP4wkENrQNNO+Lm4
 t/R1Cyx3qgrbJePA7BL/laIgmsSQ+GWFGqO43YKtUj0dWbIOPYiqdmECpOjB07MdXCKK
 zSIo+3PwZxJ8+U+oQhfl1xG0P0J63iL8EBeOgQx3vUtQGEhGzDlIPj8PVQHelKfJQMO2
 pd3nIUVtEX0Chc+pM0cvJoO4v1OooK/m+vi/WByrIOgBEZNKOYYIb9IwdFE/DF3nPBYx
 gEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698048994; x=1698653794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ua6AplhSfno5kR4OGPkJ/zUoF3YsKJs/3C6w/z0590=;
 b=KU+KQ+leAlJWh9ohPVuv+4FsI0bMVjcmVNilpULyYUOt9LsnEorWjaDyweGlIbNLke
 9WxQV2vZ2nSbh2XTbjCMLSw+MSnB4jDV1WUE39L47/gV47K/kmmdavRMsBxqR9PIp6QK
 bkCMHChAfM4TKkILYSXBwuGe6kd3T84zhvk6XZIplzy2FEoX87bQ7mNsDMLbTyJavkJ/
 ZHso0WQG+skwChKzSZb6QXA+cLgAB+lMJjQXp1F4vKXsMfXrlMK8XfJuUDExJnTUWvVK
 Wbj23dyCF+e0e2JBzUdh07GFGFovj2zFt6lBoEFNjsGwCvHQpJoVu2TkhCShHAbWWJHJ
 noPA==
X-Gm-Message-State: AOJu0YxCDRP+czMY2JY9gVtuphW5FlaJGZhy06griH6SDlOTVvfs0RVx
 69i0oCTjFOsZUl176SOcukLgjQ==
X-Google-Smtp-Source: AGHT+IFiT651CHqM0p8dQxbspG39MNPZdpSG9motMiw8PgXHx1uX7GC3vqh/E+e2zF87sA8QchyGjA==
X-Received: by 2002:a50:954c:0:b0:53f:6c6d:2e30 with SMTP id
 v12-20020a50954c000000b0053f6c6d2e30mr5976490eda.2.1698048994283; 
 Mon, 23 Oct 2023 01:16:34 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a50fc07000000b00534e791296bsm5896471edr.37.2023.10.23.01.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 01:16:33 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:16:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv/tcg: add user flag for profile support
Message-ID: <20231023-2018025adea3ffaebbbefe23@orel>
References: <20231020223951.357513-1-dbarboza@ventanamicro.com>
 <20231020223951.357513-4-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020223951.357513-4-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 20, 2023 at 07:39:48PM -0300, Daniel Henrique Barboza wrote:
> The TCG emulation implements all the extensions described in the
> RVA22U64 profile, both mandatory and optional. The mandatory extensions
> will be enabled via the profile flag. We'll leave the optional
> extensions to be enabled by hand.
> 
> Given that this is the first profile we're implementing in TCG we'll
> need some ground work first:
> 
> - all profiles declared in riscv_profiles[] will be exposed to users.
> TCG is the main accelerator we're considering when adding profile
> support in QEMU, so for now it's safe to assume that all profiles in
> riscv_profiles[] will be relevant to TCG;
> 
> - we'll not support user profile settings for vendor CPUs. The flags
> will still be exposed but users won't be able to change them. The idea
> is that vendor CPUs in the future can enable profiles internally in
> their cpu_init() functions, showing to the external world that the CPU
> supports a certain profile. But users won't be able to enable/disable
> it;
> 
> - Setting a profile to 'true' means 'enable all mandatory extensions of
> this profile, setting it to 'false' means disabling all its mandatory
> extensions. Disabling a profile is discouraged for regular use and will
> issue an user warning. User choices for individual extensions will take
> precedence, i.e. enabling a profile will not enable extensions that the
> user set to 'false', and vice-versa. This will make us independent of
> left-to-right ordering in the QEMU command line, i.e. the following QEMU
> command lines:
> 
> -cpu rv64,zicbom=false,rva22u64=true,Zifencei=false
> -cpu rv64,zicbom=false,Zifencei=false,rva22u64=true
> -cpu rv64,rva22u64=true,zicbom=false,Zifencei=false
> 
> They mean the same thing: "enable all mandatory extensions of the
> rva22u64 profile while keeping zicbom and Zifencei disabled".

Hmm, I'm not sure I agree with special-casing profiles like this. I think
the left-to-right processing should be consistent for all. I'm also not
sure we should always warn when disabling a profile. For example, if a
user does

 -cpu rv64,rva22u64=true,rva22u64=false

then they'll get a warning, even though all they're doing is restoring the
cpu model. While that looks like an odd thing to do, a script may be
adding the rva22u64=true and the rva22u64=false is the user input which
undoes what the script did.

As far as warnings go, it'd be nice to warn when mandatory profile
extensions are disabled from an enabled profile. Doing that might be
useful for debug, but users which do it without being aware they're
"breaking" the profile may learn from that warning. Note, the warning
should only come when the profile is actually enabled and when the
extension would actually be disabled, i.e.

 -cpu rv64,rva22u64=true,c=off

should warn

 -cpu rv64,c=off,rva22u64=true

should not warn (rva22u64 overrides c=off since it's to the right)

 -cpu rv64,rva22u64=true,rva22u64=false,c=off

should not warn (rva22u64 is not enabled)

And,

 -cpu rv64,rva22u64=true,rva24u64=false

should warn for each extension which is mandatory in both profiles.

Thanks,
drew

