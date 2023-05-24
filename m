Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E070F880
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pK8-0000qB-Hv; Wed, 24 May 2023 10:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1pK0-0000pX-5q
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1pJy-0003HP-Aa
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684937913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRL4br8rQ4fNGs5xVXBCwyQFdbEwpLBE3Moduh9YvJw=;
 b=A7j1Pk1HCyex0ncHHyWlooGl6pwP5dlJ3RRRTyhXQl7Yd3v3DxskBhjcKFZgOtOz6iB3wl
 Lji4cpE7dHXvDIwTHhBzY3kqAbrgdvW3juiDhqNiaEWmtx9zOzvSS3zJNmJtijaYAXsG+m
 hotIINKQ4xSvI698q43ZRznPc18e3vc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-GMxOo_M9PY2QZO1WvNFvgg-1; Wed, 24 May 2023 10:18:30 -0400
X-MC-Unique: GMxOo_M9PY2QZO1WvNFvgg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62386d1f3ecso6443456d6.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684937910; x=1687529910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oRL4br8rQ4fNGs5xVXBCwyQFdbEwpLBE3Moduh9YvJw=;
 b=IC3KMjarFmWkXOGXMKj7yIo2VjiljJadHPsNdwaKkQ9t7GqbmDX8aZh8ETiZJIJLWG
 A3cBwdtc+zFarxA0hrf71h52zWEjwo0E7O0tKyxCGmodd51PAA0gG2KYUf6hS0A1cjXT
 j+sOzyaw2vDru7HPEkJwhoGvvm8Fec4cqyL2+E9N2f/lIz3hbH2HSFy02EHjnIF9ETwm
 Hti5QLbdPIIkVUCewkRJ/nHehbvWtv55J6bW/09Vcua/69aqa1yAizqTLggN7KUS8MeV
 YKZVxWSH8om52sqGK4OjCUMFBP0lv1c0iZr1Juj1Tri/HUlmbcqE1A3y6BHXnxP4IXfz
 qG1Q==
X-Gm-Message-State: AC+VfDymQOn6NnjhRdE/gg0NzM66OHaG4/fvBlvtVQCObu/UYFNU85Uc
 MSN/tUMVta0sgmMVBKmnuKD1xlcuSNY7ASYG5KijYMi3K7gv28ISSz07OSE9n6MTgyxqPOWM3mj
 fYF+iVS2dWIFH/44=
X-Received: by 2002:a05:6214:528a:b0:56e:bfda:a14f with SMTP id
 kj10-20020a056214528a00b0056ebfdaa14fmr25221772qvb.9.1684937910389; 
 Wed, 24 May 2023 07:18:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7J74dKPNA0NsqnWjYd0Yr1u5F24iFbOuTJNy8g1Uv1tF9pDEom9lPlmMna/IFWxK/+i72F5w==
X-Received: by 2002:a05:6214:528a:b0:56e:bfda:a14f with SMTP id
 kj10-20020a056214528a00b0056ebfdaa14fmr25221747qvb.9.1684937910152; 
 Wed, 24 May 2023 07:18:30 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 u11-20020a0cf88b000000b0061b7bbb7624sm3601142qvn.130.2023.05.24.07.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 07:18:29 -0700 (PDT)
Message-ID: <8833f725-9834-b131-5d79-13592969257a@redhat.com>
Date: Wed, 24 May 2023 16:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/qtest: Run arm-specific tests only if the required
 machine is available
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
References: <20230524080600.1618137-1-thuth@redhat.com>
 <1d3d36da-3b7a-ebbe-6339-0c707b329e45@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <1d3d36da-3b7a-ebbe-6339-0c707b329e45@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/05/2023 16.01, Philippe Mathieu-Daudé wrote:
> On 24/5/23 10:06, Thomas Huth wrote:
>> pflash-cfi02-test.c always uses the "musicpal" machine for testing,
>> test-arm-mptimer.c always uses the "vexpress-a9" machine, and
>> microbit-test.c requires the "microbit" machine, so we should only
>> run these tests if the machines have been enabled in the configuration.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/qtest/meson.build | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 4c5585ac0f..087f2dc9d7 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -198,14 +198,15 @@ qtests_arm = \
>>     (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? 
>> ['cmsdk-apb-dualtimer-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? 
>> ['cmsdk-apb-timer-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? 
>> ['cmsdk-apb-watchdog-test'] : []) + \
>> -  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? 
>> ['pflash-cfi02-test'] : []) +         \
>> +  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
>> +   config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] 
>> : []) + \
>>     (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) 
>> + \
>>     (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
>>     (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? 
>> ['hexloader-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? 
>> ['tpm-tis-i2c-test'] : []) + \
>> +  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : 
>> []) + \
> 
> Also ARM_MPTIMER?

Not needed: config VEXPRESS selects ARM_MPTIMER, so there is no way that 
VEXPRESS could be set, but ARM_MPTIMER is not selected.

  Thomas



