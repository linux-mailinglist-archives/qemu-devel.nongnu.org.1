Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC644715B41
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wMm-0006Dd-AO; Tue, 30 May 2023 06:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q3wMj-0006DL-T2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:14:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q3wMi-0000Mk-6U
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:14:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f70fc4682aso2559305e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685441646; x=1688033646;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxqed2gMToKiYKu8tgJQbHBTP075yuri5d84JTRlqsI=;
 b=agn4fbvV2Yd9rEn6XiqCUrxgBkr96LyICodgDvIHMu3Ykv6cUq6MDEKAhihQn2PHI/
 K6p5MO7cVQI4MoWOEM0gfmAEDBEQ8nroCHEx4Pjr/Dtl82bjXQ58H8N8hNAHrcpkvzrZ
 svL3WF10m48k4QT1EyDrOhYozDbB9Jps4yRbqxLBK8i49RTHvPkHTmBptIur0HcMKfa6
 /cBNG3UWsWBa3GjL8Pq+w0OIjCNRAyc61I5j0qHAB8xYYSkEuzoJ8uiXX8c/IRAK+tpn
 laWbh9/PIJ6NFIASLyPzcdUupGgLcnggyrNCYlVfRDcbVdmPdkDmywGBgJuay0ZzC5zw
 SYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685441646; x=1688033646;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pxqed2gMToKiYKu8tgJQbHBTP075yuri5d84JTRlqsI=;
 b=F1B/ORfelO/tBk4nLDhUfQZVq+mX/PTLVmpdpaB53leY27Bp9+55SD4tGCMFdah17S
 hGU20+XAFVtHB0iCIhXBOi/h16Q33IDVBD/GjUKnyhsJr5aHebLZ68AjxbL+9DuINg8X
 sZ+a5QEor9fnLaenPOyoSyvv6FeWgGAZve5WMGidOLcmNdEsMiIyexl1ogojmHJJ/mTi
 0Z87Ph88+mfUqHq7KUvHo+rLV3kKDN+gEB9oynjqTXrm16eoPjOO6fFfQE7tW0Eo8cRv
 KrXWTf1WMDzeDW+4bpFSBNfSaAP/PqfP6X1ViSQOG3vUJ5Pz2Rg/8WX6L91z3MqyUhGH
 p5nA==
X-Gm-Message-State: AC+VfDxQH2nB8MJorL8rEj8EcKiJ6SXLLLSBXArA84vRX3BLnRVpVlE/
 OEHcJ8DHz3ED77DQxWOcYnwBxQ==
X-Google-Smtp-Source: ACHHUZ5d1Ice36e2LscnCBZ+jxDR3Gq32d3HDhBLG31YNOi+5XXRV400jZTozsxv44lXtNlUJLNsSg==
X-Received: by 2002:a05:600c:b4b:b0:3f4:e4cd:f6e with SMTP id
 k11-20020a05600c0b4b00b003f4e4cd0f6emr1352469wmr.17.1685441645799; 
 Tue, 30 May 2023 03:14:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a7bcd0d000000b003f60d0eef36sm20601138wmj.48.2023.05.30.03.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 03:14:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 134C31FFBB;
 Tue, 30 May 2023 11:14:05 +0100 (BST)
References: <20230529114947.2123652-1-fei2.wu@intel.com>
 <20230529114947.2123652-5-fei2.wu@intel.com>
 <98196efc-213f-3351-1564-5008ccd90f36@linaro.org>
 <ddc552ba-c95d-4b31-01d2-a6d70a978f1c@intel.com>
 <a6a88248-4142-baa6-dc86-b6d471477384@intel.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v13 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Date: Tue, 30 May 2023 11:08:18 +0100
In-reply-to: <a6a88248-4142-baa6-dc86-b6d471477384@intel.com>
Message-ID: <87cz2idt3m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


"Wu, Fei" <fei2.wu@intel.com> writes:

> On 5/30/2023 1:01 PM, Wu, Fei wrote:
>> On 5/30/2023 12:07 PM, Richard Henderson wrote:
>>> On 5/29/23 04:49, Fei Wu wrote:
>>>> +/*
>>>> + * The TCGProfile structure holds data for analysing the quality of
>>>> + * the code generation. The data is split between stuff that is valid
>>>> + * for the lifetime of a single translation and things that are valid
>>>> + * for the lifetime of the translator. As the former is reset for each
>>>> + * new translation so it should be copied elsewhere if you want to
>>>> + * keep it.
>>>> + *
>>>> + * The structure is safe to access within the context of translation
>>>> + * but accessing the data from elsewhere should be done with safe
>>>> + * work.
>>>> + */
<snip>
>>>> +=C2=A0=C2=A0=C2=A0 int64_t cpu_exec_time;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t op_count; /* total insn count */
>>>> +=C2=A0=C2=A0=C2=A0 int64_t code_in_len;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t code_out_len;
>>>> +=C2=A0=C2=A0=C2=A0 int64_t search_out_len;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Timestamps during translation=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t gen_start_time;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t gen_ir_done_time;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t gen_opt_done_time;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t gen_la_done_time;
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t gen_code_done_time;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* Lifetime count of TCGOps per TCGContext */
>>>> +=C2=A0=C2=A0=C2=A0 uint64_t table_op_count[NB_OPS];
>>>> +} TCGProfile;
>>>> +
>>>
>>> Why have you added this back?
>>>
>>> The whole point of removing CONFIG_PROFILE to begin was to have all new
>>> code.=C2=A0 Not to remove it then reintroduce it unchanged.
>>>
>>> In tcg_gen_code, you have access to the TranslationBlock as s->gen_tb.=
=C2=A0
>>> There is zero point to accumulating into TCGProfile, when you could be
>>> accumulating into TCGStatistics directly.
>>>
>> TCGProfile contains global wide (per TCGContext) stats, but TBStatistics
>> is TB specific, some info in TCGProfile such as table_op_count is not
>> able to be summed up from TBStatistics. The per-translation stats in
>> TCGProfile may be removed indeed.
>>=20
> After some cleanup locally, these are the remains in TCGProfile:
> * cpu_exec_time - which is not guarded by tb_stats_enabled, it could be
> moved out as an individual variable?
> * gen_xxx_time - which in kinda global variables across functions to
> calc ts->gen_times

Given the work on JIT profiling I think there is an argument to drop the
time profile bits and pieces. I think you can get the same information
from a perf run although it does amortise the cost of generation over
all translations. Do we see any particular TBs that are particularly
expensive to translate by more than a standard deviation?

> * table_op_count - it's indeed guarded by tb_stats_enabled, but it's a
> large array, it might be too large to put into TBStaticstics.

Probably. This is probably more interesting information as an aggregate
than per TB.

>
> Thanks,
> Fei.
>
>> Thanks,
>> Fei.
>>=20
>>>
>>> r~
>>=20


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

