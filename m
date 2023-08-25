Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A787880E7
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:33:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRJz-0001tM-PH; Fri, 25 Aug 2023 03:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRJw-0001sT-FI
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:33:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZRJu-0005uD-8K
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 03:33:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so477498f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692948804; x=1693553604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W5DcnYU6BQqu8Jy69UM40Ie+RxQfeMOCtE/JzbvU2jk=;
 b=uMfCfw9E1+TdO05zcipSLViFi8+FHH3uroLRUYLqoPonpC9cs2wLnaY0dyiH0ORVzE
 h8rvkCQ+knWOXUXc2XMqm7tb2b5Wm2/H+GUM35J924ezel/tEAesP+qd1ogyF1yppHk8
 ByuNsQS32H4KB5w3QBzinl4oD7s/PknNAekc1oMzzlKTxX7HMNSUSJdzxVN8w7bh6Bt5
 hKwuCP/14gH7+Z+vxbc4VxlGFuWWa5bw3KoD006sU4F5RzcTT7usNPhOF1RU/UmYf6y7
 8jM4WH1L7jUkZ33ivn5ydJ7FAJ7lVHeOLGWczvygsobLvScYC6WlZJtqbS3QhBsVPXH9
 PHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692948804; x=1693553604;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5DcnYU6BQqu8Jy69UM40Ie+RxQfeMOCtE/JzbvU2jk=;
 b=H6lc5FD2XKTk9FutibYYUj+xQ+9rlcuC+I7ETZcPsEEPjasalTsrPO2ZgF9WKXF0fg
 l3rWKtpgXlyNaBhCfNGBvcVf3T9JZXHSrmjOPG4wF8jqGDkNpAbu7kyvpJG4BARM4GEY
 +BrFgM9erlXB7ce081rw558FNFqwMLTXcYuaqc429MxZ+Q/QbKbGv5/nA/IjR+Adkwe8
 2dSI+96V+kDx+Zpr90BTUTUqjkUUOxRlZxmmvgjI6C+Z0s8CxhAAxgwIY1p49iE4C+lr
 A2EkOGkY0KpzqtW+NQihJaqO2VmQl0TMRTTSJgsc6mLyhQ2fiTkK2FBc4e9UBww8Wa5M
 A82w==
X-Gm-Message-State: AOJu0Ywlkhl3qGNspe4a5+9W3HNj2dl0yuG1RYPbS2oHhSx+ADQ2zvBW
 2ShkAXzkAN7htJtL1yI9MZVvcQ==
X-Google-Smtp-Source: AGHT+IHt/eLgsDdBEQAGJzsqccpclu+sDPMzQpFf5gp97c7NROk2904JVqQh4MO4v6bWK9/LmoTYhg==
X-Received: by 2002:a5d:53cc:0:b0:319:8cc9:6d9b with SMTP id
 a12-20020a5d53cc000000b003198cc96d9bmr12284868wrw.8.1692948804624; 
 Fri, 25 Aug 2023 00:33:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a056000000800b0031759e6b43fsm1376439wrx.39.2023.08.25.00.33.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 00:33:24 -0700 (PDT)
Message-ID: <3f278596-1091-a7d5-ad72-68a03a1b0d2f@linaro.org>
Date: Fri, 25 Aug 2023 09:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 11/12] gdbstub: replace global gdb_has_xml with a
 function
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
 <20230824163910.1737079-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824163910.1737079-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 24/8/23 18:39, Alex Bennée wrote:
> Try and make the self reported global hack a little less hackish by
> providing a query function instead. As gdb_has_xml was always set if
> we negotiated XML we can now use the presence of ->target_xml as the
> test instead.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/internals.h    |  1 +
>   include/exec/gdbstub.h | 10 +++++-----
>   gdbstub/gdbstub.c      | 12 +++++++-----
>   gdbstub/softmmu.c      |  1 -
>   gdbstub/user.c         |  1 -
>   target/arm/gdbstub.c   |  8 ++++----
>   target/ppc/gdbstub.c   |  4 ++--
>   7 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


