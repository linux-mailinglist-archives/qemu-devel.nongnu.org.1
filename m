Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAE47E49A2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 21:18:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0SVG-0007AU-Ib; Tue, 07 Nov 2023 15:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0SVD-0007AG-Ta
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 15:16:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0SV7-000139-Al
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 15:16:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so45104575e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 12:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699388197; x=1699992997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgMA7yYTutO3WwAosjJe2MCBdUowFV8bW4BGzygP7Vw=;
 b=lZl37rXUM9U7UReFe1ls7rXxYEv7X72Y3dnC6zxiXYlceh5jDwLGKb5H+XV2BFtjAe
 yMDa+lYegiGRoMW0E6KtwbuvdHEficVFCicZsdeLzLvKAov7aO1de9Dpblxco5FkJdM/
 tz92QYnWoHIlRj4Ry29Js3EDQsUyf2P+P9YaASLJLQzByzIQFiI4/yH+F3GKl1dPcWey
 wnLDKiRgjMUXasZUC49MEMA5P7DN2SiFMDu+ApJ3G96OM4WCvvkFCzkU8fyAb6U4YyZ0
 LiVjFMP7DiElWnh3YCMF8cFKYrsCNHr4adKnyCrlN2g/Rc18v3pwswAIvQ/LUju7Nbbv
 Djlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699388197; x=1699992997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgMA7yYTutO3WwAosjJe2MCBdUowFV8bW4BGzygP7Vw=;
 b=LgrtdNOn3pE9qdytRs0tiFhkRSuEQdPS2o72CMZnnIlpaLUkeAOWkUDiPZQwcgOdte
 lk1jO6PIuF73jqR0QYlDQex+eG2DP9AlNAJtA4jaZ9Q104uGjnYOWwph0mcW3+Wd7l1c
 uFLUG0aPqc/vl/6OqmH5Gbb0pdj7Ei7XjXDDQuj2RMRZXz6Kon4bRyw6/kpi9J+f1Pux
 oJrpyFr4opq7QktOJaIikt4n4jrOswJfKS9mpIJkjIx18+1BcCv79C2AEwewuMdcfb7F
 FR0JxuJJajR3S4LmcGLPaLzyo17aqWTACi9uwnuPwXX9U3rl8lDo/a6AWU8080HeAtQ2
 SkDw==
X-Gm-Message-State: AOJu0YwFbICF8+AbYjIN4JXcZYJ7UqwQjIpoYTGDBb8fNGsLu0RbhPuW
 QDEeOYVFCRN4ALUFzcALAZaZdQ==
X-Google-Smtp-Source: AGHT+IE7VISjuqCBM5nXO9KB+ERybl6oRQ8lhZbK23jlntXpdF/usJj3ORT7DdtHpIQJpJTL/Iz5lg==
X-Received: by 2002:a05:600c:1c1f:b0:405:34e4:14e3 with SMTP id
 j31-20020a05600c1c1f00b0040534e414e3mr45827wms.3.1699388197281; 
 Tue, 07 Nov 2023 12:16:37 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 ha7-20020a05600c860700b004080f0376a0sm16304370wmb.42.2023.11.07.12.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 12:16:36 -0800 (PST)
Message-ID: <ab47bd6d-4b85-4761-99e9-2c4b81023ff4@linaro.org>
Date: Tue, 7 Nov 2023 21:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 4/5] MAINTAINERS: update libvirt devel mailing list address
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231107190817.1607710-1-berrange@redhat.com>
 <20231107190817.1607710-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107190817.1607710-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/11/23 20:08, Daniel P. Berrangé wrote:
> Effective immediately, the libvirt project has moved its list off
> libvir-list@redhat.com, to devel@lists.libvirt.org
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

FYI I already sent this one:
https://lore.kernel.org/qemu-devel/20231106110336.358-60-philmd@linaro.org/
I hope it gets merged smoothly.

Regards,

Phil.


