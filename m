Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6C70BF4D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15JP-0004aA-S3; Mon, 22 May 2023 09:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15JH-0004Yp-PU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:10:52 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15JC-0007OW-5o
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:10:47 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-19a1ac5e200so4491914fac.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684761041; x=1687353041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5Mt0JWEWXXcQaAmSsPxoyfqoGwsyktWXCBKXbxrTAg=;
 b=lO38OCGa82Q9z41njcYwfadxbs34WF03dizRcHkihf6LCstbFIAF47vAd+yFSvQlvK
 JrtJfaIbdS/HSYg2hj7csl0reHkFNQcy03oQsK+hcSZSiy7Z5lf2cBqOINUHhjm6RcL0
 mMcTPUbyc3/WkGnJ6DdWCciZZY7RI4bOLEjPSp81EseuqUcbhz+BrMcgcUs4h/Pm9Vxa
 QvWTDAYb1pfaCpQ59DIWZL8uvuY82B3mHASfq1Ww1fs7wh+mfuR30c+w/PLBn59nySHw
 y8M+CsMvtOgtECtvl8LPbrG+dQ7j6y+DWPvkg4zQc9Gl04JECKsSUUY/l8ar5pZRfBBt
 /Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761041; x=1687353041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5Mt0JWEWXXcQaAmSsPxoyfqoGwsyktWXCBKXbxrTAg=;
 b=hEU+1ZsgfC+AXLzG89j3slcLwZYjsh2bLcdPWOPviypL7gtk9kQ/0geIY/b2XCFLDM
 VvJfKuWzJGACo9rfmPSRHwI2TQYcr40S+d84BrbLcDUno26rLtRXSPkLY9PJIk3GZVr0
 g+9bF0qG9guJrLtHL4W6lImf/v36syb5lc1PnJDLkP6kK30A6PAGVjDvHOHDNaYYTx2I
 rZ61o5rwEJx/2SdAFsbGbljlnZdxv2yicKfIARZsI0CkQzabLS9zm5He9hf6xIwnTUPA
 BqOgoBq7b1PcIkjoAyS9gFknSJkbF3de3Zx+PrluovrzonZjNiCJ80F/TnDhBkXwtnRj
 mvnw==
X-Gm-Message-State: AC+VfDwwtKM3WSh3if2C/wo61QxFNOJCaxnDLyCqiLqzzzRMABxRUQDW
 mTvATH86U8ZWvaptaa86CbZBlKzx2wqow4YraVU=
X-Google-Smtp-Source: ACHHUZ56s2s9txNuZjZcR8zT/4+rgNNlZJv9M5QDK7fVcVe7djPlE2A3wsyq0hoG2TDAq9zJmm132Q==
X-Received: by 2002:a05:6870:3404:b0:196:8dc5:178b with SMTP id
 g4-20020a056870340400b001968dc5178bmr4738081oah.29.1684761040876; 
 Mon, 22 May 2023 06:10:40 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a05687051d600b00195f0e75438sm2422426oaj.15.2023.05.22.06.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:10:40 -0700 (PDT)
Message-ID: <0ca6bb76-ba1c-4185-6faf-e70f979849da@ventanamicro.com>
Date: Mon, 22 May 2023 10:10:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/7] disas/riscv.c: Support disas for Zcm* extensions
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230519021926.15362-1-liweiwei@iscas.ac.cn>
 <20230519021926.15362-4-liweiwei@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230519021926.15362-4-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

In fact, apparently checkpatch.pl is not too happy about this patch:

On 5/18/23 23:19, Weiwei Li wrote:
> Support disas for Zcmt* instructions only when related extensions
> are supported.
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---
>   disas/riscv.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 729ab684da..9e01810eef 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2501,7 +2501,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   op = rv_op_c_sqsp;
>               } else {
>                   op = rv_op_c_fsdsp;
> -                if (((inst >> 12) & 0b01)) {
> +                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
>                       switch ((inst >> 8) & 0b01111) {
>                       case 8:
>                           if (((inst >> 4) & 0b01111) >= 4) {
> @@ -2527,16 +2527,20 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   } else {
>                       switch ((inst >> 10) & 0b011) {
>                       case 0:
> -                        if (((inst >> 2) & 0xFF) >= 32) {
> -                            op = rv_op_cm_jalt;
> -                        } else {
> -                            op = rv_op_cm_jt;
> +                        if (dec->cfg->ext_zcmt) {
> +                            if (((inst >> 2) & 0xFF) >= 32) {
> +                                op = rv_op_cm_jalt;
> +                            } else {
> +                                op = rv_op_cm_jt;
> +                            }
>                           }
>                           break;
>                       case 3:
> -                        switch ((inst >> 5) & 0b011) {
> -                        case 1: op = rv_op_cm_mvsa01; break;
> -                        case 3: op = rv_op_cm_mva01s; break;
> +                        if (dec->cfg->ext_zcmp) {
> +                            switch ((inst >> 5) & 0b011) {
> +                            case 1: op = rv_op_cm_mvsa01; break;
> +                            case 3: op = rv_op_cm_mva01s; break;
> +                            }

At this point:

================
3/7 Checking commit 989059d476f9 (disas/riscv.c: Support disas for Zcm* extensions)
ERROR: trailing statements should be on next line
#51: FILE: disas/riscv.c:2541:
+                            case 1: op = rv_op_cm_mvsa01; break;

ERROR: trailing statements should be on next line
#52: FILE: disas/riscv.c:2542:
+                            case 3: op = rv_op_cm_mva01s; break;

total: 2 errors, 0 warnings, 35 lines checked

Patch 3/7 has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
================


The issue predates your patch. It would be very nice of you if you can fix it
though :D



Daniel


>                           }
>                           break;
>                       }

