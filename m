Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BA8074FC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:30:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAumr-0002dK-K5; Wed, 06 Dec 2023 11:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAumn-0002d9-K6
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:30:09 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAuml-0001wg-Sz
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:30:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ce28faa92dso31857385ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701880199; x=1702484999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UFz1JkNXPZ+tIthJCg/p38aHK9p+N1Zabi9DfvjqDs=;
 b=alZ//NoshUBGxsQXhhtPDR0cWjpspYgpsU9IScgo8Dk6aISGla7N82HPlYw0p3tg0K
 e/KCwa3Qu2DZ6/QzS/hPfzsjkRYMDH6aj7BSIl7HQegIE5rErAqP8sS1Ic51XtVLk/eg
 7+Pj4mutnELq3zVgdi8XQc0vS4fWTLEK7dTLkMgwcyebxhgn5ZrIbTFjwPfF9lpXCcbH
 bB6Jz94AbVCGYgqmLkNMcGwwmsxjnEL1R8YzE8olGqp72VYk2dg+kDJ81rfq85ZBbz0X
 9nrigdrUfqy/ARX82n5MhVEO6goAMJmVP4Cx7MR+EuoQ5hVS6dZYtU7Brs3u8pfBgusQ
 2+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880199; x=1702484999;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6UFz1JkNXPZ+tIthJCg/p38aHK9p+N1Zabi9DfvjqDs=;
 b=DoCMmUNH4o9yxyBrC2vs1OaAG97kwnoowKA8ahxeso0twU6wZ3l5jwLuCE1Mc/CMCK
 pvHq/8QLcF12VtLa2KK01CAZx5PQLeWS8VkaByZQ00qUAib/j9m2yVuy7piANIY5tBfJ
 ZRiqHyytkRczUUxOwjk9NJ0ybTvl6wJ1VuVjz7BPXA89PP00XZJOp6VUSaUimY7Vlu8j
 rufRwBb/frBfnG6vsFlAWzaGZe9+fX8Pg0dF4jzQ4wGxDbCt6Ptk6YrzpvqgIzBhCFuf
 D5sVxVy/Cs31czprTMe0ju5seiOs8/HWoVyXky/481h9XdDX6Fk4h0B4+HtIGQcZFoMp
 fymQ==
X-Gm-Message-State: AOJu0YzF05HpXlWCOx1T7xaTPL+Xyt7SoBdG1OE112CgQRABm4g5y/z5
 FKLUCq4Q2AR9/goSbdAEcm1FBA==
X-Google-Smtp-Source: AGHT+IEzvJ2EcUGH334TlYcHjX7OeBoZ8rawJHiJP0EvlocqthPYhYVkcKON4+IvDNdDnCpWHSsgdg==
X-Received: by 2002:a17:903:94d:b0:1d1:e0b6:1aac with SMTP id
 ma13-20020a170903094d00b001d1e0b61aacmr10858plb.19.1701880199118; 
 Wed, 06 Dec 2023 08:29:59 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 iw1-20020a170903044100b001d1cd7e4acfsm23188plb.201.2023.12.06.08.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:29:58 -0800 (PST)
Message-ID: <5af59a41-57ae-4fc7-b46a-1dcb8b194a6b@linaro.org>
Date: Wed, 6 Dec 2023 08:29:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] scripts/replay-dump: update to latest format
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
 <20231205204106.95531-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> @@ -268,6 +279,49 @@ def decode_clock(eid, name, dumpfile):
>                     Decoder(28, "EVENT_CP_RESET", decode_checkpoint),
>   ]
>   
> +# Shutdown cause added
> +v12_event_table = [Decoder(0, "EVENT_INSTRUCTION", decode_instruction),

This comment applied to the v7 changes.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

