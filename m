Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74160792118
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRaw-00031d-RY; Tue, 05 Sep 2023 04:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRaQ-0002vR-4W
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:39:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRaN-0002kE-2R
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:39:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1863943f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693903137; x=1694507937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0lV3DJ+XHWkmovo3KNNDXOCtaqNZwKjJ3GgF5ulagFA=;
 b=qiwbi8QRz84WuikSvQHtcD/sXx/8GKU7RQ75O5FLvvCU2tS8RBUF+5ErxwCDhjU+Wx
 ZQO61vMS4WL+rSJ/c/l7TU78MGRNWeDXBZc/A7Oi08Ghpo5kEfRM7sx0BO7JWxJfJu84
 /6Z8PnOMtkuQhL4A0B9zMOg9HuswfY8yCibmOh8gSfOMsuX9IRCF/r7+b7g5CbldepTM
 z8itEVghFNBoocwm5K6Qa+Oygvxj/Ae08YhGSpUvviTZos0luNW/5bXZLcD98dMFmGIJ
 9T+RtYYKQt55SUcSJrXiV4SbyHjA+FicFYMDOdvRxvRFJQ2OGsGPTRPDUN9YuyFDT/SM
 y6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693903137; x=1694507937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0lV3DJ+XHWkmovo3KNNDXOCtaqNZwKjJ3GgF5ulagFA=;
 b=hqCXhElJS9xsaK29GdRgY/j0SJxaQOzmk6vdyIrxOnG4rnp6noAU3p0LANz72zC7Gv
 bwMBXKcZJR0rvw3BBW1ydNAd+fIOCBRh863TWpQR/moqhLRraimaW9iGbxLIeXX8+rtF
 Fpy0u4sOVGPXc6EceJ4rnjTCcUcLS1pOOi3wPxwkOGj+85ExmNEd2Rim62Q3c95Nt9W/
 KhQpvr/M0ArYGMKzMjJ6WgYqLRtxuNcmcYDtO76JM7UIi+jyaqyw9XiecBwcSowSoiGx
 YYL6Bg7AJxHf/zgg0bkv8em6H4uwzqcKK67feFVdVpBChs6RPEnOd/9B9jlBbJVqBdF7
 sG6A==
X-Gm-Message-State: AOJu0YyTN0ltlvX9nK0ZsNiV59bO8JrFJ5a9QUtTjWgEJzi7Owgh+4Cp
 SXb6EuZQf+pZqBKSgy2ohGy9gg==
X-Google-Smtp-Source: AGHT+IF3SCqKI/eOyx/nCu/3nAAtvuv27M88iyo3tRYt5fDKadmmwE0L67a/2aOPS81KUfjctkJagw==
X-Received: by 2002:a05:6000:188:b0:317:7448:6613 with SMTP id
 p8-20020a056000018800b0031774486613mr8494508wrx.55.1693903136874; 
 Tue, 05 Sep 2023 01:38:56 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 z12-20020adff1cc000000b0031ddf6cc89csm16645617wro.98.2023.09.05.01.38.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:38:56 -0700 (PDT)
Message-ID: <4babbe22-581a-54a0-a002-a2d46c136f9f@linaro.org>
Date: Tue, 5 Sep 2023 10:38:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 1/3] Python: Drop support for Python 3.7
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 "Armbruster, Markus" <armbru@redhat.com>,
 "Maydell, Peter" <peter.maydell@linaro.org>,
 "P. Berrange, Daniel" <berrange@redhat.com>
References: <20230904095720.154738-1-pbonzini@redhat.com>
 <20230904095720.154738-2-pbonzini@redhat.com>
 <2fdf3391-bef5-7d86-d066-1f687cec1285@linaro.org>
 <CABgObfa-65y-y1u=ztQ9RdaP7ub7VZAoDjm9e+q8xmCwkxgtSw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CABgObfa-65y-y1u=ztQ9RdaP7ub7VZAoDjm9e+q8xmCwkxgtSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/9/23 08:00, Paolo Bonzini wrote:
> 
> 
> Il lun 4 set 2023, 12:34 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>      > Since it is safe to under our supported platform policy, bump our
> 
>     Is 'under' a verb? This sentence is not obvious to me.
> 
> 
> No, just drop "to".

Argh, now it is clearly obvious... :)


