Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A158F826D36
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:57:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoF1-0007yR-Vr; Mon, 08 Jan 2024 06:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMoEs-0007y6-OH
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMoEq-00018G-T5
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704714975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ApdWQ+wVUWgVcJrl2sJylghyCy1PCmb4ZAVuglb/X+w=;
 b=OKrQah9IPCYQwEzWd1jfGwYhOVt1aqmrLMahfa1g2TG6N4iCDWuYi2iSMmy0X38Ab7KbfE
 VEON/Yoaf0kwnZqkmelNiyqUL54ZVLyVhFjLYX0Xt2Q82rBDhzMtKU2J+jf0fiSyUpB4uJ
 zufWn+DIibZVLbbsRxbHdwNEqlHmSog=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-JFMYGsQpPAOwAEp8kSTodg-1; Mon, 08 Jan 2024 06:56:14 -0500
X-MC-Unique: JFMYGsQpPAOwAEp8kSTodg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-680f62983acso38763816d6.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704714974; x=1705319774;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ApdWQ+wVUWgVcJrl2sJylghyCy1PCmb4ZAVuglb/X+w=;
 b=T5YY5B8ewWZsJtnh+PF2fYWRroOajZqtWTV0NN7RlsXsjsV24y/GxqfTbh7ruquOf5
 kHnEi/goGOYRyKDBOPSjS4AUX0JwgZnFYJtIZcLgZE4GUsCJaZglJ48iaNxgSv+LHBzW
 Q60q6UbhQx2QUlgnXptd+B/j1uFKKIZ7LKAvDF2MK1VnumDzs9F7SviQky5V0OnGadFr
 y2CVzGjJshvdLW2t59nvyZLn/RYAzGbhpjwUZ/iVqXPSomWpOLVywjgZbTDn1c4yJaHr
 RaOTt6FTl4WJawC7qEHJwGw39C+ILozOiClSTx+Tml8674dW2lshqj1kZp0ss2kZy4PR
 h1CA==
X-Gm-Message-State: AOJu0YzPumQxzrrr92v4HL6DPiWDnHOH6VQ1Jgl3sKlZweAwqX8mWQgM
 hzYgtKuUKnOhh4Ur/SJKFLYcevYNuwCMCRFCifXMyQrhdyFzyC3Ko8ABwunyto/qbk/TZgr/G+g
 3ePYJT8Ig+F2wUR7Kn4LmKzk=
X-Received: by 2002:a05:6214:23c5:b0:680:d395:cff9 with SMTP id
 hr5-20020a05621423c500b00680d395cff9mr4920662qvb.93.1704714973850; 
 Mon, 08 Jan 2024 03:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFnUAZwUTt6lFoavk0cmFjHRx/3B7db6tARaDCvEWFmUtpYPcvNLqdWchKnGokbVpbbGbwKg==
X-Received: by 2002:a05:6214:23c5:b0:680:d395:cff9 with SMTP id
 hr5-20020a05621423c500b00680d395cff9mr4920651qvb.93.1704714973628; 
 Mon, 08 Jan 2024 03:56:13 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-78.web.vodafone.de.
 [109.43.179.78]) by smtp.gmail.com with ESMTPSA id
 de12-20020ad4584c000000b006806f422415sm2792512qvb.130.2024.01.08.03.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:56:13 -0800 (PST)
Message-ID: <52ec1361-ec18-4b9a-b878-73dd36129f67@redhat.com>
Date: Mon, 8 Jan 2024 12:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] tests/avocado: mark boot_linux.py long runtime
 instead of flaky
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-3-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240107170119.82222-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 07/01/2024 18.01, Nicholas Piggin wrote:
> The ppc64 and s390x tests were first marked skipIf GITLAB_CI by commit
> c0c8687ef0f ("tests/avocado: disable BootLinuxPPC64 test in CI"), and
> commit 0f26d94ec9e ("tests/acceptance: skip s390x_ccw_vrtio_tcg on
> GitLab") due to being very heavy-weight for gitlab CI.
> 
> Commit 9b45cc99318 ("docs/devel: rationalise unstable gitlab tests under
> FLAKY_TESTS") changed this to being flaky but it isn't really, it just
> had a long runtime.
> 
> So introduce a new AVOCADO_ALLOW_LONG_RUNTIME variable and make these
> tests require it. Re-testing the s390x and ppc64 tests on gitlab shows
> about 100-150s runtime each, which is similar to the x86-64 tests.
> Since these are among the longest running avocado tests, make x86-64
> require long runtime as well.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   docs/devel/testing.rst      | 8 ++++++++
>   tests/avocado/boot_linux.py | 8 ++------
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index bd132306c1..3a9c1327be 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -1346,6 +1346,14 @@ the environment.
>   The definition of *large* is a bit arbitrary here, but it usually means an
>   asset which occupies at least 1GB of size on disk when uncompressed.
>   
> +AVOCADO_ALLOW_LONG_RUNTIME
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +Tests which have a long runtime will not be run unless that
> +``AVOCADO_ALLOW_LONG_RUNTIME=1`` is exported on the environment.
> +
> +The definition of *long* is a bit arbitrary here, but it usually means a
> +test which takes more than 100 seconds to complete.

For the qtests (and others), we are using "make check SPEED=slow", so what 
about just re-using the SPEED environment variable instead? IMHO that would 
be more consistent?

  Thomas



