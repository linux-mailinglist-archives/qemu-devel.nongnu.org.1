Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D353176BC94
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 20:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQuF6-00032N-Uc; Tue, 01 Aug 2023 14:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuF5-00032F-It
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQuF3-0004Sl-UW
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 14:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690915027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S14usRbSJqM19qfXveu8r0Di5wpneaJTb8ucv/HGOo=;
 b=dCqF7HLIejJW8l+sFRulV6XjYygoU9l4+7MT/Z+sgyi+P8P3QNO+ctCQ0UzwQR4E4UvdZH
 gr8Mvng6AitX2kGAMfz1bOSA5Ab1DTfkNQ8LQvMdxXjmCkVZDCa3acMeNoxkyek6jFXigU
 PX1VJc0gBNFJ0UoYrqMzj0l8dix2NT8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-RbfblOfSOq-RxIkSD5AdNQ-1; Tue, 01 Aug 2023 14:37:04 -0400
X-MC-Unique: RbfblOfSOq-RxIkSD5AdNQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3a3a70425b4so10354336b6e.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 11:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690915024; x=1691519824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1S14usRbSJqM19qfXveu8r0Di5wpneaJTb8ucv/HGOo=;
 b=eDVk6eVskazfaxESRBseq6NvMt3WjcmpTvemIKlI7rGFVOaPjERKf+yR6OKurfpU8O
 UaE78gd4HBbHyBCimNX5CgjFeC7z1qkWPRmh4AORZa8CB9PyX9pYqXnbhzmvixueQ7yM
 gQ6pSkd63LaWOYdJX3OueC3CeQwo5PrSBvgT2BDtJvfybwnTsXLQGjoCytOyx611vdrC
 2/9RsWVtYCYgUfl+gB3SoyZUXJt3D0FqZYI1DLmRowZfI+fBZQG5FKj+Ytnt9vSX/18P
 9VzNLeEROw/s2obErOorOIIHxZbYQVy0sTi5BT2NexMt/BuarOX+GQxb+PDTvUJt77Ik
 cWoQ==
X-Gm-Message-State: ABy/qLYqlNjKfBkz5gIY1AqCH/sQ1GyXslJ7uk7bbg35XjuyuuBxU8Kx
 GVNzlu9SKhyRLTPTCAi4pX0+3mqg1bpG1zjXBCyI6e1fX7IUtKdvqjJtfAtVyg3Gu8Kpyz1X+5L
 HYFEG2Kc14aObw/w=
X-Received: by 2002:a05:6358:27a4:b0:139:65ca:5d6 with SMTP id
 l36-20020a05635827a400b0013965ca05d6mr5291988rwb.25.1690915023770; 
 Tue, 01 Aug 2023 11:37:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8w4vvL2k9AhJLNN4+LzKOu/936upUkOP4qYHuswm3aKsG5Tvw5iGfdlbzJCac+GuSffJbiA==
X-Received: by 2002:a05:6358:27a4:b0:139:65ca:5d6 with SMTP id
 l36-20020a05635827a400b0013965ca05d6mr5291968rwb.25.1690915023437; 
 Tue, 01 Aug 2023 11:37:03 -0700 (PDT)
Received: from [192.168.8.105] (tmo-081-137.customers.d1-online.com.
 [80.187.81.137]) by smtp.gmail.com with ESMTPSA id
 q6-20020a0ce206000000b0061a68b5a8c4sm4842402qvl.134.2023.08.01.11.37.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 11:37:03 -0700 (PDT)
Message-ID: <0d86bcdc-2419-c823-30e7-fa35d73256df@redhat.com>
Date: Tue, 1 Aug 2023 20:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/8] gitlab: remove duplication between msys jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.092, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/08/2023 15.03, Daniel P. Berrangé wrote:
> Although they share a common parent, the two msys jobs still have
> massive duplication in their script definitions that can easily be
> collapsed.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 132 +++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 83 deletions(-)

As I discovered in the recent days, this is also quite helpful in case we 
ever want to switch to Clang, since we need to change the prefix of the 
packages there. And it's still easy to have distinct packages with some few 
lines of codes changes, as I tried it out in my Clang patch. So this patch 
now sounds fine to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>


