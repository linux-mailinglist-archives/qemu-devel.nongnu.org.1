Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC36D8220E4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 19:20:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKjMR-0003SR-Sh; Tue, 02 Jan 2024 13:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKjMP-0003Rc-1D
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 13:19:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKjMN-0001v1-24
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 13:19:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so107390075e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704219562; x=1704824362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u9zjAXOGDUevqE3lX3XCII8mfbCbZgj6a4zVwp54adw=;
 b=AXMZ3x0SYY06WMVAM+okmrLXVY47+04NbKJVCxY/McjIdZzyPoFPGFL4e6dMd3A54d
 35is7R/6V3XicXc9EI4enTrlqboKPV3abcBkb1R+C2byg9naK8orYkFPpMPB+4wxJ7B8
 M8L8Tlh5PsHaVSf2ceKYaiUIlrZ9O+RGM2Mi96kJ8hn//8gr8WmHNlxN14OttYZUvWAe
 24a8+1re8pHVz26XesGr0fwSJWPbYxraz1lNdV8MeNnvw7oKs4qLZgxIk9dEEaWmFN0r
 Jwpp5BQ9kTvAzd3P9xvFOG54i7NbtsEU/0Jsoa5JP2EjlLci+yezcrYA3apsNTRXcqDX
 lOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704219562; x=1704824362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u9zjAXOGDUevqE3lX3XCII8mfbCbZgj6a4zVwp54adw=;
 b=lDHVGTnrhiJhQnsUVkU3paeOVOb/IMU+bhowMY8o3N5TbpIjR3wJZ3Qocc8nWnAt1P
 Lh6nahTBbnsPcLjwzpCKqkRjQnqgiEcSAahfJAlQkXRFkVAZD4RDRiQSmiGqAh24aDFg
 n5cRg5R+317AUnMEl6txFWcX5Q35X/4MtmCg2aD93VUjZD1J5RAO/WuDqwzM3BjMA4Xr
 0/UXaGrg3k3lwNbpibsvNQe5KAdiz+CaKJqeS/qrHQcBoVmM9krFZ9oYkscHxAxtn0f5
 G7SktxIk66lvgArtBd3pMcGILnJr7fsNbTBAbJqG3rReWWwkKbUe5LhM1eVFwnwsqg/0
 Gl+w==
X-Gm-Message-State: AOJu0YzgJxmXwR028NM5axVHRctxJN3oc1k77iiWdeNfRtB/nTONQ0jq
 v/B3YLVgsi3jkPP7IGRIr5cekJYS0sknvw==
X-Google-Smtp-Source: AGHT+IGmESu/XK8uI2JOSt8S/3giC9L303Ih37k+eCAKs6XCq8ikTsxhcxL0/Cr6xKHulUd9+fWb5g==
X-Received: by 2002:a05:600c:1c93:b0:40d:3571:cc13 with SMTP id
 k19-20020a05600c1c9300b0040d3571cc13mr10610791wms.9.1704219562311; 
 Tue, 02 Jan 2024 10:19:22 -0800 (PST)
Received: from [192.168.1.102] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 iv13-20020a05600c548d00b0040d30af488asm50365714wmb.40.2024.01.02.10.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 10:19:21 -0800 (PST)
Message-ID: <eb9bb489-d79a-4aa1-951e-b0c7e97313dc@linaro.org>
Date: Tue, 2 Jan 2024 19:19:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jason Wang <jasowang@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org> <ZK2YS0v5G3iKyXwJ@redhat.com>
 <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
 <ZK6Kn8hB8soQBRsA@redhat.com>
 <30d49562-451e-b4c6-679e-0f8d1e0abe72@linaro.org>
 <ZK6lhY5H/XRqukgU@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZK6lhY5H/XRqukgU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/7/23 15:07, Daniel P. Berrangé wrote:
> On Wed, Jul 12, 2023 at 02:55:10PM +0200, Philippe Mathieu-Daudé wrote:
>> On 12/7/23 13:12, Daniel P. Berrangé wrote:
>>> On Wed, Jul 12, 2023 at 01:00:38PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 11/7/23 19:58, Daniel P. Berrangé wrote:
>>>>> On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>> Refresh the generated files by running:
>>>>>>
>>>>>>      $ make lcitool-refresh
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     tests/docker/dockerfiles/debian-amd64.docker |  2 -
>>>>>>     tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>>>>>>     tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
>>>>>
>>>>> I don't know why this would be removing xen/pmem from these files. If
>>>>> I run 'lcitool-refresh' on current git master that doesn't happen

FTR since commit cb039ef3d9 libxdp-devel is also being changed on my
host, similarly to libpmem-devel, so I suppose it also has some host
specific restriction.

>>>>> Do you have any other local changes on top ?
>>
>> (I just noticed manually updating the libvirt-ci submodule is
>>   pointless because the 'lcitool-refresh' rule does that)
>>
>>>> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
>>>> b/tests/docker/dockerfiles/ubuntu2204.docker
>>>> index 1d442cdfe6..5162927016 100644
>>>> --- a/tests/docker/dockerfiles/ubuntu2204.docker
>>>> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
>>>> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>> -                      libpmem-dev \
>>>> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>> -                      libxen-dev \
>>>
>>> What architecture are you running from ? I'm suspecting it is a non
>>> x86_64 architecture as these pacakges are both arch conditionalized.
>>
>> My host is Darwin aarch64, but how is this relevant to what we
>> generate for guests? Are we missing specifying the target arch
>> somewhere? (This is not the '--cross-arch' argument, because we
>> don't want to cross-build). These dockerfiles always targeted x86_64,
>> in particular the debian-amd64.docker one...
> 
> This is an unfortunate design choice of lcitool.
> 
> If you give '--cross-arch' it will always spit out the dockerfile
> suitable for cross-compiling to that arch.
> 
> If you omit '--cross-arch' it will always spit out the dockerfile
> suitable for compiling on the *current* host arch.
> 
> When we're committing the dockerfiles to qemu (or any libvirt project
> using lcitool), we've got an implicit assumption that the non-cross
> dockerfiles were for x86_64, and hence an implicit assumption that
> the person who ran 'lcitool' was also on x86_64.
> 
> This is clearly a bad design choice mistake in retrospect as people
> are increasingly likely to be using aarch64 for day-to-day dev work.
> 
> So I guess we need to come up with a more explicit way to say give
> me a native container for x86_64.
> 
> With regards,
> Daniel


