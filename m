Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73D830123
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:18:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ17h-0003BS-AD; Wed, 17 Jan 2024 03:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ17d-000390-SY
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:18:05 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ17b-0005R9-Iz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:18:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337be1326e3so1179289f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479481; x=1706084281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ke/xmLkvgzFtvRetxiUKK43zAqZzLNaKwqpGbNxA4QA=;
 b=uw+4ThM5RrQmdfcaK5BHpKkO6GSv/oMb8uljcn6HAiCywZY9e8f9ZNHSjhwMlQOQ76
 61oq+axxaVQ7etaWsukZvNNObBlFkxK0PPvWxStrozVnpsQRJ/aWYHo90YPn7Vm4Ub6I
 v/KZgeBtg1BMBt++Xjv4zXfXFP2A9/oxqSeoVdLt9VurBI3ifcVpQJiq/CEbDH6LdU/h
 m2P1/1HVmz7EeRLKYQkNqoHSL/gPeVOewIq2bx2PR57PAT2HJh98LOiDz/iHzF2XP3A5
 t5w9d0vSb+BbEgVAwueklcu4BYoUR9V/Af+h19n9mQL73ILmhWPyzzrIg9909RhatO4q
 SwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479481; x=1706084281;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ke/xmLkvgzFtvRetxiUKK43zAqZzLNaKwqpGbNxA4QA=;
 b=a/bcOrQTuukWgJF+udTLuqjw5Pc+fKkTS8/QRmOFMaeA89bdINT1CExm9wnNzLLnuc
 4QlMXy11EFpEknzCU87qHr9WDiAy2ZRivHnPHUfBnSkCGa31wdDfh7uaq0RCWmZSv5ok
 p2H7Q9piHebnYChq4BHvTQRPcE8yoqBIsbGYYQUWKQYFSgSZFJRs2xSkiNrhyslhOHLs
 xDyaMn1matL0hseT0JnHPADe2sUeaYKmoS/+hjQVMJ83yNUuLHfy3eiiGd+8vZ5y6hMU
 vBDD3jAHP1q1iHMcSaLe6UincLK8CfBnP8Bk30OXFnUiMW8o3uYlNGTRhZlgymw3ttL0
 AWjw==
X-Gm-Message-State: AOJu0YxRGTo6nByv9jepUdlyDwRJGuBlKZMrf+8uf+zlrV3PQGaSIIHw
 kmb2K3is1xXFINslngjBHO37rHsfAbaoyQ==
X-Google-Smtp-Source: AGHT+IEMjG5MiETyo1GsJ1SyL2iI63HionHWNF3iAy1LiXysN4sjqysCKylm9RYCEwprtszKFjqikg==
X-Received: by 2002:a05:600c:3b92:b0:40e:49e8:4068 with SMTP id
 n18-20020a05600c3b9200b0040e49e84068mr4767452wms.93.1705479481562; 
 Wed, 17 Jan 2024 00:18:01 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:18:01 -0800 (PST)
Message-ID: <0a1d43ac-8249-494c-b34a-6728c9785b01@linaro.org>
Date: Wed, 17 Jan 2024 09:17:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>
References: <20240116230924.23053-1-farosas@suse.de>
 <0f9bb6b0-6292-4926-ad9d-8bc21087c873@linaro.org>
In-Reply-To: <0f9bb6b0-6292-4926-ad9d-8bc21087c873@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/1/24 08:09, Philippe Mathieu-Daudé wrote:
> Hi Fabiano,
> 
> On 17/1/24 00:09, Fabiano Rosas wrote:
>> Avocado needs sqlite3:
>>
>>    Failed to load plugin from module "avocado.plugins.journal":
>>    ImportError("Module 'sqlite3' is not installed.
>>    Use: sudo zypper install python311 to install it")
>>
>> Include the appropriate package in the dockerfile.
>>
>>  From 'zypper info python311':
>>    "This package supplies rich command line features provided by
>>    readline, and sqlite3 support for the interpreter core, thus forming
>>    a so called "extended" runtime."
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/docker/dockerfiles/opensuse-leap.docker | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker 
>> b/tests/docker/dockerfiles/opensuse-leap.docker
>> index dc0e36ce48..cf753383a4 100644
>> --- a/tests/docker/dockerfiles/opensuse-leap.docker
>> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
>> @@ -90,6 +90,7 @@ RUN zypper update -y && \
>>              pcre-devel-static \
>>              pipewire-devel \
>>              pkgconfig \
>> +           python311 \
>>              python311-base \
>>              python311-pip \
>>              python311-setuptools \
> 
> See in this file header:
> 
>    # THIS FILE WAS AUTO-GENERATED
>    #
>    #  $ lcitool dockerfile --layers all opensuse-leap-15 qemu
>    #
>    # https://gitlab.com/libvirt/libvirt-ci
> 
> libvirt-ci maintains dependencies required to build QEMU,
> in this case since it is a 'testing QEMU' dependency, you
> might add it in the generate_dockerfile("opensuse-leap")
> call in tests/lcitool/refresh (otherwise raise an issue
> in libvirt-ci about it).

This is incorrect, correct fix in this thread:
https://lore.kernel.org/qemu-devel/CABJz62OD0ZZSY16sDNRiTuPEBygy9Y6rUgRrwoA6N_yg8cgGAQ@mail.gmail.com/

