Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1607054E8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyyNN-0003t1-2F; Tue, 16 May 2023 13:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyNL-0003st-0a
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:22:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyyNI-0006Iw-P8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:22:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4be0b1f3so2558815ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684257731; x=1686849731;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+TIkiDFm/tl5cfLOiS0wIOhRd4wEt+s06ArEdxTwRv8=;
 b=Ckpnkcf1yhDpMcnBM6QOAkQ1VuZN8jzIL7b8tvn8r4X/pA2nqJ+JfanVBCgirqaHTt
 Wgv+jmUPm0UC25uaZ82VrxQKWlCaKYlg9Dzt4TR/lNGCoyPePAqmvNEap+GcM5fBjJR7
 Gj459nsp76PHHJsBfZMjmcVdfz6S/zASf4/HkT6VnqiYMVZPBo13AZy1/hS61FuOQhW+
 ASwR9jJESXxr7XDK1DFmty+30wXyPFkms4B6/uXIWmT4h6kfEXJcaiTulO+jSVrkboDs
 pIjk1RkQTWcM379uxSZgNrouMJ2gN228cQAdm5t2lRBliZwyjF/cXA5vTIzuGZYj+3Cx
 /+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684257731; x=1686849731;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+TIkiDFm/tl5cfLOiS0wIOhRd4wEt+s06ArEdxTwRv8=;
 b=jv6r9l7P31gUEjWEel+T86swsRAr/kedDJOS0hPa/dMUCNxzWmLU2txo4hZxU/qzr4
 dUE7XSvYLNH6eG+7tIUQ0ilUZx52p7331Hv5IkeaYt1XcO0o0IDnk9COY13KoZ5ddIYf
 I8a5TgAvHDvzmCoZNqutkgqXCooR/cKgxRaMCeM36XBle74gBIlSRCNJT17SbulcPxwx
 AmnYwghEGuiRTApiKtJQ0nFalhimaP10syMj+kHYK1rhoaRN8aI1509C2KB9CX0VgY/k
 tyWvIVQEbldZQ6ayyLeixJWZxhKQmZvLS0UCNUopH+GnEEwGxWyoMLexvNh1Sl/6OExL
 RmQw==
X-Gm-Message-State: AC+VfDzKrR+I+1TzYHT3X39pUjHk38KYdS3BG2PAr3+quuNww4USSiaP
 Es3qhyIMAldH9qePLK6t9SBW9g==
X-Google-Smtp-Source: ACHHUZ5ilzNa/JN+NR3BFJ1pHkk4DQTAKROpSJH1l64lLFXHEb4yszkSOiu8x/dxj8pzZT4cY7SmSg==
X-Received: by 2002:a17:902:e545:b0:1ac:a661:a4c9 with SMTP id
 n5-20020a170902e54500b001aca661a4c9mr33838049plf.33.1684257731348; 
 Tue, 16 May 2023 10:22:11 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170902c3c500b001a6ff7bd4d9sm15827715plj.15.2023.05.16.10.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 10:22:10 -0700 (PDT)
Message-ID: <8be29abe-4779-87ef-6392-435f5a90c135@linaro.org>
Date: Tue, 16 May 2023 10:22:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/4] 9p queue 2023-05-16
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>,
 Peter Foley <pefoley@google.com>, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
 <03994a55-ead7-4a17-f5d4-78ff6f5bf101@linaro.org>
In-Reply-To: <03994a55-ead7-4a17-f5d4-78ff6f5bf101@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 10:17, Richard Henderson wrote:
> On 5/16/23 08:21, Christian Schoenebeck wrote:
>> The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:
>>
>>    Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging 
>> (2023-05-15 13:54:33 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/cschoenebeck/qemu.git tags/pull-9p-20230516
>>
>> for you to fetch changes up to 3887702e5f8995638c98f9d9326b4913fb107be7:
>>
>>    configure: make clear that VirtFS is 9p (2023-05-16 16:21:54 +0200)
>>
>> ----------------------------------------------------------------
>> 9pfs: fixes
>>
>> * Fixes for Xen, configure and a theoretical leak.
> 
> The public key I have for you is expired.
> Have you pushed a refresh of it somewhere?

Nevermind, I've found it.


r~


