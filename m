Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6413C8074DC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAufE-0000LR-1z; Wed, 06 Dec 2023 11:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAufB-0000KT-Eg
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:22:17 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuf8-0000jr-PG
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:22:17 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c65ca2e1eeso2155522a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701879732; x=1702484532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgzTRrVIHXkKpSnjqb6dN4Dl4sfC8Fe7D70BwMzoGWY=;
 b=MGIQ2XI9s44e42sMOhWlILXXdliCBh8XTfqRC+3bSjjG5PeuA0EYuMQOYE703yRIp+
 8Af/zpbvcWFJexHCPwoMboJ0MofTDd9rJ8dvKMtNtoa9o+C+rH04lAvOaT2tzWIPG0Ne
 p2tTzyKEZbcxiWlK8lVA7F/1ckp3WLbTu2DC9HDxO3W5LZ+hfE1THwS5gOtvFO4MyvjV
 pVLhNxiRGTBy+EtWuexLOd5utdubw9oecEn/atQVb2W4oZq7yx5MEEnjnZ2TeIlVmT3A
 WzC6Oh2tyJlLnIcRwA9aTz7PvdpQGpcFigEy3alQJ64t64iEnK7UPlHktwdyzfKhHKUD
 5FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701879732; x=1702484532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgzTRrVIHXkKpSnjqb6dN4Dl4sfC8Fe7D70BwMzoGWY=;
 b=oUvt9WSEmzMWrCyHyD5YMs0YZrlJBC2ItdKfPyCo//E6jFqCHhU4Jz1G/B4lE4a/G1
 k7XwFBS34WrhEBh6GBQj/OMSnIchXQBVIElenS5qBPGX1ilWAVYSCMyjTBb1xojrMl4N
 GmFdTJ4ZvFnchBuaNiuXl834sqhiW3y/Vph8TDrVmhaKWH0CZE3HFaysfL9zQkuPWOJ8
 +P8s3ZIFmpS6tTJUdHt7xooU8P0OFfhGgudjZb95pm86kZKieKyXBmO3pHaNBK4JLASK
 n8eKlDddmlKvlf5ygSlrPSMzQOd7FIHD+1uaTP8ZTC7iYi1DxpdeglCdRpFMj3tzN+Z4
 5lqQ==
X-Gm-Message-State: AOJu0YzQK5EF+eZKQNpibu4LsuC9ZNqG2Y2mhlpgeOMGb2g5zdiiiltV
 m14dhrC/2HZb5dNDukF0WHF46Q==
X-Google-Smtp-Source: AGHT+IF3IW65sp/H65z5b+xF80CXbsu3jyN4vp87KTZzQH0nWfsYwotZWRU/ho94rTTjMH8oXuuM4Q==
X-Received: by 2002:a05:6a20:9145:b0:18f:97c:5b79 with SMTP id
 x5-20020a056a20914500b0018f097c5b79mr867682pzc.71.1701879732459; 
 Wed, 06 Dec 2023 08:22:12 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h24-20020aa786d8000000b006ce350d946csm183692pfo.41.2023.12.06.08.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:22:12 -0800 (PST)
Message-ID: <9b8ad153-8101-4616-95f5-c11bf1726449@linaro.org>
Date: Wed, 6 Dec 2023 08:22:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] tests/avocado: fix typo in replay_linux
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
 <20231205204106.95531-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 12/5/23 12:40, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/replay_linux.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

