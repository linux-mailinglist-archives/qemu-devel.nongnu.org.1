Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D061781AF70
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:30:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDV7-0007w4-4Z; Thu, 21 Dec 2023 02:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDV5-0007vh-Im
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGDV1-0006ZZ-6z
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703143782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eOl9pQiiXKZaxt3jQWUXr4LZzemhJ56QorqIDGR1iMU=;
 b=AO6P9VX+8V/L6hV5XdMVGsD+0/dFADPC9h9/07xVRYCGbw4Qq0a6L40CwcnDueeSvMik+z
 w4l7IptZtSKYbidxoiE/g9eK2vTRmybwq5GvBC0IN4nt62eic7+1H8dOb8GgjFeIEUEt6p
 F7v0keI5VfHokrKEALEA2lcZ33rXyiU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-MK7v1yp1NwSc_LyFKnjtRQ-1; Thu, 21 Dec 2023 02:29:40 -0500
X-MC-Unique: MK7v1yp1NwSc_LyFKnjtRQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33689c90957so172895f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703143779; x=1703748579;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eOl9pQiiXKZaxt3jQWUXr4LZzemhJ56QorqIDGR1iMU=;
 b=ne7NxahBPZnrJsIZlpdGLS2PH5RXVhwOGT8M8J2DDNUGrsyFtN+El7Pa/3p0Stoe5A
 EITsge3cZ1PEY16WV3qXMEtZ9o36arGXqb7o5aYGrlPstnocDWFMFR5Wjafnt8lY6E/E
 NOqDXKJBPOG7fMhswB7r/NbXmZtL4EiFeCLQket9v6fpOO5rPFh8UGypbz2GzTgFJ4+J
 L6IjcBp/h76/Jz11HWvU+sPXYtfowIJnfH/CLfWmTL1YFO6ITHmNvaz9QwRUHsqlxu2C
 J36/fK7h+tONP9WrpiMCqqfLrnf1aOb/p2EnB/yiWLHnhaUFv043QSz01+fztxLSxWKC
 R/ww==
X-Gm-Message-State: AOJu0YxoDJTIfIcpZJz6U44xlVhZQqll+JGrhHtTG3N+mRkdiSXHSwFD
 rCBdnC2V+gocA4sUSs1UulJVq30fquoVLJ1EFml5/4DXwqrBQQ3/XiOaDHmFGmoJ3Pn9aIBMchw
 3/JwlJMBg0rvnt6A=
X-Received: by 2002:a05:600c:3d93:b0:40b:5e1c:5c21 with SMTP id
 bi19-20020a05600c3d9300b0040b5e1c5c21mr448232wmb.54.1703143779609; 
 Wed, 20 Dec 2023 23:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRT+lKDJYnrT+xZwQZ1fbVBlrU9dSlbN6/RL84UeHtsu4RdZtnnCsHHbqD4g6YnwQNcGxO3Q==
X-Received: by 2002:a05:600c:3d93:b0:40b:5e1c:5c21 with SMTP id
 bi19-20020a05600c3d9300b0040b5e1c5c21mr448221wmb.54.1703143779270; 
 Wed, 20 Dec 2023 23:29:39 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 b22-20020a05600c4a9600b0040d37e97393sm915439wmp.1.2023.12.20.23.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:29:38 -0800 (PST)
Message-ID: <aa009a56-a268-4a6f-9975-a8293b8adb08@redhat.com>
Date: Thu, 21 Dec 2023 08:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] fixup scsi: only access SCSIDevice->requests from one
 thread
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
 <20231221014903.1537962-4-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20231221014903.1537962-4-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 12/21/23 02:49, Stefan Hajnoczi wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/scsi/scsi-bus.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index df68a44b6a..5b08cbf60a 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -127,7 +127,8 @@ static void scsi_device_for_each_req_async_bh(void *opaque)
>        */
>       ctx = blk_get_aio_context(s->conf.blk);
>       if (ctx != qemu_get_current_aio_context()) {
> -        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh, data);
> +        aio_bh_schedule_oneshot(ctx, scsi_device_for_each_req_async_bh,
> +                                g_steal_pointer(&data));
>           return;
>       }
>   

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>


