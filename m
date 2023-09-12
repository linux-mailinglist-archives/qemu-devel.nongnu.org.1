Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6262679D6AD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Vj-0006YQ-4d; Tue, 12 Sep 2023 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6VT-0006WY-Jj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:44:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg6VR-0005hS-1z
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:44:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-403004a96a4so38360145e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694537090; x=1695141890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xYzn/3kOKpXxvHMz10ApcHvQSJG8FaIxGybsqApJRpA=;
 b=gwcj6hDmce41k/GKLonijcSudIbbWRbWWYssIYOKMkcVbBfM9M/PDO3BbEX94WDPtW
 w7qLxCeUafAIF/rEpqR8cH7T1USxRuizcWdmTvRQ321T9CtHyAmdFJDCW015r6CXERIx
 1N4VcD8xn39MVSRzqBzKmD5iHXeDN1rsszgkCc99hqPqY93OnZXdh+nmN2HpENbK5KWU
 Mv3q+ZLne5oa9dCp/Th9Sag9VV6HfjOpwid7twFru37jLcDOhcwMoBy95ckc3Z4l2cJk
 bYui5v3fhTnj0su4WPZQjUL2AcYUw8QfXFpo7eBWvGL5qq8RizsJbGv13oDGlMS3rXXN
 xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694537090; x=1695141890;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xYzn/3kOKpXxvHMz10ApcHvQSJG8FaIxGybsqApJRpA=;
 b=I+ZrU5nTEzjjU5Ms1ZZ6x+Occ1L860mVbmgY5IVLLQiHxBMD/uxiv+CqrHj7geXChv
 4aoHHHrtkdhPaqZxb4JVIC3uz3Ukl+alvaptaE5PMbjlo6ppWfBBmjDN2K6fURq9IeFF
 LKqizHmE63hzZeKc1KPzSmenV4SmlYTtOLl6ai/OHvwOz0tp5sPVNBxlTXhRugK5N/ud
 aP42HANIsKO14OVWHB2Q2tdlB1cpC5SBnq8uFrrFCOSOfa0u1AlFWGYtWCPvK/2elpxt
 +UOC8BcjGdajSYWQ6nMy1imVLCU7q/BXxswYtDG6sPEmCEdbi8S+GfXb9wFDLXXQ3gXP
 IHoQ==
X-Gm-Message-State: AOJu0Yyn50cWc668+VuypRJ8+0yc9jk7K07po2vImDZZMdluhvcmgsCS
 Rk3MhrUC6c8BN5S5zPiNv+oldw==
X-Google-Smtp-Source: AGHT+IH5vub4rBT/vbvswzxQwp1f1tgh1SGV+s0iqZ7V+FINUgCe/yHe8M0v8fp7xIKASp2eOFPd5g==
X-Received: by 2002:a7b:c4cb:0:b0:3fd:30cb:18bd with SMTP id
 g11-20020a7bc4cb000000b003fd30cb18bdmr12420154wmk.15.1694537090421; 
 Tue, 12 Sep 2023 09:44:50 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 l12-20020a1ced0c000000b003fe24441e23sm13498474wmh.24.2023.09.12.09.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 09:44:50 -0700 (PDT)
Message-ID: <111b9277-59b6-7252-6ddd-13edff9b2505@linaro.org>
Date: Tue, 12 Sep 2023 18:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 0/3] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230911211317.28773-1-philmd@linaro.org>
 <fabf2451-e8ad-8171-b583-16b238c578e7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fabf2451-e8ad-8171-b583-16b238c578e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 12/9/23 16:07, Paolo Bonzini wrote:
> On 9/11/23 23:13, Philippe Mathieu-Daudé wrote:
>> Too many system-specific code (and in particular KVM related)
>> is pulled in user-only build. This led to adding unjustified
>> stubs as kludge to unagressive linker non-optimizations.
>>
>> This series restrict x86 system-specific features to sysemu,
>> so we don't require any stub, and remove all x86 KVM declarations
>> from user emulation code (to trigger compile failure instead of
>> link one).
>>
>> Philippe Mathieu-Daudé (3):
>>    target/i386: Check kvm_hyperv_expand_features() return value
>>    RFC target/i386: Restrict system-specific features from user emulation
>>    target/i386: Prohibit target specific KVM prototypes on user emulation
> 
> At least, patch 2 should be changed so that the #ifdef'ery is done at a 
> higher level.

I can try to improve it with your comments, but I have no idea of
x86 CPU features.

> However, the dependency of user-mode emulation on KVM is really an 
> implementation detail of QEMU.  It's very much baked into linux-user and 
> hard to remove, but I'm not sure it's a good idea to add more #ifdef 
> CONFIG_USER_ONLY around KVM code.

Do you rather v3 then?

https://lore.kernel.org/qemu-devel/20230911142729.25548-1-philmd@linaro.org/


