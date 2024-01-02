Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D9D821EAA
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 16:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKge0-0006ny-NM; Tue, 02 Jan 2024 10:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rKgdy-0006nS-Gm
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:25:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rKgdw-0004TX-69
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 10:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704209122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Hp4Lu9G8Kw6G4WkdG/9mADL+7JI25TFqjMHwmg1SK8=;
 b=MTpiblAyCLqIJjy4szD050UGZHTsRsFHW0iLnrB796dsDdpjwd3HFBOPYM6nkKk6A8vS0U
 xlnSnd51xZVk5jGTbXWFQkUIrf/HMzew4XBfm1VHUMoUPmRWFvNTkAMk8IWIPB1GUZTWUE
 bbH2wXPq6zRs19wGuLLGGBeP1CBnt2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-R58LablYPdmdGmcsY6MY2g-1; Tue, 02 Jan 2024 10:24:14 -0500
X-MC-Unique: R58LablYPdmdGmcsY6MY2g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3368250f2a3so6983026f8f.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 07:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704209053; x=1704813853;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6Hp4Lu9G8Kw6G4WkdG/9mADL+7JI25TFqjMHwmg1SK8=;
 b=hYxnOR2G7myHUXuJiRG8EqQh5RtkXrxAVf5ilEx9odtInXCIVw4jRIDUk9CRIq1eFg
 i3eILntcs96mQzfdcZeZlkSiSl4fD4oXK3oG1ysOm3ZSjXazst9RXVM13ktjEuZ76Wc2
 Sq+bwv3t1xGzDjoCLG89752FDZvKVoHoqLn6T3CRs/Kb+Os0OopLbqOeYNlyFKCWcxU8
 nqACfp1Wgm/hvyGRjNW9Bi/DHR+LcHr1AJEhShsSH02nrjRIO2BWH0cRoikeAbzcVUlm
 N6nwlyiFHfbra5sqcfHc8VQWVV7qn20fnGeHw2cLEag6Ge31bNwaUrc5CEROM09MiDbj
 rG9w==
X-Gm-Message-State: AOJu0Yx8Ab/u7Fdne7XVqZdV5eu2Jr/Pb/vawF481qjfv72P1Wn+msXH
 aAHWzR/BIjlRbryMiowpQqimJKeygylgjoTyQtiauuxNvppe5dsJ2hyVo/z+8j+nH8FYitv5Jfd
 uCWBY+q/x+XKPxOsxoE1CSI0=
X-Received: by 2002:adf:e5ca:0:b0:336:737a:db37 with SMTP id
 a10-20020adfe5ca000000b00336737adb37mr4064978wrn.148.1704209053552; 
 Tue, 02 Jan 2024 07:24:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/7s8CJSoJ7+UIOuZbEsFaCCuDy9MBj6B8sKPFMYJ7F5bne/Nj50gXDvtMCdKNoPUU79TCnw==
X-Received: by 2002:adf:e5ca:0:b0:336:737a:db37 with SMTP id
 a10-20020adfe5ca000000b00336737adb37mr4064972wrn.148.1704209053223; 
 Tue, 02 Jan 2024 07:24:13 -0800 (PST)
Received: from ?IPV6:2003:cf:d73b:4190:ba24:b3c:c06d:9990?
 (p200300cfd73b4190ba240b3cc06d9990.dip0.t-ipconnect.de.
 [2003:cf:d73b:4190:ba24:b3c:c06d:9990])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm28565280wrj.112.2024.01.02.07.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 07:24:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------pp3N5wRGekeQI0sEpMPPl4hj"
Message-ID: <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
Date: Tue, 2 Jan 2024 16:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 pbonzini@redhat.com, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

This is a multi-part message in MIME format.
--------------pp3N5wRGekeQI0sEpMPPl4hj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.12.23 22:15, Stefan Hajnoczi wrote:
> Hanna and Fiona encountered a bug in aio_set_fd_handler(): there is no matching
> io_poll_end() call upon removing an AioHandler when io_poll_begin() was
> previously called. The missing io_poll_end() call leaves virtqueue
> notifications disabled and the virtqueue's ioeventfd will never become
> readable anymore.
>
> The details of how virtio-scsi devices using IOThreads can hang after
> hotplug/unplug are covered here:
> https://issues.redhat.com/browse/RHEL-3934
>
> Hanna is currently away over the December holidays. I'm sending these RFC
> patches in the meantime. They demonstrate running aio_set_fd_handler() in the
> AioContext home thread and adding the missing io_poll_end() call.

