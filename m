Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8872A7AE712
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 09:45:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql2jl-0001v8-Oq; Tue, 26 Sep 2023 03:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2jk-0001uw-3b
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:44:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql2ji-00046c-5c
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 03:44:03 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVeDq-1rCeIC1gRw-00RZZJ; Tue, 26 Sep 2023 09:43:56 +0200
Message-ID: <9f80f321-4911-f108-ceae-11e1cd72170c@vivier.eu>
Date: Tue, 26 Sep 2023 09:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] m68k: Silence -Wshadow=local warnings in the m68k code
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230925185603.106945-1-thuth@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230925185603.106945-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7SA+q+aDUVvGuztVKtnYr62TlKbNMoz+Kxgf3yEdz9FHDV322tS
 DFo6+mjkE1gb+YaF7b4qZDxENlp/WvRu8MacQVMKBVMjWViXqCiJjCkAvpCrutVaeNo/ZfK
 pkKGm9egPzvemgwq3FNdhf+J9BX3BNgxz7laV0HvLUTYV3/yGFf9nsnarQFB8Hb8uKW61Mk
 78b4YLzpp1EaqoXXxQckQ==
UI-OutboundReport: notjunk:1;M01:P0:nYGjZfzx8dQ=;3XfAt2BHdNReJnghpJK/Is+fnp3
 R1ysNxu+vKV4bjgjSHphbVvizmD47cr1i6ZoxvQuf58KzHeMUn94vt5Hwx+xYWHW0AFHgrUbp
 +KYWrQUfV6XABGlE1KNHA8rFyFamRKseOauEV62xlTq2a+FlphOlMf8uPAEGSfzUoJmDE1odO
 ATXXEdP1jLqwsWGGJkk2Al+qzVZSluV9+W8C/wSrrVawSAmvQizA2KMz9DBWdFY5C1wAY2EU6
 Fq/vub9eK4RuoI5U8yxVeYLtDVOEe7ju5bgZYsd9He2czLUnstvXKswmya/rAz2LYDVmY1/mQ
 zlbbjVutnQsHZ9dusq4HeTcWAcrbmV2ul+2QFWoG10rkL4G1P0L4e2W4YYzw95UualTyH23Se
 i9E03FqMZtT+JcTkmDEn18q1iAfn8M1zotCgWbWOhaDus8FZ1yloHLiarijGqvPv07DeDv0uj
 lQDllHlQN/FPuUvT+erTBkyq+zB1A55qoJUk3qUXWJxWE/mGrRFdijWz0TIN5oZ3jKMDZE+zi
 5ONFM2+r7m5t0Plezv5d4a2evqfpW2YCaRynXKdRfF/XbBpFcDh8lVwKhOpSCGliYKz6BtVJj
 aLl1fjy5uBbJu9f6MAKwZZgUSep36IGrU+L6yaFIOShFiINoexROlaJ0JWl98/zMQOjHBhzQI
 gp3iTXNYrLnKrgS9L6dMVgp3Wu4XoJZG+Y7l/GcFf/16aXLyOkv6GvDPMOoPfJC1drdR63IPL
 M1sLY1rjfrRO5F6ExzuoJDokMRms9mUIaaJETKtrcET5P/ZLmIUm5paVdd8HhvZz27rL39M+5
 xeY2O7I8txioJlzX+evFLeIdN/3BiJJFZLdZjLIO3IqcBvhCbN47ErzbWcOA3Ej1moqgtUMKN
 /RQ93Mw8Bu2pSJg==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 25/09/2023 à 20:56, Thomas Huth a écrit :
