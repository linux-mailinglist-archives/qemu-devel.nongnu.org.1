Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0E7B86DC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5uS-0002c1-B9; Wed, 04 Oct 2023 13:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5uP-0002Yo-Fb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:43:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo5uN-0005jL-Mc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:43:41 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32325534cfaso110215f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696441418; x=1697046218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dt0erOZF/uFiruM50fX+VhTsdRaoFe5n4jIhM8XieJ8=;
 b=X+rJjVtNmZOxDR3j1a8E8yfrhDS8EEfLykDJ3KjJmSVGwrXE6BWEE/GTe2UIdiwPnE
 dZ8SXaqGhi4/zq9RoPYHeZvrHoRijeZfhAcf188mmQxOWbPt1MTULzAi78et/oTFEm13
 aV9Ux2FukchDEG1AS34/OU3Mcf75ZlolWZwqaSO9Zn7sg5k+6/5/H37rbJlZVItpPDYl
 lsCaU3AaZL1ivLbjN5EmZ/3PyJgQED9GPUDvHMz7PsXSf30KU3SU5d1RUxI48caBkNUf
 S7nkLgziZ0w1wjgZend3osdLcbqMCM5odfAelxYhIMrwFSRnib3iOh/EPooFNvo7quGf
 9eUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441418; x=1697046218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dt0erOZF/uFiruM50fX+VhTsdRaoFe5n4jIhM8XieJ8=;
 b=DncNSSBP7QNGXLb1gxmikHdvJ82zDeiAnHTr3GiK8VhttUMccEnRx2uFh85vRMTsCB
 4c/AeJtFJ5wSL0CqN7Uj2Qq9cHFyteWnA0aFwf7OSUaBT7bXS1DaLWdvHF6XpVxp75nv
 rZE9uaDPyQRbtcA5bMPYDLK7PjS5H4d5N3ivX0QSObxr1QqaWkoZ150sKckxExbhBgzI
 Iq9jpV/0ZMASBYF53rfDuxEdOSAgA1o1CKsiPI/1FmzTkcW9UPntl0MPXRWTUFK3pfRn
 FoZrm2V2ZT3EYoKGel72rFv8Pfi6Vj5LKSof8afdvnNE3ghVRB/QGfIdoPrQD/IvgLdp
 WuRA==
X-Gm-Message-State: AOJu0Yy7FwI82j2JhxTxRhXbJe2E+I3WgkNYm9Pg0moUH9VVjFHEoAgm
 WJnEjsm9toCYihXjGgJeCtvt+w==
X-Google-Smtp-Source: AGHT+IEbi22rTlSFg4O9ljhe45uRIRO8LdoAI+ivYQRDi3aX5jWcJQLqV60E4hYKOG9FOGfQ/pyz5A==
X-Received: by 2002:adf:efd1:0:b0:31f:fc96:9af1 with SMTP id
 i17-20020adfefd1000000b0031ffc969af1mr2750711wrp.59.1696441418017; 
 Wed, 04 Oct 2023 10:43:38 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 k14-20020adff5ce000000b00323287186aasm4529420wrp.32.2023.10.04.10.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:43:37 -0700 (PDT)
Message-ID: <b8b28fa6-6224-cf6c-9aa9-016083ed994f@linaro.org>
Date: Wed, 4 Oct 2023 19:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Wshadow: Better name for 'optarg'?
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
 <d688281c-d019-c1ff-6927-d1791911c57d@linaro.org>
 <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e13885b5-06a2-599f-e0fe-c5e8f0671742@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 4/10/23 19:35, Thomas Huth wrote:
> On 04/10/2023 19.23, Richard Henderson wrote:
>> On 10/4/23 03:05, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:
>>
>> I thought things like this is why we were trying -Wshadow=local.
>>
>> I think it's unlikely that we'll be able to prevent all such cases.
> 
> Given the broad range of operating systems and libraries that we support 
> in QEMU, I agree with Richard - it will likely be impossible to enable 
> that option without =local by default without risking that compilation 
> breaks on some exotic systems or new versions of various libraries.

-Wshadow=local doesn't seem to work here which is why I switched
to -Wshadow. I probably misunderstood something from Markus cover
letter. My setup is:

C compiler for the host machine: clang (clang 14.0.3 "Apple clang 
version 14.0.3 (clang-1403.0.22.14.1)")

I suppose we'll figure that out when eventually enabling -Wshadow=local
on CI. Meanwhile I already cleaned the 'optarg' warnings that were
bugging me, see:
https://lore.kernel.org/qemu-devel/20231004120019.93101-1-philmd@linaro.org/
I'll try to get -Wshadow=local, but the other series still seems a
good cleanup, as I used more meaningful variable names.

Regards,

Phil.

