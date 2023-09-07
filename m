Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8379703B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 08:10:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe8CE-0006fI-Kq; Thu, 07 Sep 2023 02:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8C7-0006b1-VP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:08:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8C4-0006Jm-6L
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:08:46 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so647551a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694066922; x=1694671722; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYDZWNiLokdJ4Ff1DhUiLUMZwrH1Af5LQlAIdMTWP/o=;
 b=CH18oAH0mTi0K0PVFWfXprHG8BdKIYn+HLmnDBQp2SsbR78TpDESsgcsFEDoxlXyC+
 2wr//zVCSxBiWOd8YrlWSE30LM+ZK3AdLHkuko/jZtDWKcqQC56oM6NK7iS0I0c2ZJiQ
 poehptHtxoYCitsc9ceIq8pkl8CPV/+GUK7TQFPMHOYOkcwP5DajKA34KqT+nQtISRFF
 91Go4bFcK8tz9LWIn4kqROs5/wKl4s94UMkWlJs1Oz05g0AcLX91l2LW/LzxksJIfx6v
 wt+hAyGgkc6+6lCM5Cmv9/aR5znNoEbrhSCoiTgnza40JlbWUoba7Y4uUDdFcPhcfjWH
 ebcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694066922; x=1694671722;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYDZWNiLokdJ4Ff1DhUiLUMZwrH1Af5LQlAIdMTWP/o=;
 b=I4L1iIP4gahNmpSLQqPGbnev9Ay01k1/oUZKtPjXdbf1r1p1i9wzq2OWXFoNT6Z5au
 mUaMRJLRWXuk/fUsh1wQ8j2NlLAuboGBPZBack0wsxjpLtOq03jqE5Pg7YN2zwNKwj/q
 cpOaH0kW6gCvtQeC9DQE+FUfVi0iderDW86yac2xkwHnrVV8Rsx1ly+e7ENkmH4U380x
 aPdT26SCNEVEsSwefjgqirdC5pcqwCDWYkOqjX2RFnUHPbsi8BznfyKcrfMPhGFJir3r
 9uV/KnG5Uu5n+UWxDcxqD+FsyhFVMev/L4GlsXkhA38EyENt9pLh36u12K83+9t5IH0D
 5d6w==
X-Gm-Message-State: AOJu0YzF4utdf2dV9l6lXTXv5xXgvHmWB9p0XcTuUOSAiCeu1uaAoTvm
 LZ66AYRW53MmyX2cSxqWVTTahA==
X-Google-Smtp-Source: AGHT+IHVnT8ZviGzIyalU0NVWt4iS1mDcrtp6YKxPzYAnn66qieH1XZa57q/5SMEEu/OoP3Rrbnw1A==
X-Received: by 2002:aa7:c3c9:0:b0:52b:cbbd:ee90 with SMTP id
 l9-20020aa7c3c9000000b0052bcbbdee90mr3272576edr.26.1694066921785; 
 Wed, 06 Sep 2023 23:08:41 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 d9-20020aa7d689000000b005256ae8494asm9279194edr.17.2023.09.06.23.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 23:08:41 -0700 (PDT)
Message-ID: <e0de73f2-496e-d723-e037-f968d6e7b4cc@linaro.org>
Date: Thu, 7 Sep 2023 08:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL for-6.2 0/7] Ide patches
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
 <CAFn=p-ZJYBNX_ZDbHynmK1Hv-PQHgx7n++1bvEn3Oa7sysRNRQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFn=p-ZJYBNX_ZDbHynmK1Hv-PQHgx7n++1bvEn3Oa7sysRNRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 7/9/23 05:43, John Snow wrote:
> I guess the last time I sent IDE patches was for 6.2 and that tag got
> stuck in my git-publish invocation, oops. I am not suggesting we break
> the laws of causality to merge these patches.

lol

> On Wed, Sep 6, 2023 at 11:42 PM John Snow <jsnow@redhat.com> wrote:
>>
>> The following changes since commit c152379422a204109f34ca2b43ecc538c7d738ae:
>>
>>    Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-09-06 11:16:01 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/jsnow/qemu.git tags/ide-pull-request
>>
>> for you to fetch changes up to 9f89423537653de07ca40c18b5ff5b70b104cc93:
>>
>>    hw/ide/ahci: fix broken SError handling (2023-09-06 22:48:04 -0400)
>>
>> ----------------------------------------------------------------
>> IDE Pull request

\o/

>> ----------------------------------------------------------------
>>
>> Niklas Cassel (7):
>>    hw/ide/core: set ERR_STAT in unsupported command completion
>>    hw/ide/ahci: write D2H FIS when processing NCQ command
>>    hw/ide/ahci: simplify and document PxCI handling
>>    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>>    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>>    hw/ide/ahci: fix ahci_write_fis_sdb()
>>    hw/ide/ahci: fix broken SError handling


