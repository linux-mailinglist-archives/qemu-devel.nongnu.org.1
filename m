Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CD2759926
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8kL-0004dJ-Gh; Wed, 19 Jul 2023 11:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM8kG-0004bb-Vm
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:05:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qM8kF-0003Xv-7s
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:05:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so5936975e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689779136; x=1692371136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m5fidQ4YGykwofCDWsNPXQXLHM4Q8nH0nVVR3QjspZE=;
 b=BOwH85ldTJQDng+qDJcxxfRgFoSLZBcIMoHEmhtn5VE5dFtnujnPMfii2JL1AWi48e
 vXvhj129UQel5yZHoF+rCYZecHFaCOeJ8gIKgaU3KAuGbyxKJJo4n9oWh2q6K8pfZ6V0
 PMqOUnRan3UUQ2S+3ZMrGIRlM00/0by2hA6XAFwT/j7K1jAJI0CExJN90zl12r72h4b4
 SpMd+LGmYJEuqqqNE6uAIFzBM8XHm7MNZCc/AJ8/ug6rZTLzwB0d3N2S9FITera7I7JZ
 lpKn7C3yZxZVriJNe3GjokRt+4R+0E8TB5XE23q2tkpiIqYYlPhbuQOdByvjSqu6JUA3
 Y3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689779136; x=1692371136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5fidQ4YGykwofCDWsNPXQXLHM4Q8nH0nVVR3QjspZE=;
 b=h3qXb2M3OVc79RgKxjD3b8ut1qQeWMfWiyBuZn6orAH0H4yTFHe4aoO7eI1/2KgE0U
 P3Wjlz4VGneKhFEjndE0fEmvEtMYWXGb7WaTi55/VlEk0CQf3fsoMN+Nr2xACkOAsjwC
 kt1gUIjc0d6Mvj6+MDNyq7p5M470QKJO2e/aH31lhFZ03EOKEPsLSmM8/IOhlAqifTzI
 ye5A0imZv0rsfMm+QvGVGLJOhPros0OSORXpMDbXbHnYjEl5XXvJoGe9sCCblNMSp1PP
 IzYbGYBPoCkp/1yNqxmIyLTD66WmDK4/8IvcMRRgd84mDuPUNGulZQ+axzxi2rHSJRUM
 jpJA==
X-Gm-Message-State: ABy/qLbvb/WLt+bItrqKm/E9xt1MWNOoX6D9R6zIZfgiQfXE2FFrEI/9
 CviXmEy2W1b57OWqkeMUkrKWjQ==
X-Google-Smtp-Source: APBJJlHulmRIdt9PODZUM7Tp73gfzLjYnrt2l9pj8kBq5jrDAlSla4BN9Xf0S7ecy8do4nd9lXh5NQ==
X-Received: by 2002:a5d:484d:0:b0:314:d00:7352 with SMTP id
 n13-20020a5d484d000000b003140d007352mr1165wrs.32.1689779136085; 
 Wed, 19 Jul 2023 08:05:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.201.220])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d67c6000000b0030e5bd253aasm5547761wrw.39.2023.07.19.08.05.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 08:05:35 -0700 (PDT)
Message-ID: <6feba081-811a-527a-4188-124b0494f6fa@linaro.org>
Date: Wed, 19 Jul 2023 17:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PULL 0/8] s390x, qtest and misc patches for QEMU 8.1 rc1
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230718093040.172145-1-thuth@redhat.com>
 <CAFEAcA_AkKFnTCHEe+3Ah6sLrOdcuLOS+WtYV8RkQhA6z=T-yg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_AkKFnTCHEe+3Ah6sLrOdcuLOS+WtYV8RkQhA6z=T-yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 19/7/23 14:40, Peter Maydell wrote:
> On Tue, 18 Jul 2023 at 10:31, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f7:
>>
>>    Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-17 15:49:27 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2023-07-18
>>
>> for you to fetch changes up to a5754847e0fc2bc08a414dd381803009e8bca390:
>>
>>    tests/avocado: Disable the test_sbsaref_edk2_firmware by default (2023-07-18 11:22:51 +0200)
>>
>> ----------------------------------------------------------------
>> * Fix s390x KVM guests when compiling with --without-default-devices
>> * Fix /proc/cpuinfo features list in s390x linux-user emulation
>> * Generate FreeBSD VM package list via lcitool
>> * Disable the flaky test_sbsaref_edk2_firmware avocado test by default
>>
> 
> 
> 
> Applied to target-arm.next, thanks.

s/target-arm.next/master/ ;)


