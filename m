Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC66788229
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:36:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZSHO-0006DW-VZ; Fri, 25 Aug 2023 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZSHN-0006Ck-4f
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:34:53 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZSHI-0000TD-Fu
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:34:52 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5008faf4456so982228e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 01:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692952486; x=1693557286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GVTbhpX1ixt5LMgddEVdjeM3WDjEF1ggdhovQZa+Erk=;
 b=Hp/Hug0hC2w7qkHx4GvAEc+9EJg8S53zkPifoV5cMtsXN15eY3snyasAibmeLpyt/b
 mxYiUccwoGW5TaPEn1+1TmGiMS8Br/A3pQBlwYOp2i6GXm1xZcUZWump8HtsDbJ9wESb
 Vb6v3+musLxdExCVvsHRyqNYp7w+ZnQe9BaUc0ZxKbreOKjnNJPXtxAV86x6bXViUclR
 PHHFkpr0kL4c5InYb3tFwrm+DpiypBEyjNY+I9hl64ZXMjA/gI4A1vSsfEd84hrgEvlR
 7RucXCmOyy6QWiPvH3cxkm8/OYrv0TQFxx2pN0ic8pkr3qVcljJg2hcWksBX6zNQ8ARq
 1SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692952486; x=1693557286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GVTbhpX1ixt5LMgddEVdjeM3WDjEF1ggdhovQZa+Erk=;
 b=g1pm+uyPKb3s+bvGsJVZx5+7TIYNoFpHuUZ1CVz/tHd0o26uX/2GRo8CMfZJICQklb
 7KUGFvEGNG9zH9nTVgIr/c+qybrHGcW43nx7VyO3qzm1aPz0PKxsrdtpkPKbh9VQPc0H
 sXA4ILjaSO4M3qJcAytKu5/IoAGBktveq4cRx8hSzztx7ZrhfLbgwWksR7tRyY+npzVZ
 JU8vgMddyiYWnMD+kdqEs66i2MpUNUatXmW7aMjubX0zX/ld45TzvUYGeFJ+EnP8lJSV
 sWXqM65YZ3+d76+SNZi8T+q3j4mUtZplZcQWokXtE5yhKzCo7iwJa2qgB8sAK/oMYQK+
 N5Kw==
X-Gm-Message-State: AOJu0YxUpBggCNz+mvxp3KiZetwecinuV51zauyl0WNkVh6j3xukONyv
 U7I9G1ckYWz19OkVuLHmTz2V/w==
X-Google-Smtp-Source: AGHT+IHOu9lDA/o/ISEuWJaE7JJ7RpLRvdIc54S8BaHzplCroSIpefeb1v8mGgF6G5/Iyr5Yo6fTsw==
X-Received: by 2002:a05:6512:39d2:b0:4f8:6bca:50d7 with SMTP id
 k18-20020a05651239d200b004f86bca50d7mr14554346lfu.13.1692952486261; 
 Fri, 25 Aug 2023 01:34:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a5d6a11000000b003142e438e8csm1553375wru.26.2023.08.25.01.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:34:45 -0700 (PDT)
Message-ID: <97490761-c138-d496-c59a-f71b86e57c3d@linaro.org>
Date: Fri, 25 Aug 2023 10:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/12] gitlab: enable ccache for many build jobs
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-2-alex.bennee@linaro.org>
 <20abecb3-b330-0303-0f4a-b0b5d0cfade1@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20abecb3-b330-0303-0f4a-b0b5d0cfade1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/8/23 09:46, Michael Tokarev wrote:
> 24.08.2023 19:38, Alex Bennée wrote:
>> From: Daniel P. Berrangé <berrange@redhat.com>
>>
>> The `ccache` tool can be very effective at reducing compilation times
>> when re-running pipelines with only minor changes each time. For example
>> a fresh 'build-system-fedora' job will typically take 20 minutes on the
>> gitlab.com shared runners. With ccache this is reduced to as little as
>> 6 minutes.
> 
> I've been using ccache when building qemu in debian, for quite a while.
> 
> The problem here, in the way qemu build system works, is that the cache
> is hugely dependent on the path to the source. You change just one char
> in there (/build/qemu/v8.1.0/ => /build/qemu/v8.1.1) and whole cache 
> becomes
> unusable, it all gets compiled anew.  This is because qemu build sys uses
> absolute file names when building, and this is detected by ccache, so
> the source dir gets mixed into the hash together with gcc version and
> other things.

__FILE__ is used by assert() family, some DEBUG_PRINTF(), but mainly
by "qapi/error.h", so all error_setg*() calls.

This has been bugging me since quite some time, since if you build
the same QEMU in different paths (usually on different machines) then
the output doesn't match.

GCC 8 & Clang 10 provides -ffile-prefix-map, but

1/ Our minimal GCC supported is v7.4,
2/ meson doesn't support it. Still there is a feature request:
    https://github.com/mesonbuild/meson/issues/10533


For more info, see also the reproducible build project:
https://reproducible-builds.org/docs/build-path/

Regards,

Phil.

