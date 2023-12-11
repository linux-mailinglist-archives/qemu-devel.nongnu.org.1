Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C4480D42A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:39:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkFh-0005zN-Hb; Mon, 11 Dec 2023 12:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkFf-0005wj-Hk
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:39:31 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkFd-0006Zh-TO
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:39:31 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so29086495ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316368; x=1702921168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qJ7ZTtDNiOR9DVeQXCp9Z0oEgj+GQ40XqWpQkO0j0I=;
 b=Ncc465srvS1s2JvjEbQ/lbsvDEIp4neovxR3DEQzC3N0SNPIHRiLDtAuwHAvXO619K
 93e0n+H+kdl2APdhZ1Qbp5xW7irTUBxVbQfehjZ9O0UIgtTBrmvgm4f/oanDhM2kW8QM
 Dq1czo2kt5uRbH1UuGbAdjkz59da9s+Wq+OwypZBLZDZmG26t3ypbW5xm2mLdMXjA2FA
 Bo7twUMWUAwJYx6LXXCOQAO7qrnErBHx+fGFg33/qzG18YRMceEaMwnGSbWD4CUknA3/
 0Ki4TWNkeOi9tvRDEldL2KxZ2lPY+rjYqamUw/wE1Pkr00KZCaaO83cIeCvJv5AwQ9xN
 onGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316368; x=1702921168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qJ7ZTtDNiOR9DVeQXCp9Z0oEgj+GQ40XqWpQkO0j0I=;
 b=eAwD+tELLjACPT9QoaDQdKfw9oksPxFKw3MlpA5dRWGsUNHKRqyaLQE0Y5CBa4DAc/
 XFP8aj71htSqd6W9XdJplwtQ9ZotEDa604LHMEPtn0ywlJM5eHUU26iiMbhRDw31uxC9
 wJiT50thSUlGmDWeEc7zWEWxvI+7Ovtr5nwncvYAhLXdZI2LTvS6XBQAItXiQT1IjO/X
 7KI8c1nbDUDR3JgSBJ7B6Ry2sYnexd9i8W2jWyCZb7jR8aXOI0pM4itoPq5oD9MTDWS/
 2aCf+/dQEqk7UPz5n7Ps0Djch05TGapK7+n1RXWe1fEBNFoDwUn90fY9J+O8zeQDmrBO
 4h2g==
X-Gm-Message-State: AOJu0Yym8qo8ofWT6LvkS5MomIaRKGCCjy9WXSNDG07Jnfsw7jbbp16z
 77adtvaIaZCcoN8YkSB11ryNiQ==
X-Google-Smtp-Source: AGHT+IGSU1KxP+RavC0aJsDVtdGBYo/+ptq/skUo5HR+xFj/FZRFd9vBN8MuGlZendYe2K7+GKv6JA==
X-Received: by 2002:a17:902:f693:b0:1d0:bcb9:6dd5 with SMTP id
 l19-20020a170902f69300b001d0bcb96dd5mr2502426plg.133.1702316368438; 
 Mon, 11 Dec 2023 09:39:28 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001d1d6f6b67dsm6926698plh.147.2023.12.11.09.39.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:39:28 -0800 (PST)
Message-ID: <d8300e11-7cdc-4275-bb3a-0c16f33f067a@linaro.org>
Date: Mon, 11 Dec 2023 09:39:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] chardev: force write all when recording replay
 logs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211091346.14616-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 12/11/23 01:13, Alex Bennée wrote:
> This is mostly a problem within avocado as serial generally isn't busy
> enough to overfill pipes. However the consequences of recording a
> failed write will haunt us on replay when the log will be out of sync
> to the playback.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/2010
> Message-Id:<20231205204106.95531-11-alex.bennee@linaro.org>
> Acked-by: Pavel Dovgalyuk<Pavel.Dovgalyuk@ispras.ru>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> 
> ---
> v2
>    - add explicit if REPLAY_MODE_RECORD leg with comment.
> ---
>   chardev/char.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

