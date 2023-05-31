Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06376717BEC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4I8U-0005az-Ty; Wed, 31 May 2023 05:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8T-0005ah-2J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:53 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8R-0006xv-MS
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:52 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6af7a84b2bdso4251692a34.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685525330; x=1688117330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s/wVkhhWmgIwL0CTiJLUiS5Rb0pQvITbFvbdgCVWLFI=;
 b=YRrkKr/ODZP+QevDT2LJao05s88oSRn+DsUeQpyr5ogy/yVzSIUluplK/KYT3tM1v9
 GD55VX7FUHeSuniJgCRvHhmzLnrImuzxZif8xyXedoMBZ0aHCW+3XXyb5rQyHsxbiOoj
 rpOTSj9GzkLylPsw3gdaxCjEO3mjgFqU7RP4vENQeNERwGYS4RWslhByYPdbnGLGmP6l
 HHz1a1NCwn8+yf7P90K5HojNtqQzCUUO54jqXk9BGewD7PparQqKX7CEf7ESQzhcXKCb
 sYgcCHBhoGyyMNbOoBSWtxKznHZugh98Fk+BC8T7k1WBeSI33jHsPlYUoKXH7Y8g1HXF
 /Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685525330; x=1688117330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/wVkhhWmgIwL0CTiJLUiS5Rb0pQvITbFvbdgCVWLFI=;
 b=Kd6xSbbyZkjcWz/uY3Mt+PVhqpsuqXlKPNLT7/xIxmKuJHcdEbJQccm9nv30NmHwWz
 ZCh70/MtErve3J7xmMWvaVRP9HmMFMdd+izkLwZa+rSpN8/jP0Dxj3cOJVt8799nM/vO
 9y3VklgqW3m8GxsJfF10XIwFV8IcvynyDI7I6zMJTWdqqrDGcvAc7zrgcE2YSk6LeVZN
 7qXG5Cbauts3eSNG+YoB5QoElm+QsMFUUZsXB3TgfLkERHrUc/BTOnDLCZhQ4ldd56Nn
 I3B73u023ElZ8q6mlzEWkBWONhzvOkf9jBjIX9eVDW4Szvp9aAfJywBjWq4/L6vXAOZ7
 mtiQ==
X-Gm-Message-State: AC+VfDyWpwuuRp7KW24S0gUhYXR4T22Bjk9AvLJkYY2T506e/1LGd+dK
 CEj/O4vIkdv0K8hWf08WHzCV1A==
X-Google-Smtp-Source: ACHHUZ6aEpRKHzwmigAB+/3SOt2f1gW64oMsDa3cGveGgU7TAucuhNpWJiue232mKupo7tsHrXE0wA==
X-Received: by 2002:a05:6830:e8a:b0:6b0:9fd7:de3a with SMTP id
 dp10-20020a0568300e8a00b006b09fd7de3amr979366otb.0.1685525330503; 
 Wed, 31 May 2023 02:28:50 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 e187-20020a4a55c4000000b00555718c0c5dsm6576899oob.37.2023.05.31.02.28.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 02:28:49 -0700 (PDT)
Message-ID: <7ddff340-6312-7bcd-46de-269dac1a1bd3@ventanamicro.com>
Date: Wed, 31 May 2023 06:28:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] target/riscv: Remove check on mode for MPRV
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-3-liweiwei@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230529121719.179507-3-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 5/29/23 09:17, Weiwei Li wrote:
> Normally, MPRV can be set to 1 only in M mode (It will be cleared
> when returning to lower-privilege mode by MRET/SRET).
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index bd892c05d4..45baf95c77 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -44,7 +44,7 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>       if (!ifetch) {
>           uint64_t status = env->mstatus;
>   
> -        if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
> +        if (get_field(status, MSTATUS_MPRV)) {
>               mode = get_field(env->mstatus, MSTATUS_MPP);
>               virt = get_field(env->mstatus, MSTATUS_MPV) &&
>                      (mode != PRV_M);

