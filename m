Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D987874D3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCkg-00071X-Cr; Thu, 24 Aug 2023 12:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCkd-0006sz-Gf
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:00:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCka-0000kl-Vb
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:00:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so5685051f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892799; x=1693497599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tO/aj0lDf7Sy00wBoehQb/HstDLhUivuRJRwPhuG/uY=;
 b=XAM2CW2+aelmkFOlgx8yLoeiJWr5JaLpOKDLPl9bWrkEyZx/LU6lrQD1mAHOYAf0EO
 7nRBDm9jQOMtItrfDbrCtonLen9MPKlCJjR++21vHCtUv4LR/zn6po8p8J/jZMHk6yaI
 8aDEqoxZ/6L+ueJ+HnhSq2WG54DD13CJLnt+TpOPQaeRjHpyXoZ+QgoRLyUanOcGVdlz
 H7rL6RRnBdLcPkdOgn5Kljzn/3koRynhZKU3B60OtlxOfwx+EGKAKBU9/ryWkltp+QKx
 4nKk39Dw9/3lmlPC7P74Wij3sx7gxyh8cpNihWFpTcP+juUJVo2ZgJ+55fPic4fFD/V4
 rHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892799; x=1693497599;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tO/aj0lDf7Sy00wBoehQb/HstDLhUivuRJRwPhuG/uY=;
 b=cDjsjh0cYSUw+fKuJQY1BY6S/P0IdH518XAMwkzPC7X+HO2xwEQIQgky+PU6NE4yMW
 4C3UCbpxRm8ydnkZ6ACCcCZ/6Jkd3gQTSS7jP7/wzKKNzqZB5rE+PT0gPIk/AQxOM75U
 KUp9K0i1r4i0W+HCsBJZ/9SiizkiyOoQl1KYIHhSO+pVJnNMdgwfefN5EfAyRVGnv6as
 ZAJazaUiNcj8zoVSqgYG3sK+2xiH1PKrke/IEspBCL++colILTqDB1oUF5DU2KNvJGRD
 Z5CULDdqtUxzkF2mb91S5KIHx6BUAAUjAvxHZYHW8FaZkgbBXk03vQsFMu988BFB50N+
 GC7A==
X-Gm-Message-State: AOJu0YxLZ6+Qt/89R3lpBrWheKt/bU1u4OVhlbZxYBo8vJziqIEOzTRh
 NQbMTWWsgw5zlnCk4raDg5GAVQ==
X-Google-Smtp-Source: AGHT+IFFxy62qjkCzKAZ1NsifvXaUoCBAZQOuha2m1kSvAuSU1GLYSTHseREsbWxfzsq0bucmhZPhg==
X-Received: by 2002:a5d:6290:0:b0:317:51ff:c249 with SMTP id
 k16-20020a5d6290000000b0031751ffc249mr11296531wru.13.1692892799423; 
 Thu, 24 Aug 2023 08:59:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a7bcc81000000b003feee8d4b92sm2989925wma.47.2023.08.24.08.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:59:58 -0700 (PDT)
Message-ID: <b7ecb209-ecc9-cd17-4d2b-6d58a44e148f@linaro.org>
Date: Thu, 24 Aug 2023 17:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Matt Borgerson <contact@mborgerson.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
 <874jm2ya3g.fsf@linaro.org> <87sf9mwnzo.fsf@linaro.org>
 <CADc=-s46VkRZiU--59VdeTcACoir1srxV=eTxPwwwut_tSJESQ@mail.gmail.com>
 <87cz0o27l9.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87cz0o27l9.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 19/7/23 00:05, Alex Bennée wrote:
> 
> Matt Borgerson <contact@mborgerson.com> writes:
> 
>> Thanks Alex!
>>
>>
>> On Mon, Jul 17, 2023 at 8:34 AM Alex Bennée <alex.bennee@linaro.org> wrote:
>>>
>>>
>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Matt Borgerson <contact@mborgerson.com> writes:
>>>>
>>>>> Translation logic may partially decode an instruction, then abort and
>>>>> remove the instruction from the TB. This can happen for example when an
>>>>> instruction spans two pages. In this case, plugins may get an incorrect
>>>>> result when calling qemu_plugin_tb_n_insns to query for the number of
>>>>> instructions in the TB. This patch updates plugin_gen_tb_end to set the
>>>>> final instruction count.
>>>>
>>>> For some reason this fails to apply cleanly:
>>>>
>>>>    git am ./v2_20230714_contact_plugins_set_final_instruction_count_in_plugin_gen_tb_end.mbx
>>>>    Applying: plugins: Set final instruction count in plugin_gen_tb_end
>>>>    error: corrupt patch at line 31
>>>>    Patch failed at 0001 plugins: Set final instruction count in
>>>>    plugin_gen_tb_end
>>>
>>> I think some newlines crept in, I was able to fix. Queued to
>>> for-8.1/misc-fixes with the assert added.
> 
> Hmm so I ran into an issue:
> 
>    ./qemu-sh4 -plugin tests/plugin/libbb.so -d plugin ./tests/tcg/sh4-linux-user/testthread
>    ERROR:../../accel/tcg/plugin-gen.c:874:plugin_gen_tb_end: assertion failed: (num_insns <= ptb->n)
>    Bail out! ERROR:../../accel/tcg/plugin-gen.c:874:plugin_gen_tb_end: assertion failed: (num_insns <= ptb->n)
>    qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>    bb's: 9202, insns: 42264
>    fish: Job 1, './qemu-sh4 -plugin tests/plugin…' terminated by signal SIGSEGV (Address boundary error)
> 
> Further investigation shows that gUSA sequences can cause the number of
> instructions to run ahead, which also makes the setting of the ptb->n =
> num_insns unsafe, running ahead of the number of instructions signalled
> by plugin_gen_insn_start/plugin_gen_insn_end.
> 
>    Thread 1 hit Hardware watchpoint 5: *(int *) 0x7ffd410a2904
>    Old value = 4
>    New value = 1
>    0x000055f148c00ea8 in decode_gusa (ctx=0x7ffd410a28f0, env=0x55f14a4106e8) at ../../target/sh4/translate.c:2167
>    2167        ctx->base.num_insns += max_insns - 1;
>    (rr) p max_insns
>    $6 = 4
>    (rr) p max_insns -1
>    $7 = 3

Is this the 'fail' label? (You can check by using '-d unimp'
which would dump "Unrecognized gUSA sequence").

'fail' is followed by 'done' which updates ctx->base.num_insns.

>    (rr) p ctx->base.num_insns
>    $8 = 1
> 
> So I think we have to drop this for now until we can either fix
> decode_gusa or find something else.
> 
> Richard,
> 
> Any ideas?
> 
> 
> 


