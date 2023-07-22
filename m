Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0559675DCAF
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 14:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNC3Q-0004O4-Is; Sat, 22 Jul 2023 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNC3N-0004Np-Qm
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 08:49:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNC3M-00070X-71
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 08:49:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so23111205e9.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690030182; x=1690634982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hit/cGv4qMF9DxRtZzXy2dYJTyhiE1yhNWb3b5eWiHM=;
 b=kZ0EaQ23iKGJK1i8dbIDvCn8D5FSG0J9+CZCdGh7wKOO5OCscg6rNxA5KOlbZMI6eD
 sujcQpUlYuYnRGSXQWcKbGdLoZtT2EA/9hVOqThuZLj+EoahcfjCIzmp0IVBjJykRYjm
 X4NXw7X7Z/ov7MnE179xW0mf1zJuofGSlt+vdUx5PdQFciY+xmaez1X7eoUj3yKONy3F
 vU2fkm/FI6jAs1nJl4abdOAYonojDnqhigL/ClvD4r1P1C+fxlmVsyTAdmMIui7XaRRW
 P23XASKslEhCGnUroLETN6KNQ+TzqeWDSL+s7pFvzKPTf2j3kthuhDzGMV3KqSTAd+GL
 Hw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690030182; x=1690634982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hit/cGv4qMF9DxRtZzXy2dYJTyhiE1yhNWb3b5eWiHM=;
 b=LuBwwVe22N84ZmReCh8WpRfQEEgtjUtrTCUT+9Qq0T+7RJQJQYkON85Ck8Xu+F4Kym
 T8Gb+C9nECHsHCiEA7bokX/fLSOrCQiTFoimHrFih/TZE4WybWhe7ctB3ZoLaoaHT/BU
 0ABiBjDQQGQLoLnhYchEIlMiPHcsru0/KkNFlEA7Ppb1jk8q5tMN/d6kMJ5LA8rUxVDO
 KkDEPKRBpZP0fTFMXJjSJNInEqYEEN7WAAzaIF6rmK23iLK5M3J2SGZlADWx+9sJbyb8
 +5SvwiJ1P8r80E7puQd6hN612TFAyPklD5unvfXqGIShOhi3GCfLpdPiMFvqmNBXg/BD
 lTdA==
X-Gm-Message-State: ABy/qLbh3vAPtFhEWxKT3M3kPVkOIfULQN1uWA8PUWXwwiIb8nkZNydZ
 S3HG50k1n6J4Z8J8JusbNiE2JQ==
X-Google-Smtp-Source: APBJJlFA1VATQL/JROKb6FNOPt8CVVK7xaACzC/T9Z6PzCy8XXKGQbEJM8z6Z5ADIL3WVff+zRdNjQ==
X-Received: by 2002:a7b:c3cb:0:b0:3fd:45b:45f8 with SMTP id
 t11-20020a7bc3cb000000b003fd045b45f8mr3581568wmj.23.1690030182524; 
 Sat, 22 Jul 2023 05:49:42 -0700 (PDT)
Received: from [172.20.13.195]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a7bc4c9000000b003fbca05faa9sm5263710wmk.24.2023.07.22.05.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 05:49:42 -0700 (PDT)
Message-ID: <f2beeb1e-fc2d-9fdd-303f-d1722aeaf63d@linaro.org>
Date: Sat, 22 Jul 2023 13:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: 8.1-rc0 testfloat fails to compile
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230720224656.2841ff5f.olaf@aepfle.de>
 <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <74d1ee57-04a7-37f7-2c85-6ce49b4ded3a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/21/23 07:54, Thomas Huth wrote:
> On 20/07/2023 22.47, Olaf Hering wrote:
>> This is going on since a few weeks. I guess there is no check in CI to see if 
>> qemu.git#master compiles in Tumbleweed.
> 
> We only have a check for openSUSE leap ...
> Which compiler version is causing trouble for you?
> 
>> Since the switch to meson submodules, berkeley-testfloat-3 became mandatory. I think in 
>> the past I was able to ignore this submodule and not export it, so the following error 
>> did not show up:
>>
>> [  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c: In function 
>> 'f64Random':
>> [  141s] ../subprojects/berkeley-testfloat-3/source/genCases_f64.c:559:1: error: control 
>> reaches end of non-void function [-Werror=return-type]
>> [  141s]   559 | }
>> [  141s]       | ^
>> [  141s] cc1: some warnings being treated as errors
>>
>> Apparently this is a known issue, 3ac1f81329f attempted to ignore such errors.
> 
> Seems like the flag got lost in commit d2dfe0b506e47e14 ... Paolo, any ideas?
> 
>> Do I need to tweak the global, system-provided CFLAGS myself, or can the source be fixed 
>> to address this? Disabling this error globally will hide errors elsewhere.
> 
> We are using a forked version of the berkeley-testfloat repository, and it's possible to 
> add patches there:
> 
>   https://gitlab.com/qemu-project/berkeley-testfloat-3
> 
> The f64Random function that you mentioned above could easily be fixed by adding a 
> "default:" case to the switch statement, I think. Are there any other additional 
> warnings/errors after fixing this?
> 
> Feel free to send a patch and CC: the people from 
> https://gitlab.com/qemu-project/berkeley-testfloat-3/-/project_members

If this is with optimization enabled, the bug should be reported to gcc bugzilla.
The compiler should easily prove the default case is unreachable.


r~

