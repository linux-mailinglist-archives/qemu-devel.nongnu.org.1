Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E535E793F18
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtht-0000mA-Un; Wed, 06 Sep 2023 10:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdthr-0000m1-Sc
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:40:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdthp-0006qB-EA
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:40:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso35597205e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694011230; x=1694616030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWsSqoKKxXIkk/U2ijcNmwCsSUowIUUvLPrv0bANexk=;
 b=DYEWXXqZsHQtpi6d9wapXhvMkUa083Wftjz3FIpIFKIvCKTC3Ej4HNrYlaNk3k9mky
 9pzBiKt/FSJRgefmbQ67py9K+VNQwcpci517uZyI3CH9Np1H1GkxTp2VZldaNNc/TRj/
 zbjUlFfF5v6HQ5NfP4r4/1cGaqsauK0Dgl14OsJT4KCWP3ErFEqMrbfZOYo13zO5A1EQ
 goYG1qPNe2ym796dhNd2SowWpA1gclF209C+znHhe9PZ8HbCGAYF53yd08sAPpO4HkVu
 0Tae1SNLpqyJMH7Wu4d/PD7wz2M/o8gX1MuMAK7NJ0KeIsfURbwVnm59I1o2i+T4613/
 9e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011230; x=1694616030;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWsSqoKKxXIkk/U2ijcNmwCsSUowIUUvLPrv0bANexk=;
 b=aPFvqnj96j7RFEY/0L3chgyNzhcade9px1rSKpn9mxerWz78DUnWXHNsH9mqMm0tCr
 lKo+qmSvcaHX2I1S8PEknDCW6SdXU8emaI+k6luvdoD1bRhAOLv6cf/rNnZF5Gjl391J
 KGuY+wbMaR2bwpy8+WAo7ratQaRclm4UA/EtebOia1YxGUsWHhyop0fNN1IFKBoIJfWS
 osiQg11N0IflXPyDfgRZkAN93OAptCQ0Ra0+72K98YyPUcv35Mr2nxNpRpligStmQESF
 kbiSbNhe3mIkgFpTb0mdFG1eEX5HAAId23aYAwWXDKTdRRocb8T0coaiIb4tBtMgAKLV
 0NsQ==
X-Gm-Message-State: AOJu0YwR8EMopPNgMJv7+yyRIknCJLZ54qPVJvLyc7IgM6IY5pD5bjLi
 x5T8Rc65nNAqSKqPtH8erssydQ==
X-Google-Smtp-Source: AGHT+IHkgAdS29xGamrMeyFf4sBXX0dfkogo9LM6hMbDcJe5mtFbsqp6qy7U4ferikvcdA8ypcKFBA==
X-Received: by 2002:a05:600c:218b:b0:402:906:1e87 with SMTP id
 e11-20020a05600c218b00b0040209061e87mr2518976wme.31.1694011230592; 
 Wed, 06 Sep 2023 07:40:30 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 q12-20020adffecc000000b00316eb7770b8sm20849421wrs.5.2023.09.06.07.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:40:30 -0700 (PDT)
Message-ID: <91209058-915c-1284-e521-4b3fe0813293@linaro.org>
Date: Wed, 6 Sep 2023 16:40:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 00/16] tests: Add CPU topology related smbios test cases
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Cc: Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <663cf3d4-47ea-262d-36b3-cf826f870ef0@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/9/23 11:55, Michael Tokarev wrote:
> 25.08.2023 06:36, Zhao Liu wrote:
>> From: Zhao Liu <zhao1.liu@intel.com>
>>
>> Hi all,
>>
>> This patchset is the follow up tests of previous topology fixes in
>> smbios [1].
>>
>> In this patchset, add these test cases:
>>
>> 1. Add the case to test 2 newly added topology helpers (patch 1):
>>     * machine_topo_get_cores_per_socket()
>>     * machine_topo_get_threads_per_socket()
>>
>> 2. Add the cases in bios-tables-test.c to:
>>     * test smbios type4 table count (patch 2-4).
>>     * test smbios type4 core count field (patch 5-7).
>>     * update the test of smbios type4 core count2 field (patch 8-10).
>>     * test smbios type4 thread count (patch 11-13).
>>     * test smbios type4 thread count2 (patch 14-16).
>>
>> With the above new cases, cover all commits of [1] in test.
>>
>> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06225.html
> 
> Hmm.  I definitely didn't expect such a large patchset..  I asked for just
> a small, maybe manual (from command-line) reproducer of the original issue,
> so I can verify it is fixed before applying the change in question to qemu
> stable trees.  It is a large work.  Lemme at least give it a try in the
> gitlab CI...
> 
> Philippe, can you pick this up for the misc tree?

This area have well defined maintainers:

$ ./scripts/get_maintainer.pl -f tests/data/acpi/
"Michael S. Tsirkin" <mst@redhat.com> (supporter:ACPI/SMBIOS)
Igor Mammedov <imammedo@redhat.com> (supporter:ACPI/SMBIOS)
Ani Sinha <anisinha@redhat.com> (reviewer:ACPI/SMBIOS)

So I'll pass ;)