I agree with Paolo that if the handlers are removed, the caller probably 
isn’t interested in notifications: In our specific case, we remove the 
handlers because the device is to be drained, so we won’t poll the 
virtqueue anyway.  Therefore, if io_poll_end() is to be called to 
complete the start-end pair, it shouldn’t be done when the handlers are 
removed, but instead when they are reinstated.

I believe that’s quite infeasible to do in generic code: We’d have to 
basically remember that we haven’t called a specific io_poll_end 
callback yet, and so once it is reinstated while we’re not in a polling 
phase, we would need to call it then.  That in itself is already hairy, 
but in addition, the callback consists of a function pointer and an 
opaque pointer, and it seems impossible to reliably establish identity 
between two opaque pointers to know whether a newly instated io_poll_end 
callback is the same one as one that had been removed before (pointer 
identity may work, but also may not).

That’s why I think the responsibility should fall on the caller.  I 
believe both virtio_queue_aio_attach_host_notifier*() functions should 
enable vq notifications before instating the handler – if we’re in 
polling mode, io_poll_start() will then immediately be called and 
disable vq notifications again.  Having them enabled briefly shouldn’t 
hurt anything but performance (which I don’t think is terrible in the 
drain case).  For completeness’ sake, we may even have 
virtio_queue_aio_detach_host_notifier() disable vq notifications, 
because otherwise it’s unknown whether notifications are enabled or 
disabled after removing the notifiers.  That isn’t terrible, but I think 
(A) if any of the two, we want them to be disabled, because we won’t 
check for requests anyway, and (B) this gives us a clearer state 
machine, where removing the notifiers will always leave vq notifications 
disabled, so when they are reinstated (i.e. when calling 
virtio_queue_aio_attach_host_notifier*()), it’s clear that we must poll 
once to check for new requests.

I’ve attached the preliminary patch that I didn’t get to send (or test 
much) last year.  Not sure if it has the same CPU-usage-spike issue 
Fiona was seeing, the only functional difference is that I notify the vq 
after attaching the notifiers instead of before.

Hanna
--------------pp3N5wRGekeQI0sEpMPPl4hj
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-Keep-notifications-disabled-during-drain.patch"
Content-Disposition: attachment;
 filename="0001-Keep-notifications-disabled-during-drain.patch"
Content-Transfer-Encoding: base64

