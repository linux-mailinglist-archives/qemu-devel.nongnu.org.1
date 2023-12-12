Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54680E626
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 09:30:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCy8K-0003ac-IT; Tue, 12 Dec 2023 03:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCy8E-0003a3-OR
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:28:46 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCy8B-00031o-QY
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 03:28:45 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b9d8bfe845so4155351b6e.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 00:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702369722; x=1702974522;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ZDuJb5o83deCIk398ERTz9rXoxThyM9NCtZqNGkNHE=;
 b=FAZLHwcQaDYg6rspmbkGpRBlv2/FCE/uZ6qMBGRVb0k9BO+sJNmzla3MqRtFHGOtjB
 kIXYQfl2iHCxt2RIQaTyq6GLFqbs/N48XS7qlDUE9eO/rveSnuVMkpsP7Pku4ay4bzCG
 KowZ4nY2wO+hyhdjM8BhP+GMqxDplfPTO+mlz3KsX1k4hr2d5jfI7sUXZ/gE5TxY3AMV
 uCRJRtoGO89jwhjP3moPA9l5ATZSumvzMLfZdKvpY85tFM0vc0m2/PDTO86MK+CoRR9Z
 4Vj9s7kzU/yfREt+u5rSQMM+/bvka07BdeiToMAwfKrAL0H0TvTc1YSl14YVA2/14rBJ
 mKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702369722; x=1702974522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZDuJb5o83deCIk398ERTz9rXoxThyM9NCtZqNGkNHE=;
 b=KYVvLSiTKd5szix0PY+8JR/4w2tWh+Xnouj4FJkgaK2mo7z9jG3CIJhbwF9Rv5iGxI
 t41dFOJvBeDg2KUZIF4R2yUjXb1WGdNYJF0T0WYEIp6IXXZLbVv9Nk31ZJNIwr+B4GOD
 3XvTc77431HMNdKLJmGtpvwJ7Pqk9dCHllBswQPFjzHR2uus8DQLpoGyHWuJwPZz3a78
 2tMlnrym6FbetWL9r+P45UbcQeGnVdVlMuNJZpNQoABiS9rizH3qNC5iBW7fEq4IVN1T
 sxfhy8fJ2qlm/Sn9/hCjjuD11IrucsSytkCF1dDt4YBt6P2nbOk6b2v220gzKVMdOJp7
 a8Sg==
X-Gm-Message-State: AOJu0YyeOLPpOXw2rHWD3AKIDSpE1+uSFW1UPBnhLb29CcbQZl4F5VJg
 mYc06EO85tkx5HuNyBfT4LYjgg==
X-Google-Smtp-Source: AGHT+IHACAohiWJ6FDAypIz0YYUgTXWNKNNi0cBFK4j4vhbffcFTROVyJXs0XEXQQXTt3xQ2dqT/lA==
X-Received: by 2002:a05:6808:444a:b0:3ba:4da:89e9 with SMTP id
 ep10-20020a056808444a00b003ba04da89e9mr4681212oib.11.1702369721890; 
 Tue, 12 Dec 2023 00:28:41 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a62e710000000b006ce3bf7acc7sm7514037pfh.113.2023.12.12.00.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 00:28:41 -0800 (PST)
Message-ID: <3f15630b-4373-4fbc-83cf-ca568341b4d6@daynix.com>
Date: Tue, 12 Dec 2023 17:28:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
Content-Language: en-US
To: Marek Glogowski <smarkusg@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
 <CADfA342Dr5troPrjE6Sf2+mMuPL5J1Q_zuXhJxrUnNo9tT6KsQ@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CADfA342Dr5troPrjE6Sf2+mMuPL5J1Q_zuXhJxrUnNo9tT6KsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x232.google.com
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

On 2023/12/12 17:04, Marek Glogowski wrote:
> Hi
> 
> I checked on the emulation "qemu-system-ppc -machine pegasos".
> Full-screen seems to work fine. The screen is correctly initialised in 
> full-screen mode and there are no problems with closing the window when 
> the session is suspended.
> With this series of patches, there is also the option "Move to", which 
> makes it possible to move the screen to an external device such as an IPad.
> Thank you for the ui/cocoa acumen
> 
> Additionally, how can I use this message on qemu-devel.
> It has a post for people who use Macos or Asahi Linux. Verify random 
> qemu sessions under Macos .Some are faster others are slow.
> The topic is posted on qemu-discuss@nongnu.org 
> <mailto:qemu-discuss@nongnu.org> (I don't know if developers look there 
> often)
> 
> https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html 
> <https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html>
> 
> The program posted there was prepared by one of the maintainers of ppc 
> qemu machines "BALATON Zoltan".
> We are starting to gather as much information as possible for it.
> I hope nobody will be offended about this information in this topic. I 
> do not want to start a topic and litter other lists
> 
> Best regards
> Marek Głogowski

Hi,

I have confirmed the tests run in about 25 seconds for each trial on 
Asahi Linux (Arch Linux ARM) on M2 MacBook Air so it may be specific to 
macOS. It needs some serious debugging but I don't have free time to do 
that these days.

Regards,
Akihiko Odaki

