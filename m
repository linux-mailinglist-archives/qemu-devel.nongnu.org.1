Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06C70F6A3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nju-0000pd-4w; Wed, 24 May 2023 08:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1njq-0000jL-Ez
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1njn-00042P-N8
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684931826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ygpt7WyMmQX0B8E55j2BvQSQ9UuHxuqrYKMWe2q53SQ=;
 b=g3WxYcIwHu/M5GfeCQ1nljNxSGXdoM+o0ISQwEr6aP89ngRmJKgRtqKYvhN6Do56PNNbeQ
 IdvV/z6/GQbBDSuZtlwmltu4Xdspuj9aEABoT0OaysuEVXOfp3Haxlr1g8M+lTjTYTPZid
 XSCcRywxBBs1cWyUJWDDhBMGaMyVYkQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-CjB1BIH6MdeiXCyRBqRUuQ-1; Wed, 24 May 2023 08:37:04 -0400
X-MC-Unique: CjB1BIH6MdeiXCyRBqRUuQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-510d1c71b8fso980379a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684931824; x=1687523824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygpt7WyMmQX0B8E55j2BvQSQ9UuHxuqrYKMWe2q53SQ=;
 b=b6HuuVd/SaccCVtyjRGR1Zqe5eRtsp9sMTJ81DtbSX1vNjFZjFFsRfnvwYpxlcDGCz
 39Y5xIxo4Desq1JrcpUD6320ski7IdoT50EPy9ajloXSbRkINcrrPdhEcplx20+e4Atr
 1kAlQaZ/Mxw1sMCz6cfBTJhvYqi1jMKFDAthZ9i4p8EoDE5lrW7dkaBLaeysXu2OOzru
 D7qtjLj+iud8CptEYWeyLTk398dG6lX38XUDX+MgqokBU5EUxhvWqNcqSFKfXhoISjEl
 FIkdOeDqbsd7BlVOH9P78y/DJNZXpyqGIOQWkE8C25TG+M3FVlC4BPyIngtXJRuza2c2
 gnvA==
X-Gm-Message-State: AC+VfDwEnv3usMe7K/n6P/PHqQH3cj5eUT6RXM6Mj3Apc5ra1izwHxJP
 dIIwQdFDAYvIRTE5n7vZ6AFcLpn4hoW90pH7tiGETmDt01VHGbxMIlbZLPv8ZbfBdznnDmaBW6I
 ZLWUTW+vFU0FjM3Q=
X-Received: by 2002:a17:906:7305:b0:966:5c04:2c61 with SMTP id
 di5-20020a170906730500b009665c042c61mr16137842ejc.8.1684931823873; 
 Wed, 24 May 2023 05:37:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sWXwTWTrk8bgbex8eThTUT50nkjVfb9a+dVxEV13wHQnudBGXYiq6woe2+6wpC7RAFPAG6g==
X-Received: by 2002:a17:906:7305:b0:966:5c04:2c61 with SMTP id
 di5-20020a170906730500b009665c042c61mr16137829ejc.8.1684931823543; 
 Wed, 24 May 2023 05:37:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.googlemail.com with ESMTPSA id
 a10-20020a17090680ca00b0096616adc0d5sm5647436ejx.104.2023.05.24.05.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 05:37:03 -0700 (PDT)
Message-ID: <3fbe7180-034f-c60f-1479-f8a9e6473eb7@redhat.com>
Date: Wed, 24 May 2023 14:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] meson: Adjust check for __int128_t
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230523223844.719056-1-richard.henderson@linaro.org>
 <CAFEAcA89YToWdvwprxQgaMBpp4KVFqj8asXpBBcikg8zseSv0w@mail.gmail.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA89YToWdvwprxQgaMBpp4KVFqj8asXpBBcikg8zseSv0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/24/23 12:30, Peter Maydell wrote:
> On Tue, 23 May 2023 at 23:39, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Remove the signed * signed check, leaving the signed * unsigned check.
>> This link test runs foul of -fsanitize=undefined, where clang-11 has
>> an undefined reference to __muloti4 to check for signed overflow.
> 
> If you can't do a signed * signed multiply then that sounds
> to me like "int128_t doesn't work on this compiler". We
> specifically added this check to catch "some clang with
> -fsanitize=undefined don't actually correctly compile
> int128_t * int128_t" in commit 464e3671f9.

Oops, missed this reply before queuing (and will leave the patch aside 
until the discussion is over).

As long as -fsanitize=undefined is properly covered by CI and we don't 
need int128_t * int128_t multiplication, removing the test is ok IMO, 
though perhaps it should have a comment about why it's avoided.

Paolo


