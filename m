Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D876C84C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR78B-00058X-2K; Wed, 02 Aug 2023 04:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR789-00058K-3V
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:22:53 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR784-0004AP-Rl
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:22:52 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2683add3662so4544949a91.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690964567; x=1691569367;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kcjoaqaBTLSclwT7Cyvuh2efekchuP32Nvh+bA6mXUA=;
 b=5enLWZ6KULW7OZQP78GLbCUgqFZK8jeFs/MaAuqM9yNj3Hz2E1OPu00NxjRk8SfYak
 UcrReTcAGXks6OJWUtYzH1WWHP/xONhUawEWVGP/Lo2XCyw4LMvM0gROEUtdueEsb4XN
 7/AzSBk437oobKiPF1bSv7luhq8rrcTNinG8SfeyDe8irk8UyX5yf/gLFrtvChM8nf+u
 7pOT8gtuSv84qnzDMbCtBuFDJaiVHqIkb3o6g49YzAJM3M0O/Mcp10v43km3DU65fow3
 mEguFoFhWbs4BUuSlY8Gu24kzn3Eac7IK/loopbRFWLxyznjjEY+qS2AGnk9hKqX32uW
 7ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690964567; x=1691569367;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kcjoaqaBTLSclwT7Cyvuh2efekchuP32Nvh+bA6mXUA=;
 b=REUmuvCyI7NVWZUudl89Ax4R8QOjsOJa9qR0O4JOrEAFyNiHVLWVcMzqbhTZHK1roQ
 BOnDf8Hj17/G0hCNN3Mnkz/A3VdOGfZi3eC5P+9ZaCyykMKJ2K/56hIuenXfGkpXze+A
 c9yr4ZLc2pyzdWLkF6XWpldjqafdmtlAh5DPjmMahoKDVrJqNzY+HQ91tmFDYfRoALeq
 9KJ1wM+J8q1p52h/ZF5jNOmBai47R1ekru7MIlOtyAyoedJhKYniVwU5ospbQ+GQxYbQ
 2tlADgsQ41raZie0vbHbH8YVxdbbYistkia501hFPBXzB7gZEa4c9h2JlLSklCeRy79P
 CBgg==
X-Gm-Message-State: ABy/qLazIJQ9CPFBUrx1HPzIEQcRaIu+xYEU2wBkLWONH02hdhfk+5Wg
 IIg/pQwS7mpQpqiwg3104BkVRw==
X-Google-Smtp-Source: APBJJlF1D2zhYvd/yBI4nwko+WIE+0kxrL3g2an0JuPIbdtHGTzoPmVAOqLnof8al0H0LytEds9nWw==
X-Received: by 2002:a17:90b:46d4:b0:268:2f2:cc89 with SMTP id
 jx20-20020a17090b46d400b0026802f2cc89mr14512348pjb.4.1690964567314; 
 Wed, 02 Aug 2023 01:22:47 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 mv9-20020a17090b198900b00267f7405a3csm645914pjb.32.2023.08.02.01.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 01:22:47 -0700 (PDT)
Message-ID: <600c36ed-bb6d-ffcd-c6f9-a5aed3d4aea6@daynix.com>
Date: Wed, 2 Aug 2023 17:22:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] contrib/plugins: add meson build file
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Anton Kochkov <anton.kochkov@proton.me>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20230628162451.147419-1-anton.kochkov@proton.me>
 <20230628162451.147419-2-anton.kochkov@proton.me>
 <d205f5a6-c7ec-c8a2-74f6-901dac1774e4@gmail.com>
In-Reply-To: <d205f5a6-c7ec-c8a2-74f6-901dac1774e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I used a wrong email account.

I also forgot to mention that you must update other places referring to 
the Makefile. I'm aware of the following:
- root Makefile
- tests/tcg/Makefile.target
- docs/devel/tcg-plugins.rst

On 2023/08/02 17:16, Akihiko Odaki wrote:
> Thanks for letting me know this on GitLab.
> 
> On 2023/06/29 1:26, Anton Kochkov wrote:
>> Add crossplatform Meson file to build TCG plugins since
>> the Makefile makes wrong assumptions about it being used only
>> on Linux. Tested on Linux and macOS.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1710
>> Signed-off-by: Anton Kochkov <anton.kochkov@proton.me>
>> ---
>>   contrib/plugins/meson.build       | 31 +++++++++++++++++++++++++++++++
>>   contrib/plugins/meson_options.txt |  1 +
>>   2 files changed, 32 insertions(+)
>>   create mode 100644 contrib/plugins/meson.build
>>   create mode 100644 contrib/plugins/meson_options.txt
>>
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> new file mode 100644
>> index 0000000000..72c4167461
>> --- /dev/null
>> +++ b/contrib/plugins/meson.build
>> @@ -0,0 +1,31 @@
>> +project('qemu-plugins', 'c', meson_version: '>=0.50.0')
>> +
>> +qemu_src = get_option('qemu_path')
>> +if qemu_src == ''
>> +  qemu_src = '../..'
>> +endif
> 
> The default value should be provided in meson_options.txt.
> 
>> +
>> +qemu_include = qemu_src + '/include/qemu'
> 
> I think the following is more idiomatic:
> qemu_include = qemu_src / 'include/qemu'
> 
> Regards,
> Akihiko Odaki
> 
>> +incdir = include_directories(qemu_include)
>> +
>> +plugins = [
>> +  'execlog',
>> +  'hotblocks',
>> +  'hotpages',
>> +  'howvec',
>> +  'lockstep',
>> +  'hwprofile',
>> +  'cache',
>> +  'drcov',
>> +]
>> +
>> +th = dependency('threads', required: true)
>> +glib = dependency('glib-2.0', required: true)
>> +
>> +foreach p: plugins
>> +  library(p, p + '.c',
>> +    include_directories: incdir,
>> +    dependencies: [th, glib],
>> +    override_options: ['b_lundef=false']
>> +  )
>> +endforeach
>> diff --git a/contrib/plugins/meson_options.txt 
>> b/contrib/plugins/meson_options.txt
>> new file mode 100644
>> index 0000000000..2d76cda496
>> --- /dev/null
>> +++ b/contrib/plugins/meson_options.txt
>> @@ -0,0 +1 @@
>> +option('qemu_path', type : 'string', value : '', description : 'Full 
>> path to the QEMU sources to build plugins for')
>> -- 
>> 2.41.0
>>
>>
>>

