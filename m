Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D97E3868
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:07:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IzR-0007J9-Ii; Tue, 07 Nov 2023 05:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IzP-0007J1-JZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:07:19 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IzM-0001qS-JJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:07:18 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso9036393a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351635; x=1699956435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4J4kkJz6O3hzXVOuXR6sD805VbvglzIAWsKyxbWp16U=;
 b=cv2wBqwZ5g9hygNaijhK0kybW4Jd+BLV/qX2IssU4ZlU0VGh+Qa3mRnPABGrYQYteD
 2NQcL79KMQV8bUmYES1g6G40sgN25ACiCJj2O9QYm0UNuwoAK0jEI/n0lo0UbW8QILsu
 SAZkYfIGHX0HCOELYQxsZ72WIN521Es1Jyxq2dzVUyujG+7CXUsoAZJ5hg8n1Ypsq6kn
 +HjoDXXzy3nED+1tMOOisOvt566cWKla6owtnO6Wl8g7xwBDt6LjoGThjGWfZaQO7ZUu
 3UUjhj2tPyzBPyu5tKSsQFGUGY/qtixwY6z9okiSZvczRzIsmPGix1rbfx/AZQq4mowa
 HDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351635; x=1699956435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4J4kkJz6O3hzXVOuXR6sD805VbvglzIAWsKyxbWp16U=;
 b=SkDFjwx2Zn62LrDtzskHiFRlpVItB96lGVQ+1EjwLm6jzDpEafGzwQvuWzBLpZg4SR
 jynx/IWP78+DYgi5Yk3O+ZYjcjK67UFWBWbtYJQB/rDC63AhEofP5ccMRxCU9zVQe7rc
 IRKLGvt09wEBg6lhzP6Dk/yNQgZfBfuTW4bkdkju7/myqDZBzvp0Xx6caOyS3Cvt58Iw
 TOt4Muq76fQHtVNfzviRzUGDijglv/tFsBBd6ucgzt+DUf1AgekxhvpJrJ15HmBf5QR+
 Ea8F4/PLSje2P6ODU6cPBzUC1YB7xDpeCZ3+QULkUXb272b+b2GgUU2UKGGZDIOdsKCS
 3fpw==
X-Gm-Message-State: AOJu0Yxjr+bOHsaNDDOZDmYOxpkOac1DV07BtuJYukvT/YSEnnahGlvo
 nI7g8nTwT+CeJHTX1wmsFYai3w==
X-Google-Smtp-Source: AGHT+IEa4iBapsSkTdbmpTkrVbt8JCJlS4kDAwEO7LPYSa8MoSJiIUNPUtBSoLBr4ZNjpNbMx66nng==
X-Received: by 2002:a50:d7dd:0:b0:543:72cd:e14c with SMTP id
 m29-20020a50d7dd000000b0054372cde14cmr18722361edj.36.1699351634899; 
 Tue, 07 Nov 2023 02:07:14 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 k28-20020a508adc000000b0053de19620b9sm5450734edk.2.2023.11.07.02.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:07:14 -0800 (PST)
Message-ID: <3bf96059-44a8-4af3-9b0b-c9f070cd498b@linaro.org>
Date: Tue, 7 Nov 2023 11:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] gdbstub: Add num_regs member to GDBFeature
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Richard Henderson
 <richard.henderson@linaro.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alex,

On 6/11/23 19:50, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Currently the number of registers exposed to GDB is written as magic
> numbers in code. Derive the number of registers GDB actually see from
> XML files to replace the magic numbers in code later.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231025093128.33116-2-akihiko.odaki@daynix.com>

Something in your workflow is odd, you should keep this Message-Id,

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-9-alex.bennee@linaro.org>

and not propagate this one, IMO.

> ---
>   include/exec/gdbstub.h  |  1 +
>   scripts/feature_to_c.py | 46 +++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 45 insertions(+), 2 deletions(-)



