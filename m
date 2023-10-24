Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3AB7D4B41
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDAV-0000UE-9b; Tue, 24 Oct 2023 04:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDAQ-0000OU-Uv
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDAO-0006J8-Ef
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:53:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso33656925e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698137613; x=1698742413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zlxPJ3rDPcak4IogFU7b34T2MElcuiLdIjaH4Coc+LM=;
 b=hYhRAgdPG94DPO03/Ydne3dqMdcufQHDRZI9ABaePMj8f+nGRbbVUgi/suR7PdpDZS
 98GX6y2YyCUJzQalS6c6OJPV5bPfyojtxZD7VI9HtpuILVhCm0c1WWJZ/abrbmWW85Jv
 2JE0x5mXiHrzKCzjUmhVu00udmb4zezMX65hqANF7cQpoE16YGXArh09nVE9dCcLRnV2
 TZD5dIeMP7QxUMovY+UwI7MlOkfPt5J9wzDM8ptMf1wBA8u7U1md4eeM70Vvww46eprk
 lO4WQz0NTBeMwV51WluTxcAiUF1R4jZC+NDlyohOgTfD69ej5MZ6FWIgM+VCpBjDjWoP
 8AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698137613; x=1698742413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlxPJ3rDPcak4IogFU7b34T2MElcuiLdIjaH4Coc+LM=;
 b=Dp12fLvesFmM5Qc222aLZnWhfUj/U0cRTiBc7nfuqBU9UmKBRxquXBjArrS4eCLvCN
 8gy79iOFl1hDKuFp2RB0wcOXH7W8KEitT2Ec/eRlWmoS6jLEF0HVCnSJ9UCzHZmN3EjM
 bgenoua6r3GiqnZ6/h0H6ayml08QXZpXaIgy073Ft+9tHZE2gFbfOynZMobe3lY50RVL
 DCigKrVl6aOdlxLbf7qA1HqRWRrWSvM2NgkpSoa0rhMcX8e9AzdgrisMtObbleelGUct
 orVx27eU1NneB0GFRQbS/mdXGm98cBh2nylf5myW56j/Io7u8ITmSTya0qJdFgku58Cg
 0ZpQ==
X-Gm-Message-State: AOJu0YymMny5KjA4fz6Py2tOhTQlyYesvQa8eTdern7t5nfUFlJMGRRv
 c7nUeXc4hFqzFweFpjBZ6nukoA==
X-Google-Smtp-Source: AGHT+IGzKLV7Qg7iSSgooeH6jjwFQ8z18m+r1zuHmiHbzZvfSM7e6I0WuNIGPjeB8+yVJoUAaK0uFA==
X-Received: by 2002:a05:600c:4f45:b0:408:3ac4:dc3f with SMTP id
 m5-20020a05600c4f4500b004083ac4dc3fmr9485957wmq.29.1698137612722; 
 Tue, 24 Oct 2023 01:53:32 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 x17-20020a5d60d1000000b0032d8f075810sm9509437wrt.10.2023.10.24.01.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 01:53:32 -0700 (PDT)
Message-ID: <1668b930-e79b-d84a-f0c1-b0fca9b3baaa@linaro.org>
Date: Tue, 24 Oct 2023 10:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 8/9] target/cris: Use tcg_gen_sextract_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-9-philmd@linaro.org>
 <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <db537981-e8ee-419c-9bc1-d9092ec60deb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 24/10/23 02:26, Richard Henderson wrote:
> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC: please double-check bits
>> ---
>>   target/cris/translate.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/target/cris/translate.c b/target/cris/translate.c
>> index 65b07e1d80..3a161f8f73 100644
>> --- a/target/cris/translate.c
>> +++ b/target/cris/translate.c
>> @@ -336,8 +336,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv 
>> b, TCGv ccs)
>>        */
>>       t = tcg_temp_new();
>>       tcg_gen_shli_tl(d, a, 1);
>> -    tcg_gen_shli_tl(t, ccs, 31 - 3);
>> -    tcg_gen_sari_tl(t, t, 31);
>> +    tcg_gen_sextract_tl(t, ccs, 3, 1);
> 
> tcg_gen_sextract_tl(t, ccs, ctz32(N_FLAG), 1);
> 
> Also, it appears t_gen_cris_mstep consumes CCS without making sure that 
> it is up-to-date.

Do you mean we first need to call cris_evaluate_flags?

-- >8 --
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 3a161f8f73..5eb68b8a63 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -177,6 +177,8 @@ static const int preg_sizes[] = {
  #define t_gen_movi_env_TN(member, c) \
      t_gen_mov_env_TN(member, tcg_constant_tl(c))

+static void cris_evaluate_flags(DisasContext *dc);
+
  static inline void t_gen_mov_TN_preg(TCGv tn, int r)
  {
      assert(r >= 0 && r <= 15);
@@ -325,7 +327,7 @@ static void t_gen_cris_dstep(TCGv d, TCGv a, TCGv b)
      tcg_gen_movcond_tl(TCG_COND_GEU, d, d, b, t, d);
  }

-static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
+static void t_gen_cris_mstep(DisasContext *dc, TCGv d, TCGv a, TCGv b, 
TCGv ccs)
  {
      TCGv t;

@@ -335,6 +337,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, 
TCGv ccs)
       *    d += s;
       */
      t = tcg_temp_new();
+    cris_evaluate_flags(dc);
      tcg_gen_shli_tl(d, a, 1);
      tcg_gen_sextract_tl(t, ccs, 3, 1);
      tcg_gen_and_tl(t, t, b);
@@ -702,7 +705,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
          t_gen_cris_dstep(dst, a, b);
          break;
      case CC_OP_MSTEP:
-        t_gen_cris_mstep(dst, a, b, cpu_PR[PR_CCS]);
+        t_gen_cris_mstep(dc, dst, a, b, cpu_PR[PR_CCS]);
          break;
      case CC_OP_BOUND:
          tcg_gen_movcond_tl(TCG_COND_LEU, dst, a, b, a, b);
---


