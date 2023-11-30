Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E257FF45A
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jXl-0006nL-0s; Thu, 30 Nov 2023 11:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8jXW-0006mr-Re
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:05:25 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8jXT-0002gE-8B
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:05:21 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1f5d34235dbso509937fac.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701360315; x=1701965115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n0aNH9A7zgDcAASqStlMfqHSZL65zf0mh50KHVviXlA=;
 b=E1o+MzSdT8tCdT0nnUn0B9I1xRywJZpESjIcyIt+VE/08uO/BK9qlYitiEZQIecWx4
 aJ/z9SVZUqYJNrsPpCE7ZfqrIR6NwHLlcvcWigB908u0NlpwuX4WgkNxTkOUvIrcK8dH
 4CdAkFIavOAapKpznmYXDxuEY8jYvw5HDsO3LiRdbiTzvhItBMqwLsLcB0iufUpt3p+C
 3isE4QPWY0Kyk6CX0Dxks3Jl8SZkdD5mBOvyzro3QdIdhH2Ht8rK0+KCvjsDbGAQ0MZa
 JXTcr9My8AqtEhyZLQRzl8+Z1tG61V3fkHtOLypJBlT3cbdSlaSZHzNFzWASOT3+oN3Z
 gQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701360315; x=1701965115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n0aNH9A7zgDcAASqStlMfqHSZL65zf0mh50KHVviXlA=;
 b=S1kl2REGqvq/r/WAWcoAi6C4Ea1M8mXflc7OAGsFWXZ0PyYXfSRJvzuYW6rf2JmGfF
 jCErPjvgKZ0/GRK1I1RfcsRrpAiS3meI+LjchsKYJKPXHOOVZN7k2oFV6bI2U+FEbu46
 kbjFvx00o7teJjHv7WrZSKlphxCXZVz9X9ReJRrOqq4QhZGQwg79+pHhcMVE1Knn/KOl
 n0n+8QT+o3qssqj40WSfHdUACCac4PNTjPfK6dWnWpYvm5DYhLYNoMMbLEge4akl4bGz
 PX/m7Kc2G6ZopXGTtNmfEjwN6Tfmi3p91TX8nBv4DZn7f9O7mXi46SA/txjc8VnPrciy
 30jg==
X-Gm-Message-State: AOJu0YwDk+l+zrdtJfID7cpHfTkcTMuK7NMPZPnWcKuL3SBzteSBwYJW
 oIgeWTZQWQB+G1AAKDqOmN0VUg==
X-Google-Smtp-Source: AGHT+IG0zmPgyZxbDqG6Uei6B4s/i1C81O0voOiadZIFbyeAyM0f8QpYn6qx2NHORlUUU786epqlBQ==
X-Received: by 2002:a05:6870:b86:b0:1fa:169b:3cf5 with SMTP id
 lg6-20020a0568700b8600b001fa169b3cf5mr11950519oab.28.1701360315383; 
 Thu, 30 Nov 2023 08:05:15 -0800 (PST)
Received: from ?IPV6:2607:fb90:f2e0:8450:be70:af46:b71a:41bf?
 ([2607:fb90:f2e0:8450:be70:af46:b71a:41bf])
 by smtp.gmail.com with ESMTPSA id
 cr3-20020a056870ebc300b001fa3ab0a3bdsm319867oab.31.2023.11.30.08.05.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 08:05:14 -0800 (PST)
Message-ID: <c887c7b0-0d47-4350-bece-3668ad75bb9d@linaro.org>
Date: Thu, 30 Nov 2023 10:05:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] final fixes for 8.2
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231130153333.2424775-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/30/23 09:33, Alex Bennée wrote:
> Alex Bennée (3):
>    gdbstub: use a better signal when we halt for IO reasons
>    docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
>    gitlab: add optional job to run flaky avocado tests

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

