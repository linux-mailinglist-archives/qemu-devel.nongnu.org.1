Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA60983012B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:19:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ190-00047Z-QI; Wed, 17 Jan 2024 03:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ18o-00043c-PX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:19:19 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ18n-0005YM-63
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:19:18 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3377d45c178so5397096f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479555; x=1706084355; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FhnYN1wxc6Rpz4/bWZvLJCpIwLXZNAZ+5wWPk+mani0=;
 b=SyragHf2t9gLlr9UEARsogfBYaHiiNk9O1eO0VzVIAETxhEmCROHq5U3kNBY0iK3aL
 2Rs83RB8KNkxzr5vxXiZYo87mpD+ZZNkdqzHUK3Pe2emBCFIrwcl2PQN4uPfCUXTdCPu
 H+o17o4Uy0EQuUp5l5f+60p72eA20Z6LdX1J2T5+/2AMT4LPS0wwap9wnyBjC6UKf7Za
 qzEisVW0kZkRXGcM2M8mqvMCc9yXuBvJ2SflxnTCAaElamE4Byi3tE6oqQ86OY5tOpXg
 E3KJ3TTIMdgv4Q7nIS+LIkRqOTqs3QsO7yHx2zU/0az+TfPtMID5tie2izDOGnYrDUIW
 Pm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479555; x=1706084355;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FhnYN1wxc6Rpz4/bWZvLJCpIwLXZNAZ+5wWPk+mani0=;
 b=U+/LCSzTLpj4uBmWAzz04k30Hw8uRqR3nnjcBfqOCN5DjUSRKzOJdpV32j5HCDBxnu
 QAuGzBU3ijIIxlVvOn2/9sybGBrNbM1xMrOVRHowSOHb02O+psvpSSaV1LPmJHatwlkd
 /JQgLsJ7gweXkLnCSe4nPddnmkKqRzDwMEO8Ek5tP71KABw2a9YtEme8cRPyTsg4k2xW
 N7XRMjHVzkO2hFhoNs74O5fdacTD/2EVV/6FEsiU4uTG5oYCuqLWhuN/JR+KkEMYQsbf
 9YuBeUAIcF4jin/tmgKlSHkJJ5Nsr7YpJQ3o0t993t21k84n4anqUTGJodl2Fy1C2yrj
 RsaQ==
X-Gm-Message-State: AOJu0YzfshM7psA+R4q0vSHecIPDO+DY2mQzHteCX5AHjCsV7l1O2ZKQ
 ab54XTAw+2yPmv4nmZl0RcYsLYIaohXh/A==
X-Google-Smtp-Source: AGHT+IFpymsL3TkKbFhYTFN2D2PKbl+FYw1r4zrFR8Svas2JQhGqWz/0b9vvsRMkaeH0oHl8zSdUjA==
X-Received: by 2002:a5d:6a8c:0:b0:337:beed:42ba with SMTP id
 s12-20020a5d6a8c000000b00337beed42bamr919795wru.65.1705479555697; 
 Wed, 17 Jan 2024 00:19:15 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:19:15 -0800 (PST)
Message-ID: <e23fc314-b2f4-4d98-a007-7576c8211b81@linaro.org>
Date: Wed, 17 Jan 2024 09:19:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Raphael Norwitz email
Content-Language: en-US
To: Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-devel@nongnu.org,
 mst@redhat.com
Cc: raphael.s.norwitz@gmail.com
References: <20240111192846.111699-1-raphael.norwitz@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240111192846.111699-1-raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 11/1/24 20:28, Raphael Norwitz wrote:
> I will be leaving Nutanix so updating my email in MAINTAINERS to my
> personal email for now.
> 
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.



