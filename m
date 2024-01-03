Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FDF822E7C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:36:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1Pp-0003Fh-2l; Wed, 03 Jan 2024 08:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rL1Pl-0003FX-34
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:36:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rL1Pj-00014p-Gd
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704288966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MFGrASxmcKgJnC24IT85W2f2R7HBlw1S7irBMq7Wj6E=;
 b=YcOvJ7a6TXFDM1GwNhHdeu5dNNEC/Lij2BdemBLWjALXR7Oub+PG9q+GSsFoc0KKWTpNOk
 Z7Lq9TDSjkEla4kHyakW6HivKM/usgqmLnj4CgRQ/3eePVErYB7QfPzgg0BEDuQwwKOMtZ
 sA4Th8jDP/Ado+9PbIgwk0qCGEKr/8U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-6ZH93x-UMHCiLlsInDQ9qw-1; Wed, 03 Jan 2024 08:36:03 -0500
X-MC-Unique: 6ZH93x-UMHCiLlsInDQ9qw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-556c3940051so353487a12.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704288962; x=1704893762;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFGrASxmcKgJnC24IT85W2f2R7HBlw1S7irBMq7Wj6E=;
 b=RiM0OyiogAAPFBEqdzMEY1cV7VfE/k0w8iyB0KV3Iit9wuS1jrgNxV5N0F8MAKz2ms
 kYAh127n1hGSctiVpXVVh8hDwx2EJlMDIwYFP6ywtzh4CbGMeTpYXHYKhtAEI/I0LBAF
 c8o2HNeOE2Rqh0EGjuHr7rLcHAQ7eCMHjAQa1+etwOYTci5R0aJA2sly0+ftb+Zc6d7C
 S8E1p2FZRDHMboi/TsEDSTjDeEwrDL2PTkeG8IWPe1Ev09aTilD5DCx5QZpMetqIY6CW
 azCgna3Pcg4ZPEhnoqiQNOrKFXCIgJ98tTdC8N+tA/Gl/O10n6buQG4ridCAr8QGqluh
 Gt6w==
X-Gm-Message-State: AOJu0YyIDTUBD9PSreIxnzXk4f7Q8O/4NXsqneX9umsquHKvUIxDdzAl
 T2HHge4jZC3flRDtXtpJEXoiw28p0fKFZvopvPBaUfkXp/YL6NNm1xUQS3zY5KtelkKvGUm1/aH
 h76RijPVk+4IS9gO6LzTxPPQ=
X-Received: by 2002:a50:d4db:0:b0:555:1c92:d1a9 with SMTP id
 e27-20020a50d4db000000b005551c92d1a9mr5592021edj.46.1704288962478; 
 Wed, 03 Jan 2024 05:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbEr04sBzSQsItGUavSHk1e1KqnQObfIWrC+YuaNCUsrbxfCcr6VK461BAqrtvHpiAqo1oYQ==
X-Received: by 2002:a50:d4db:0:b0:555:1c92:d1a9 with SMTP id
 e27-20020a50d4db000000b005551c92d1a9mr5592016edj.46.1704288962190; 
 Wed, 03 Jan 2024 05:36:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 o6-20020a056402444600b0055473af90a6sm14726086edb.0.2024.01.03.05.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 05:36:01 -0800 (PST)
Message-ID: <94db88e7-1f02-44dd-bc2c-3d9ccf1cce72@redhat.com>
Date: Wed, 3 Jan 2024 14:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
 <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/3/24 12:40, Fiona Ebner wrote:
> I'm happy to report that I cannot reproduce the CPU-usage-spike issue
> with the patch, but I did run into an assertion failure when trying to
> verify that it fixes my original stuck-guest-IO issue. See below for the
> backtrace [0]. Hanna wrote in https://issues.redhat.com/browse/RHEL-3934
> 
>> I think it’s sufficient to simply call virtio_queue_notify_vq(vq)
>> after the virtio_queue_aio_attach_host_notifier(vq, ctx) call, because
>> both virtio-scsi’s and virtio-blk’s .handle_output() implementations
>> acquire the device’s context, so this should be directly callable from
>> any context.
> 
> I guess this is not true anymore now that the AioContext locking was
> removed?

Good point and, in fact, even before it was much safer to use 
virtio_queue_notify() instead.  Not only does it use the event notifier 
handler, but it also calls it in the right thread/AioContext just by 
doing event_notifier_set().

The call to virtio_queue_set_notification(..., 1) is safe; not sure 
about the call to virtio_queue_set_notification(..., 0) though.  I'd 
rather have that executed synchronously in the AioContext using 
aio_wait_bh_oneshot().  This is consistent with the pattern used by 
virtio_scsi_dataplane_stop() and virtio_blk_data_plane_stop().

Paolo


