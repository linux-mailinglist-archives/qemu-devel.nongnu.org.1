Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B0801096
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:53:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96kx-0002WS-FP; Fri, 01 Dec 2023 11:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96ko-0002WC-MR
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:52:39 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96km-0005wJ-UX
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:52:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40b427507b7so17826815e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701449555; x=1702054355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLqrsJyIgN0Yuln7+eEL6VjvTDZW8dgYSvdwKy0MUkE=;
 b=j/Nuh7O/s4XTnihfHCRukA00iFPGy1Y3Bpnk+fKCaQOF4MxUDrzhv9Qsh3jz5N1KbS
 SHA5XPeHq1yADHw/BEs3nik1Scs/ycDCUBtuFsat2L0S6AzxRdmdwv372br3/tHwU5+K
 47i7bDc1JVv8GO01BZIKmatuBBzPKEcqjz88BD6d8REigNuUnQ7jpQ4WfqHolH0bW1vA
 Rlm+JmZtUzuRXN6cCcl7y2uiYUX7QyaJnbnbwyJ1fhjUklyADs1JskwCLFjS2dB5qP6S
 2elBrm+R4kDnPUGPKOYyZPpEsk1N62z66G5IegzElB2uyZ7xzQ0UAm5GXmrE7g/UrTY/
 6kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701449555; x=1702054355;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLqrsJyIgN0Yuln7+eEL6VjvTDZW8dgYSvdwKy0MUkE=;
 b=auGvjeT2QhV8xDiddlUR/oJTg9nGYdWquotzlYs+Pkg4vA35h+UQYoc/36/7myxTkk
 QgZZQJ0aAdKB+xHOY7nsCU/ERxrrLG7S8glAPO8dE6vAL99ebLCtiBoUIudQt5rwLCwJ
 KNgy9+/I0q4NrAVd+cihYU+ivKWJj0sIlk3dA7LLHbwrpQwtvQXG8og/Zu4XRc0M/Yuc
 QsFmvmL3XffTYn6vzivzsX7PD/oVD6PQ9BNvatulOsAaoP8N3Z8fLlf3qs/fdB1J+a8D
 2qYayaeNCIHoACRBOHnJoL+ZV/Q/wUJJBxkufAhv7B9BYuAS+h7jqOhv7e1XOTirOPvQ
 oR6A==
X-Gm-Message-State: AOJu0YySpqYTjxa01d4bcWBoFi9RpnhQO8lVFst3N6SG8TYmohxoLSur
 YBLArCPHiQhw+/RkfrHT749LHm36OWXGi2jiZW4=
X-Google-Smtp-Source: AGHT+IF0bFNQNQbb8Eq4PpZrHnnxT+QRWqHCcRE+I8OWSSbP5CsdoHHmYKFsjUk7QEhfI66TwJQD1g==
X-Received: by 2002:a05:600c:4f0d:b0:40b:5e21:cc20 with SMTP id
 l13-20020a05600c4f0d00b0040b5e21cc20mr534104wmq.75.1701449555364; 
 Fri, 01 Dec 2023 08:52:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c444900b0040b461550c4sm9675100wmn.42.2023.12.01.08.52.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 08:52:35 -0800 (PST)
Message-ID: <0ac3a8ef-894f-4405-b816-c06dbb62e051@linaro.org>
Date: Fri, 1 Dec 2023 17:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] gdbstub, avocado and gitlab updates
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
 <7727c4ad-b6a2-49f5-88bf-0ac83e93f570@linaro.org>
In-Reply-To: <7727c4ad-b6a2-49f5-88bf-0ac83e93f570@linaro.org>
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

On 1/12/23 17:50, Philippe Mathieu-Daudé wrote:
> Hi Alex,
> 
> On 1/12/23 16:12, Alex Bennée wrote:
>> The following changes since commit 
>> abf635ddfe3242df907f58967f3c1e6763bbca2d:
>>
>>    Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/stsquad/qemu.git tags/pull-more-8.2-fixes-011223-1
>>
>> for you to fetch changes up to a7a740cce1ec49568e7ebd8e776279e59e2fb5b6:
>>
>>    gitlab: add optional job to run flaky avocado tests (2023-12-01 
>> 14:12:05 +0000)
>>
>> ----------------------------------------------------------------
>> Flaky avocado tests, gdbstub and gitlab tweaks
>>
>>    - gdbstub, properly halt when QEMU is having IO issues
>>    - convert skipIf(GITLAB_CI) to skipUnless(QEMU_TEST_FLAKY_TESTS)
>>    - drop mips malta cpio test as assets expire in Debian archive
>>    - tag sbsa-ref tests as TCG only
>>    - build the correct microblaze for avocado-system-ubuntu
>>    - add optional flaky tests job to CI
>>
>> ----------------------------------------------------------------
>> Alex Bennée (6):
>>        gdbstub: use a better signal when we halt for IO reasons
>>        docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
>>        tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test
> 
> This patch has been posted 5h ago and we are still discussing it...
> I'm quite surprised you include it in your PR.

Do you mind re-posting your PR without this patch? I don't
mind to work on it during the WE and merge it let's say
Sunday, if you want it in before this Monday.

Regards,

Phil.



