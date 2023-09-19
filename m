Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131377A60F8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYgG-0002an-Oz; Tue, 19 Sep 2023 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYgC-0002RN-Jc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qiYgA-0005Ga-MG
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695122045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4n5aA1sHukdr2V7qnHPEVjSQo3hDz/PNP9LJnFyyRc=;
 b=Pdpw5SvUzUtm7G5kDJ3WzJx9hTbJo5AVNiYvvGQkzI8i3vL9DK5S4jVWCl30oT++wxQHXK
 8v1Ey/zcBlkhGaSU0AesFfo11Vu0Q3WDqUmJ5SPe7rObutZtN5D4m5cCtP/wxJRrsmZVJU
 LloUUVGpQNdiTptWQsqmK+L6Euj1J5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-55jF2UzONfirewQn6_THxg-1; Tue, 19 Sep 2023 07:14:04 -0400
X-MC-Unique: 55jF2UzONfirewQn6_THxg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9aa05c1934aso977241866b.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695122043; x=1695726843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4n5aA1sHukdr2V7qnHPEVjSQo3hDz/PNP9LJnFyyRc=;
 b=XJBu9HYp0yFL3xxvGyUQ2L1DYZOK0Sn8MEQGX9WZBlPVR1ZqtyNm1bKRXvf+84HBFB
 pEvtn69p46LbLedjRdPb/x1oM7MzJlRtbbWKh6F668DxgEB6UAQS8aycz5i4vvVSSsbz
 e/3m0BDLP6y7nJfQjgMFMFwwn/YNdGtG7VT/DlSR84vmhyVSU7cKa4rZKj4/J/VNJ29Y
 wOn78SjBnkauBShg3gM+v6HVwmJBLF6JrR7Bn+mbzVYoNqSanKOsanO84KbWUdMNEF4p
 5HT4e6D6NwlOUdsD9Z6jFpqd57pViEpKCYlMA9IgvgU2Vjrxesa9veqyEuLVtX+4kMsm
 r6dQ==
X-Gm-Message-State: AOJu0YzBS5fDDvlTcJTxbAWaQ47SFJvOYRAumZyg64TdICUijQdPWsQw
 kUZFiybE+ANFnfxYezf6YFq/hv4rQ6zeyKbfW1Z2l0Z01PzKn3l8IYS8bgaEILX92vEWIFgIngK
 i11W0Gle869jyjyM=
X-Received: by 2002:a17:907:72d1:b0:9a9:9d19:b250 with SMTP id
 du17-20020a17090772d100b009a99d19b250mr3231525ejc.17.1695122043597; 
 Tue, 19 Sep 2023 04:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpSEVPtRFIMFq5ursjTmS3izd8YVLbSJwSKdOaga/tHD9W4N0IUrYmR1DzT/HGTqP9plxnMA==
X-Received: by 2002:a17:907:72d1:b0:9a9:9d19:b250 with SMTP id
 du17-20020a17090772d100b009a99d19b250mr3231506ejc.17.1695122043247; 
 Tue, 19 Sep 2023 04:14:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 ks21-20020a170906f85500b0099b6becb107sm7769957ejb.95.2023.09.19.04.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 04:14:02 -0700 (PDT)
Message-ID: <0e0923bd-01f0-e19a-c183-e6b7951fe550@redhat.com>
Date: Tue, 19 Sep 2023 13:14:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/8] iotests: add tests for "qemu-img rebase" with
 compression
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-9-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230915162016.141771-9-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 15.09.23 18:20, Andrey Drobyshev wrote:
> The test cases considered so far:
>
> 314 (new test suite):
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
> 271:
>
> 1. Check that when target image has subclusters, rebase with compression
>     will make an entire cluster containing the written subcluster
>     compressed.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/271     |  65 +++++++++++++++
>   tests/qemu-iotests/271.out |  40 +++++++++
>   tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/314.out |  75 +++++++++++++++++
>   4 files changed, 345 insertions(+)
>   create mode 100755 tests/qemu-iotests/314
>   create mode 100644 tests/qemu-iotests/314.out

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


