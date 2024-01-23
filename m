Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE40A838D61
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:26:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSEue-0005Lx-MP; Tue, 23 Jan 2024 06:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSEuM-0005Go-Ul
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rSEuH-0006xq-Gz
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 06:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706009127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IgL7xkE/ZFGFm35Oqp6i0tcdRHexgi2JIIMynUsVSI=;
 b=PV3hMuLoKbvJPmru1PSTKrBDmnEKxdvcZtfP6+b+URdCtsmWGI7GJWfxNHlz568RkRSiUw
 VPKOQdF8YUIexAT43Jl/eUfmgyphAileXGhKJ98y6IWpWQ8FwEQvGJfCafcMc1TPcSabVf
 Alodrt6eqnlFI5Ygq2mVJgfW6lNW5Yc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-ytxrr_euNo6wWL2o2NneBQ-1; Tue, 23 Jan 2024 06:25:23 -0500
X-MC-Unique: ytxrr_euNo6wWL2o2NneBQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40eaedb4446so15140725e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 03:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706009122; x=1706613922;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4IgL7xkE/ZFGFm35Oqp6i0tcdRHexgi2JIIMynUsVSI=;
 b=SR5ReZiD2a4Z4mu7OFeuf3MtPf0wxi1dcn17IuRyX7cMasjWjvwopmzg0tbYxet+K8
 zIsfpX1xT5GBRj6HNhSdIHTvR+Vvkdl9m2owgPbIiOX0B7OFxgkStXP+XK4Vj3qwjf5E
 B71J+QSznNhLO98O50Pltm2RdtLyJaOxGUb/RhoB1Jm4h49ao6ynXVjqelyomML9FupI
 TalBHLjqjqcDE9zUUSW+2TN5SVrbR3xdLBS9Mmdmfe5T0JbfAF4UXKRHkwH46Xw/T9oP
 pAxtP/Y9S/aXUNGJ28aSr+uZD1CKko6U3OKAR0/4Ba4Fpcj4QO7RXmJYxugbk2iAsRkj
 YjaA==
X-Gm-Message-State: AOJu0Yz7JvcQDOUnH2//VFJzvWMW7GoUP11zRl+NHUp8heonbUkWtUC0
 zLXMP2wjDEFF98YqXj+RJ4aBdvaXRtSohq8ad4xXlNiac+BahiuuYXKf83EL210iAKgSx23KYz/
 btOAdE51WDt/cILSFcb6GypNx4FDNk6fwUF49zyrnh4IBaI5a/rU7
X-Received: by 2002:a7b:cb87:0:b0:40e:b2b2:d2 with SMTP id
 m7-20020a7bcb87000000b0040eb2b200d2mr25437wmi.134.1706009122151; 
 Tue, 23 Jan 2024 03:25:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtS6PIH+rjwJFfsRg6kAbldbVhRtYX2TbK9sjCoRBdqCPrLH7B9IDSjFxuVLQyXokOJdKHYw==
X-Received: by 2002:a7b:cb87:0:b0:40e:b2b2:d2 with SMTP id
 m7-20020a7bcb87000000b0040eb2b200d2mr25430wmi.134.1706009121865; 
 Tue, 23 Jan 2024 03:25:21 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4143:2bf6:228a:1b7a:e384?
 (p200300cfd73b41432bf6228a1b7ae384.dip0.t-ipconnect.de.
 [2003:cf:d73b:4143:2bf6:228a:1b7a:e384])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c3b9200b0040e4ca7fcb4sm42388131wms.37.2024.01.23.03.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 03:25:21 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------aJ7CF4e8iHwij30aUT0D9MKL"
