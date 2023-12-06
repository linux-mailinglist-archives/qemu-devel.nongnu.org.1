Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1328807579
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:42:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuyV-0002wG-EN; Wed, 06 Dec 2023 11:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuyM-0002ke-Uo
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:42:08 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuyL-0004RW-Dl
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:42:06 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2868cf6cb82so1311a91.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701880924; x=1702485724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tjy8cCX0O1uy9ylb6i/Po/ipJa1EN1stXVznqcz8Wc4=;
 b=lZ+VzKDTnx1DUKlvj301nCwcHN7dLZX52lb8wYJgjuJWNwsknuXvqrwjBt84x7CHpA
 Lbnx26w/Gb2g3KW0Khs09OC5XlYPHlQiOzb7qDxg5A4bFguDx2ZnAD2ZKz6XlYQFT54l
 bmA8pIrCeAf+q0beLk8r9yVIvgy1aWCRoNAUjAz8hN0x6pKCbjZgWrH7CF2iJXU+OIl/
 UqYNxqsSACfpHUaQ5GJ9PUNwQ114o6QkrpfdUmnm2JJZTwxC+ARfsqJpC79f+Wm9U1Yl
 4vZn5dBzSzWvLO8EynE0lMihPRKPH1gjc6Ky1V8qVdbF2I+VVeVPjv5AtUHVNHrARNsr
 zepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880924; x=1702485724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tjy8cCX0O1uy9ylb6i/Po/ipJa1EN1stXVznqcz8Wc4=;
 b=JJu09SEkBxUGp6bK7L/Iu1ma6m4hxMnjjpha2WEcobk0JZDo8v+xnEvtGQqcOBDjx3
 9sMq4P6GGnLLhqwYiOwz0gZ0423R7FK1ka9Hj/CI9Jy1K4kciM1QD7HreFMfMUG/gNOq
 T4qHTSu31TvOj3KwCGHZugUM5psXwz+ugyaFddjwrvGInnEUxKVJOcUbOOwyg7zcQ1D7
 dFx9KVFjjFF1oSMYSRAMv2GgtsvozR49y3waVDzYAkBxf0RMNwBgGiYDIhuhpUyER0hu
 ko/7RL7teKV2hvs57jT8gdMxK5qqS83uUB1cEeWllTl6djy/drtPAvi7bttxKy3Et+jx
 PhDQ==
X-Gm-Message-State: AOJu0YxjIKkAhTmbLv2WG7aRHxsTFD044rOCJLCFoaFZLUtUcsxXo6e0
 m/nBwlrhHIFw44WAhJSf5flhbw==
X-Google-Smtp-Source: AGHT+IFoPv4Cdt0ggGqHkBLGBMemicsjxTwyZraxlKUfSTSgvFS9G0Qi2a2VRyTvPum+y1PHy3j6Cg==
X-Received: by 2002:a17:90a:c912:b0:286:49bf:b215 with SMTP id
 v18-20020a17090ac91200b0028649bfb215mr797102pjt.25.1701880924005; 
 Wed, 06 Dec 2023 08:42:04 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 qc11-20020a17090b288b00b00285e53d90cesm42586pjb.26.2023.12.06.08.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:42:03 -0800 (PST)
Message-ID: <56bcc5d9-30de-4fe4-9938-02cb559d7980@linaro.org>
Date: Wed, 6 Dec 2023 08:42:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] replay: make has_unread_data a bool
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 12/5/23 12:41, Alex Bennée wrote:
> For clarity given it only has two states.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 4 ++--
>   replay/replay-internal.c | 4 ++--
>   replay/replay-snapshot.c | 6 +++---
>   replay/replay.c          | 2 +-
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

