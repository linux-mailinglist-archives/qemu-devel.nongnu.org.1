Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F963822F1C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:02:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1oP-0004j8-Lu; Wed, 03 Jan 2024 09:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1o3-0004gj-NE
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:01:16 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1nx-00073V-7k
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:01:13 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so863818a12.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 06:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704290465; x=1704895265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B+SeJrYHOHeb0n8EPEq05j+IHNe8ZL6Bu6xI2IfMTfE=;
 b=z7zOgKX1AuG8bVqrLoLojfJ3ENDrfzI2v8eprxc+RXmt7Dv6zLiUqCdUwEI69hfVZR
 Uz8Xd7mLPXVJ6hg+IglrbYqskkU+k6xPNQe2JvUcWAp0/XeqFSeL+XVJ+wJCfWXINmpn
 SVJpakydhhjlcrn02WDNw78L9N39MQPLrgeswsk9gX+bZBJ7EZwsgloIatmGotPGju6P
 1ZU2TPXXQ5o/dzQkCLKBONoPn7g9Yv2ouIm4uH1FA67q2OSn2Tc+pvsQMYFIyanb5lBf
 IHjxGhXohSYUm7s8Ut+RjlvDkbmAp9AnGmiYEUurHnFK9kbpayYqe8cMYmh1ruj2lkaM
 SwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704290465; x=1704895265;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B+SeJrYHOHeb0n8EPEq05j+IHNe8ZL6Bu6xI2IfMTfE=;
 b=fPpFwPE/1y80ycH66zODp5noADlVhcemFy6zheFJecJ6gxv6SRx6zT8Up5CajtC7oG
 MqscKmJL8PnJ0FzcNeRQjMpgBvD/YK4S38HMLRtg04bz/aqcOXiCieLRxsctqdGjwIa0
 Z6Z1TD76CNFb2sGa0jAxRVjLpIKNQ8PXfQm2hHPgaC0gcTl+R7s6kt5IiCtbZmQHOkcm
 TLBdQmOOpKpsG5/LOLi5kdrNM0Oya529lzK+FtKTYkEcNfqrJeoK5Cn1SNKFZJs8f7sd
 7z0TgizyFhgmPziDytccY1NQpROXJKdP9jZYgmwvtdxaKLpqhBC+BVeMYhNci7UM1T0o
 rtWQ==
X-Gm-Message-State: AOJu0YyfDznWUfW2YTuANwe62D5lKJowycprL2Lw63+JWtBhfp/3QO+I
 fArb2nVuPrpEEPu6lqyrdSZ8Xr6opIrbfQ==
X-Google-Smtp-Source: AGHT+IFOF8cg2CsW4ktDt+o5SVQBz5CWwOObLjC2g7eFj8GPBQFyYzTem665XWbhZet+v7hHFOL18g==
X-Received: by 2002:a17:907:7e92:b0:a28:a9a7:cbe0 with SMTP id
 qb18-20020a1709077e9200b00a28a9a7cbe0mr255473ejc.122.1704290465222; 
 Wed, 03 Jan 2024 06:01:05 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 ex17-20020a170907955100b00a269fa0d305sm12781245ejc.8.2024.01.03.06.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 06:01:04 -0800 (PST)
Message-ID: <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
Date: Wed, 3 Jan 2024 15:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
 <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
 <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
 <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
In-Reply-To: <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/1/24 12:53, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 3/1/24 09:54, Michael Tokarev wrote:
>> 03.01.2024 03:22, Richard Henderson wrote:
>>> On 12/22/23 01:51, Michael Tokarev wrote:
>> ...
>>>> git bisect points to this commit:
>>>>
>>>> commit ab84dc398b3b702b0c692538b947ef65dbbdf52f
>>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>>> Date:   Wed Aug 23 23:04:24 2023 -0700
>>>>
>>>>      tcg/optimize: Optimize env memory operations
>>>>
>>>> So far, this seems to work on amd64 host, but fails on s390x host -
>>>> where this has been observed so far.  Maybe it also fails in some
>>>> other combinations too, I don't yet know.  Just finished bisecting
>>>> it on s390x.
>>>
>>> I haven't been able to build a reproducer for this.
>>> Have you an image or kernel you can share?
>>
>> Sure.
>>
>> Here's my actual testing "image": 
>> http://www.corpit.ru/mjt/tmp/s390x-chacha.tar.gz
>>
>> It contains vmlinuz and initrd - generated on a debian s390x system 
>> using standard
>> debian tools.
>>
>> Actual command line I used when doing bisection:
>>
>>   ~/qemu/b/qemu-system-s390x -append "root=/dev/vda rw" -nographic 
>> -smp 2 -drive format=raw,file=vmlinuz,if=virtio -no-user-config -m 1G 
>> -kernel vmlinuz -initrd initrd -snapshot
> 
> I had a quick look at the reproducer and reduced the code
> area to:
> 
> void tcg_optimize(TCGContext *s)
> {
>      ...
>          switch (opc) {
>          case INDEX_op_ld_vec:
>              done = fold_tcg_ld_memcopy(&ctx, op);
> 
> 
> static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
> {
>      ...
>      if (src && src->base_type == type) {
>          return tcg_opt_gen_mov(ctx, op, temp_arg(dst), temp_arg(src));
>      }
> 
> 
> static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, 
> TCGArg src)
> {
>      ...
>      switch (ctx->type) {
>      case TCG_TYPE_V128:
>          new_op = INDEX_op_mov_vec;
> 
> 
> By disabling this optimization, the test succeeds.
> 
> Looking at commit 4caad79f8d ("tcg/s390x: Support 128-bit load/store")
> and remembering the constraints change on PPC LQ in
> https://lore.kernel.org/qemu-devel/20240102013456.131846-1-richard.henderson@linaro.org/
> I wondered if LPQ constraints are correct, but I disabled
> TCG_TARGET_HAS_qemu_ldst_i128 and the bug persists (so
> re-enabled).
> 
> Then disabling TCG_TARGET_HAS_v64 and TCG_TARGET_HAS_v128 the bug
> disappears.

Reducing a bit further, it works when disabling rotli_vec opcode
(commit 22cb37b417 "tcg/s390x: Implement vector shift operations"):

---
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..5f147661e8 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2918,3 +2918,5 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType 
type, unsigned vece)
      case INDEX_op_orc_vec:
+        return 1;
      case INDEX_op_rotli_vec:
+        return TCG_TARGET_HAS_roti_vec;
      case INDEX_op_rotls_vec:
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index e69b0d2ddd..5c18146a40 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -152,3 +152,3 @@ extern uint64_t s390_facilities[3];
  #define TCG_TARGET_HAS_abs_vec        1
-#define TCG_TARGET_HAS_roti_vec       1
+#define TCG_TARGET_HAS_roti_vec       0
  #define TCG_TARGET_HAS_rots_vec       1
---

