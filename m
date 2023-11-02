Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA7B7DEFA6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:17:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUkf-0001jf-HH; Thu, 02 Nov 2023 06:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qyUkc-0001im-Sr
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:16:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qyUka-0000p4-4b
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:16:34 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so1147778a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698920190; x=1699524990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pEuyS6PFzaiRhKJYYiHWIf3WVjJ25FyTyrtfZQavGv8=;
 b=RhZM8gp0T/VIiHkuJC52bJMKJOFx0UnByCHXQ5buT7gROtyhXU69V/8F+7HtiI88jl
 zU55+p90ILhtLTJXFbx4+YusVhOtG18dE8iXOsncVGnXlYF5ioGCgW209EfP9wTR0ugU
 2OeWBf2nTmAQUKaaPjdYicRkfL/mKWPdEoBYPMdyZlgRxZNPuXsuTL2HXX/Yx3+YD3z5
 Padgq9l0aSYT1KLZx1h05Wen5cS4AXTTlrQhR97ekk6bonzmfsdJ9LqHXTyNavBCqiJm
 ehNDl0ei2U4+mWkPZuAJzY8XKFM92Q5BjWe+qBkj9BaPIlZ0NajqC42QRH+yqYVOMB1D
 ScRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698920190; x=1699524990;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pEuyS6PFzaiRhKJYYiHWIf3WVjJ25FyTyrtfZQavGv8=;
 b=g1+3j6k8nTVKS/mRlo41Mq0eTFP99rrTJA0RGV96L6ckzFc20g/e3SY0B3ewwo7m0K
 TtqzALXX8ZykP6FZPsd00rxO1tHwZO+c2yy6wz2ncJTQ59Xk2M2jWwjUx7y8vjDFDffw
 aTTLYatUXagfo6S1zvjIrtons+/ARqbhWpX3EMCkDxrO5iexwZx+mtL585gJN+3mIFOw
 7te8InEbpVdWOf0Y57iSvP/YuYv7NOWP8gDXSqNcha887K53dnZtXhJbb3R/5j5Znpx9
 EM8FnXyTbKxeON7UXXBeGJ36KXioe7QeKj4PcKrQ0+ZiR908aJqAvcwX9gGOMwpZMW9l
 tKRw==
X-Gm-Message-State: AOJu0YzrBIH+kX8bPGcjf2X0jrXDFK9FI7kw3LjJdyN1v8ZBt0R5630S
 WaFUnloAqc9AE5x5s6mhmIQZ5A==
X-Google-Smtp-Source: AGHT+IGSPhO6SzbRS9hwFswyZ580KrD6Pj03nL/S0eRpYsFgiAUhXvPfVJQ7Tfn/IYZwRSUQbIDAPw==
X-Received: by 2002:a50:d553:0:b0:543:74e6:9da2 with SMTP id
 f19-20020a50d553000000b0054374e69da2mr5684610edj.0.1698920189614; 
 Thu, 02 Nov 2023 03:16:29 -0700 (PDT)
Received: from [192.168.200.206] (83.11.185.48.ipv4.supernova.orange.pl.
 [83.11.185.48]) by smtp.gmail.com with ESMTPSA id
 e12-20020a50ec8c000000b0053de19620b9sm2106566edr.2.2023.11.02.03.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 03:16:28 -0700 (PDT)
Message-ID: <7fea290c-5e11-44b2-b670-a518464b5d05@linaro.org>
Date: Thu, 2 Nov 2023 11:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FreeBSD 13.2 installer does not see AHCI devices on
 aarch64/sbsa-ref and x86-64/q35
Content-Language: pl-PL, en-GB, en-HK
To: Niklas Cassel <nks@flawful.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
References: <b7e00b36-2ac8-44fa-9847-b2025ebe05f6@linaro.org>
 <F1D854EB-9C6F-4A54-BAA9-D75C40DBE86F@flawful.org>
 <a6cc110d-132e-b3f3-0b64-368bcb5c31a9@tls.msk.ru>
 <ZRx8iLkWE5fwLOpE@x1-carbon>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <ZRx8iLkWE5fwLOpE@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x531.google.com
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

W dniu 3.10.2023 o 22:41, Niklas Cassel pisze:
> On Tue, Oct 03, 2023 at 08:11:39PM +0300, Michael Tokarev wrote:

>> Were you able to take a look at what's going on here?  I wish I were
>> able to help here but I know right to nothing about ahci emulation..
> 
> I was away on a conference all last week, so I didn't have much time to
> look at this yet. I will debug the problem this week.

Did you had a chance of finding out what the problem is?

FreeBSD 14-rc3 came out recently and problem exists still. If they have 
to change code then it may be last hope before final release.


