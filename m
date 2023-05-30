Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B07162EB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zvV-0005zd-ID; Tue, 30 May 2023 10:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zvK-0005oT-Pi
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:02:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zvJ-00047V-7y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:02:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f68fc6b479so46355335e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455324; x=1688047324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzAcObIyff1vXbnB0Bajjnvce7V4RAkrBzQi6JJyIO8=;
 b=uuUd3pA/kGMqkF8OmJRNLxo5nEx8YH+7DZkZUJ20V2c3aQTiB28Etou8YUeIP4zV2c
 wzQbxqTmZht87yWSqftU+Ng55kFtoy5LV3qBuCqvF3/OvI/8lNw9ZSs00tquyh4Hr3Jz
 e2hDppFYiq5FTdeU3MZLPaIH+VGUP9tCULM8zHxXYkPBeNs3bLoJQLF+/T18hZrjpqoq
 7rr22rNWS6ODWFvft1o7uWHTsf9pZPN38A42QYyPRJbIh+uw6WoF4/htjQkKIzbyAjwN
 fhveKcCnThyo4EU8YYNfQ9lBnFmoPLe1J33UZG+RedC4ZiwQVgEX9o2CWtvWIFdbyyNz
 XUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455324; x=1688047324;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzAcObIyff1vXbnB0Bajjnvce7V4RAkrBzQi6JJyIO8=;
 b=ZTTr1RUyhl60aA0wYvfz1gvcjrLT+W58AqNIE1OObY4aQ+6XO8a9G0Po1LnfwCaDnB
 dWpz7BhpLGBqmy9+AMIvvaoyK3wCXoi+liM9XDZogdLCmWtHlQL5JZ9DdpU/eZSHhI8C
 mhNEeHjjRs2CHeTbhsYRR77YRKHgemWGtTztZMtuzsb91NpCaBRFI3NZ1XxxELzi5REZ
 Mn+fCYpNRFid0LgOWsELOY0oh7NEUY+pZPZwS7GJONu6awzkdQ4HY5T+MlstfGExdVM1
 aqi94/BG/GlyxyZPkKhAn1L6crivCpAFQouiQvOpC/HAScdVvDHikKuQjJO9GZI+X9/U
 b7aQ==
X-Gm-Message-State: AC+VfDwh4jQYq4pX/lDfRGupYLFADphok1iS6k1sVY7a3+LtULsUFWj/
 XalmvRSQSUpBA4VDmP9Kain9RQ==
X-Google-Smtp-Source: ACHHUZ64EMzeuTERtIKBSe0oWCyNS3GIYKXPIfGg+9uMvPPLuc4AFwqBplrcsDLFFxn6vem2ODbEkg==
X-Received: by 2002:a05:600c:ad7:b0:3f2:549b:3ef2 with SMTP id
 c23-20020a05600c0ad700b003f2549b3ef2mr1924183wmr.17.1685455323828; 
 Tue, 30 May 2023 07:02:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a05600c205700b003f42314832fsm17501694wmg.18.2023.05.30.07.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 07:02:03 -0700 (PDT)
Message-ID: <29192acf-0876-e14e-1331-45260cb179c3@linaro.org>
Date: Tue, 30 May 2023 16:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] Prepare bcm properties for videocore 4
Content-Language: en-US
To: "Kambalin, Sergey" <sergey.kambalin@auriga.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230524191438.172019-1-sergey.kambalin@auriga.com>
 <CAFEAcA_PH8yAT28s3p7_0rqK9NodJ6gTXxv63J+98XoMQ_nJTg@mail.gmail.com>
 <15c444063e114814807551c36ea3389b@auriga.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <15c444063e114814807551c36ea3389b@auriga.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 15:00, Kambalin, Sergey wrote:
> Got it! Thanks!
> 
> I'll split this one to three patches:
> 1) replace magic numbers with named constants (refactoring)
> 
> 2) add new properties for VC 4
> 
> 3) Add some unit tests to check the newly added properties via mailbox
> 
> 
> Is it OK?

This looks good. Try to imagine sitting on the other side, where
developers will review your code. Usually the simplest the better,
even dumb patches, since there is no risk for doubt. Don't be afraid
to post many small patches.

Personally I'd do:

- import Linux definitions
- replace current magic values with imported Linux defs
- add GET_CLOCKS property
- add GET_THROTTLED property
- add FRAMEBUFFER properties
- add GPIO properties
- add VCHIQ property

Look at do_test_arm_raspi*() in tests/avocado/boot_linux_console.py,
you could add newer kernels which use the properties you added.

> (Sorry for wasting your time by inappropriate patches - this is my first 
> experience with OSS)

So far you are doing great!

Thanks,

Phil.

