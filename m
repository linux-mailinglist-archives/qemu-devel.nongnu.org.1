Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F66379E015
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 08:34:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJR0-0002Rw-PU; Wed, 13 Sep 2023 02:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJQy-0002RX-9d
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:33:08 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgJQv-0001Fy-LK
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:33:07 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so1234225a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694586784; x=1695191584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBqoLX8n4mBPQs1Fsg8dkBrrU8QOs/EEJuvO0t7lf/s=;
 b=WPqDALFou75AOCVi2srlSeSnZ5twTmcy9F2pY44pvMQ968CVo/qhJGWTpvzKXw6KBp
 vRTJEekkxLk4dD71UEJWcfu7dXgYEjaa0mKt47IoJZmgto3fxjMsKziYeC2fEUVtE7ep
 E8AywWIV5tOgE8n/zZ2oIcDLz80OnBFe8UG2Pk3htEtyXkTJocr6DB8T6lX2f/m1bWTq
 UYzjpc/ocbPLmH6yjP1znIKz0Y4hXvKuV6Envc+q6VT/iMuZ9CpoC8WscyJn1OZCRKlX
 NpEErJcIK76hwCahOtxWciIysmPyB8z3oQVIECRSfCnvIU1wtH4H26g6q1qHN4NapD31
 c4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694586784; x=1695191584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IBqoLX8n4mBPQs1Fsg8dkBrrU8QOs/EEJuvO0t7lf/s=;
 b=wD3jkRh1v38hSsMAgAqa4tCjlAwuc5VmwbeEIOWrYJq9eIAEC0x6FmLtlR7a3/FAkw
 BcL0Q3YZw3AUxbi8qAztYRQwMhi1QjlTZ/peEsVuTmDJmAXCUihOGkMyA7oSp+c0izpr
 UuRS3xl6kBDn8/0W46lI5L2p+v4C8PU19/LlRfhP/8S+gSYLAnk+uHE6baazKP5zOEFd
 E/3AmvupPt1N/J5vUSOnX7BeM4mfsJyGZHRR6WhsXz7CtiQSCAjp7R3Bqz1AOv1VqZjM
 0LFGjjV7pqEG11bj9Zbtr406h7qAqLWgQaIGlVQAOl9mqSxZ4eHsblxyEH7hPXG2AR1q
 +drg==
X-Gm-Message-State: AOJu0YwdX97Xv6hi3+Z5CWBPNv1VWdgvxi+UiEUU1IFZ69EkwVzTGUKz
 egVJ/dy+UrMR/lkz2818dhSq8A==
X-Google-Smtp-Source: AGHT+IENdmcJARXfZVVX1LtplJqC4G9SExLMGDxMZj52L6CjMRCdxKmz1xBpCaRZyichT5IBJfyB1Q==
X-Received: by 2002:a17:906:74dd:b0:9a5:cc2b:50e5 with SMTP id
 z29-20020a17090674dd00b009a5cc2b50e5mr2419702ejl.32.1694586783857; 
 Tue, 12 Sep 2023 23:33:03 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 q18-20020a170906a09200b0099b8234a9fesm7903371ejy.1.2023.09.12.23.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 23:33:03 -0700 (PDT)
Message-ID: <3cc2c925-d2a8-36f4-28b6-db391b5bbf38@linaro.org>
Date: Wed, 13 Sep 2023 08:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/i386/pc_piix: Mark the machine types from version 1.4
 to 1.7 as deprecated
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-discuss <qemu-discuss@nongnu.org>
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20220117191639.278497-1-thuth@redhat.com>
 <YeXNoKzsFeIPSy6E@redhat.com>
 <44b4ce3f-030a-993a-b959-e8e722c7cee4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <44b4ce3f-030a-993a-b959-e8e722c7cee4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 18/1/22 09:49, Thomas Huth wrote:
> On 17/01/2022 21.12, Daniel P. Berrangé wrote:
>> On Mon, Jan 17, 2022 at 08:16:39PM +0100, Thomas Huth wrote:
>>> The list of machine types grows larger and larger each release ... and
>>> it is unlikely that many people still use the very old ones for live
>>> migration. QEMU v1.7 has been released more than 8 years ago, so most
>>> people should have updated their machines to a newer version in those
>>> 8 years at least once. Thus let's mark the very old 1.x machine types
>>> as deprecated now.
>>
>> What criteria did you use for picking v1.7 as the end point ?
> 
> I picked everything starting with a "1." this time ;-)
> 
> No, honestly, since we don't have a deprecation policy in place yet, 
> there was no real good criteria around this time. For the machine types 
> < 1.3 there was a bug with migration, so these machine types could not 
> be used for reliable migration anymore anyway. But for the newer machine 
> types, we likely have to decide by other means indeed.
> 
>> I'm fine with the idea of aging out machine types, but I'd like us
>> to explain the criteria we use for this, so that we can set clear
>> expectations for users. I'm not a fan of adhoc decisions that have
>> different impact every time we randomly decide to apply them.
>>
>> A simple rule could be time based - eg we could say
>>
>>    "we'll keep machine type versions for 5 years or 15 releases."
>>
>> one factor is how long our downstream consumers have been keeping
>> machines around for.
>>
>> In RHEL-9 for example, the oldest machine is "pc-i440fx-rhel7.6.0"
>> which IIUC is derived from QEMU 2.12.0. RHEL-9 is likely to rebase
>> QEMU quite a few times over the coming years, so that 2.12.0 version
>> sets an example baseline for how long machines might need to live for.
>> That's 4 years this April, and could potentially be 6-7 years by the
>> time RHEL-9 stops rebasing QEMU.
> 
> Yeah, 5 years still seemed a little bit short to me, that's one of the 
> reasons why I did not add more machine types in my patch here. I think 
> with 7 or 8 years, we should be on the safe side.
> 
> Any other opinions? And if we agree on an amount of years, where should 
> we document this? At the top of docs/about/deprecated.rst?

I suppose x86 being the oldest, x86 maintainers have to comment, but
5 years should be enough from sysadmins to migrate their VMs, isn't it?
(No need to migrate from 1 -> 8, they can do 1 -> 3 -> 5 -> 8, right?)

Anyhow you are right, better is to clearly state that in deprecated.rst,
at least to start and widen the discussion.

