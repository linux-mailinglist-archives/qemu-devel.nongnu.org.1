Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CE73CB4A
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:18:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD44q-0000wj-90; Sat, 24 Jun 2023 10:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD44o-0000wD-Cx
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:17:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD44m-0004Nc-7W
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 10:17:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so1537222f8f.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687616237; x=1690208237;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJi8w5BfqHV+fSoGZqMCdRbBKXM0XIPr1579lVo5n14=;
 b=jsBD+bXrMIbX7d5vS2kCRzkJfkPaWEdz0wNaYXi70oScxgEw5hia26W3kWuz+N5+tq
 I1ZSSjeSTBZC/QZcbATYzv7QKEKJ/cW8wHQwT5DW6nydagkENltIm7jmU2B3RIdl78um
 KwZVlSVNsS/Mt9DWrG1n4UMo4B1apZ90ZQ97wlIf+ojhkfn71dnKII21JaMKDJfAGQx8
 /RVV9FS73ZSVEs/JnmCum0twOVP6JYY+hqmYqv+UOQq9hOD/7V4EpJHdFTbhhVj4GrYw
 CgVPEKtGyZa90RPzAc3wyO70ASCEnsqGc/COV+HT+xnUC7LRY5Zr74jXwnh6PKav24yf
 4Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687616237; x=1690208237;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJi8w5BfqHV+fSoGZqMCdRbBKXM0XIPr1579lVo5n14=;
 b=BpESn7Hrs77l0CdPbChGo1cpkf/w7F6+szXzQ3BGbObNZ7nLrFFOiOCuX+7W69odTd
 nvSbvcKNpFg4LXgzKIHiT+D1ttcfuhr/1tw/wjJZdfxEsp7Tg99HFLfqmUTf4usdHSvi
 HQ0ASNTWr+NuqDL1C+ib0LGI3w4vUUBt8jX4W1awP2sPu/YKwJFukdiaLaeUNTj/xd9y
 J9gpbw1zj6nFUt0aXdJYtPSLiAf++orQQ26etCu06pux97TT7VNAgCBLJd+72aqHO2Vk
 b9d8/0NW8QYjQf2oSQ+RYk2AXYEDwXI7cC/RBFJhEaf/DPT40azu629yYKgQvXHQDcrS
 4P+g==
X-Gm-Message-State: AC+VfDxgWCPZH2pbXoAZ074lCXQ3bsWg9fs8njnjGoEGskzzUPlN9SXD
 DcCJVvkA66v5Hdx9DDks1oRhsg==
X-Google-Smtp-Source: ACHHUZ5oSVMsn9CUz/Q1yuXekH7uERbDA20UzQ0Zh65Jhnqmgcu7NjSNEojMdgLZ5asFzydfQHm/TQ==
X-Received: by 2002:adf:efcc:0:b0:309:3c0c:b2c1 with SMTP id
 i12-20020adfefcc000000b003093c0cb2c1mr17267205wrp.23.1687616237239; 
 Sat, 24 Jun 2023 07:17:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 o14-20020adfe80e000000b0031270cf1904sm2212997wrm.59.2023.06.24.07.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jun 2023 07:17:16 -0700 (PDT)
Message-ID: <588b8968-608e-6d8e-d2ef-e1ab35d72ff8@linaro.org>
Date: Sat, 24 Jun 2023 16:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 10/14] tests/docker: Remove old Debian 9 containers
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
 <20201002113645.17693-11-alex.bennee@linaro.org>
 <c4782597-91f8-93c2-dea1-1b755fdec17e@linaro.org>
In-Reply-To: <c4782597-91f8-93c2-dea1-1b755fdec17e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 24/6/23 00:29, Philippe Mathieu-Daudé wrote:
> On 2/10/20 13:36, Alex Bennée wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
>> are now no longer used in the gitlab-CI. Time to remove them.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Message-Id: <20200921174320.46062-6-thuth@redhat.com>
>> Message-Id: <20200925154027.12672-14-alex.bennee@linaro.org>
> 
> 
>> --- a/tests/docker/dockerfiles/debian-win64-cross.docker
>> +++ /dev/null
>> @@ -1,45 +0,0 @@
>> -#
>> -# Docker mingw64 cross-compiler target
>> -#
>> -# This docker target builds on the debian Stretch MXE base image.
>> -#
>> -FROM qemu/debian9-mxe
>> -
>> -MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
>> -
>> -ENV TARGET x86-64
>> -
>> -ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
>> -
>> -ENV PKG_CONFIG_PATH \
>> -    
>> $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
>> -
>> -RUN apt-get update && \
>> -    DEBIAN_FRONTEND=noninteractive eatmydata \
>> -    apt-get install -y --no-install-recommends \
>> -        mxe-$TARGET-w64-mingw32.shared-bzip2 \
>> -        mxe-$TARGET-w64-mingw32.shared-curl \
>> -        mxe-$TARGET-w64-mingw32.shared-glib \
>> -        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
>> -        mxe-$TARGET-w64-mingw32.shared-libusb1 \
>> -        mxe-$TARGET-w64-mingw32.shared-lzo \
>> -        mxe-$TARGET-w64-mingw32.shared-nettle \
>> -        mxe-$TARGET-w64-mingw32.shared-ncurses \
>> -        mxe-$TARGET-w64-mingw32.shared-nsis \
>> -        mxe-$TARGET-w64-mingw32.shared-pixman \
>> -        mxe-$TARGET-w64-mingw32.shared-pkgconf \
>> -        mxe-$TARGET-w64-mingw32.shared-pthreads \
>> -        mxe-$TARGET-w64-mingw32.shared-sdl2 \
>> -        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
>> -        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
>> -        mxe-$TARGET-w64-mingw32.shared-zlib \
>> -        curl && \
>> -    curl -s -S -o 
>> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
>> -        
>> "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvemulation.h?format=raw" && \
>> -    curl -s -S -o 
>> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
>> -        
>> "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatform.h?format=raw" && \
>> -    curl -s -S -o 
>> /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
>> -        
>> "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatformdefs.h?format=raw"
>> -
>> -# Specify the cross prefix for this image (see tests/docker/common.rc)
>> -ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-
> 
> I just realized this was the image cross-building the WHPX accel.
> 
> Presumably we don't test it since 2.5 years.
> 
> Sunil, is it still working for you?

Nevermind, problem figured: Since this MinGW commit:
https://sourceforge.net/p/mingw-w64/mingw-w64/ci/395dcfdea
cross-building doesn't work anymore on case-sensitive fs.

Patch on the way.

