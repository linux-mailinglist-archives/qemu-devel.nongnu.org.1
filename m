Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9B6822FAF
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL2Mv-0005ac-32; Wed, 03 Jan 2024 09:37:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL2Mt-0005ZZ-8y
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:37:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL2Mr-0005oz-BH
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:37:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d3c4bfe45so110114895e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 06:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704292630; x=1704897430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PIqngcVh94Wb8vg7GP+xQFUfn1aR+1xFvQPfhZ0wFE=;
 b=OJ4VyN6Aa3VhU06bTCNimWSg0vcaoyR366XsxzUNMeSXCRwR7pg4KkwQOiACICLCfz
 u5G3jHsAwBSIhCPmdTICaj2jTDaickVlkepOa/OujlqiJaFt/0CXeEFK0qDo+kRgLHQQ
 xZlv3yLoFpMdhhpNIrxLask4aDHW5nStTHYw7QdWtSXEzGnMsZ7ZSEMN7GMxU22fIzKJ
 afuZXTfpNwcO2Sby1H/be4x0FSm9KQ/mUgfTwRAyM1vb6yGF5nu6oi2ey7uMYTT3i3WY
 D9PpC8qaaUpCvqVfAMUF5z9HUaSgSLMoeRwMY9sP8VLRB5qf/hjd2eG7HZXO3/TJSkds
 7nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292630; x=1704897430;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2PIqngcVh94Wb8vg7GP+xQFUfn1aR+1xFvQPfhZ0wFE=;
 b=YRx4ronqyUQX8k2AqBzHAdQA8Ct6eyeHL9VT9hwRJBUWCtprj6Q/A1TYv18H684wpD
 D6ZLJSVSkfllRmyxT9V1SdekiorpfwuW7Jwk3oJyt2y28W+ZkplC90JmAlUk/frQpiHp
 Q74fjb2tZ1+wc/Udii3bQ0tv4sjTrbBmHpZjr5RNUHzNn8dt1hsGrbAVAnSD1AcB4xNX
 Fq4ZucVinBYP/Bn//pvCE6FmyX/s+QDt7MtOXj7GCSiuSqloO/yCsNfsyVK6JRqSvjk+
 EFpHxonQqjvj9iph7c8rnz/3eLguZ4MfPUU34TmfDYS1KX8YHiohN03XH+XpIrwyzCnT
 Rt8Q==
X-Gm-Message-State: AOJu0Yyu5WVmkexDTTbEaCTJOZaCtZ9qciCs3CpWZ9J79/v8zVWQYsgE
 ZTQKuv8Ecw3VXdqbZk4ZrwtA/yiW+G8xVg==
X-Google-Smtp-Source: AGHT+IHoBZ9fsoLdxYXu05R1UfIzGVw3bBFHLI+lkmjjRLaYw8do7uO4bd6bJgqEGdzbFGmrQ93zSw==
X-Received: by 2002:a05:600c:3d93:b0:40d:8898:a71 with SMTP id
 bi19-20020a05600c3d9300b0040d88980a71mr1319292wmb.358.1704292630642; 
 Wed, 03 Jan 2024 06:37:10 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 cg13-20020a5d5ccd000000b00336e6014263sm19397696wrb.98.2024.01.03.06.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 06:37:10 -0800 (PST)
Message-ID: <e1f48ff4-d640-4500-9f2b-6b9db0d8ffe3@linaro.org>
Date: Wed, 3 Jan 2024 15:37:08 +0100
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
 <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
In-Reply-To: <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 3/1/24 15:01, Philippe Mathieu-Daudé wrote:
> On 3/1/24 12:53, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 3/1/24 09:54, Michael Tokarev wrote:
>>> 03.01.2024 03:22, Richard Henderson wrote:
>>>> On 12/22/23 01:51, Michael Tokarev wrote:
>>> ...
>>>>> git bisect points to this commit:
>>>>>
>>>>> commit ab84dc398b3b702b0c692538b947ef65dbbdf52f
>>>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>>>> Date:   Wed Aug 23 23:04:24 2023 -0700
>>>>>
>>>>>      tcg/optimize: Optimize env memory operations
>>>>>
>>>>> So far, this seems to work on amd64 host, but fails on s390x host -
>>>>> where this has been observed so far.  Maybe it also fails in some
>>>>> other combinations too, I don't yet know.  Just finished bisecting
>>>>> it on s390x.
>>>>
>>>> I haven't been able to build a reproducer for this.
>>>> Have you an image or kernel you can share?
>>>
>>> Sure.
>>>
>>> Here's my actual testing "image": 
>>> http://www.corpit.ru/mjt/tmp/s390x-chacha.tar.gz
>>>
>>> It contains vmlinuz and initrd - generated on a debian s390x system 
>>> using standard
>>> debian tools.
>>>
>>> Actual command line I used when doing bisection:
>>>
>>>   ~/qemu/b/qemu-system-s390x -append "root=/dev/vda rw" -nographic 
>>> -smp 2 -drive format=raw,file=vmlinuz,if=virtio -no-user-config -m 1G 
>>> -kernel vmlinuz -initrd initrd -snapshot


> Reducing a bit further, it works when disabling rotli_vec opcode
> (commit 22cb37b417 "tcg/s390x: Implement vector shift operations"):
> 
> ---
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index fbee43d3b0..5f147661e8 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -2918,3 +2918,5 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType 
> type, unsigned vece)
>       case INDEX_op_orc_vec:
> +        return 1;
>       case INDEX_op_rotli_vec:
> +        return TCG_TARGET_HAS_roti_vec;
>       case INDEX_op_rotls_vec:
> diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
> index e69b0d2ddd..5c18146a40 100644
> --- a/tcg/s390x/tcg-target.h
> +++ b/tcg/s390x/tcg-target.h
> @@ -152,3 +152,3 @@ extern uint64_t s390_facilities[3];
>   #define TCG_TARGET_HAS_abs_vec        1
> -#define TCG_TARGET_HAS_roti_vec       1
> +#define TCG_TARGET_HAS_roti_vec       0
>   #define TCG_TARGET_HAS_rots_vec       1
> ---

Finally changing the constraints on op_rotli_vec seems to fix it:

---
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..b3456fe857 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3264,13 +3264,13 @@ static TCGConstraintSetIndex 
tcg_target_op_def(TCGOpcode op)
      case INDEX_op_ld_vec:
      case INDEX_op_dupm_vec:
+    case INDEX_op_rotli_vec:
          return C_O1_I1(v, r);
      case INDEX_op_dup_vec:
          return C_O1_I1(v, vr);
      case INDEX_op_abs_vec:
      case INDEX_op_neg_vec:
      case INDEX_op_not_vec:
-    case INDEX_op_rotli_vec:
      case INDEX_op_sari_vec:
      case INDEX_op_shli_vec:
      case INDEX_op_shri_vec:
      case INDEX_op_s390_vuph_vec:
      case INDEX_op_s390_vupl_vec:
          return C_O1_I1(v, v);
---

But I'm outside of my comfort zone so not really sure what I'm doing...
(I was inspired by the "the instruction verll only allows immediates up
to 32 bits." comment from
https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg317099.html)

