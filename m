Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549D70F6B1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nnq-000370-8A; Wed, 24 May 2023 08:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1nno-00036o-Kg
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1nnn-0005K5-7t
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684932074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JeWX/fSWMbqa6/IJ2q7pCPqbSm2lemaWKKvgsSSqBcM=;
 b=EGWiEUMIaFcJaz2grDjAgZ2uU7BPHu6qMBfUHBT+VMkFH6Nplr1xi/zSoDkD+CF4sRU2fI
 A2hfRXuCvSOwyBgQnkXoVQO4lQ2HZ6cX8Tl2gbCxpF18JhctxUhi3Wb5lx+IkSw0yJeieJ
 v4NbBRRl5JV35LdKXS+2he5imEkUrQA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-9hMobXsaPCCj1_OT7ktHYQ-1; Wed, 24 May 2023 08:41:12 -0400
X-MC-Unique: 9hMobXsaPCCj1_OT7ktHYQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96f9996fb3dso77340266b.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684932071; x=1687524071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JeWX/fSWMbqa6/IJ2q7pCPqbSm2lemaWKKvgsSSqBcM=;
 b=HrkmEcSrBFZmEGN/J9iPh1yVAjy8xwMdKoXPobfq+GqQ4y8i95AaBtLrYLW71ucV5O
 JHbqDeW3OMkhN9VhAg/YLgN0nR+dWmDZl7qiFWiEvfBpZA5MP0JM7kiTS8bHQcB8HzpJ
 JPfbwQsSt/SFB7yFnS1zQFD33uZnPwvWSKHR/L9noXF7wsMkX2r1cVTgaGiB/i5D8LuD
 RyBIvmoHjDjPpcfdN6QAgK6pNjtTlYGMYFHwKDgVv6nPgIi4Ys+2cEj8eUZycSf/A7/S
 V1LhB/IZnguf4eTaRcxb2pim/0K4D/6UHrZ/QBFGPe8/qGAUcGXvxnvMy+DOoDC5cwfQ
 H8MA==
X-Gm-Message-State: AC+VfDy5aQk5AarZubq+rtEveZWN3Dv7hFX40Xmeiy3POfnVnTd8LMBP
 CswG9BK/Ufm6py0FoXFBSR4l/ntmMi4ozjVlN0nCCGT7yBtUhGaOsEFEjd/ux78TwQZW2oInRUl
 yRsPKePbWlpqm3ww=
X-Received: by 2002:a17:907:1ca7:b0:971:2eaf:556 with SMTP id
 nb39-20020a1709071ca700b009712eaf0556mr5988048ejc.18.1684932070996; 
 Wed, 24 May 2023 05:41:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DwTgFBc0pIrxXS+erm78UI2nWZRRJY1zg1ylRlgCB7QgPI0OD1fg4Q2r86iHe1eCVYEg9sg==
X-Received: by 2002:a17:907:1ca7:b0:971:2eaf:556 with SMTP id
 nb39-20020a1709071ca700b009712eaf0556mr5988026ejc.18.1684932070673; 
 Wed, 24 May 2023 05:41:10 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a?
 ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.googlemail.com with ESMTPSA id
 y25-20020a170906471900b00965ddf2e221sm5760463ejq.93.2023.05.24.05.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 05:41:10 -0700 (PDT)
Message-ID: <20e00cf1-ab81-f2c6-c61b-530032e099b0@redhat.com>
Date: Wed, 24 May 2023 14:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] meson: Adjust check for __int128_t
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523223844.719056-1-richard.henderson@linaro.org>
 <20230524123156.105360-1-pbonzini@redhat.com>
 <CAFEAcA9PGPerZ5RT32gatCZGBOra+B6uupA8d=adR0ht59-qeg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA9PGPerZ5RT32gatCZGBOra+B6uupA8d=adR0ht59-qeg@mail.gmail.com>
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

On 5/24/23 14:33, Peter Maydell wrote:
> On Wed, 24 May 2023 at 13:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Queued, thanks.
> 
> Can you unqueue it, please? This is reverting a fix we
> deliberately put in in commit 464e3671f9d5c.

Yes, I have done so.

Paolo


