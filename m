Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400D709A48
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:45:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01LW-0005LJ-8X; Fri, 19 May 2023 10:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01LU-0005Kl-8O
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01LS-0002PV-Vy
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Adt5IcIOen/FCzmeJ9ZKl4dQmt7S+GpjvrRhWvgpkw=;
 b=g8/dOZIdshc++EZQA9MwIlWChJThTIsP7OalbqogxUY4dvCrAWVjaqtw00Szkq/abOC57D
 8jEoSs68f/+puyKBkWEfd7TkZEqK75xDwPYF/hRr2Q7LVuaHrG2HQdXHhPrjT45OHnwk7g
 mVTsY3LbrYUSz9LoFLCcA9p60ZbrihA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-EI1l0rnvNhORryVfaGwkmA-1; Fri, 19 May 2023 10:44:37 -0400
X-MC-Unique: EI1l0rnvNhORryVfaGwkmA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-510dd6ff768so2530829a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507474; x=1687099474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Adt5IcIOen/FCzmeJ9ZKl4dQmt7S+GpjvrRhWvgpkw=;
 b=Fm++eJM6KrG9yCAbcxsDTsyQEbtSrf2EfaTkKpd7rPCaqpPs7yTT3ROEZj0uc5qev9
 r2r6Mw2WaUI7UOpEtywaFptYTI5G/q9OQfaIxprdh238GM4KFLbFtMaHCM3CJFaXB/nR
 E/d8B4KZca8PZN4S0vjlYwZ/Re4jOUelN1Q8k4biyuXwwlsOXo+6O8Q9VUYiMi9KRksT
 e9SABEu3mt1VViML2bIomP32g2fDswo16gHeyjrBWr5W3exQclay6gDt+qO69n6D6f3O
 BjjTRhgLdJAZootIQ9gUYmIXcBDJI3/oaKBZyBr+3vbXtiTNJsXMYlKjLa+rtGVdH/zz
 SBQw==
X-Gm-Message-State: AC+VfDwgi9MW9rk83gvRUPp8D/UbCaetV32etNKwgsJCpWXVWMN3qDdy
 PhekMjK2po7RDFENefHaPcwpD5vgnPPW6EH7Fs4o/Pmiz0bocYpnZx2TKeyRAhpAt9WJ1+aHx3q
 H+wCZDc7BUmY66B0=
X-Received: by 2002:a17:907:2cc7:b0:959:18b2:454a with SMTP id
 hg7-20020a1709072cc700b0095918b2454amr1917217ejc.76.1684507474660; 
 Fri, 19 May 2023 07:44:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MMo2hK0oMYQplXO2EET+zCHbds0t3NpnEPg3/PjndUcMeCcxvm6bYNdOsw/p9fZnytSuXqQ==
X-Received: by 2002:a17:907:2cc7:b0:959:18b2:454a with SMTP id
 hg7-20020a1709072cc700b0095918b2454amr1917206ejc.76.1684507474354; 
 Fri, 19 May 2023 07:44:34 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 rk5-20020a170907214500b0094f3b18044bsm2363548ejb.218.2023.05.19.07.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 07:44:33 -0700 (PDT)
Message-ID: <06e3f1ce-06a9-467c-ecf4-5966725642c1@redhat.com>
Date: Fri, 19 May 2023 16:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/19] cutils: Document differences between parse_uint
 and qemu_strtou64
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-7-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-7-eblake@redhat.com>
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
> These two functions are subtly different, and not just because of
> swapped parameter order.  It took me adding better unit tests to
> figure out why.  Document the differences to make it more obvious to
> developers trying to pick which one to use, as well as to aid in
> upcoming semantic changes.
>
> While touching the documentation, adjust a mis-statement: parse_uint
> does not return -EINVAL on invalid base, but assert()s, like all the
> other qemu_strto* functions that take a base argument.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   util/cutils.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


