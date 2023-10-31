Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2821A7DD081
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:28:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqeU-0003U4-Iz; Tue, 31 Oct 2023 11:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxqeS-0003TG-UW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qxqeR-0001fW-KE
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698766050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6Hn+yowlpaZFH8sjE+Bkj99AkC0h+h1uF4xGWARmE8=;
 b=QtGh+ELTrI3TW+hw8ZfQzboQyj5TdOvJDSR1ifzShXybxdglmhD/7X59NXKQObsgCCGRmN
 FaPCqbVGHC81sSbaWX9rSPRjyY0e//wlKx0bMIxYyYNSs35JZpYn7xgyHNFpKQjzjkrcJ0
 EgtaXwBGpANdlh/iynkChfm8v6Iov/M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-yR9FCJ89O_K47RsjwpVofg-1; Tue, 31 Oct 2023 11:27:28 -0400
X-MC-Unique: yR9FCJ89O_K47RsjwpVofg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so43073165e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766047; x=1699370847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6Hn+yowlpaZFH8sjE+Bkj99AkC0h+h1uF4xGWARmE8=;
 b=UaHTOfw4k/H640qSKvtTXdT5OTa0BHUNXTyvKvaGYgRMmIrjBkqdfqfJLkiF72ocD8
 wuW4NRI4tZp/I4jnINsE9LXiCPmr2zLJL6CmSjvaJgRwzO47xYCTiVVc0z+SG4aktl9N
 ErFDnKLv0oBenrxKJsWcNn15w/rGACO6lpLbp0liYGetvTC+NYFMj/eJ5Qp7yGSbiMth
 vJ2M/8Fh+/a9dgxf31DdMqGo/xh5cBEZDRyzjo3mX8AzhxuLP/2x7nZIwJCtFRJsm7N9
 sLwj30N0nzuR6NaqKGsWRxtL/e1pN4hY47ljdZlABgol9CJo5tRT82SzUwdRUrDbspdO
 o0ww==
X-Gm-Message-State: AOJu0YwmnvcWnUXNFPbzE9P1tG/Yp1d3Y4EKeaEzfhLJlQjyTaginQFc
 ldQRvMzMV8htVdBNB3eI+piU1CBoiNTjxdRmNzRfRo+B9AoDlOqQUmK/5uQ5dKd891e/c7xzLa5
 CI0OZNWjL0VO3zwM=
X-Received: by 2002:a05:600c:c0f:b0:409:50b4:3da8 with SMTP id
 fm15-20020a05600c0c0f00b0040950b43da8mr1976141wmb.38.1698766047566; 
 Tue, 31 Oct 2023 08:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqk6DEi00P+9Zn3CHpR2S1EB0OmBExzPABkmbbx62ozSIbIKlBbRBuXiRT5cdR+U9GrCejLQ==
X-Received: by 2002:a05:600c:c0f:b0:409:50b4:3da8 with SMTP id
 fm15-20020a05600c0c0f00b0040950b43da8mr1976120wmb.38.1698766047175; 
 Tue, 31 Oct 2023 08:27:27 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a5d5151000000b0032326908972sm1732757wrt.17.2023.10.31.08.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:27:26 -0700 (PDT)
Message-ID: <bc28bffe-672f-47bf-9824-2fde09f00768@redhat.com>
Date: Tue, 31 Oct 2023 16:27:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcow2: make function update_refcount_discard() global
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 berto@igalia.com, den@virtuozzo.com
References: <20231020215622.789260-1-andrey.drobyshev@virtuozzo.com>
 <20231020215622.789260-2-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231020215622.789260-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 20.10.23 23:56, Andrey Drobyshev wrote:
> We are going to need it for discarding separate subclusters.  The
> function itself doesn't do anything with the refcount tables,

I think the idea behind the naming was that updating refcounts can lead 
to clusters being discarded, i.e. update_refcount_discard() did the 
“discard” part of “update_refcount”.

> it simply
> adds a discard request to the queue, so rename it to qcow2_queue_discard().

But that’s fine, too.

> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-refcount.c | 8 ++++----
>   block/qcow2.h          | 2 ++
>   2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


