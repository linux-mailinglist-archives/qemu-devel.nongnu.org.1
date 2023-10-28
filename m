Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EC77DA8E4
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwouK-0004hR-89; Sat, 28 Oct 2023 15:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwouA-0004ep-Om
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:23:32 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwou9-0000Mm-7I
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:23:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bd0e1b1890so2759438b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521008; x=1699125808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmQCo4Ze/JxdoHJaWpQY+Fmizs/6gYSFsG1kanyMQfM=;
 b=rZh0s6NI7ctCo7tX1I66pDNTLSujhnnu/wmL2Fiq7m7ZyUQaf2y7oEteaBwUcRTjKF
 ewjpQt/OeIGozXYWcqCaPvCp8wKvujHHewp1nqjJlMT/jKZTaX887sD6j7NJQb291ahu
 CN5UDtok13QJTJTEQN4q6Yn+9qKcucCgZUOj2HIh8ycJHbZ2zOFM7MSezEltXEX5M1sA
 JDmVipL9frGY4R4t5VAgkfv+3upWRut9PRDfULBbOURebWjBgrAS4z+TPE1e37Eb3Cw9
 NWWYTyD+Ubfa7EbpJycB0ONIW+hmnKyPq1pqGS+TaJ7twgs/5Dhy+nMS64z0vZ/XZ6uh
 nEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521008; x=1699125808;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NmQCo4Ze/JxdoHJaWpQY+Fmizs/6gYSFsG1kanyMQfM=;
 b=vHsmsE+FVAyjKuh/mNfY+WJBHbsbl1AFjSsL6crGaiSy7iGMfbsv0jy4DOt3b9c2gh
 CiWPDYk94sgd/Ytbrul5fv/K061Tdc88WQ7SeTOa2RXLOlX0yrOjU1MMVQt1CwvOZTAM
 D3Xy3BX9OiiSzM0Z+YxXLw2jWwIMq5OfYYN7U2tZy7GV9bkGRCVC+Cxwg/3scYBpb4Na
 IujoC7jdF/K1gNvGn/gLlHeIS1fYZXP7k+aqXn1S1eYCtRMDNSzGw+LqN6GbZQJm7etA
 enZqH8F0oAU8Ldz/IQZM3L4VUhzuHx+cFRl5lGlgLdi5nFbwclfYbrAx4ruq+tmH/sxi
 PEYg==
X-Gm-Message-State: AOJu0Yyvg6cITCFcCL3oj5NUhZJHbFQWfRpyKZzmnv87bazlpbSBe0Ez
 E72AHFUtsrQsv+y5yPpSj4NE9PXPqInZCBwZcJo=
X-Google-Smtp-Source: AGHT+IHGJr0RrsuRFAT0vXTf4TOGp2WwNEMuz58dYdNQS2dbFCmOIBdasscCwO0H/VEGjWUIU3yIng==
X-Received: by 2002:a05:6a00:150e:b0:68c:4e22:8f78 with SMTP id
 q14-20020a056a00150e00b0068c4e228f78mr6133643pfu.25.1698521007759; 
 Sat, 28 Oct 2023 12:23:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:23:27 -0700 (PDT)
Message-ID: <0b429a5a-8c5d-40de-b53c-65110d65a5b0@linaro.org>
Date: Sat, 28 Oct 2023 12:23:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] tests/docker: use debian-all-test-cross for power
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:33, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  4 ++--
>   .gitlab-ci.d/container-cross.yml              |  6 -----
>   tests/docker/Makefile.include                 |  1 -
>   .../debian-powerpc-test-cross.docker          | 23 -------------------
>   4 files changed, 2 insertions(+), 32 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-powerpc-test-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

