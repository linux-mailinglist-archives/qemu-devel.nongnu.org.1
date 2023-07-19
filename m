Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55C759854
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM89v-0008Vm-5p; Wed, 19 Jul 2023 10:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM89t-0008VI-8V
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qM89r-0004gT-IT
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689776883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGX4QWWm7upD7fb/KrKBJjhHcZLahxgtZGczTIh5tqc=;
 b=XhCvHCkB+Omi2GFRm9r62WyLFtNO011TuKmgOoatcp4K9SAiDXHG+tVl5KcwAzy75rBYm7
 jKTFLCtEvTNYZ7pO7AnccG+YdC/HTbsZxflDPd7XfBQxrkwK5TADS35L628WdOGEFIFn9q
 XFIz74YAVBaLi5atm3o5g6ciprQLOmA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-XvNXR3nMOHeAGQVVo9LAmQ-1; Wed, 19 Jul 2023 10:28:01 -0400
X-MC-Unique: XvNXR3nMOHeAGQVVo9LAmQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso6236291e87.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689776880; x=1692368880;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGX4QWWm7upD7fb/KrKBJjhHcZLahxgtZGczTIh5tqc=;
 b=BrUh8juJkyyoCfIWziysf5d+Y0SZWgH84F+OuT1sNifPtEyBDX6eMsWglu3QfV7moo
 ZFi4XaZ81FZiCZ11APjQbVjbfiJCtvUz9XlMs+blRMsmuiOdKqx7hxRKBLF9isneIIKi
 GOz8/Eyh/eOvvCYPFkmm3Tn9OyiCCPNANx8V2DfGAGp7VbhZpGwGjaUqq69nn3ifUQ6r
 ILJPbKZXatMuXaC342+9Jr0e2DahWTNfxk4zt4KvQW5ZU6tLzuysLo4pV49Gm4MDNrhn
 PU5lyNJkSHN7U+9Xoufb9MRjcxxZ215wrSxs17g1c1AbGR3vssDwTJD4xHMDCbG64h5E
 lgaA==
X-Gm-Message-State: ABy/qLbrxMvobu/Z4dqUn720xgw4cP3UoApZ4zg6IKRLm4MsqKnSGn8j
 eUaa3295yXgWZjCtFbYjNjrNx+CZ3o85u3h8fohjkaEAWzmmU5pWeBJVWgfFZrzj0n2oeTepIs9
 yPGeP95LDdlRZGmQ=
X-Received: by 2002:a05:6512:78f:b0:4f9:6535:a56 with SMTP id
 x15-20020a056512078f00b004f965350a56mr40173lfr.26.1689776879746; 
 Wed, 19 Jul 2023 07:27:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+jsbGLzDota5nYRlFmpUHfLFxa+K2MT15Iv7PXMdRdj/doGs62rcqiH6f3+9tk86TO9V+gg==
X-Received: by 2002:a05:6512:78f:b0:4f9:6535:a56 with SMTP id
 x15-20020a056512078f00b004f965350a56mr40164lfr.26.1689776879329; 
 Wed, 19 Jul 2023 07:27:59 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 a19-20020aa7cf13000000b00521936fadabsm2757188edy.89.2023.07.19.07.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:27:58 -0700 (PDT)
Message-ID: <0c8e2902-89a0-a9b6-744d-6ab737a0dbb0@redhat.com>
Date: Wed, 19 Jul 2023 16:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-7-hreitz@redhat.com> <20230718151044.GG44841@fedora>
 <7ba1e055-e513-1735-5e60-eceb06fe877a@redhat.com>
In-Reply-To: <7ba1e055-e513-1735-5e60-eceb06fe877a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19.07.23 16:11, Hanna Czenczek wrote:
> On 18.07.23 17:10, Stefan Hajnoczi wrote:
>> On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
>>> The only user of vhost_user_reset_status() is vhost_dev_stop(), which
>>> only uses it as a fall-back to stop the back-end if it does not support
>>> SUSPEND.  However, vhost-user's implementation is a no-op unless the
>>> back-end supports SET_STATUS.
>>>
>>> vhost-vdpa's implementation instead just calls
>>> vhost_vdpa_reset_device(), implying that it's OK to fully reset the
>>> device if SET_STATUS is not supported.
>>>
>>> To be fair, vhost_vdpa_reset_device() does nothing but to set the 
>>> status
>>> to zero.  However, that may well be because vhost-vdpa has no method
>>> besides this to reset a device.  In contrast, vhost-user has
>>> RESET_DEVICE and a RESET_OWNER, which can be used instead.
>>>
>>> While it is not entirely clear from documentation or git logs, from
>>> discussions and the order of vhost-user protocol features, it 
>>> appears to
>>> me as if RESET_OWNER originally had no real meaning for vhost-user, and
>>> was thus used to signal a device reset to the back-end.  Then,
>>> RESET_DEVICE was introduced, to have a well-defined dedicated reset
>>> command.  Finally, vhost-user received full STATUS support, including
>>> SET_STATUS, so setting the device status to 0 is now the preferred way
>>> of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
>>> remain valid as fall-backs.
>>>
>>> Therefore, have vhost_user_reset_status() fall back to
>>> vhost_user_reset_device() if the back-end has no STATUS support.
>>>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> ---
>>>   hw/virtio/vhost-user.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>> index 4507de5a92..53a881ec2a 100644
>>> --- a/hw/virtio/vhost-user.c
>>> +++ b/hw/virtio/vhost-user.c
>>> @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct 
>>> vhost_dev *dev)
>>>       if (virtio_has_feature(dev->protocol_features,
>>>                              VHOST_USER_PROTOCOL_F_STATUS)) {
>>>           vhost_user_set_status(dev, 0);
>>> +    } else {
>>> +        vhost_user_reset_device(dev);
>>>       }
>>>   }
>> Did you check whether DPDK treats setting the status to 0 as equivalent
>> to RESET_DEVICE?
>
> If it doesn’t, what’s even the point of using reset_status?

Sorry, I’m being unclear, and I think this may be important because it 
ties into the question from patch 1, what qemu is even trying to do by 
running SET_STATUS(0) vhost_dev_stop(), so here’s what gave me the 
impression that SET_STATUS(0) and RESET_DEVICE should be equivalent:

vhost-vdpa.c runs SET_STATUS(0) in a function called 
vhost_vdpa_reset_device().  This is one thing that gave me the 
impression that this is about an actual full reset.

Another is the whole discussion that we’ve had.  vhost_dev_stop() does 
not call a `vhost_reset_device()` function, it calls 
`vhost_reset_status()`.  Still, we were always talking about resetting 
the device.

It doesn’t make sense to me that vDPA would provide no function to fully 
reset a device, while vhost-user does.  Being able to reset a device 
sounds vital to me.  This also gave me the impression that SET_STATUS(0) 
on vDPA at least is functionally equivalent to a full device reset.

Maybe SET_STATUS(0) does mean a full device reset on vDPA, but not on 
vhost-user.  That would be a real shame, so I assumed this would not be 
the case; that SET_STATUS(0) does the same thing on both protocols.

The virtio specification says “Writing 0 into this field resets the 
device.” about the device_status field.

This also makes sense, because the device_status field is basically used 
to tell the device that a driver has taken control.  If reset, this 
indicates the driver has given up control, and to me this is a point 
where a device should fully reset itself.

So all in all, I can’t see the rationale why any implementation that 
supports SET_STATUS would decide to treat SET_STATUS(0) not as 
equivalent or a superset of RESET_DEVICE.  I may be wrong, and this 
might explain a whole deal about what kind of background operations we 
hope to stop with SET_STATUS(0).

Hanna


