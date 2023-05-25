Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65E710D51
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B8T-0004oJ-0r; Thu, 25 May 2023 09:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2B8R-0004nw-BG
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2B8O-0007XG-TW
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685021763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9VeDLCkXMXEZfhZhe16e3a71puWaMCniB4JYXqHjClM=;
 b=PHJxLO6Bo+uSpOX+FRfxD8yhXNCTYjb+zYYcFU0VSRtAr2ToN7Dd7z9qInBRpbNH0Joplv
 Is5xUrWHZI98Y7SdLBfT5sl8zMAng+RtEF7DR46KfNEgJ3/7y3Iqs0Ol4Q9oQO8eCC4U1E
 +pNBUArwP42wxZtt2ITmml1rGYAquj0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-PRFSAfhqNciXKAEB4Buq0g-1; Thu, 25 May 2023 09:36:01 -0400
X-MC-Unique: PRFSAfhqNciXKAEB4Buq0g-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96fb396ee3dso65407066b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021759; x=1687613759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9VeDLCkXMXEZfhZhe16e3a71puWaMCniB4JYXqHjClM=;
 b=XjhkBusiGogD8UA7GJ5zNHCxCej2VrgECf310IAGspa5NenSZ0/bXqVoZVk/2khYtU
 RS1B6V0OaHWGwpcjnOgmQ0kibtPy+m79LRwNUKbInDzAvKRHHtMxp8TofKawVhosaXoz
 F1f5PiMjHGxf99/7ZnrOnaZjvIzF17kJ0ra3OHFvXAxlex1qncYV5qfmzGDgEaPsJVXZ
 VYh1vj+oNQIf7M9hDdZE5Utuuhjn/6/ttoB/3DaW4BXf+JQwvn2bVtWCDGYSAbZNk/Dj
 obgeG57LhHzPbYQWbppNltiFHUgKsiCQQBxrxu6qsSsighcLLZRfqAcl7MPLkwKrG88N
 TtHQ==
X-Gm-Message-State: AC+VfDwZcJCIAUKf+EJAFpI937rEjSi3X0d/QwM1GoEYuc6upUMYfvHk
 kFMsDO03ejKLfngBQY2dIbZ9dtVYx2ZLYCX5EcMSgN/22ly9kdVARAUhU2MQrRoXagOR/rmX0HZ
 NUddSYF8J+bVajHE=
X-Received: by 2002:a17:907:86a0:b0:96a:717:d452 with SMTP id
 qa32-20020a17090786a000b0096a0717d452mr2097033ejc.19.1685021759475; 
 Thu, 25 May 2023 06:35:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ75t0HnaNoeGGM4I6ZSaVAV8qTzlHJAiGkufnsh6V13Jo/CqaMgzRClwPzMeEWtWyKEp3KhIQ==
X-Received: by 2002:a17:907:86a0:b0:96a:717:d452 with SMTP id
 qa32-20020a17090786a000b0096a0717d452mr2097001ejc.19.1685021759115; 
 Thu, 25 May 2023 06:35:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 pg27-20020a170907205b00b009662d0e637esm842904ejb.155.2023.05.25.06.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:35:58 -0700 (PDT)
Message-ID: <f9a61c55-7b26-343c-6d63-9f59d3573fc9@redhat.com>
Date: Thu, 25 May 2023 15:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/decode: Emit TAP
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230524173815.1148653-1-richard.henderson@linaro.org>
 <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA9+BGdG6bShPQ+SZzJNOjMAMJ2fVYqpcvR4vOVums+dMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/25/23 12:00, Peter Maydell wrote:
> At least some of its "missing quoting" complaints are
> also legitimate, notably on $PYTHON and $DECODETREE.

$PYTHON could include command line options, so I don't think it should 
be quoted.  Though we could stop insisting on using -B; either not doing 
anything at all, or adding

export PYTHONDONTWRITEBYTECODE=1

to Makefile.

Paolo


