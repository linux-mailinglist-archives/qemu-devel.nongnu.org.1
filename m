Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09147821FC0
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 17:57:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKi3g-0001zp-Gz; Tue, 02 Jan 2024 11:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rKi3d-0001zT-HE
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:56:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rKi3b-0002eb-3R
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 11:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704214557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDy329Lp/uSXEtt6pvlOC3SJYXTbmInnOQNNS4l+gX8=;
 b=Xo6PsH3wkeLko5RG/RGOD5xaNIDK03QqZuBsbaVVpUhNJF6gwU5mornXKMFnmc8FUI8X9b
 etbC7jcrT09B+0UfiMW24gtS9E+XWqUNG/2D7d9d8wMZx+PjIII5lNzbIYDFLdJmyP7Eln
 VU8frwtKbpP+CeaUdvJMwclddsgi3z0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-z6Ydklc-MVu0dWjZzf7gDg-1; Tue, 02 Jan 2024 11:55:56 -0500
X-MC-Unique: z6Ydklc-MVu0dWjZzf7gDg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d3eabab1eso80639375e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 08:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704214555; x=1704819355;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eDy329Lp/uSXEtt6pvlOC3SJYXTbmInnOQNNS4l+gX8=;
 b=IYfN1MVJ21C2DrVC9CPgiJLU7tgSWDQ+5djh8aKIW2j5PxLefMKKMvaD/o3v+1gc1z
 k/kYl5cfjxMc84sdYtFkgugm3/oYkk3jtUU+KIwHUadrWUhwa0vq8wj1aVVgypx8Ozq9
 2aEBExVxBWwjSuv5n4rm67G8CxwpPnONdVqPFS1wDz3KASNT+rTlaQgklCAhXkP/7+ZK
 vBZ1vhtMLw4Q6/ASJobtbllzcb0/6ByjoIVeIavfhk72SlHKtNcdssRaeBmpdEt5XIAO
 L9VmbDzDS4HhtSQozygB7Lkch8q6xQfdXblcZJ0InpaZ5xH5OQDzzAaR5MNu8YnbK9hY
 O/EQ==
X-Gm-Message-State: AOJu0Yz+HzcK1+VbHr/HeghgSbiTamWi2JDJUwAb6kGc1u0wAyUy9hRI
 UR2LVKIID8MnX54o4VtU9JGNVt0kU/bijwQc1KmMpC5dSdnCx20EJeYXOJFBy1e9htZdCIMSZn/
 b45WUAoVGflaf6u3caSzOEts=
X-Received: by 2002:a05:600c:3506:b0:40d:8810:efd5 with SMTP id
 h6-20020a05600c350600b0040d8810efd5mr1703685wmq.56.1704214554936; 
 Tue, 02 Jan 2024 08:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXIEalcXRsYeXs+vY+S1CyDdWbZDE8lW9R1EAqzZH3mZ7YzIJEIDG29PjjMV9lihlQWZbEkQ==
X-Received: by 2002:a05:600c:3506:b0:40d:8810:efd5 with SMTP id
 h6-20020a05600c350600b0040d8810efd5mr1703678wmq.56.1704214554623; 
 Tue, 02 Jan 2024 08:55:54 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4190:ba24:b3c:c06d:9990?
 (p200300cfd73b4190ba240b3cc06d9990.dip0.t-ipconnect.de.
 [2003:cf:d73b:4190:ba24:b3c:c06d:9990])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c510600b0040d5ae2905asm26442134wms.30.2024.01.02.08.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 08:55:54 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------zEzhaS0d0eLVCit0nm0XjfLf"
Message-ID: <dd8f1223-1e84-4c24-abb8-e6019b0ac3d2@redhat.com>
Date: Tue, 2 Jan 2024 17:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Fiona Ebner <f.ebner@proxmox.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
 <CABgObfZcB-0b7-dF1obyUqqdsgjy93d-1rGLaiExzRdZK9hHEA@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CABgObfZcB-0b7-dF1obyUqqdsgjy93d-1rGLaiExzRdZK9hHEA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

This is a multi-part message in MIME format.
--------------zEzhaS0d0eLVCit0nm0XjfLf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.01.24 16:53, Paolo Bonzini wrote:
> On Tue, Jan 2, 2024 at 4:24 PM Hanna Czenczek<hreitz@redhat.com>  wrote:
>> I’ve attached the preliminary patch that I didn’t get to send (or test
>> much) last year.  Not sure if it has the same CPU-usage-spike issue
>> Fiona was seeing, the only functional difference is that I notify the vq
>> after attaching the notifiers instead of before.
> I think the patch makes sense and cleaning up the logic of aio_poll
> (which is one of those functions that grew and grew without much
> clarity into who did what) can be done on top.
>
> Just one small thing, the virtio_queue_notify_vq() call is required
> because the virtqueue interrupt and eventfd are edge-triggered rather
> than level-triggered; so perhaps it should be placed in the
> function(s) that establish the handlers,
> virtio_queue_aio_attach_host_notifier() and
> virtio_queue_aio_attach_host_notifier_no_poll()? Neither
> virtio_blk_drained_end() nor virtio_scsi_drained_end() are
> particularly special, and the comment applies just as well:
>
>      /*
>       * We will have ignored notifications about new requests from the guest
>       * while handlers were not attached, so "kick" the virt queue to process
>       * those requests now.
>       */

I wasn’t entirely whether we want to call notify_vq() if we have 
instated the handlers for the first time (in which case someone ought to 
look for existing unprocessed requests anyway), so I decided to limit it 
to drained_end.

But considering that it must be safe to call notify_vq() right after 
instating the handlers (virtio_queue_host_notifier_read() may then be 
called after all), we might as well do so every time, yes.

Hanna
--------------zEzhaS0d0eLVCit0nm0XjfLf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 02.01.24 16:53, Paolo Bonzini wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CABgObfZcB-0b7-dF1obyUqqdsgjy93d-1rGLaiExzRdZK9hHEA@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Jan 2, 2024 at 4:24 PM Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I’ve attached the preliminary patch that I didn’t get to send (or test
much) last year.  Not sure if it has the same CPU-usage-spike issue
Fiona was seeing, the only functional difference is that I notify the vq
after attaching the notifiers instead of before.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think the patch makes sense and cleaning up the logic of aio_poll
(which is one of those functions that grew and grew without much
clarity into who did what) can be done on top.

Just one small thing, the virtio_queue_notify_vq() call is required
because the virtqueue interrupt and eventfd are edge-triggered rather
than level-triggered; so perhaps it should be placed in the
function(s) that establish the handlers,
virtio_queue_aio_attach_host_notifier() and
virtio_queue_aio_attach_host_notifier_no_poll()? Neither
virtio_blk_drained_end() nor virtio_scsi_drained_end() are
particularly special, and the comment applies just as well:

    /*
     * We will have ignored notifications about new requests from the guest
     * while handlers were not attached, so "kick" the virt queue to process
     * those requests now.
     */
</pre>
    </blockquote>
    <br>
    I wasn’t entirely whether we want to call notify_vq() if we have
    instated the handlers for the first time (in which case someone
    ought to look for existing unprocessed requests anyway), so I
    decided to limit it to drained_end.<br>
    <br>
    But considering that it must be safe to call notify_vq() right after
    instating the handlers (virtio_queue_host_notifier_read() may then
    be called after all), we might as well do so every time, yes.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------zEzhaS0d0eLVCit0nm0XjfLf--