> Rename the innermost variables to make the code compile
> without warnings when using -Wshadow=local.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/m68k/bootinfo.h      | 10 ++++------
>   disas/m68k.c            |  8 ++++----
>   target/m68k/translate.c |  8 ++++----
>   3 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
> index a3d37e3c80..d077d03559 100644
> --- a/hw/m68k/bootinfo.h
> +++ b/hw/m68k/bootinfo.h
> @@ -44,15 +44,14 @@
>   
>   #define BOOTINFOSTR(base, id, string) \
>       do { \
> -        int i; \
>           stw_p(base, id); \
>           base += 2; \
>           stw_p(base, \
>                    (sizeof(struct bi_record) + strlen(string) + \
>                     1 /* null termination */ + 3 /* padding */) & ~3); \
>           base += 2; \
> -        for (i = 0; string[i]; i++) { \
> -            stb_p(base++, string[i]); \
> +        for (int _i = 0; string[_i]; _i++) { \
> +            stb_p(base++, string[_i]); \
>           } \
>           stb_p(base++, 0); \
>           base = QEMU_ALIGN_PTR_UP(base, 4); \
> @@ -60,7 +59,6 @@
>   
>   #define BOOTINFODATA(base, id, data, len) \
>       do { \
> -        int i; \
>           stw_p(base, id); \
>           base += 2; \
>           stw_p(base, \
> @@ -69,8 +67,8 @@
>           base += 2; \
>           stw_p(base, len); \
>           base += 2; \
> -        for (i = 0; i < len; ++i) { \
> -            stb_p(base++, data[i]); \
> +        for (int _i = 0; _i < len; ++_i) { \
> +            stb_p(base++, data[_i]); \
>           } \
>           base = QEMU_ALIGN_PTR_UP(base, 4); \
>       } while (0)
> diff --git a/disas/m68k.c b/disas/m68k.c
> index aefaecfbd6..a384b4cb64 100644
> --- a/disas/m68k.c
> +++ b/disas/m68k.c
> @@ -1632,10 +1632,10 @@ print_insn_arg (const char *d,
>       case '2':
>       case '3':
>         {
> -	int val = fetch_arg (buffer, place, 5, info);
> +	int val2 = fetch_arg (buffer, place, 5, info);
>           const char *name = 0;
>   
> -	switch (val)
> +	switch (val2)
>   	  {
>   	  case 2: name = "%tt0"; break;
>   	  case 3: name = "%tt1"; break;
> @@ -1655,12 +1655,12 @@ print_insn_arg (const char *d,
>   	      int break_reg = ((buffer[3] >> 2) & 7);
>   
>   	      (*info->fprintf_func)
> -		(info->stream, val == 0x1c ? "%%bad%d" : "%%bac%d",
> +		(info->stream, val2 == 0x1c ? "%%bad%d" : "%%bac%d",
>   		 break_reg);
>   	    }
>   	    break;
>   	  default:
> -	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val);
> +	    (*info->fprintf_func) (info->stream, "<mmu register %d>", val2);
>   	  }
>   	if (name)
>   	  (*info->fprintf_func) (info->stream, "%s", name);

"reg" would be a better name than "val2".

> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 9e224fe796..b28d7f7d4b 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -824,14 +824,14 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
>           reg = get_areg(s, reg0);
>           result = gen_ldst(s, opsize, reg, val, what, index);
>           if (what == EA_STORE || !addrp) {
> -            TCGv tmp = tcg_temp_new();
> +            TCGv tmp2 = tcg_temp_new();
>               if (reg0 == 7 && opsize == OS_BYTE &&
>                   m68k_feature(s->env, M68K_FEATURE_M68K)) {
> -                tcg_gen_addi_i32(tmp, reg, 2);
> +                tcg_gen_addi_i32(tmp2, reg, 2);
>               } else {
> -                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
> +                tcg_gen_addi_i32(tmp2, reg, opsize_bytes(opsize));
>               }
> -            delay_set_areg(s, reg0, tmp, true);
> +            delay_set_areg(s, reg0, tmp2, true);
>           }
>           return result;
>       case 4: /* Indirect predecrememnt.  */

"inc" would be a better name than "val2".

Otherwise:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


Thanks,
Laurent


