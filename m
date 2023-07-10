Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11A74DB66
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 18:46:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIu03-00039I-Ix; Mon, 10 Jul 2023 12:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIu01-00038r-Ax
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 12:44:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qItzz-0003wA-K1
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 12:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689007470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xb1StjqhEoChGl9o/gMdYYZN1gH8eJF6tw+EWRq+/g4=;
 b=DLuHbm+T4YT2Eg7eoq4vGdf1lvnAWvhoxRYVQTBU9p3OxuoT1BArjpnxmZVU/tcpI2JHGq
 TfeB4okBdfl0bQ6CmMhTYHo9VH8rSregcQF+7WpyuXnj0mtwE2wptxiE9Ij8PK3fezCT9d
 L8bIMk/cQQa/9XgNfGUVCpILIichjFg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qB1sHyoiMVGJvk-mUv9u9A-1; Mon, 10 Jul 2023 12:44:28 -0400
X-MC-Unique: qB1sHyoiMVGJvk-mUv9u9A-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-39cb2a0b57aso3927683b6e.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 09:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689007468; x=1691599468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xb1StjqhEoChGl9o/gMdYYZN1gH8eJF6tw+EWRq+/g4=;
 b=fpS5mA+NMHjZxF2NbXTKVz43Vh4sLrJD29vlkuLhiYNoy5A11KxxeQMUxrpsWh3z/z
 0bDm2/HQckbyTU2X6GfB5ag9dBZuLZa97CCucs2unvZrCdGSTj2dGmBBy+rZCdYaf7+B
 8kGtPZblNv2sD/GVG+tYpEbKFtlSrKoq5MPMsGLbIIQkk4w4Li4xicHvLfEoXctnaRec
 kwjD/5CdPbXOy1dwr3SijXv54m32ueNNodBXoIIpdGczBfgdMF/8x9o49qkwjmWq6eke
 Xz1Iqj62dQa1ChVFL46BGOGllA2LID+1WgXH+tNnNsWxOndAYEktyy2R8H36+AqsGP3s
 ZshA==
X-Gm-Message-State: ABy/qLacEqtUUru6KxQakIhg99FJVDWfCR/+CpEauJTourz14/AcfU//
 FQuIdE1fl3gz7naeTVP0ABm3oHm3v8r8Hl0PeA00PUVqpaR7Co8eSnNraDEjCCvYT7sAN9q/W40
 ay7ey6zl1WExuLEo=
X-Received: by 2002:a05:6808:1689:b0:3a3:64a3:b5a1 with SMTP id
 bb9-20020a056808168900b003a364a3b5a1mr11958699oib.7.1689007468041; 
 Mon, 10 Jul 2023 09:44:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBwIOaXow+4It/vG/vjQSm8NatUigJyHjvAtxQOzHpBlcHExSOn3DHE9Q2AzVGis81V67DeQ==
X-Received: by 2002:a05:6808:1689:b0:3a3:64a3:b5a1 with SMTP id
 bb9-20020a056808168900b003a364a3b5a1mr11958679oib.7.1689007467770; 
 Mon, 10 Jul 2023 09:44:27 -0700 (PDT)
Received: from [192.168.8.101] (tmo-097-99.customers.d1-online.com.
 [80.187.97.99]) by smtp.gmail.com with ESMTPSA id
 k6-20020ac86046000000b0040372a5968csm90191qtm.28.2023.07.10.09.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 09:44:27 -0700 (PDT)
Message-ID: <0c70e8f3-586f-5683-7ef2-0aa3138d7832@redhat.com>
Date: Mon, 10 Jul 2023 18:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/avocado: Disable the test_sbsaref_edk2_firmware in
 the gitlab-CI
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230710144348.239441-1-thuth@redhat.com>
 <CAFEAcA_QTRJwtQxh1FRHtwjSARAptF-j1ZeyGen8xBfrhq7tww@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAFEAcA_QTRJwtQxh1FRHtwjSARAptF-j1ZeyGen8xBfrhq7tww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 10/07/2023 16.54, Peter Maydell wrote:
> On Mon, 10 Jul 2023 at 15:43, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The test fails occasionally, see e.g.:
>>
>>   https://gitlab.com/thuth/qemu/-/jobs/4196177756#L489
>>   https://gitlab.com/thuth/qemu/-/jobs/4623296271#L290
>>
>> Disable it at least in the gitlab-CI to avoid failing CI
>> pipelines due to this problem.
> 
> I'm not really a fan of disabling flaky tests only in the
> gitlab CI. It means that plain "make check-avocado"
> is useless to the average developer because it can
> have all manner of broken or flaky tests in it that
> never get tested by our CI. In fact I've had to develop
> the habit of running "GITLAB_CI=1 make check-avocado"
> so I can run the CI tests that we think work and not
> get distracted by intermittent failures.
> 
> If we want "disable this test except for if you're
> trying to investigate why it's flaky" then we should
> have the test be opt-in, not opt-out, the same way
> we do with QEMU_TEST_FLAKY_TESTS in the qtests.

Agreed, this makes perfectly sense. Actually, I was looking for something 
like this in the tests/avocado directory, but I did not find anything 
similar, so I went for the GITLAB_CI variable ...

I'll send a v2 with QEMU_TEST_FLAKY_TESTS instead (and document it in the 
docs directory).

  Thomas



