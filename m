Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E71E76EB33
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYjH-0008Df-9t; Thu, 03 Aug 2023 09:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qRYjE-0008DO-NS
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qRYjC-0006oW-Nu
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691070656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t153WUlaEGgf6UKOwh/n6dejBFO9Qo5GSEPIg06B5uE=;
 b=WlaAme0Gwlr9tUdj1V3zkxQjWIbtTtVJCqsjSAxRlQXptn8NPG+7yA0v5st6I49usZPIiY
 y5mGjjFkmav/akdNTT4BnbHaEXGtH8uB7xRusYh2AQmj198u7EhAieLRIYXbYn/iHPnPxZ
 KqN7RgPw2/1B4Wpto6CLwiLENn2dGpQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-C9u2EpfVMeav7b22Hv2OZQ-1; Thu, 03 Aug 2023 09:50:55 -0400
X-MC-Unique: C9u2EpfVMeav7b22Hv2OZQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c0bd2ca23so104802966b.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691070654; x=1691675454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t153WUlaEGgf6UKOwh/n6dejBFO9Qo5GSEPIg06B5uE=;
 b=URLRMlLDMGReulGu/7n2j44EtTldMo1pSd9A6/PYroutzJ1d5OYU8o6gxcKjgGBRdj
 1O0dPEGe6FDz5+HMBlZiSdJqqXYloqqsmdFULCh+0YX31KvlFB5D/kUGw6VLr1zn9w2f
 mUCzhHOrkR7uv52GWX9KD2FWo8D46SXnv5dyUbiMO33e6auIUx1jFYFgqOjJFONN4M2B
 IT85B/iMK84plLFiyS8j5J2t8YrYj9u9H7nnh83YvSghkvneyhYPVCjoNeBJQqFKA8rG
 0Q/3stf99kPq7aKasLtmHGIw6l+2h+MKRWa9ajVeSHmKNHc0POcJ5cC6jgVasjs/Xwkj
 oX+w==
X-Gm-Message-State: ABy/qLakIIQOqZTQ1yHRoiGnlUjxHbashvNRzvQQAhpy8wUlR2ejWdog
 ZKVqtfgAv41Py4/+b3Aurjwz31rdr05kkGCQdLHFafiN2pAGLBYz4G3Zh4wBJ/TCiflXxDVnUSD
 Rop1rePCHe9AtCs0=
X-Received: by 2002:a17:906:8466:b0:994:539d:f97f with SMTP id
 hx6-20020a170906846600b00994539df97fmr7329088ejc.37.1691070654692; 
 Thu, 03 Aug 2023 06:50:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErbcprKBmchHIh+2MK9cx7dlwxJ3Vs5udcXKbiXbwCF+kDhQCJP1mH7uxa7flsEfG9IM0ZKg==
X-Received: by 2002:a17:906:8466:b0:994:539d:f97f with SMTP id
 hx6-20020a170906846600b00994539df97fmr7329076ejc.37.1691070654418; 
 Thu, 03 Aug 2023 06:50:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a1709061b0d00b0099bcb44493fsm10681215ejg.147.2023.08.03.06.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 06:50:53 -0700 (PDT)
Message-ID: <87c4b435-01cc-870a-b805-d65ac924e06d@redhat.com>
Date: Thu, 3 Aug 2023 15:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] block/blkio: close the fd when blkio_connect()
 fails
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20230803082825.25293-1-sgarzare@redhat.com>
 <20230803082825.25293-2-sgarzare@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230803082825.25293-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03.08.23 10:28, Stefano Garzarella wrote:
> libblkio drivers take ownership of `fd` only after a successful
> blkio_connect(), so if it fails, we are still the owners.
>
> Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> Notes:
>      v2:
>      - avoid to use `fd_supported` to track a valid fd [Hanna]
>
>   block/blkio.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


