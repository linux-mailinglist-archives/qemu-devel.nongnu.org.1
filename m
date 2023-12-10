Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F55580B8D5
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:12:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCBAN-00062F-KD; Sat, 09 Dec 2023 23:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCBAJ-00061N-4P
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:11:39 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCBAH-0007A9-I2
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:11:38 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35d4de84195so13987735ab.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181496; x=1702786296;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHiKyIW8CW8KPATS7dT57c/viP6HxCdGRmtk+8noqOo=;
 b=ZoxwY/Fttft2ZVodekHrKSQEDdJfa3HQwYAxJrPi41GxZyh/vYNURuGqZBGohZ8uAX
 nwAmZhx8Ev3SyG1Hzl+9LGxkPJoqkrCHjO//7EcvM2xfdnZ0iS9TsVAxcbSYSOpR+wwq
 W/SdzTv1Pb6AduUYX6Gi874C+QhQIWC+Sli3Jmavu/Yk9APa3unb8C+wLTOmXBN8tsWQ
 UvbdQNG7N7egq8g/vmK/U7uiPU/Ar2rEE4pR+QCwy40rseMdr4eWNwu0aF4bbYXjGWor
 6bGZE3U8OdO4c3BRg4907qgeeGNczNV10NmG1E3veqJK4r9lBO4bchJ4iSK4TSra++i1
 bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181496; x=1702786296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHiKyIW8CW8KPATS7dT57c/viP6HxCdGRmtk+8noqOo=;
 b=kN12ND2WXCaAFtZDSKf2/h7CZyks/U8RztxzoUw7Ul8ejqQ+57xnWtxhqnUNxSLRQv
 rir3sqaEztyZfkDa0BcBJr9U2czyd+uTcs0jBlnKQ3Ac6I2EB8FaFUwAzAzlYyM/ztxi
 tsaXmJo5SZCw9Jo22gWRlQbCd5K+8lGo6TnF136eDXZGWLjO1pPJOoBn9NlKw/gEfNjM
 zuQJFPFqyUQQYGKHKrWDSLrkRzua67mT1ikOn3fEfcHSZUAzn83oiGbTFC6OZi0/BpFt
 uNMnp9ghL7jtjhJVNdpHyr/JYGW+TS1pisIwvbp+PNKKD7+jGAluqjSYLDXP8TKKWdgj
 J2cg==
X-Gm-Message-State: AOJu0YzrychMRfiLq/WkqwWTu8dKMdbWTiEZILoMbj+GyPAup8VZGsnK
 LYeHL0ovrks/6HlwcVDH0BKCAA==
X-Google-Smtp-Source: AGHT+IFYCMkj99QK+5QRZnG+Mwna4RVhNEAb4Bwjmkcesu1zs/Hyw4q9Djvk4LdrPsOGzmBTk8IIDg==
X-Received: by 2002:a05:6e02:198d:b0:35e:6bbf:4e5a with SMTP id
 g13-20020a056e02198d00b0035e6bbf4e5amr3032157ilf.44.1702181495955; 
 Sat, 09 Dec 2023 20:11:35 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a631403000000b005c6aa4d4a0dsm3949945pgl.45.2023.12.09.20.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:11:35 -0800 (PST)
Message-ID: <8717f71f-5350-45ef-9712-89c1240bc77c@daynix.com>
Date: Sun, 10 Dec 2023 13:11:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] tests/avocado: mips: add hint for fetchasset plugin
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-3-crosa@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231208190911.102879-3-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12d.google.com
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

On 2023/12/09 4:09, Cleber Rosa wrote:
> Avocado's fetchasset plugin runs before the actual Avocado job (and
> any test).  It analyses the test's code looking for occurrences of
> "self.fetch_asset()" in the either the actual test or setUp() method.
> It's not able to fully analyze all code, though.
> 
> The way these tests are written, make the fetchasset plugin blind to
> the assets.  This adds redundant code, true, but one that doesn't hurt
> the test and aids the fetchasset plugin to download or verify the
> existence of these assets in advance.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Why not delete fetch_asset() in do_test_mips_malta32el_nanomips()?

