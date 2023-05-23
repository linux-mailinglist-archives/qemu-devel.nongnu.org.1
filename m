Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB2E70E2CE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:38:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VwB-0006cj-KC; Tue, 23 May 2023 13:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q1Vw9-0006cA-CW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q1Vw7-0000an-Rs
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684863396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfJbutzzYxQWthbTzlNFe2Uhx0+f5U/JnhWMlHGECRg=;
 b=NGY4nsztrB3zOIoSf+9KPBDJqmFgBuQyKoZHd+hAweraDURGdQHRHYbjU5RGvG/E6Gf+7S
 CMzib1oRa2uu0pGdq4LR3W2NdVjjxmVbv5wG6B1TZu8ENoN/R1j6pP3GZTM4hRqlM6cFAW
 cnCu3FMnB63GZOVR5ClDXgOlLWNUq+Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-_1TRGG20NBipf376ILZD4Q-1; Tue, 23 May 2023 13:36:35 -0400
X-MC-Unique: _1TRGG20NBipf376ILZD4Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-513e916ed47so94842a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684863393; x=1687455393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfJbutzzYxQWthbTzlNFe2Uhx0+f5U/JnhWMlHGECRg=;
 b=CYsorplfEoLqb3LMV0T+dF3Jkx2QmoIYl0IFEcCwHw92X3XS7xyDCJSnBkikwJSDnQ
 EyLuqyhqX1CJuq6Qa5mV1sKpantov8J3oEXUgZgPSa2HfIkzNuOr88+gYmZXnR64Ju6j
 U3Qjz+1WJndMIp89MKYRGAjNOQ+Ik4JOgyjKF4YmXxangSzD4LZ6LEGp4Tun1KrBgSj6
 ZMqSecctt/yH44nh49NOCZ3uq+GAEMGDZbyQALDewzjWrzRWa3ZsLsTDN/YTcZGqFxq/
 PEtypymgT+m+RCQArK/+uZ0uWuKhOHGUV6zun3H1vKzYC26CgWhU3EQrbEZqVXVo4ADP
 /W0Q==
X-Gm-Message-State: AC+VfDzqpu6ZdzeDR2DytipWVuPrk2S8arCbA8VdAN3wdC46IokrCd6y
 hJji7KUE1Ht6RCQZapyhHZBbboSNawG5dCFthq9kt7IuKQnTlmHq7AY2rbFdkZ8UvvdKDq8Xtj2
 gaXkbQhYr7SgAW5ijUP7HMlc=
X-Received: by 2002:a17:907:96aa:b0:96f:d556:b926 with SMTP id
 hd42-20020a17090796aa00b0096fd556b926mr7644627ejc.77.1684863393538; 
 Tue, 23 May 2023 10:36:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+IKX6Dz3IZZuDzAdxN3koN+Wi12qmTfrHxUty4B8254KmAINFukvdnNzbx4UUGcGDlvyucQ==
X-Received: by 2002:a17:907:96aa:b0:96f:d556:b926 with SMTP id
 hd42-20020a17090796aa00b0096fd556b926mr7644616ejc.77.1684863393269; 
 Tue, 23 May 2023 10:36:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3?
 (p200300cfd723b0c78fa2ce552d0c5fa3.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a170906854e00b009534211cc97sm4616322ejy.159.2023.05.23.10.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:36:32 -0700 (PDT)
Message-ID: <0fb47100-5169-6acc-0f3f-06e3c934bc09@redhat.com>
Date: Tue, 23 May 2023 19:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 05/19] cutils: Fix wraparound parsing in qemu_strtoui
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20230522190441.64278-1-eblake@redhat.com>
 <20230522190441.64278-6-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230522190441.64278-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22.05.23 21:04, Eric Blake wrote:
> While we were matching 32-bit strtol in qemu_strtoi, our use of a
> 64-bit parse was leaking through for some inaccurate answers in
> qemu_strtoui in comparison to a 32-bit strtoul (see the unit test for
> examples).  The comment for that function even described what we have
> to do for a correct parse, but didn't implement it correctly: since
> strtoull checks for overflow against the wrong values and then
> negates, we have to temporarily undo negation before checking for
> overflow against our desired value.
>
> Our int wrappers would be a lot easier to write if libc had a
> guaranteed 32-bit parser even on platforms with 64-bit long.
>
> Whether we parse C2x binary strings like "0b1000" is currently up to
> what libc does; our unit tests intentionally don't cover that at the
> moment, though.
>
> Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: qemu-stable@nongnu.org
> ---
>
> v3: rewrite with better comments in code and commit message [Hanna];
> fix additional problems with wraparound, cc qemu-stable although this
> has been long-standing enough to be low priority, R-b dropped
> ---
>   tests/unit/test-cutils.c | 20 +++++++++-----------
>   util/cutils.c            | 25 +++++++++++++++++++------
>   2 files changed, 28 insertions(+), 17 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


