Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE9788C4C
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 17:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZYZ8-0004EE-Ph; Fri, 25 Aug 2023 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYZ6-0004Dj-FA
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZYZ4-0005kj-Aw
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692976653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQPvDemxEkIykIRo5mbGKI2P/9AifCEUD29JgCwE+9o=;
 b=ep1rkxxaAqpSZC3gs6Bm7TdgpdmG8eBgrbZ9o8mj+ktPQfo38+mtv5bUm8I4dwGQ9zrmO0
 vFjqwnZXAOxa8NEXLXRc5zWiirQM7trCI8QKSBbHEAUCsLz4PHNA9B0szccXKdtdhKjSrQ
 r1tl+LzUOmtc8yxMLyrJT7bkhk3fCKQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-dJeIzMS9OCKO0WYRdkgyHw-1; Fri, 25 Aug 2023 11:17:32 -0400
X-MC-Unique: dJeIzMS9OCKO0WYRdkgyHw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso77446666b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 08:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692976651; x=1693581451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQPvDemxEkIykIRo5mbGKI2P/9AifCEUD29JgCwE+9o=;
 b=OPnPeMjfjYgG/fR/bZYbeGUzX2VFYh/Pswltcxay+ePYCJJQ6+CBi5B5XoONLEZsZQ
 7Rio95M11ZGwUxyomXtCU6ynGSoHhrAycy3J9ym/JPaDqJMy+g0hZwDdlBWwrdf2qAzr
 0UP+OoMVy9iTNz8EnjzaSgC0yoQhFgg7unYeWKmGzjD7ZYRI2gk8b8CXGApnFZi+8tZl
 w68pWVO7MfCx84UV6tYW7WdVnPDXlIb0cRv4lYcXBGMSM11M5f72FJSFFTBnZZnR97HA
 K81ktuNVFvUjAtEA0GW6Ohot6OsWpelZzmWnMJHXGHdol5d4XdYkM1TtzrPcKyyP/HCl
 nrrw==
X-Gm-Message-State: AOJu0Yz+p7Sq5HinsZW8CPmFPGJCChD2ju+dkcdvCu3zIH7TQhKniD3W
 bwK1N2Ch6rwlSY8gyT4pcPLYJSAir4v4nmPHo0fwYX3KMFtmujipdFrdei6Bb5H4ell2dQ/fpkW
 HqVM0bAK4rkblW2I=
X-Received: by 2002:a17:906:212:b0:9a1:bd86:3acc with SMTP id
 18-20020a170906021200b009a1bd863accmr7537617ejd.12.1692976651217; 
 Fri, 25 Aug 2023 08:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZrC3hw3ACrk4EssOyRoscm780y0cpv0TS2TkexU9hCFbC5aNb3keIq+Ps7Did2qiDC4A72g==
X-Received: by 2002:a17:906:212:b0:9a1:bd86:3acc with SMTP id
 18-20020a170906021200b009a1bd863accmr7537609ejd.12.1692976650933; 
 Fri, 25 Aug 2023 08:17:30 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a17090648ce00b0099cb349d570sm1040184ejt.185.2023.08.25.08.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 08:17:30 -0700 (PDT)
Message-ID: <68af1ff7-5a4d-85c6-f8e4-332f6932d136@redhat.com>
Date: Fri, 25 Aug 2023 17:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] iotests: add test 314 for "qemu-img rebase" with
 compression
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-7-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-7-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
> The test cases considered so far:
>
> 1. Check that compression mode isn't compatible with "-f raw" (raw
>     format doesn't support compression).
> 2. Check that rebasing an image onto no backing file preserves the data
>     and writes the copied clusters actually compressed.
> 3. Same as 2, but with a raw backing file (i.e. the clusters copied from the
>     backing are originally uncompressed -- we check they end up compressed
>     after being merged).
> 4. Remove a single delta from a backing chain, perform the same checks
>     as in 2.
> 5. Check that even when backing and overlay are initially uncompressed,
>     copied clusters end up compressed when rebase with compression is
>     performed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>   2 files changed, 240 insertions(+)
>   create mode 100755 tests/qemu-iotests/314
>   create mode 100644 tests/qemu-iotests/314.out

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


