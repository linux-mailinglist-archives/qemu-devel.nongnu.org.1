Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF9D78FF3C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5BI-0006hX-5c; Fri, 01 Sep 2023 10:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5BE-0006f1-Lm
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:31:24 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5B9-0004vO-VR
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:31:24 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-313e742a787so12181f8f.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693578678; x=1694183478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTlmZTcTjXXm0dN15dhdczx3GEuymgxpFJn2+Kqce8g=;
 b=X/krse74B79fwCzcLgrLhWADdTMsBNDFK5jU8UemfO/ZUvL8Amprp9HYtZEJs6op1A
 /n0b/G3I3Gpn1cPH8dBFhMp07ZdlYjcf9K6E8Q7ZSco3bV3DlX56S0a9o6dLrECLy8i/
 8F+40yxEamirtxrBRawTqzi5cXAPZTdMf4yrPMkcPUZ9te68CKrmdOTroFEJ6bAWfipd
 ljaa7lHwMVtniOwt+KgbH0s1lnYxceuuB7FHc0jQV//v6F2LEi7I3EULcBSP4nw99kjf
 eNULlAzX8TQmAQD15lHbpgswDhQKQzld/TYqCH2lwerCnsKYJ+cU24XAdmgKa8csRb1q
 h/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693578678; x=1694183478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTlmZTcTjXXm0dN15dhdczx3GEuymgxpFJn2+Kqce8g=;
 b=Ho3VwDC/v4/EsbOCC8tkgPsLAWkbi642c+1hm/RTVb0633uh81A7EYKPx9kaVsJRrv
 vJzIxz1mcq9HiTdKCIIqEeyLYCY0QOUBOqe4EpfeHykKSeI4Y8aT0WiKDzHIXs7sKgSo
 Wt30bpLg3IYxdHgPFCZ0+5n4jk3Vm8seJDqet2GrtMXnTky7eZkVWao3EpMZW87y8Csf
 FkEJUictAJaVVGXdT3q/UqQ9JTz/u7KpRiG9HhpbPGZ97Ne5ZXveC4NAckwiC9FDJ6cB
 luefmbEAd0vJVqyJztcUz6SWU4ioBCQ227uCgJksbid8oss6kTFWlz/Db2uoutX37+V4
 Vizw==
X-Gm-Message-State: AOJu0YygQMbA8yf5AylcrxUWBOLtLEmP7DX0agtmc9nP7d+K77XVYbMu
 /mwfiUlCfzFcfXybi7S0VCGXig==
X-Google-Smtp-Source: AGHT+IEBBN9CCsn9YltN2F0V7LF3Z5GRBPMVLtPg4poVoLEEKPmPVtqhAv3tXZryDsJq5nVnF/yeGQ==
X-Received: by 2002:a5d:69cf:0:b0:319:7ec8:53ba with SMTP id
 s15-20020a5d69cf000000b003197ec853bamr2219654wrw.14.1693578677580; 
 Fri, 01 Sep 2023 07:31:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a056000181200b00317f29ad113sm5370740wrh.32.2023.09.01.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:31:16 -0700 (PDT)
Message-ID: <a577e600-5bd9-2b6b-d4e6-5486df10bdb8@linaro.org>
Date: Fri, 1 Sep 2023 16:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 7/7] qobject atomics osdep: Make a few macros more hygienic
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com, pl@kamp.de,
 sw@weilnetz.de, sstabellini@kernel.org, anthony.perard@citrix.com,
 paul@xen.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-8-armbru@redhat.com>
 <vfkfi6uld3gbd4urmqdlzkv6djtws6mkbluc5qvwcla6btszhu@ff66zfyd7smm>
 <7b8a4589-7f29-e564-4904-9b1a4fd342af@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7b8a4589-7f29-e564-4904-9b1a4fd342af@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
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

On 1/9/23 14:59, Cédric Le Goater wrote:
> On 8/31/23 16:30, Eric Blake wrote:
>> On Thu, Aug 31, 2023 at 03:25:46PM +0200, Markus Armbruster wrote:
>>
>> [This paragraph written last: Bear with my stream of consciousness
>> review below, where I end up duplicating some of the conslusions you
>> reached before the point where I saw where the patch was headed]
>>
>>> Variables declared in macros can shadow other variables.  Much of the
>>> time, this is harmless, e.g.:
>>>
>>>      #define 
>>> _FDT(exp)                                                  \
>>>          do 
>>> {                                                           \
>>>              int ret = 
>>> (exp);                                           \
>>>              if (ret < 0) 
>>> {                                             \
>>>                  error_report("error creating device tree: %s: %s",   \
>>>                          #exp, 
>>> fdt_strerror(ret));                      \
>>>                  
>>> exit(1);                                               \
>>>              
>>> }                                                          \
>>>          } while (0)
>>
>> Which is why I've seen some projects require a strict namespace
>> separation: if all macro parameters and any identifiers declared in
>> macros use either a leading or a trailing _ (I prefer a trailing one,
>> to avoid risking conflicts with libc reserved namespace; but leading
>> is usually okay), and all other identifiers avoid that namespace, then
>> you will never have shadowing by calling a macro from normal code.
> 
> I started fixing the _FDT() macro since it is quite noisy at compile.
> Same for qemu_fdt_setprop_cells(). So are we ok with names like 'ret_'
> and 'i_' ? I used a 'local_' prefix for now but I can change.

See 
https://lore.kernel.org/qemu-devel/20230831225607.30829-12-philmd@linaro.org/


