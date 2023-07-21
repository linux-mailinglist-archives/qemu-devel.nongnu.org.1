Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D2875C29D
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMm9B-0003RV-JU; Fri, 21 Jul 2023 05:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm98-0003PM-P7
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:09:58 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qMm96-0006Wb-5M
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:09:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-314417861b9so1275222f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689930594; x=1690535394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uXNgqTOe/M6G5+92cdwm/LqhdcVyVSfcFCjmO3R6Eco=;
 b=qgY0NXgD1qOJ4agClmhjwudl2HB4PihOx/fhmEEsy/D2q0KDAfXxbc+FMvuby240xP
 4VdqJGogbK99t2fbuh7FdTFKfhSD19p3lgXB6bxZx0VyZrKJL37z5NLXgYkAfEb/TaDN
 8j8k+LpNKqhkHMtu+WDY2w6xtJKQJ/056Agiw0qxzR757HN/sc3/zhN6ZlpbChkRdury
 UIBFZwZ+qrLSY50rfSQLzqMLGIkCcdJQfKweicjHapVBuzX+g/ErG+1MvTaDId5QScY+
 ZekgNEh6vPvdKLuIU8FHSyOVSXYgBJJpMa8cnR4ZZizk3BGkAsZTPFHCNIhtK2JuAzkE
 lsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689930594; x=1690535394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXNgqTOe/M6G5+92cdwm/LqhdcVyVSfcFCjmO3R6Eco=;
 b=aKAcDqRlNg9r6tE6z59HihezeTsGkHu0XXQuE3IO7X1oOE3v9WVTnpZmX3mxvhzyiU
 LafFBTPs22N342PstfnH52C+9fNgqHOXQucyNp6zDHJfVY29txGssZG/kupACgFKI1Jr
 qUkSe4IJjCoMMdqas87WdZnKqoJ2TbuCClWWpDGtyCKet6cXRct+wvSRq0UyITN+fz1E
 LXPnoVDTZo1cTaM8ovw3lQrKMTdnQJzyDcTL1Kkji1OzA1AqiUbXhKKN1Wxc8lG2ltZu
 mgq6qPA16q2bV4vBCghzyb76Fvut+JUS8o469aTENUWMn2Wm21o9LFdh6fcSrE9VizDT
 oNCQ==
X-Gm-Message-State: ABy/qLaUxintAnFuunCh3Pk/G3+qFMmS9Xf2z0kgA58J2eDieoqOyBdE
 8XwuJiwWN9yJospEKTFVkyYCHQ==
X-Google-Smtp-Source: APBJJlEXXxtyMWsSLDdHGGe1EKpcXyrO3jIp7TeWsL6NotdPcjDAA338ufWcUeKUOZqGxfer3SYNYg==
X-Received: by 2002:adf:dccf:0:b0:313:fce9:c568 with SMTP id
 x15-20020adfdccf000000b00313fce9c568mr1024607wrm.31.1689930594417; 
 Fri, 21 Jul 2023 02:09:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.192.5])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a5d4b42000000b0030ae53550f5sm3601644wrs.51.2023.07.21.02.09.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 02:09:54 -0700 (PDT)
Message-ID: <aeb9374e-014c-f9ae-43d8-25579c3090e8@linaro.org>
Date: Fri, 21 Jul 2023 11:09:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/4] hw/rtc/twl92230: Use int64_t for sec_offset
 and alm_sec
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>
References: <20230720155902.1590362-1-peter.maydell@linaro.org>
 <20230720155902.1590362-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230720155902.1590362-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 20/7/23 17:59, Peter Maydell wrote:
> In the twl92230 device, use int64_t for the two state fields
> sec_offset and alm_sec, because we set these to values that
> are either time_t or differences between two time_t values.
> 
> These fields aren't saved in vmstate anywhere, so we can
> safely widen them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have a suspicion that really these fields *should* be
> being migrated, but this device is only used in the n800
> and n810 boards, so I'm not going to investigate how broken
> migration/vmsave is there...
> ---
>   hw/rtc/twl92230.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


