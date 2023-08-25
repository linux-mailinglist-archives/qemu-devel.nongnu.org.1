Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF13788103
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:39:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRP5-00074B-6A; Fri, 25 Aug 2023 03:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRP2-0006s3-Us
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:38:44 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZROz-0006kc-CT
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:38:44 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso883018e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692949119; x=1693553919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m7FPeEhgkdsBqicWrmJ6zgHv8Z+lpIGsCg02gKRccgI=;
 b=ea1RxAYTEFcIpZ9wrxWPivzpnIszV/U8e2axYgyt/R8y3iN/yhIe3wIjpd6Cey6Cls
 5CPZNG3Dh6zWqHdsy/rBGQzBVN39vi4SyI1RpEpk7SkZCLG4mM7rv39N3f0ArXCE8hKi
 vmjRJe6YNeCfQ0NHtwr4Edo/JZ7ZoYDkRZgDIoVSGAl3lwR810TzDgJ/tSef6//3f6Z2
 L3BvXWI7Hn5sCbj6MImGAXZzXC61fvjIXdUfMoeano19Fwal4y0WVAVkHec0pJTISnC9
 Qp3abSDRldUvvAsR27G1vuBKJEgPfpEKNy+JZpjcp2uTlQazS++gH3CQrT4DBaHi7rNq
 9Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692949119; x=1693553919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m7FPeEhgkdsBqicWrmJ6zgHv8Z+lpIGsCg02gKRccgI=;
 b=ejC9lJVgKJ62yusankfESgTQ2oaliTcAvxiVTQ6RIE2QIwSq1W66XeNxHYYDvfAzVw
 NXLNSbStp7SokbqNyE9rFIe6Vs+yitj/3zTBkxRoJmVtjvgQNRqDFi+4zRJJB7T3EIyN
 +gHW235KWGEfwxN3/nmmsHydSrKAYt2YyS5omxeXMwZptVDjuESJ5Wngsz434taZMRBA
 BQ7SVrMs+LWEn70FOjS9Gqb3s6xHFp8pNNiAzEgHL3LbHCTUS+0XeMUTmOu2vu32XWN6
 OggrYr0ZEDAEMj/jukbh1gPee0P7M5WEpVhgy6NsQV0ZqdbRng4+26ZKWtOhBVN0o/An
 4BDA==
X-Gm-Message-State: AOJu0Yxe+8sA4M3KcIXRpSGvRFK1eS+vd5/4BqjXtfMqGmqtmirFT7G/
 +g7ZT5vGy1j430Y7ZHlBFQOMlQ==
X-Google-Smtp-Source: AGHT+IGLwCnb+HEkuehovrYsNTfkcrX9pGGcSeXMyrxX8gkl4rochpy7a+NcpScIncU18WN2DsSNug==
X-Received: by 2002:a19:e001:0:b0:500:a2d0:51ba with SMTP id
 x1-20020a19e001000000b00500a2d051bamr2282690lfg.44.1692949118848; 
 Fri, 25 Aug 2023 00:38:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090682c500b00992c92af6f4sm663584ejy.144.2023.08.25.00.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:38:38 -0700 (PDT)
Message-ID: <72ab2316-f80e-3e53-b40b-181fa034d724@linaro.org>
Date: Fri, 25 Aug 2023 09:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 01/12] gitlab: enable ccache for many build jobs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824163910.1737079-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 24/8/23 18:38, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The `ccache` tool can be very effective at reducing compilation times
> when re-running pipelines with only minor changes each time. For example
> a fresh 'build-system-fedora' job will typically take 20 minutes on the
> gitlab.com shared runners. With ccache this is reduced to as little as
> 6 minutes.
> 
> Normally meson would auto-detect existance of ccache in $PATH and use
> it automatically, but the way we wrap meson from configure breaks this,
> as we're passing in an config file with explicitly set compiler paths.
> Thus we need to add $CCACHE_WRAPPERSPATH to the front of $PATH. For
> unknown reasons if doing this in msys though, gcc becomes unable to
> invoke 'cc1' when run from meson. For msys we thus set CC='ccache gcc'
> before invoking 'configure' instead.
> 
> A second problem with msys is that cache misses are incredibly
> expensive, so enabling ccache massively slows down the build when
> the cache isn't well populated. This is suspected to be a result of
> the cost of spawning processes under the msys architecture. To deal
> with this we set CCACHE_DEPEND=1 which enables ccache's 'depend_only'
> strategy. This avoids extra spawning of the pre-processor during
> cache misses, with the downside that is it less likely ccache will
> find a cache hit after semantically benign compiler flag changes.
> This is the lesser of two evils, as otherwise we can't use ccache
> at all under msys and remain inside the job time limit.
> 
> If people are finding ccache to hurt their pipelines, it can be
> disabled by setting the 'CCACHE_DISABLE=1' env variable against
> their gitlab fork CI settings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230804111054.281802-2-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/ci-jobs.rst.inc                    |  7 +++++
>   .gitlab-ci.d/buildtest-template.yml           | 11 ++++++++
>   .gitlab-ci.d/crossbuild-template.yml          | 26 +++++++++++++++++++
>   .gitlab-ci.d/windows.yml                      | 13 ++++++++--
>   .../dockerfiles/debian-hexagon-cross.docker   |  9 ++++++-
>   5 files changed, 63 insertions(+), 3 deletions(-)

Very nice, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


