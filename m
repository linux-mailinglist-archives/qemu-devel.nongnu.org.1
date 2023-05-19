Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A3709AA1
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01VU-0004ZT-Q7; Fri, 19 May 2023 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01VT-0004Yr-BH
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01VR-0005VZ-Tx
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684508097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wzb0geO+0m+islgln1S5KPyD7d22nuEfTQu+NEpapas=;
 b=UhM4rngG8nRxjmtxPcLrAeBNlYFDxs+mmpU4J2WDwCU9FEgs+F5tMRpPSNxy/CQbLxf4v8
 r2DSWVmaT9kbgqokLvfnEH6o6UpXR8jy7Aq8xmN8AdFzvfxsA/i3BrDqPyd6Ilv9wqRjwc
 VA3pX8p8x/925HqceeiGZSf9awQ8Up8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-u0Se8l91M32hNtVvE1aRaw-1; Fri, 19 May 2023 10:54:55 -0400
X-MC-Unique: u0Se8l91M32hNtVvE1aRaw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50d89279d95so1254189a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684508094; x=1687100094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wzb0geO+0m+islgln1S5KPyD7d22nuEfTQu+NEpapas=;
 b=hOObLsM9LqJpEMBLeJ7WOW5X6CimiDCy1bQ8+wBM0xeiNokvb5hibfTHjsUWKXOAc9
 jYFZOMAKiEP8x3Mf2odIijc6t/Ew2+05ahCzbivPpZ8u/5QotqLlVBcNEmWr8whqMYlI
 xMEdRiXYnVMexlTtD4/N5e58jvh3kmoMRLTlwoKd+stH5EH+PPLaOA1ha4JQ5/KSeNxA
 /LoxliYNAU2J/r1+mNPhqJrnEqcJ0YKJgWRcudQKswtqSEZLwCdBsu0ohle1ayNkTREc
 HDozGnFPMFnmmgh1fgeyhYkIFcHe7wBarb8WTvuK7pPe3HlImNQM+nd4r7SX9FTb5HyX
 Ivog==
X-Gm-Message-State: AC+VfDyJY8LKV7/pXp9sLjEnOReK0PRGEUd0cjbHhMJaelxVOZyhONyr
 rYBtBYJNoh3xsGp3qVeVsi9KOLvUF+Cd9gPd3FiG4wWynJ+UYP3ptpyX04TZn2tSQqBlrSUrF5C
 flSfL7AY1oAifVoE=
X-Received: by 2002:a17:907:6d26:b0:966:5fac:2e52 with SMTP id
 sa38-20020a1709076d2600b009665fac2e52mr2245979ejc.9.1684508094815; 
 Fri, 19 May 2023 07:54:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RU8ojAkGgs87dCBsL6mfGvYqkXweKQH0XmXPaSWIboTTbRBFeXR5bSjcW7h9WFKSr62mGdA==
X-Received: by 2002:a17:907:6d26:b0:966:5fac:2e52 with SMTP id
 sa38-20020a1709076d2600b009665fac2e52mr2245961ejc.9.1684508094454; 
 Fri, 19 May 2023 07:54:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 r21-20020a170906281500b0096ace550467sm2398193ejc.176.2023.05.19.07.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:54:53 -0700 (PDT)
Message-ID: <dc9aca94-08be-20d4-9777-ba777ca5fa1b@redhat.com>
Date: Fri, 19 May 2023 16:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 08/19] cutils: Allow NULL endptr in parse_uint()
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-9-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-9-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
> All the qemu_strto*() functions permit a NULL endptr, just like their
> libc counterparts, leaving parse_uint() as the oddball that caused
> SEGFAULT on NULL and required the user to call parse_uint_full()
> instead.  Relax things for consistency, even though the testsuite is
> the only impacted caller.  Add one more unit test to ensure even
> parse_uint_full(NULL, 0, &value) works.  This also fixes our code to
> uniformly favor EINVAL over ERANGE when both apply.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/unit/test-cutils.c | 18 ++++++++++++++++--
>   util/cutils.c            | 34 ++++++++++++----------------------
>   2 files changed, 28 insertions(+), 24 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


