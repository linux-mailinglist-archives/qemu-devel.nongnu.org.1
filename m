Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF79D7DA8E6
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwov8-0005rE-Hr; Sat, 28 Oct 2023 15:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwov6-0005qS-Hh
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwov4-0000SB-P7
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:24:28 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so2903133b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521065; x=1699125865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qvHpKjhNSfo4UiZfn0DBQYkFCaaq8Bylt9PuFDoF4U=;
 b=R/2jmwoKt+E+6HPgCVpWDLz6qTlnnAxH8U2VlbAzbEcrIJGExlBd1PAh0c1hW1gtRd
 sFxAQGMUyfjbZQQ92E/02Mn1FO8vdLogKqBt9PrFvUTmoJp9a/mSaZWOqt+cAgLPnuOo
 +6tKFdC/9AYdzyN9Il11+QL44AtX59RTOh6L0XTEd2akuVrpDfUK7mIZdMnnt28BDvch
 zmN2/NasBTzVlrDMjV+Y2jd3YSpTeFfWoBFJf8Pi0rqkM4R2imS1enNjFofqOvkXIxEc
 CevBZyF3Yt1SuV+/hCNu/wPFVWzuXxm5lTifGs9zlxEhKHSbR1Q5NCNh+kxvqMum2hFV
 TCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521065; x=1699125865;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0qvHpKjhNSfo4UiZfn0DBQYkFCaaq8Bylt9PuFDoF4U=;
 b=EbfbC3cmgc+8uOJcKKYAj5rDVy/HwzUjeT7KL3PlpoldY4JYDj07znWgl4axFowm3v
 Y/4nchlBvxQ4THsqiRchvvz0PLl2uYaVMzH0VgW4SdBFN+xLG7RG9KSaC90AYTQaEtFp
 Aq6VeW1EqOjHbD7Wy8H7KQPeErWfc5gEjoH/T1lG6aQqw6WKcpuTMyZG4ntgecV9yhzA
 fOytq7iqmeqlxrW9rhzRbXuseCS/tbNIo6OxReYv0L44jNg1w6DaNfyX6cGNNYzQn7xc
 arGLkgZZNLGuY7+cxycUonvnFwla/Yxs6u/roVIYJjEvKe87yuF65mvGp6uMWA/qqj+C
 Iczg==
X-Gm-Message-State: AOJu0YzrZdQpODNpJoWtz6Or5JimEKpEfCSh9hG52ko7sqo7oxX+sCeH
 XYKSO5sJc5Om6KSxPAEmP6776YuIFgZbJoDKF4g=
X-Google-Smtp-Source: AGHT+IEXvshvYbk7y5S3gsZrVb7tTmHwFpo795k36EDkufckRSx4FDPIVVl4ok2eakQ9mSwuhbAdbA==
X-Received: by 2002:a05:6a21:4847:b0:172:83b8:67f7 with SMTP id
 au7-20020a056a21484700b0017283b867f7mr4980644pzc.44.1698521065517; 
 Sat, 28 Oct 2023 12:24:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:24:25 -0700 (PDT)
Message-ID: <4295ffe4-ad5d-4636-8e05-d9d3d33dfe38@linaro.org>
Date: Sat, 28 Oct 2023 12:24:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] tests/docker: use debian-all-test-cross for m68k
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
>   configure                                     |  5 +++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  2 +-
>   .../dockerfiles/debian-m68k-cross.docker      | 19 -------------------
>   4 files changed, 6 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-m68k-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

