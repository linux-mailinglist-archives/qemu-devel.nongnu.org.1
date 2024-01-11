Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB082AD5D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:27:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtDU-0006Re-Ux; Thu, 11 Jan 2024 06:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNtCv-0006MN-JG
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:26:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNtCt-0006Mo-RM
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:26:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3367632ce7bso3705346f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704972402; x=1705577202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIzEQo7AtvIwKovAUhvlMYyyu+16UkD3WesCRGIWkhw=;
 b=bdYwok/I3fz+xr9kDeDhaiphUvffu5PHKQ2OMERuH0SjgBmmR2eYNabrOTiVV7gKjK
 zOE53p0J0Ky79mfeikEsC/7jH+fmQxFbYZIyWxjASzDCNnQ3fXNh+g2jdjkJ0o9vXxDH
 QxtSPdsGKU7qYhgLydStZWUFwM96ns2PByuJTuwFPpBIDPzUy5vDVucg8GXrn4OLc/5L
 OuQXznmgmEJ6wFOqGjaq8AXO9CRJPXRti3aINlix7MTtPxKoF9taU/TQ+V6KST8GueBu
 HG0lV5wpLC2bq0qnVKcMhCZkoTGxDmqKkaW+bwYbTD0DC6B7dr5F5LksksnMzdY+TOhx
 MCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704972402; x=1705577202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIzEQo7AtvIwKovAUhvlMYyyu+16UkD3WesCRGIWkhw=;
 b=HYT2cizkYJja7w8rKWKA0iGIp9M8Cpnes+Qvu6fge3c5HEGyTUWgULFMmf9DYtFk/t
 sXTbbpUwMH/93PcdWsV1/0+ifFLGoEtUBITrwgfZ9UIeWwubUSDVBVmQ5rjLL97yyAMR
 lsFWizT89AnZIXL4QGlxv7lBb8c1J66PEqqwWQzRjbMf8yOAqk5OBBbct+0PzQstv82z
 p3bj9RWv3hpPQMxjnfXlyz8mGrX04vAv5ME/djDreWYqYu3w1NNnbHEB50AsMoZBmgLr
 HENRqh8UJTxzdOyaaSpoX2u3Mw9p1LurvX7MYaXlZV/zHnrUtKU87+qUvtdtbntBAA84
 o8Sw==
X-Gm-Message-State: AOJu0YyUOI7HA0vE5nUI/lwkSsriIJ4Z0O/RDfV6OB8lkYwA8hvDh/fw
 NJsT9WYePLpjYiglIRy05/L1jc5MSYEIfQ==
X-Google-Smtp-Source: AGHT+IEoeT3O9RC4K1o4jvDe6djVpA9yCzGxfjObNrDDgj6fGrAdwWhlba4Tnumxmp6+bDljFkN9dA==
X-Received: by 2002:a05:6000:1a8a:b0:337:89d2:fb99 with SMTP id
 f10-20020a0560001a8a00b0033789d2fb99mr516459wry.23.1704972402000; 
 Thu, 11 Jan 2024 03:26:42 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 q6-20020adf9dc6000000b003378e67fd2asm335415wre.86.2024.01.11.03.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 03:26:41 -0800 (PST)
Message-ID: <0964ddb6-f403-4bec-8f90-23f8b9b0dfd6@linaro.org>
Date: Thu, 11 Jan 2024 12:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
Content-Language: en-US
To: gaosong <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
 <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
 <96bdddb5-e15c-469f-b74b-7e82049888f1@redhat.com>
 <3766d853-8dc5-f455-e0ea-dd970c65a6c5@loongson.cn>
 <6f17d2f1-6876-4f1c-beb5-c6a4e89340d8@redhat.com>
 <94b84fa3-4a10-3fef-0415-6b87f2aa255b@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <94b84fa3-4a10-3fef-0415-6b87f2aa255b@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 11/1/24 10:51, gaosong wrote:
> 在 2024/1/11 下午5:04, Thomas Huth 写道:
>> On 11/01/2024 09.50, gaosong wrote:
>>> 在 2024/1/11 下午4:20, Thomas Huth 写道:
>>>> On 11/01/2024 08.37, gaosong wrote:

>>> LoongArch no support these cmds  or some problems .
>>> -    "gva2gpa 0",
>>> -    "memsave 0 4096 \"/dev/null\"",
>>> -    "x /8i 0x100",
>>> -    "xp /16x 0",
>>>
>>> Could we disable these 4 cmds or the test_temp check?
>>> After we fix the cmds problems, we can enable them.
>>
>> Even if loongarch does not support one of these commands, it should 
>> not crash QEMU. So please fix the crashes first before considering to 
>> enable the KVM-only test in the CI.
>>
> 
> Sure,  we will fix the cmds problems first.

The issue might be missing get_phys_page_attrs_debug() implementation.

