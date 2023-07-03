Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0E745DC6
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:51:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJwp-0007aD-7l; Mon, 03 Jul 2023 09:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJwk-0007Qv-Ja; Mon, 03 Jul 2023 09:50:30 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGJwi-0007Ke-Oj; Mon, 03 Jul 2023 09:50:30 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-560b7ac3cbfso2973774eaf.2; 
 Mon, 03 Jul 2023 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688392227; x=1690984227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6s0X+p3NJh518O4lUTJ5eE8vRNrU44GwKeOsh/Qheo=;
 b=H7VDJZZWHNUj5PlPs+YBSmq2EtJrZJnmzbH51uIGTxyem09u8I0s9DsFQZ8oOCWpUC
 Ge2La0uhHQayR4/JEv4db2/M8ElFKpGHGP0faIbxj6TtdPaafW5c2MRw0JmjllmrF1gM
 hyFoyfAqdxqYgDAD2dxQ7pCnnXw0VMaoxzmykigCf2koRczc81zYWB+iLiazOaVRGl3z
 64xJ16hy5NRS4xQ928U5Gk5dKc5b/6enut97eOwrPfgUdANZcwmzdoGbtdJqFAscHTXF
 inpEF2Buhl4jUI3LglMBg3UMVUpqDukk6qDU589HSWCYIF4cvIZliv5pfQ41OM2zm1tj
 8HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392227; x=1690984227;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n6s0X+p3NJh518O4lUTJ5eE8vRNrU44GwKeOsh/Qheo=;
 b=ZVfmbMUB5pM0q9RPjwOwavcy7nNKdlYcJ5wzqDNq8Q3sJPkjDjNlk3hxXu92z7exOD
 uFKtiDPQLqLhFS0r4D+eU+NZiA/suXvSnTMcWncngMCNwVLWr/Fzls1KmTVzjRb9kqlC
 VL5reZzvD9PWKVdcavwF4WjaASm+Y/W9YdvFLK5s2i1II/+kIkZHqBIWfyTTK8zY4d0d
 oPLE/tDCYrywyw0LWS4l6vvSCy1eMfSjjmNM24OP1q+rZ3PChRu6i/s8xeGIV6/M95lv
 iVATHGJy0kKlcIIlyTXqqHDp6p1KgEiM85dq1Y9dJvgaDyIyT32LyfaO1UD19SR5GBfU
 FoOA==
X-Gm-Message-State: AC+VfDz34Bo0UuUFZpLHwya5i0v1yftYJw1IOpvTM5Z1Htw5BU6h+yPz
 YCcTridIFu/jpwLW4LPWEfQ=
X-Google-Smtp-Source: ACHHUZ6NkUvKNr7Q/ZL/wSRJvQgSr0lVNAnWEhEz89FiMNshD0lTV2yUiTlWrrusBL2OS31wmkfOjA==
X-Received: by 2002:a4a:1dc1:0:b0:55e:5c65:c6cd with SMTP id
 184-20020a4a1dc1000000b0055e5c65c6cdmr6453385oog.6.1688392227056; 
 Mon, 03 Jul 2023 06:50:27 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 e9-20020a4ae0c9000000b00565c6b61effsm3635155oot.23.2023.07.03.06.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:50:26 -0700 (PDT)
Message-ID: <dac5ff8c-3d9d-1047-c232-014b7d573c01@gmail.com>
Date: Mon, 3 Jul 2023 10:50:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Content-Language: en-US
To: Narayana Murty N <nnmlinux@linux.ibm.com>, clg@kaod.org,
 david@gibson.dropbear.id.au, groug@kaod.org, npiggin@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com
References: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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


Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel


On 6/23/23 04:25, Narayana Murty N wrote:
> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian
> (LE) mode. So crash tool fails to load the dump as illustrated below:
> 
> Log :
> $ virsh dump DOMAIN --memory-only dump.file
> 
> Domain 'DOMAIN' dumped to dump.file
> 
> $ crash vmlinux dump.file
> 
> <snip>
> crash 8.0.2-1.el9
> 
> WARNING: endian mismatch:
>            crash utility: little-endian
>            dump.file: big-endian
> 
> WARNING: machine type mismatch:
>            crash utility: PPC64
>            dump.file: (unknown)
> 
> crash: dump.file: not a supported file format
> <snip>
> 
> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> always set for powerNV even though the guest is not running in hv mode.
> The hv mode should be taken from msr_mask MSR_HVB bit
> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> the guest endianness.
> 
> The crash tool also expects guest kernel endianness should match the
> endianness of the dump.
> 
> The patch was tested on POWER9 box booted with Linux as host in
> following cases:
> 
> Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
>                                                    Memory-Dump-Format
> BE             powernv(OPAL/PowerNV)                   LE
> BE             powernv(OPAL/PowerNV)                   BE
> LE             powernv(OPAL/PowerNV)                   LE
> LE             powernv(OPAL/PowerNV)                   BE
> LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
> LE             pseries TCG                             LE
> 
> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory
> dumps")
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
> Changes since V3:
> commit message modified as per feedback from Greg Kurz, Cédric Le
> Goater and Nicholas Piggin.
> Changes since V2:
> commit message modified as per feedback from Nicholas Piggin.
> Changes since V1:
> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
> The approach to solve the issue was changed based on feedback from
> Fabiano Rosas on patch V1.
> ---
>   target/ppc/arch_dump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index f58e6359d5..a8315659d9 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>       info->d_machine = PPC_ELF_MACHINE;
>       info->d_class = ELFCLASS;
>   
> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
>           info->d_endian = ELFDATA2LSB;
>       } else {
>           info->d_endian = ELFDATA2MSB;

