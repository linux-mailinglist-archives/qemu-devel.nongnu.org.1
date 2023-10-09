Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7557BDA71
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoqi-0007sz-DM; Mon, 09 Oct 2023 07:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpoqf-0007sl-UR
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:54:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpoqe-00051T-Ae
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:54:57 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso779671766b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696852493; x=1697457293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+JMv02NfetdExOBZ28bzgpWm0YsoWYoOUAnbmb6sjN0=;
 b=jKs9yD8/L2uDebw7aq5zri4JUS6jBBojVGIDBrKA2ESCceX6p+/BE3LLZh14zJpjLR
 f0JtcjSiIhH3qOjm59LW5wt/wrYjLROmC20DbQNIB5M4u6NxJFc84GluK4nZAhGIHyjH
 hRN3V5S4ec0I9KNnX7kEL1vmCwSYtAR6p/E/5nmxKmRL4BZG3FTKkY9nSRByzIdN9dIf
 9VQ3GNOzp6AwezC1Wn0H5vC9jsyTrFnh2cziojvpSsQXtbXukhrCLapgc6RppJ3LsTKX
 YrRYLz9pFC1KMeLwwhDqp9z7Iv51mh1Qy0bIKy+5zonfZe/ttnCuABEydDB0BQCofdgQ
 4TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696852493; x=1697457293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+JMv02NfetdExOBZ28bzgpWm0YsoWYoOUAnbmb6sjN0=;
 b=C3NysoW9VJZy0iy+q04keKaYI8JDxwHRnhn+OwDxQhHKeg+rzI0wX/rddRdw/hrtn5
 595wNQMIRIfj4f5CXwc4LjKYRPzNKrNTejE9GECH9Y8GH3FI9wXJ0vW2t51mPZDcJEBc
 jcOXbLx/SK3JmBW4ugHJVUYqHRx1qsd7I1cxXiDpKB/JOiNFEOZP0O6glOSKYdT6Z8Va
 5vH/aTBhxgXSViyjM9s/FdnXWcdTpGZHXYTuOJ2XV3wDmNHRDIludnQxemOsdkg3wi74
 4EUw3AYIrdxKBQHEWV+EuQEm1tbKSlKysYflM6MJTC4oF5znfW99STSjlUo1aZEKwC4J
 jSGQ==
X-Gm-Message-State: AOJu0Yze1dA8JM8EurossImGT4/eeWD7Is1jOIkgjm2YTWXvAFgHRvLD
 X9gj8+IO2ze03HTy1nTHAbAzGlwSyNXvu5f1fJE=
X-Google-Smtp-Source: AGHT+IGLCTyboqYhBhHnI46dznkw1yzFhd9LJrTFIANdlAmmgBo9gS62zATRXxykNPgXVrdnB/gpHg==
X-Received: by 2002:a17:907:2715:b0:9b2:babd:cd44 with SMTP id
 w21-20020a170907271500b009b2babdcd44mr13094038ejk.44.1696852492941; 
 Mon, 09 Oct 2023 04:54:52 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a1709061d0200b009a0955a7ad0sm6573794ejh.128.2023.10.09.04.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 04:54:52 -0700 (PDT)
Message-ID: <9cd1675b-22a4-ee2a-fde0-bb87c7c5bd26@linaro.org>
Date: Mon, 9 Oct 2023 13:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] system/vl: Use global &bdo_queue in configure_blockdev()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231009093152.51270-1-philmd@linaro.org>
 <87sf6k2isd.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87sf6k2isd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 9/10/23 12:26, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Commit d11bf9bf0f ("vl: Factor configure_blockdev() out of main()")
>> passed &bdo_queue as argument, but this isn't really necessary since
>> there is only one call, so we still use the global variable.
>>
>> Dropping the &bdo_queue argument allows to silence this global shadow
>> warning:
>>
>>    softmmu/vl.c:678:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>>    static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
>>                                                         ^
>>    softmmu/vl.c:172:29: note: previous declaration is here
>>    static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
> 
> Not sure this is an improvement.  Up to Paolo, I guess.

Any alternative suggestion? I'm looking at enabling -Wshadow with Clang
to avoid Clang users not getting the -Wshadow=local warnings until a
maintainer test their patches on CI.

