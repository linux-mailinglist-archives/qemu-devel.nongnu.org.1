Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8376CC3E
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 14:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRAYf-00013W-4p; Wed, 02 Aug 2023 08:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qRAYd-000138-0W
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qRAYb-0008Lc-Er
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 08:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690977744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwjZ2ap/KtkUtuv6alaaB3AOvZOGyhokq+MW9/KtxHA=;
 b=MeJB+G2QXnoKnq3HOaJFXH0iMwOtm1aj3ZGvJPjsmpN7Jk75emZIVCEk/FrD27VTd0voqB
 Zs0Mx5fZlhzklTPHGwZqUCkX4UFeeg+zvzdiPaKYJqbXM056WrXTNhpCMSKoP7Et7o45js
 OASHuohpYh0vsrsCpP7HZ5rwNAYbFAw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-bNKbkyitNbyb-kNSKUgfSA-1; Wed, 02 Aug 2023 08:02:22 -0400
X-MC-Unique: bNKbkyitNbyb-kNSKUgfSA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f76712f950so6188393e87.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 05:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690977740; x=1691582540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SwjZ2ap/KtkUtuv6alaaB3AOvZOGyhokq+MW9/KtxHA=;
 b=UUtGq0SfMhyNAKf3KZ8s5JMMm5zVF3v722zFuFy+8AKQi3rq3jCvwCpFzawzp0bj/A
 nzYw5MYHQ4mwEmUlAF2YcrzLqAiCVWDw1thUIhmo4Xym/uqcGvEKrjhWQBgOqh4fmi2X
 jzF2Gl+gNAU0PJm8Ofx0hq7xvyGXplpAFCueCUBdDWyefm2ATemaKBHNuzEwFSJPr4S6
 LE3rv3s7Xx6pQnPBQSKxPsl7pT+FJCHqKXxL4oyI7T9XTb6Fepph6KPqFb/iXZUBfYlx
 cqwew13Ewe+MfUvcGTWM4geQNDzW5+ZySD2/FBlYos+N9QN31YnUnXBU7+/DOc9jWPO/
 uuPA==
X-Gm-Message-State: ABy/qLYt+m80GehD7xUecq8c/Xq2vFJ857AcaHkKkrr781iZYGlkl5/G
 9YYZM1gpHw7gSBFt6hDIgWkn6EQqFYwXM9MZIl9hNmK39fCyFV7rn8IPu7wqOGL1xpf1yH5VEHZ
 LKFkj5P+mpCDEUIM=
X-Received: by 2002:ac2:5f74:0:b0:4fb:fe00:49c2 with SMTP id
 c20-20020ac25f74000000b004fbfe0049c2mr3888799lfc.32.1690977740717; 
 Wed, 02 Aug 2023 05:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkuaB3UnssBGFQeSCthjGI7iDcdhvW79EDZ1xkb0Ubh3Y4YnDGBg5U1cIOXbE0EYcoAX9Kvw==
X-Received: by 2002:ac2:5f74:0:b0:4fb:fe00:49c2 with SMTP id
 c20-20020ac25f74000000b004fbfe0049c2mr3888778lfc.32.1690977740385; 
 Wed, 02 Aug 2023 05:02:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a1709066bd900b00977c7566ccbsm8912108ejs.164.2023.08.02.05.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 05:02:19 -0700 (PDT)
Message-ID: <7465bcb8-ec1c-92af-54e6-1f4ccec91f5b@redhat.com>
Date: Wed, 2 Aug 2023 14:02:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] block/blkio: add more comments on the fd passing
 handling
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230801160332.122564-1-sgarzare@redhat.com>
 <20230801160332.122564-3-sgarzare@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230801160332.122564-3-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.08.23 18:03, Stefano Garzarella wrote:
> As Hanna pointed out, it is not clear in the code why qemu_open()
> can fail, and why blkio_set_int("fd") is not enough to discover
> the `fd` property support.
>
> Let's fix them by adding more details in the code comments.
>
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   block/blkio.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