Message-ID: <b609e36e-62ab-40d0-b51a-3717f90a51e5@redhat.com>
Date: Tue, 23 Jan 2024 12:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
 <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
 <94db88e7-1f02-44dd-bc2c-3d9ccf1cce72@redhat.com>
 <bfc7b20c-2144-46e9-acbc-e726276c5a31@proxmox.com>
 <67a36617-9e61-4778-aebf-1e667cb51120@proxmox.com>
 <3bb5aa0e-ae0a-4fda-a5b5-1bfac86651ac@redhat.com>
 <e281e717-f416-47d2-aef4-d08b327122ef@redhat.com>
 <8a32f350-e69a-458a-be4e-1d3335e696c6@proxmox.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <8a32f350-e69a-458a-be4e-1d3335e696c6@proxmox.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

This is a multi-part message in MIME format.
--------------aJ7CF4e8iHwij30aUT0D9MKL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.01.24 12:12, Fiona Ebner wrote:

[...]

> I noticed poll_set_started() is not called, because
> ctx->fdmon_ops->need_wait(ctx) was true, i.e. ctx->poll_disable_cnt was
> positive (I'm using fdmon_poll). I then found this is because of the
> notifier for the event vq, being attached with
>
>> virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);
> in virtio_scsi_dataplane_start(). But in virtio_scsi_drained_end() it is
> attached with virtio_queue_aio_attach_host_notifier() instead of the
> _no_poll() variant. So that might be the actual issue here?
>
>  From a quick test, I cannot see the CPU-usage-spike issue with the
> following either:
>
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 690aceec45..ba1ab8e410 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -1166,7 +1166,15 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>>   
>>       for (uint32_t i = 0; i < total_queues; i++) {
>>           VirtQueue *vq = virtio_get_queue(vdev, i);
>> -        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
>> +        if (!virtio_queue_get_notification(vq)) {
>> +            virtio_queue_set_notification(vq, true);
>> +        }
>> +        if (vq == VIRTIO_SCSI_COMMON(s)->event_vq) {
>> +            virtio_queue_aio_attach_host_notifier_no_poll(vq, s->ctx);
>> +        } else {
>> +            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
>> +        }
>> +        virtio_queue_notify(vdev, i);
>>       }
>>   }

Perfect, so we agree on trying it that way. :)

Hanna
--------------aJ7CF4e8iHwij30aUT0D9MKL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 23.01.24 12:12, Fiona Ebner wrote:<br>
      <br>
      [...]<br>
      <br>
    </div>
    <blockquote type="cite"
      cite="mid:8a32f350-e69a-458a-be4e-1d3335e696c6@proxmox.com"><span
      style="white-space: pre-wrap">
</span>
      <pre class="moz-quote-pre" wrap="">I noticed poll_set_started() is not called, because
ctx-&gt;fdmon_ops-&gt;need_wait(ctx) was true, i.e. ctx-&gt;poll_disable_cnt was
positive (I'm using fdmon_poll). I then found this is because of the
notifier for the event vq, being attached with

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">virtio_queue_aio_attach_host_notifier_no_poll(vs-&gt;event_vq, s-&gt;ctx);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
in virtio_scsi_dataplane_start(). But in virtio_scsi_drained_end() it is
attached with virtio_queue_aio_attach_host_notifier() instead of the
_no_poll() variant. So that might be the actual issue here?

From a quick test, I cannot see the CPU-usage-spike issue with the
following either:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 690aceec45..ba1ab8e410 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1166,7 +1166,15 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
 
     for (uint32_t i = 0; i &lt; total_queues; i++) {
         VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_attach_host_notifier(vq, s-&gt;ctx);
+        if (!virtio_queue_get_notification(vq)) {
+            virtio_queue_set_notification(vq, true);
+        }
+        if (vq == VIRTIO_SCSI_COMMON(s)-&gt;event_vq) {
+            virtio_queue_aio_attach_host_notifier_no_poll(vq, s-&gt;ctx);
+        } else {
+            virtio_queue_aio_attach_host_notifier(vq, s-&gt;ctx);
+        }
+        virtio_queue_notify(vdev, i);
     }
 }
</pre>
      </blockquote>
    </blockquote>
    <br>
    Perfect, so we agree on trying it that way. :)<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------aJ7CF4e8iHwij30aUT0D9MKL--


