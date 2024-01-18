Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790F831C3B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUBT-00053x-1f; Thu, 18 Jan 2024 10:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUBQ-00053e-Ji
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:19:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQUBO-0005Tq-Um
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 10:19:56 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-337d6d7fbd5so262236f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705591192; x=1706195992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCbAnUjvgKG20+9DpWHVRnqgTMixpS8WefegCWeTDjw=;
 b=yrHZ7h1muV/R8hwPXnRNpm6bgAwAXRXh3ByhuQRn0i6HQhny6nDhWi+RXZpAxcmyTy
 5qYFXbYJp78SBe7gHFS81vz5KwJ5SMQh+HgW3zjJPDwRZ14OQ4P0k0NZsK129qkJz/WI
 ExLGp7wblRkMKUGY39zePgjnpA6kk09U1UekbgLUl7qDPa/mIZ7irWQDmZcYxvFU/vtO
 55PGWDoTbudWtitHlExRRoJ1Q22/QC7oNrtJtijGTFvMboqOw2nfxL7mZH7HMLZOtrIF
 RKMq8IzAo8vlEQcMj1qdBZSAvSkigJ4Sken78LtRgmWzvHapjxgw1ecwbxBCbL30TTHk
 7ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705591192; x=1706195992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iCbAnUjvgKG20+9DpWHVRnqgTMixpS8WefegCWeTDjw=;
 b=wTi/uUsjV3KqC8BiPkZNqkGzCvTN9vitr7Plw6tVYgwV7wnonGPb1FqkhpKD3ZsKmc
 uwDUUXZhCCXcn9QjkavBpjna25t4KxmrQv6YDThAKVk0aMtUMEDTZk0IkdFPbP5eSnPU
 sIAOS7irAkCZzb3TiNptSqmmT/DMzhUd58/DqVLvCG6PdXNhNrzHM8wiV/RDEl1hdy3P
 chCOYiBeKvbDTaE0CKMXP8qr+1a1TIjdyAtHzkCT4QHmaGc0AEQAmukBtawsYbQ8Xm8C
 TeKKOdd+DbTwnjOV17hBfqQL+4rAkQPEQ8VbOkiSSuJJi8KTqbMMTlnun8NStsxCnOth
 ATqw==
X-Gm-Message-State: AOJu0YxrYciGqrvpn8qbXQcWOgOxHl2L5vsXHoCiAHGlX8eigfZfSCpn
 bzkBP7lWGQot5vEleYWxlabwGFNIETxYBbNOTRv3wAInXf6LtnAfzmZ0dbB6MVM=
X-Google-Smtp-Source: AGHT+IFo6M2BJ37VNJZj8zQXThYttHtIH3jMa8a8GrY+dKcuLdhUUa5jGhiPavtkUKrmv1cGXo2V9Q==
X-Received: by 2002:a5d:4692:0:b0:337:9a69:25c1 with SMTP id
 u18-20020a5d4692000000b003379a6925c1mr690227wrq.57.1705591191667; 
 Thu, 18 Jan 2024 07:19:51 -0800 (PST)
Received: from [192.168.108.175] (33.red-95-127-38.staticip.rima-tde.net.
 [95.127.38.33]) by smtp.gmail.com with ESMTPSA id
 d6-20020adff846000000b0033725783839sm4256057wrq.110.2024.01.18.07.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 07:19:51 -0800 (PST)
Message-ID: <cb1b39b3-52e0-451e-b07b-ca8c9613a32a@linaro.org>
Date: Thu, 18 Jan 2024 16:16:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/ppc/spapr: Rename 'softmmu'
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20240118133206.158453-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240118133206.158453-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 18/1/24 14:32, Nicholas Piggin wrote:
> I grabbed Philippe's series series and tried to use a more
> agreeable name. Further disagreement is okay, but must come
> with a better alternative :) would be good to get this out of
> the way. I actually don't think softmmu is a great term for it
> either even in isolation, so would be good to move away from it.

Eh thanks for the respin Nicholas! I'm happy with the new name :)

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



