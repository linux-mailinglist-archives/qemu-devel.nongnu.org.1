Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303857DBFA8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 19:20:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWqn-00044Z-6z; Mon, 30 Oct 2023 14:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxWqk-00044A-QU
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:18:54 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxWqY-00084g-46
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 14:18:54 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc5916d578so6772015ad.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698689920; x=1699294720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3STRVTSVCOhgbkwxhLG3kFaxkLA5LyYTVzlAT2QFOso=;
 b=AvhTjh/lEvWCwIbd4oLvz5rvyecYPO9cvel4o5K6+6im/IqcgxSKYi07zBDrcA1Yqd
 cl/AyOyBY1PCdBBMhtEgSz1Pt6S9V//BUhQyfXOPr6q+elPQnvTS7lM6yGsC/uVjGV87
 vci5y36jzWCPYX+HJ91cmcLl5qOqEp/P9oGtCVYvMV8tjMHuq3KoKLOFoFqeLWjld1W4
 +ZurANeWLzzfQo+gUshYeRO07DVHky+pBqXBRBpmBSWGeoaZCNCHJSpuy06ymNkIIe+8
 mOAUi+HUdAZNIh/HNzrIC0LW9UbtbKnNiuPZVAc99mCh3lcQOA0ZDJH7GMPhfR81rS0T
 l0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698689920; x=1699294720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3STRVTSVCOhgbkwxhLG3kFaxkLA5LyYTVzlAT2QFOso=;
 b=wtIj96jL+Yxt0LZ/LigxREi8+1NUPJN6dWBRGTmlkBP9Ux4pt7LyqGuyWxMI/NYAco
 db8BN0nO8ZVzOiMi8nvjgLWimVUHGNVHKxp8KSCKrw2kqgDGcGKKuCA1mznomRkptkg3
 isE78REJYV5F97kv0n/m3rWhIkEoj3J58Y/J5sqRSHh2wprfuJMmTaSL5E08D2Rf5cVS
 F6+zQzUosTD4REzLja11TID5tmOe2j51KLBwzTJSwgrAp8EvTMF21gF+F1iwGXjfhAov
 EM9VoPTWRKu0z1UZtp3FYGfuoS4816HbKx05QKs0r1WIvH99dTwHJwznh855aY8uy4Da
 SL0g==
X-Gm-Message-State: AOJu0YxUyyDnBieosdqsy/8UOwgODqsqIX6nBlFaP38GqgMh2fPbYOD4
 z8mTsf2xtNu65m8GkOMvksV5BZyWwNXao4nSfGo=
X-Google-Smtp-Source: AGHT+IFUO8xX8szD9PtFpQn3VRg0/TE5ErmvTTAgDfbKUWW3Wkt3gTo+OEo4a4CsfzyWS5+3iP3gsQ==
X-Received: by 2002:a17:902:d48a:b0:1cc:5168:688 with SMTP id
 c10-20020a170902d48a00b001cc51680688mr3374453plg.60.1698689919789; 
 Mon, 30 Oct 2023 11:18:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170902d30100b001c73f3a9b7fsm6539695plc.185.2023.10.30.11.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 11:18:39 -0700 (PDT)
Message-ID: <1f06e3b0-1531-4f9c-9a66-1811bbba37fa@linaro.org>
Date: Mon, 30 Oct 2023 11:18:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Getting qemu plugins working on windows
Content-Language: en-US
To: Greg Manning <gmanning@rapitasystems.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "luoyonggang@gmail.com" <luoyonggang@gmail.com>
References: <CWXP123MB43418A508D8E101ABC58A523D7A1A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CWXP123MB43418A508D8E101ABC58A523D7A1A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 10/30/23 09:48, Greg Manning wrote:
> Hello,
> 
> Currently, qemu plugin support only works in Linux and I would like to get qemu plugins working on
> Windows. I have had some success experimenting with this locally (based on some previous work by
> Yonggang Luo, see below), but would like to gauge opinion before I commit to suggesting a solution.
> 
> The overall structure of how plugins work is this:
> 
> 1. qemu executable loads plugin.so.
> 2. plugin.so defines a function qemu_plugin_install, which qemu looks up, and calls.
> during that function call plugin.so might call some of the qemu_plugin_* functions that the host
> executable has implementations of. plugin.so is compiled with unresolved references to these functions,
> and they get linked up at dll load time.
> 
> Windows doesn't let you do such on-the-fly load time linking. You need a dll import library, which is
> specific to a particular host executable. The qemu project, however, has many executables, any
> of which might want to load a given plugin.
> 
> Possible ways to get things working on Windows:
> 
> 1. Make the dll import library. Possibly refactor the qemu plugin code into a single qemu_plugin.{so,dll},
>     and then make the import library for that. I don't fully understand this system, and I'm still concerned
>     it would be fragile (if qemu is recompiled, do I need to recompile all my plugins against the new
>     version of the import library?)

As we work toward a single qemu executable, I expect that we will need to build most of 
qemu as a dll, and then you'd have exactly the image against which plugins could be linked.

This is probably still a couple of releases away from daylight, but I wouldn't want too 
much work to be done on an alternate method for Windows in the meantime.


r~

