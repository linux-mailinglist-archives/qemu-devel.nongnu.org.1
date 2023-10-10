Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB3F7BFBB4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqC84-0004oL-2E; Tue, 10 Oct 2023 08:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqC7r-0004kz-2k
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:46:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqC7g-0002WA-NT
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:46:10 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53da80ada57so476732a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696941963; x=1697546763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tS/SER2Ki3H7urIAoipZ7KoYvVtZSIygCxbsQ1IHwj0=;
 b=xv+WIH1EGZSM/psfuqIJUz5uZB6uRekQ4f3w8ASf7bhnnl5DwFqd01bFZuoiW44L17
 SlNV3hXgEgwJXYlvuowoON/8x8QQaBcOjcJQuSlrXnPClZQk+MTvAtWh5uQknSqpujtL
 gfYszQlnVorhIu2GYNsxbqgXjYOJ3zc3pQQ7AJv9GMH21BCXKTPpuii9MfQooI2xNEmR
 zbr2XSKw92f2BseMQXJadj7NAbHWz9sgv95eP+Q5SOcfhKu65jfiqjfM7bc1rM3rJ1Ru
 IgZfAqJoudhjJtK7SkFeHHp6QZtcH1shNikiILvR+BFQlHGwlcug4ry9QF22tpazdy6/
 o+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941963; x=1697546763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tS/SER2Ki3H7urIAoipZ7KoYvVtZSIygCxbsQ1IHwj0=;
 b=b7W7XKknBPfFqPN14zTszusOPgBdx5mFw9DQ4dcbMC8DyY1QZtR8n0P/mvuC047ruF
 1ZPXYllYziCVVDKfHnepP7LJp80I0oqI3fs1XtyloBxyP1OnWW0aO4F1hKr2fX4FBTca
 WwUTYMOo5t5bGnxIsiecUO6+ndg/tptfDSZ5S/iYvVm2BuPjIfp6RCLonxL3RW1D8mUa
 Sy7784eM/Po4ExjglopQyYr7FeyRHEajvnOqmlN726VJs4QRyVitEvQS2G6ZnfFfZi0n
 kYwQRMAfgpw5POwuR3a78F3xAzXk7EN9seIIFGX4U1J6wa7ao+puMaRPWKBWfBOmlFYx
 HdFA==
X-Gm-Message-State: AOJu0YwX/BZuxgySei4IxmvQ5wRYkIo5mfF6yJDLXw3wyXdAKru1eKVH
 cLgoJD6/vuUoLyvMXBJG4DibEw==
X-Google-Smtp-Source: AGHT+IE1mrnHi6OndDyfJ8Xp+MwQeEAq6AbRfuXWYf+7h06/FJXD6Lqo/v9i/KNA9ByhvBhpXfNOrg==
X-Received: by 2002:aa7:c3da:0:b0:534:8392:879d with SMTP id
 l26-20020aa7c3da000000b005348392879dmr16142569edr.37.1696941963204; 
 Tue, 10 Oct 2023 05:46:03 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 a23-20020a50ff17000000b005342fa19070sm7612149edu.89.2023.10.10.05.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:46:02 -0700 (PDT)
Message-ID: <f0c26ccc-ba96-f0ef-4756-370f5114ec94@linaro.org>
Date: Tue, 10 Oct 2023 14:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 13/16] disas: Allow monitor_disas to read from
 ram_addr_t
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com, "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 20:30, Richard Henderson wrote:
> From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>
> 
> Introduce a MonitorDisasSpace to replace the current is_physical
> boolean argument to monitor_disas.  Generate an error if we attempt
> to read past the end of a single RAMBlock.
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> [rth: Split out of a larger patch; validate the RAMBlock size]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/disas.h     |  8 +++++++-
>   disas/disas-mon.c         | 32 ++++++++++++++++++++++++++++++--
>   monitor/hmp-cmds-target.c | 27 ++++++++++++++++-----------
>   3 files changed, 53 insertions(+), 14 deletions(-)
> 
> diff --git a/include/disas/disas.h b/include/disas/disas.h
> index 176775eff7..cd99b0ccd0 100644
> --- a/include/disas/disas.h
> +++ b/include/disas/disas.h
> @@ -5,8 +5,14 @@
>   void disas(FILE *out, const void *code, size_t size);
>   void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
>   
> +typedef enum {
> +    MON_DISAS_GVA, /* virtual */
> +    MON_DISAS_GPA, /* physical */
> +    MON_DISAS_GRA, /* ram_addr_t */
> +} MonitorDisasSpace;


Obviously I'd rather see MonitorDisasSpace = {MON_DISAS_GVA/GPA}
introduced in a preliminary patch, but just saying.

>   static void memory_dump(Monitor *mon, int count, int format, int wsize,
> -                        hwaddr addr, int is_physical)
> +                        hwaddr addr, MonitorDisasSpace space)
>   {
>       int l, line_size, i, max_digits, len;
>       uint8_t buf[16];
>       uint64_t v;
>       CPUState *cs = mon_get_cpu(mon);
>   
> -    if (!cs && (format == 'i' || !is_physical)) {

Why is the '!cs' check removed? Otherwise LGTM.

> +    if (space == MON_DISAS_GVA || format == 'i') {
>           monitor_printf(mon, "Can not dump without CPU\n");
>           return;
>       }
>   
>       if (format == 'i') {
> -        monitor_disas(mon, cs, addr, count, is_physical);
> -        return;
> +        monitor_disas(mon, cs, addr, count, space);
>       }
>   
>       len = wsize * count;
> @@ -163,15 +162,21 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
>       }
>   
>       while (len > 0) {
> -        if (is_physical) {
> -            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
> -        } else {
> +        switch (space) {
> +        case MON_DISAS_GVA:
>               monitor_printf(mon, TARGET_FMT_lx ":", (target_ulong)addr);
> +            break;
> +        case MON_DISAS_GPA:
> +            monitor_printf(mon, HWADDR_FMT_plx ":", addr);
> +            break;
> +        default:
> +            g_assert_not_reached();
>           }
>           l = len;
> -        if (l > line_size)
> +        if (l > line_size) {
>               l = line_size;
> -        if (is_physical) {
> +        }
> +        if (space == MON_DISAS_GPA) {
>               AddressSpace *as = cs ? cs->as : &address_space_memory;
>               MemTxResult r = address_space_read(as, addr,
>                                                  MEMTXATTRS_UNSPECIFIED, buf, l);
> @@ -235,7 +240,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
>       int size = qdict_get_int(qdict, "size");
>       target_long addr = qdict_get_int(qdict, "addr");
>   
> -    memory_dump(mon, count, format, size, addr, 0);
> +    memory_dump(mon, count, format, size, addr, MON_DISAS_GVA);
>   }