RnJvbSA0NTFhYWU3NGZjMTlhNmVhNWNkNjM4MTI0N2NkOTIwMjU3MTY1MWU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uYSBDemVuY3playA8aHJlaXR6QHJlZGhhdC5j
b20+CkRhdGU6IFdlZCwgNiBEZWMgMjAyMyAxODoyNDo1NSArMDEwMApTdWJqZWN0OiBbUEFU
Q0hdIEtlZXAgbm90aWZpY2F0aW9ucyBkaXNhYmxlZCBkdXJpbmcgZHJhaW4KClByZWxpbWlu
YXJ5IHBhdGNoIHdpdGggYSBwcmVsaW1pbmFyeSBkZXNjcmlwdGlvbjogRHVyaW5nIGRyYWlu
LCB3ZSBkbwpub3QgY2FyZSBhYm91dCB2aXJ0cXVldWUgbm90aWZpY2F0aW9ucywgd2hpY2gg
aXMgd2h5IHdlIHJlbW92ZSB0aGUKaGFuZGxlcnMgb24gaXQuICBXaGVuIHJlbW92aW5nIHRo
b3NlIGhhbmRsZXJzLCB3aGV0aGVyIHZxIG5vdGlmaWNhdGlvbnMKYXJlIGVuYWJsZWQgb3Ig
bm90IGRlcGVuZHMgb24gd2hldGhlciB3ZSB3ZXJlIGluIHBvbGxpbmcgbW9kZSBvciBub3Q7
IGlmCm5vdCwgdGhleSBhcmUgZW5hYmxlZCAoYnkgZGVmYXVsdCk7IGlmIHNvLCB0aGV5IGhh
dmUgYmVlbiBkaXNhYmxlZCBieQp0aGUgaW9fcG9sbF9zdGFydCBjYWxsYmFjay4KCklkZWFs
bHksIHdlIHdvdWxkIHJhdGhlciBoYXZlIHRoZSB2cSBub3RpZmljYXRpb25zIGJlIGRpc2Fi
bGVkLCBiZWNhdXNlCndlIHdpbGwgbm90IHByb2Nlc3MgcmVxdWVzdHMgZHVyaW5nIGEgZHJh
aW5lZCBzZWN0aW9uIGFueXdheS4KVGhlcmVmb3JlLCBoYXZlIHZpcnRpb19xdWV1ZV9haW9f
ZGV0YWNoX2hvc3Rfbm90aWZpZXIoKSBleHBsaWNpdGx5CmRpc2FibGUgdGhlbSwgYW5kIHZp
cnRpb19xdWV1ZV9haW9fYXR0YWNoX2hvc3Rfbm90aWZpZXIqKCkgcmUtZW5hYmxlCnRoZW0g
KGlmIHdlIGFyZSBpbiBhIHBvbGxpbmcgc2VjdGlvbiwgYXR0YWNoaW5nIHRoZW0gd2lsbCBp
bnZva2UgdGhlCmlvX3BvbGxfc3RhcnQgY2FsbGJhY2ssIHdoaWNoIHdpbGwgcmUtZGlzYWJs
ZSB0aGVtKS4KCkJlY2F1c2Ugd2Ugd2lsbCBtaXNzIHZpcnRxdWV1ZSB1cGRhdGVzIGluIHRo
ZSBkcmFpbmVkIHNlY3Rpb24sIHdlIGFsc28KbmVlZCB0byBwb2xsIHRoZSB2aXJ0cXVldWUg
b25jZSBpbiB0aGUgZHJhaW5lZF9lbmQgZnVuY3Rpb25zIGFmdGVyCmF0dGFjaGluZyB0aGUg
bm90aWZpZXJzLgotLS0KIGluY2x1ZGUvYmxvY2svYWlvLmggICAgICAgIHwgIDcgKysrKysr
LQogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLmggfCAgMSArCiBody9ibG9jay92aXJ0aW8t
YmxrLmMgICAgICB8IDEwICsrKysrKysrKysKIGh3L3Njc2kvdmlydGlvLXNjc2kuYyAgICAg
IHwgMTAgKysrKysrKysrKwogaHcvdmlydGlvL3ZpcnRpby5jICAgICAgICAgfCAzMCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0KIDUgZmlsZXMgY2hhbmdlZCwgNTYgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Jsb2NrL2Fp
by5oIGIvaW5jbHVkZS9ibG9jay9haW8uaAppbmRleCBmMDhiMzU4MDc3Li43OTVhMzc1ZmYy
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2Jsb2NrL2Fpby5oCisrKyBiL2luY2x1ZGUvYmxvY2sv
YWlvLmgKQEAgLTQ5Nyw5ICs0OTcsMTQgQEAgdm9pZCBhaW9fc2V0X2V2ZW50X25vdGlmaWVy
KEFpb0NvbnRleHQgKmN0eCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBaW9Qb2xs
Rm4gKmlvX3BvbGwsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXZlbnROb3RpZmll
ckhhbmRsZXIgKmlvX3BvbGxfcmVhZHkpOwogCi0vKiBTZXQgcG9sbGluZyBiZWdpbi9lbmQg
Y2FsbGJhY2tzIGZvciBhbiBldmVudCBub3RpZmllciB0aGF0IGhhcyBhbHJlYWR5IGJlZW4K
Ky8qCisgKiBTZXQgcG9sbGluZyBiZWdpbi9lbmQgY2FsbGJhY2tzIGZvciBhbiBldmVudCBu
b3RpZmllciB0aGF0IGhhcyBhbHJlYWR5IGJlZW4KICAqIHJlZ2lzdGVyZWQgd2l0aCBhaW9f
c2V0X2V2ZW50X25vdGlmaWVyLiAgRG8gbm90aGluZyBpZiB0aGUgZXZlbnQgbm90aWZpZXIg
aXMKICAqIG5vdCByZWdpc3RlcmVkLgorICoKKyAqIE5vdGUgdGhhdCBpZiB0aGUgaW9fcG9s
bF9lbmQoKSBjYWxsYmFjayAob3IgdGhlIGVudGlyZSBub3RpZmllcikgaXMgcmVtb3ZlZAor
ICogZHVyaW5nIHBvbGxpbmcsIGl0IHdpbGwgbm90IGJlIGNhbGxlZCwgc28gYW4gaW9fcG9s
bF9iZWdpbigpIGlzIG5vdAorICogbmVjZXNzYXJpbHkgYWx3YXlzIGZvbGxvd2VkIGJ5IGFu
IGlvX3BvbGxfZW5kKCkuCiAgKi8KIHZvaWQgYWlvX3NldF9ldmVudF9ub3RpZmllcl9wb2xs
KEFpb0NvbnRleHQgKmN0eCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEV2
ZW50Tm90aWZpZXIgKm5vdGlmaWVyLApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8v
dmlydGlvLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaAppbmRleCBjOGY3Mjg1MGJj
Li42NGU2NmJlYTJkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaAor
KysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaApAQCAtMzM1LDYgKzMzNSw3IEBAIHZv
aWQgdmlydGlvX3F1ZXVlX3VwZGF0ZV9yaW5ncyhWaXJ0SU9EZXZpY2UgKnZkZXYsIGludCBu
KTsKIHZvaWQgdmlydGlvX2luaXRfcmVnaW9uX2NhY2hlKFZpcnRJT0RldmljZSAqdmRldiwg
aW50IG4pOwogdm9pZCB2aXJ0aW9fcXVldWVfc2V0X2FsaWduKFZpcnRJT0RldmljZSAqdmRl
diwgaW50IG4sIGludCBhbGlnbik7CiB2b2lkIHZpcnRpb19xdWV1ZV9ub3RpZnkoVmlydElP
RGV2aWNlICp2ZGV2LCBpbnQgbik7Cit2b2lkIHZpcnRpb19xdWV1ZV9ub3RpZnlfdnEoVmly
dFF1ZXVlICp2cSk7CiB1aW50MTZfdCB2aXJ0aW9fcXVldWVfdmVjdG9yKFZpcnRJT0Rldmlj
ZSAqdmRldiwgaW50IG4pOwogdm9pZCB2aXJ0aW9fcXVldWVfc2V0X3ZlY3RvcihWaXJ0SU9E
ZXZpY2UgKnZkZXYsIGludCBuLCB1aW50MTZfdCB2ZWN0b3IpOwogaW50IHZpcnRpb19xdWV1
ZV9zZXRfaG9zdF9ub3RpZmllcl9tcihWaXJ0SU9EZXZpY2UgKnZkZXYsIGludCBuLApkaWZm
IC0tZ2l0IGEvaHcvYmxvY2svdmlydGlvLWJsay5jIGIvaHcvYmxvY2svdmlydGlvLWJsay5j
CmluZGV4IGExZjhlMTU1MjIuLjY4ZGFkOGNmNDggMTAwNjQ0Ci0tLSBhL2h3L2Jsb2NrL3Zp
cnRpby1ibGsuYworKysgYi9ody9ibG9jay92aXJ0aW8tYmxrLmMKQEAgLTE1MzgsNiArMTUz
OCwxNiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fYmxrX2RyYWluZWRfZW5kKHZvaWQgKm9wYXF1
ZSkKICAgICBmb3IgKHVpbnQxNl90IGkgPSAwOyBpIDwgcy0+Y29uZi5udW1fcXVldWVzOyBp
KyspIHsKICAgICAgICAgVmlydFF1ZXVlICp2cSA9IHZpcnRpb19nZXRfcXVldWUodmRldiwg
aSk7CiAgICAgICAgIHZpcnRpb19xdWV1ZV9haW9fYXR0YWNoX2hvc3Rfbm90aWZpZXIodnEs
IGN0eCk7CisKKyAgICAgICAgLyoKKyAgICAgICAgICogV2Ugd2lsbCBoYXZlIGlnbm9yZWQg
bm90aWZpY2F0aW9ucyBhYm91dCBuZXcgcmVxdWVzdHMgZnJvbSB0aGUgZ3Vlc3QKKyAgICAg
ICAgICogZHVyaW5nIHRoZSBkcmFpbiwgc28gImtpY2siIHRoZSB2aXJ0IHF1ZXVlIHRvIHBy
b2Nlc3MgdGhvc2UgcmVxdWVzdHMKKyAgICAgICAgICogbm93LgorICAgICAgICAgKiBPdXIg
LmhhbmRsZV9vdXRwdXQgY2FsbGJhY2sgKHZpcnRpb19ibGtfaGFuZGxlX291dHB1dCgpIC0+
CisgICAgICAgICAqIHZpcnRpb19ibGtfaGFuZGxlX3ZxKCkpIGFjcXVpcmVzIHRoZSBBaW9D
b250ZXh0LCBzbyB0aGlzIHNob3VsZCBiZQorICAgICAgICAgKiBzYWZlIHRvIGNhbGwgZnJv
bSBhbnkgY29udGV4dC4KKyAgICAgICAgICovCisgICAgICAgIHZpcnRpb19xdWV1ZV9ub3Rp
ZnlfdnEodnEpOwogICAgIH0KIH0KIApkaWZmIC0tZ2l0IGEvaHcvc2NzaS92aXJ0aW8tc2Nz
aS5jIGIvaHcvc2NzaS92aXJ0aW8tc2NzaS5jCmluZGV4IDljNzUxYmYyOTYuLjkyMzRiZWE3
ZTggMTAwNjQ0Ci0tLSBhL2h3L3Njc2kvdmlydGlvLXNjc2kuYworKysgYi9ody9zY3NpL3Zp
cnRpby1zY3NpLmMKQEAgLTExNjcsNiArMTE2NywxNiBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9f
c2NzaV9kcmFpbmVkX2VuZChTQ1NJQnVzICpidXMpCiAgICAgZm9yICh1aW50MzJfdCBpID0g
MDsgaSA8IHRvdGFsX3F1ZXVlczsgaSsrKSB7CiAgICAgICAgIFZpcnRRdWV1ZSAqdnEgPSB2
aXJ0aW9fZ2V0X3F1ZXVlKHZkZXYsIGkpOwogICAgICAgICB2aXJ0aW9fcXVldWVfYWlvX2F0
dGFjaF9ob3N0X25vdGlmaWVyKHZxLCBzLT5jdHgpOworCisgICAgICAgIC8qCisgICAgICAg
ICAqIFdlIHdpbGwgaGF2ZSBpZ25vcmVkIG5vdGlmaWNhdGlvbnMgYWJvdXQgbmV3IHJlcXVl
c3RzIGZyb20gdGhlIGd1ZXN0CisgICAgICAgICAqIGR1cmluZyB0aGUgZHJhaW4sIHNvICJr
aWNrIiB0aGUgdmlydCBxdWV1ZSB0byBwcm9jZXNzIHRob3NlIHJlcXVlc3RzCisgICAgICAg
ICAqIG5vdy4KKyAgICAgICAgICogT3VyIC5oYW5kbGVfb3V0cHV0IGNhbGxiYWNrcyAodmly
dGlvX3Njc2lfaGFuZGxlX3tjdHJsLGNtZCx2cX0pIHVzZQorICAgICAgICAgKiB2aXJ0aW9f
c2NzaV9hY3F1aXJlKCksIHNvIHRoaXMgc2hvdWxkIGJlIHNhZmUgdG8gY2FsbCBmcm9tIGFu
eQorICAgICAgICAgKiBjb250ZXh0LgorICAgICAgICAgKi8KKyAgICAgICAgdmlydGlvX3F1
ZXVlX25vdGlmeV92cSh2cSk7CiAgICAgfQogfQogCmRpZmYgLS1naXQgYS9ody92aXJ0aW8v
dmlydGlvLmMgYi9ody92aXJ0aW8vdmlydGlvLmMKaW5kZXggZTUxMDU1NzFjZi4uZjUxNTEx
NTA2OSAxMDA2NDQKLS0tIGEvaHcvdmlydGlvL3ZpcnRpby5jCisrKyBiL2h3L3ZpcnRpby92
aXJ0aW8uYwpAQCAtMjI1NSw3ICsyMjU1LDcgQEAgdm9pZCB2aXJ0aW9fcXVldWVfc2V0X2Fs
aWduKFZpcnRJT0RldmljZSAqdmRldiwgaW50IG4sIGludCBhbGlnbikKICAgICB9CiB9CiAK
LXN0YXRpYyB2b2lkIHZpcnRpb19xdWV1ZV9ub3RpZnlfdnEoVmlydFF1ZXVlICp2cSkKK3Zv
aWQgdmlydGlvX3F1ZXVlX25vdGlmeV92cShWaXJ0UXVldWUgKnZxKQogewogICAgIGlmICh2
cS0+dnJpbmcuZGVzYyAmJiB2cS0+aGFuZGxlX291dHB1dCkgewogICAgICAgICBWaXJ0SU9E
ZXZpY2UgKnZkZXYgPSB2cS0+dmRldjsKQEAgLTM1NTYsNiArMzU1NiwxNyBAQCBzdGF0aWMg
dm9pZCB2aXJ0aW9fcXVldWVfaG9zdF9ub3RpZmllcl9haW9fcG9sbF9lbmQoRXZlbnROb3Rp
ZmllciAqbikKIAogdm9pZCB2aXJ0aW9fcXVldWVfYWlvX2F0dGFjaF9ob3N0X25vdGlmaWVy
KFZpcnRRdWV1ZSAqdnEsIEFpb0NvbnRleHQgKmN0eCkKIHsKKyAgICAvKgorICAgICAqIHZp
cnRpb19xdWV1ZV9haW9fZGV0YWNoX2hvc3Rfbm90aWZpZXIoKSBsZWF2ZXMgbm90aWZpY2F0
aW9ucyBkaXNhYmxlZC4KKyAgICAgKiBSZS1lbmFibGUgdGhlbS4gIChBbmQgaWYgZGV0YWNo
IGhhcyBub3QgYmVlbiB1c2VkIGJlZm9yZSwgbm90aWZpY2F0aW9ucworICAgICAqIGJlaW5n
IGVuYWJsZWQgaXMgc3RpbGwgdGhlIGRlZmF1bHQgc3RhdGUgd2hpbGUgYSBub3RpZmllciBp
cyBhdHRhY2hlZDsKKyAgICAgKiBzZWUgdmlydGlvX3F1ZXVlX2hvc3Rfbm90aWZpZXJfYWlv
X3BvbGxfZW5kKCksIHdoaWNoIHdpbGwgYWx3YXlzIGxlYXZlCisgICAgICogbm90aWZpY2F0
aW9ucyBlbmFibGVkIG9uY2UgdGhlIHBvbGxpbmcgc2VjdGlvbiBpcyBsZWZ0LikKKyAgICAg
Ki8KKyAgICBpZiAoIXZpcnRpb19xdWV1ZV9nZXRfbm90aWZpY2F0aW9uKHZxKSkgeworICAg
ICAgICB2aXJ0aW9fcXVldWVfc2V0X25vdGlmaWNhdGlvbih2cSwgMSk7CisgICAgfQorCiAg
ICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZ2cS0+aG9zdF9ub3RpZmllciwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRpb19xdWV1ZV9ob3N0X25vdGlmaWVyX3Jl
YWQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICB2aXJ0aW9fcXVldWVfaG9zdF9ub3Rp
Zmllcl9haW9fcG9sbCwKQEAgLTM1NzMsNiArMzU4NCwxMCBAQCB2b2lkIHZpcnRpb19xdWV1
ZV9haW9fYXR0YWNoX2hvc3Rfbm90aWZpZXIoVmlydFF1ZXVlICp2cSwgQWlvQ29udGV4dCAq
Y3R4KQogICovCiB2b2lkIHZpcnRpb19xdWV1ZV9haW9fYXR0YWNoX2hvc3Rfbm90aWZpZXJf
bm9fcG9sbChWaXJ0UXVldWUgKnZxLCBBaW9Db250ZXh0ICpjdHgpCiB7CisgICAgaWYgKCF2
aXJ0aW9fcXVldWVfZ2V0X25vdGlmaWNhdGlvbih2cSkpIHsKKyAgICAgICAgdmlydGlvX3F1
ZXVlX3NldF9ub3RpZmljYXRpb24odnEsIDEpOworICAgIH0KKwogICAgIGFpb19zZXRfZXZl
bnRfbm90aWZpZXIoY3R4LCAmdnEtPmhvc3Rfbm90aWZpZXIsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2aXJ0aW9fcXVldWVfaG9zdF9ub3RpZmllcl9yZWFkLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlVMTCwgTlVMTCk7CkBAIC0zNTgxLDYgKzM1OTYsMTkgQEAg
dm9pZCB2aXJ0aW9fcXVldWVfYWlvX2F0dGFjaF9ob3N0X25vdGlmaWVyX25vX3BvbGwoVmly
dFF1ZXVlICp2cSwgQWlvQ29udGV4dCAqY3QKIHZvaWQgdmlydGlvX3F1ZXVlX2Fpb19kZXRh
Y2hfaG9zdF9ub3RpZmllcihWaXJ0UXVldWUgKnZxLCBBaW9Db250ZXh0ICpjdHgpCiB7CiAg
ICAgYWlvX3NldF9ldmVudF9ub3RpZmllcihjdHgsICZ2cS0+aG9zdF9ub3RpZmllciwgTlVM
TCwgTlVMTCwgTlVMTCk7CisKKyAgICAvKgorICAgICAqIGFpb19zZXRfZXZlbnRfbm90aWZp
ZXJfcG9sbCgpIGRvZXMgbm90IGd1YXJhbnRlZSB3aGV0aGVyIGlvX3BvbGxfZW5kKCkKKyAg
ICAgKiB3aWxsIHJ1biBhZnRlciBpb19wb2xsX2JlZ2luKCksIHNvIGJ5IHJlbW92aW5nIHRo
ZSBub3RpZmllciwgd2UgZG8gbm90CisgICAgICoga25vdyB3aGV0aGVyIHZpcnRpb19xdWV1
ZV9ob3N0X25vdGlmaWVyX2Fpb19wb2xsX2VuZCgpIGhhcyBydW4gYWZ0ZXIgYQorICAgICAq
IHByZXZpb3VzIHZpcnRpb19xdWV1ZV9ob3N0X25vdGlmaWVyX2Fpb19wb2xsX2JlZ2luKCks
IGkuZS4gd2hldGhlcgorICAgICAqIG5vdGlmaWNhdGlvbnMgYXJlIGVuYWJsZWQgb3IgZGlz
YWJsZWQuICBXZSBqdXN0IHJlbW92ZWQgdGhlIG5vdGlmaWVyLCBzbworICAgICAqIHdlIG1h
eSBhcyB3ZWxsIGRpc2FibGUgbm90aWZpY2F0aW9ucy4gIFRoZSBhdHRhY2hfaG9zdF9ub3Rp
ZmllciBmdW5jdGlvbnMKKyAgICAgKiB3aWxsIHJlLWVuYWJsZSB0aGVtLgorICAgICAqLwor
ICAgIGlmICh2aXJ0aW9fcXVldWVfZ2V0X25vdGlmaWNhdGlvbih2cSkpIHsKKyAgICAgICAg
dmlydGlvX3F1ZXVlX3NldF9ub3RpZmljYXRpb24odnEsIDApOworICAgIH0KIH0KIAogdm9p
ZCB2aXJ0aW9fcXVldWVfaG9zdF9ub3RpZmllcl9yZWFkKEV2ZW50Tm90aWZpZXIgKm4pCi0t
IAoyLjQzLjAKCg==

--------------pp3N5wRGekeQI0sEpMPPl4hj--


