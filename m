Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FDA82C772
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:52:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQNf-0004iy-9j; Fri, 12 Jan 2024 17:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQNd-0004iO-5H
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:52:01 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOQNb-0007xE-4j
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:52:00 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso59161525ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705099917; x=1705704717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n0eRD2gbAFK8+D4qYKrFFO5oLv8pyWiOLJDRDhM9lXU=;
 b=RLUTfA5h39C7ce+9oBCqiUAd03/NfX09lRlDBf5a2Sf3XCVA798jxhZzmNDlmCXg0H
 krOmqBvHJxCh5RDGMsxwnGzKxE22QoflgXljeTIZT04MCMsolAEmF0VRc9ugoRGBmy7w
 tlCCJdtalCeE3SwMW61kifyW7ADtAG9zf1TpN0S4hEF57NGtktkp3hlu+R/7lXby3S8S
 B8RNRk1oofHgjNo67DqN39ieTFwWqqbsLIMybjZUaNNH1PoSbZHYeYq16xDJ+iXQ3LW7
 cCE/K5zmFf8U/G8gA8vRNV4jNW6Zp3joMi+o0n3yld7P29VRMy+jqPp6T7B5fQPmOpWd
 D3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705099917; x=1705704717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n0eRD2gbAFK8+D4qYKrFFO5oLv8pyWiOLJDRDhM9lXU=;
 b=ntcl2ko63r3UbbTtRbRHYLhsxMk35moMRz2FNpbJ5L+QnO+rw14zdohnFkdTIovih6
 M3XLVqL+ZZ/pGVbSwU+OFcbwN4hzsvJ5EYIQHmhypvWd1pKyblCQETAwZv8gh9KHsHA/
 EReSEptkfAChrmjGdl//DHdFaoa6VDxL+LvXgPK7QzQYEDqbwQtaqNMuoDW+7GUZCLvu
 WSiv5VCHhxam+dGjdueMeSG83oauchmwXXxmSFfpgbkuUEo7wwL6Grxnz68oNoUQz2p0
 v0a4Rw/smI7cRBczc11yGZ0gebYjyavPp0Gkf0U/eah0H4lm1dKHu+k3yYus0dp1X3TO
 4I+w==
X-Gm-Message-State: AOJu0Yz6vARfvIC/HVkVF6BsZmkSPnBSlq+KSclB40eTES0Qt3vjCZS3
 n70I2S+7e6jheVy+aKaGk6XA7eU6eScWUQ==
X-Google-Smtp-Source: AGHT+IHuoZPySER0Cu6e6UuBV8h9dlII6GE8IxbbGGEPkadrUPMyuoDo2v0W30skiTUDxlXEme5Ibw==
X-Received: by 2002:a17:902:c792:b0:1d4:cb7e:14ee with SMTP id
 w18-20020a170902c79200b001d4cb7e14eemr1420196pla.84.1705099917717; 
 Fri, 12 Jan 2024 14:51:57 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:2ad6:e985:c1c8:a4fc:508?
 ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a170902e2c200b001d09c539c96sm3680953plc.229.2024.01.12.14.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 14:51:57 -0800 (PST)
Message-ID: <32238550-8008-4771-9a1d-755be8c19384@linaro.org>
Date: Sat, 13 Jan 2024 09:51:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] trans_rvv.c.inc: remove vlmax arg from
 vec_element_loadx()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240112213812.173521-1-dbarboza@ventanamicro.com>
 <20240112213812.173521-12-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240112213812.173521-12-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/13/24 08:38, Daniel Henrique Barboza wrote:
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 26 +++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 804cfd6c7f..3782d0fa2f 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3265,21 +3265,28 @@ static void endian_adjust(TCGv_i32 ofs, int sew)
>   #endif
>   }
>   
> -/* Load idx >= VLMAX ? 0 : vreg[idx] */
> +/*
> + * Load idx >= VLMAX ? 0 : vreg[idx]
> + *
> + * This function assumes ctx->vl_eq_vlmax = true.
> + */
>   static void vec_element_loadx(DisasContext *s, TCGv_i64 dest,
> -                              int vreg, TCGv idx, int vlmax)
> +                              int vreg, TCGv idx)

I think removing the cpu configuration constant is a mistake.
Compile-time constants are always better than computation...

> +#ifdef TARGET_RISCV64
> +    tcg_gen_mov_i64(t_vlmax, cpu_vl);
> +#else
> +    tcg_gen_extu_tl_i64(t_vlmax, cpu_vl);
> +#endif

That said, no ifdef required -- the second statement should always work.



r~

