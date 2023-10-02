Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5257B4B86
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCVW-00067d-Pa; Mon, 02 Oct 2023 02:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCVS-00066J-Uj
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:34:14 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnCVQ-0000Hr-H0
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:34:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-307d20548adso14622489f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696228451; x=1696833251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sdN2GiYiWq3oZ8d5Z/OMYSPn2YhDjDNB5o3UMwzA2ys=;
 b=oMS4y469TrarDGpicL4v4CJuBuEeXAtR9ABujG5yxKTwYpPQXy1Q2fpeU3DgsWBI9X
 0wi/cE2nxaSb46quwaycySXujo+eGfDBHbAsKJdbtqzw1rK8iG2sMeCss6wxzr0J1eLW
 dnM3pj+w+EaI46Dygla6A+1iz4XMJNQE2n3TKLGJZxvJgp50r+uqFMzmGezzramq7M5e
 WlggS+zANP5pTZQ08Fq7J/YdPosChRp/6s8QXkTw57RyxgHXVL+u7/hSws/gL3DEmfUH
 +9viTcqxdW1Aw1Sipgr0W1dbuK4ROsCOaiAu/98c9lfUZ9MwbeDAnpsVtW75kxcXpKlj
 UBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696228451; x=1696833251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sdN2GiYiWq3oZ8d5Z/OMYSPn2YhDjDNB5o3UMwzA2ys=;
 b=hu7Xs0YYL4Xh4KYLRwhV3p3MFjCuwz04rYLXPih5A3dZQ/w9QFb10sSlpmFa793clu
 0z0h47f3tHkpxex6SB8BGtm45WyNb3NrKqKcjBV2PEhjZpXUl7KSPcNuiA2sgxhynbv/
 r/tBPqlw7U3rN4lleCsDGvbK2O/Ql3VmgBVsr3n9avkkUjE9K7pQbt0k2ukQJTLoKEpK
 pnJbmHJ4dPGjBjVuSnnjIjXFpnqUqaMW9D92Sv5vidEG6tFmV9yz5STexNAdKuHw+vqn
 rWlFs7g4wctMPj6sDgSqeqcF2dMWQ5vSSoGukdYZw8ZmBlhe2YW/B3y80m6qV5qjyJCn
 s6nw==
X-Gm-Message-State: AOJu0YxAL/Zvc7rsr0Eb5H94vTbHhp4pmbDysFdgGbg+lee3zphpocfA
 ua/rU3zPkA1lEMlFVtjRoP2KEg==
X-Google-Smtp-Source: AGHT+IFD0ojFRksBMQrRlfl3CKPdZg8/Kpyt3vQxWKzL4um/6nF73yB9CbBYvDy7O8lWAFHlseGQNA==
X-Received: by 2002:adf:f98f:0:b0:320:bae:2dfd with SMTP id
 f15-20020adff98f000000b003200bae2dfdmr8914700wrr.5.1696228451227; 
 Sun, 01 Oct 2023 23:34:11 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 z15-20020a5d4d0f000000b00324ae863ac1sm8487272wrt.35.2023.10.01.23.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:34:10 -0700 (PDT)
Message-ID: <5a4215fc-efac-2145-5868-ddc7eeac1e0c@linaro.org>
Date: Mon, 2 Oct 2023 08:34:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user/hppa: Fix struct target_sigcontext layout
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230930212742.586468-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230930212742.586468-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30/9/23 23:27, Richard Henderson wrote:
> Use abi_ullong not uint64_t so that the alignment of the field
> and therefore the layout of the struct is correct.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/hppa/signal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


