Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED18817CB4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 22:43:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFLNz-0003ww-8x; Mon, 18 Dec 2023 16:42:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFLNr-0003wC-PG
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 16:42:44 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFLNd-0002tV-Vt
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 16:42:31 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d075392ff6so26106195ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 13:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702935748; x=1703540548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdXgJLb8m17I6hAhaSrmUKe3l3vEoRUpd/gpx/q+FSo=;
 b=DDkV691mxIyuetPMrAL7ou3686oCWq+dR9H9RorDWxwE8wy//JbotT+KVKAi4O/YAC
 I66wViSLiiExV4MDayy611JELlnFdg3Vr7Ozvw/sMWs8GQWodh4mRmARjkuKaPpI6RD4
 KN3cvpAjSG5f7qgsP3mIiS4mnAydOkrbZGVRU8a1MgQ6dhaS4sFwVEWG5xICOTemEk3L
 EyBMSCqMMoFTl3aAPPLZ4YglwTOHfevb9G7jZyLh+NzFoeW9mXUBm1vuX4UrJBp3ULGD
 IkDcM/+6uEJVMe8BeC/TnBMzGrar8HoZBsF4U6sis9jnGqdYZIiNdGeDnDsBabGJyvAG
 jWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702935748; x=1703540548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdXgJLb8m17I6hAhaSrmUKe3l3vEoRUpd/gpx/q+FSo=;
 b=GsQgVY/iADlpuPKEBOGJVolp1HYOruET8gkDxCoyVW08jh/R5TcUpjINk2SSyBflkn
 cO4MteXN6OGZ9dSvqEWakgrRP1S2V+xd2uWG4vh6TgOoBL0PyeMGSjWufy5hxQY47PSZ
 9fZJ9a3ctal59nUYArugltph9fjwjBg00qzjTZ0rspDMophxqQ5L/5bOLCRj76UovsA7
 UVyoJJQ2X2b+BsgjSJ7cFFpdfzbwpaM+iDITXIjVc8y4tyyh+dHz2z02YwIQatPP49wi
 ihm0YtnaqHtwY/Vl7/Tpy/jeiiW/PDNvP0Fz3KkxPp/qR8Z76bJoZ7DV8EJYO/rAuSGN
 44sQ==
X-Gm-Message-State: AOJu0Yx6RbhWDAXTuRIRUAIKwjLTOYlzwosbiShw1XYBugNX2GBBied4
 A5TySRfif9yjjLHDTUnsjg4L4U3foZaMIg==
X-Google-Smtp-Source: AGHT+IE6Q+NG23Au5ghMw570AIhk6jEK7jCweZZ2am+21PHPcxjkzB8xoXYOMzrZnoDgi04KrEeIpg==
X-Received: by 2002:a17:903:27c8:b0:1d3:5612:e546 with SMTP id
 km8-20020a17090327c800b001d35612e546mr45002plb.12.1702935748376; 
 Mon, 18 Dec 2023 13:42:28 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 az4-20020a170902a58400b001b7f40a8959sm19429993plb.76.2023.12.18.13.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 13:42:27 -0800 (PST)
Message-ID: <969e91df-5c1b-4c55-aa31-942d32d314a6@ventanamicro.com>
Date: Mon, 18 Dec 2023 18:42:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv/kvm.c: remove group setting of KVM AIA
 if the machine only has 1 socket
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231218090543.22353-1-yongxuan.wang@sifive.com>
 <20231218090543.22353-2-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231218090543.22353-2-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 12/18/23 06:05, Yong-Xuan Wang wrote:
> The emulated AIA within the Linux kernel restores the HART index
> of the IMSICs according to the configured AIA settings. During
> this process, the group setting is used only when the machine
> partitions harts into groups. It's unnecessary to set the group
> configuration if the machine has only one socket, as its address
> space might not contain the group shift.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/kvm/kvm-cpu.c | 31 +++++++++++++++++--------------
>   1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 62a1e51f0a2e..6494597157b8 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1387,21 +1387,24 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>           exit(1);
>       }
>   
> -    socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
> -    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> -                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
> -                            &socket_bits, true, NULL);
> -    if (ret < 0) {
> -        error_report("KVM AIA: failed to set group_bits");
> -        exit(1);
> -    }
>   
> -    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> -                            KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT,
> -                            &group_shift, true, NULL);
> -    if (ret < 0) {
> -        error_report("KVM AIA: failed to set group_shift");
> -        exit(1);
> +    if (socket_count > 1) {
> +        socket_bits = find_last_bit(&socket_count, BITS_PER_LONG) + 1;
> +        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> +                                KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
> +                                &socket_bits, true, NULL);
> +        if (ret < 0) {
> +            error_report("KVM AIA: failed to set group_bits");
> +            exit(1);
> +        }
> +
> +        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> +                                KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT,
> +                                &group_shift, true, NULL);
> +        if (ret < 0) {
> +            error_report("KVM AIA: failed to set group_shift");
> +            exit(1);
> +        }
>       }
>   
>       guest_bits = guest_num == 0 ? 0 :

