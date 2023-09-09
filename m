Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E72799B78
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5le-0007ka-BP; Sat, 09 Sep 2023 17:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5lb-0007Xm-Kh
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:45:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5lZ-0007aU-5S
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:45:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68c0cb00fb3so3012723b3a.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694295918; x=1694900718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7lmnRSaWvwUO2cahoC8pkeFLJzMHhijxFy2yPPWztt8=;
 b=gbyKLe+3XD9ssK1+Gn5oknprs404oZBp/2vHtJXb6uEuU5bCUrKN82Hx4jha1yBzXR
 gYDjGoradj5YY8nAQve5JFx3unYJFwvqd5959zjAwHV09foptitxKbsveJfi8R3VUeu2
 YljEqmcpb3esgaurrOxssieu2g6ia9a3kQnbq+rgsUOsDd/jZ7Z7bgwKmBO0LeTitVQ+
 RvbLvbjLGXxqZ+f3n31KHXOeZzRRaIzstXZmX60k4cuzY2pNZFeVL5np+lqzHPQt6DDP
 vSImai4LXabOd87iy+8Vh8MUFGTLh2olWRTsHnqElnSBa+0zfRzIs/U3UDt3zNHSicdP
 Gxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694295918; x=1694900718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7lmnRSaWvwUO2cahoC8pkeFLJzMHhijxFy2yPPWztt8=;
 b=qqD5qKRhMRraMz2j5VqooY0wvSvrT/z+zSFpCYXlj2DyYZdiWV/jJ7xUyhuBD6EPSZ
 pWvgO5WMoC+igWNo0ybJPo1+cfE/dc38ywDLrgtcmbtOLx5cyIhzb4qXYtqZPILF1ZSK
 8JeO5I+CpEAJZj0ftfz3sQcSFCWz8HY9KFV61jDrF5e6pHiDvihCmZlEdQGnCIZixa5a
 ctnS3NZW/AJZND07lz56LulnJPbUBj4vdeU1xJ3dhhCjJ2SD8eI2UzUeODCiFQmStvBn
 dFZiVsT5/xwgqCEjwF6X/sXCSnWb6+23zKJkKFv34FAYAK5WiOKbkO2fKBcUBaTcXQb/
 /BCA==
X-Gm-Message-State: AOJu0YyVY33JUG1HgWUCPE2BJ+vOWJqyxajnVAUGpjUOlpgrBpI8miH0
 77JdqTQ+TRpfxKc3UxwZerjBsg==
X-Google-Smtp-Source: AGHT+IEqw9lmMTn9qUokX3q28PRM1Pph0svsKb4vpq2qcMvYCobV0tlYhySGKpL+kTx3/BfzG6FycA==
X-Received: by 2002:a05:6a00:4218:b0:68f:a5ff:3f3a with SMTP id
 cd24-20020a056a00421800b0068fa5ff3f3amr2779165pfb.11.1694295918427; 
 Sat, 09 Sep 2023 14:45:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y26-20020aa7855a000000b00689f1ce7dacsm3120828pfn.23.2023.09.09.14.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:45:18 -0700 (PDT)
Message-ID: <dc4ad688-c5c6-8464-737e-92f087ca48a3@linaro.org>
Date: Sat, 9 Sep 2023 14:45:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] util: Delete checks for old host definitions
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20230810225922.21600-1-akihiko.odaki@daynix.com>
 <ff0c7ba4-2c4f-4638-acc5-8819179da7e1@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ff0c7ba4-2c4f-4638-acc5-8819179da7e1@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/2/23 22:53, Akihiko Odaki wrote:
> Hi,
> 
> Can anyone have look at this?
> 
> I also have another patch similar but for thunk. It was reviewed but no one has made a 
> pull request yet:
> https://patchew.org/QEMU/20230808152314.102036-1-akihiko.odaki@daynix.com/

Queued this one to tcg-next also.


r~

