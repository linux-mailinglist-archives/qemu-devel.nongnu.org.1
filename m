Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4777084D8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfXo-0001LN-CW; Thu, 18 May 2023 11:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfXl-0001L1-VY
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfXj-0003z0-Mx
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684423670;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RVsWedMGqMQr6bM4ca41H/pcxJaQD1wOcUTf6g/yiVg=;
 b=G+1FDx1LQrrj+Ya9d+yCSvs+cmuBdqhmMD1u3hZ2NgiS4RnAkDAaldHHhm3Dv7+o41u+oc
 Z3j+CrhkuIMzxyBEFCtdj6fLqVoqnWEWHwUeiqi5dW6MmwlDAQpXiCe8ftbzzTtOLZFuFJ
 EsFBg9gbQNICZiDwsbHip0be0b4hHYE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-4R-kwjFyMeCIB5fyc7vuXg-1; Thu, 18 May 2023 11:27:49 -0400
X-MC-Unique: 4R-kwjFyMeCIB5fyc7vuXg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30940b01998so848186f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423668; x=1687015668;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVsWedMGqMQr6bM4ca41H/pcxJaQD1wOcUTf6g/yiVg=;
 b=Wr4wfM66t5305Cjw0gaQpibLT9kQdEVOCqgKRsp5YcVzfi4n3eVEJRq5MGCThAInpW
 rFrjKHfJEP35PLEQ7uY8qX9+kaKHpBuFZBE+ixtaLE/fujSgLTwIpcBUkignNH9soAee
 v/i8IFBc+YOG5P1uwTeqnwHcQqlRlRnn0v5Ce2byXHooGUIsKIiBLl6cjRIN6nlE6e36
 q9jLmZwMzw8DXNbKrqFrZZeBgZG4U5ok1ZPPHqPxbjXOhc/zEDZg2+/rn9GptKOf3yL/
 n9PuTYqRZubQEjfTOs+YsLz+fp3KnTiDsieHwJOnyXJ1TjLgue2AvfVLfpLV1MBc6XD6
 1Bxw==
X-Gm-Message-State: AC+VfDwA9Gnt5mR6RCG0L06+1PJnbvLXjwcKAjgHPf1HXzArBSQ+4W2W
 qzESVSXl6Wb+gAa28zMgvsoUgtHnKXNwACo9tl+Tb0+06qqVEG5f/HAGCVKS4dtRU0hbLS03Nog
 UHkYkgl3rqwppLiY=
X-Received: by 2002:a5d:5703:0:b0:307:8e1b:6cc7 with SMTP id
 a3-20020a5d5703000000b003078e1b6cc7mr1412228wrv.67.1684423668339; 
 Thu, 18 May 2023 08:27:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4keqQDLVmbKs4IXAHWXezPzb0E3g1/mccfdNarRBmmq3KcUPCgyb+i34Il5T9kYpKQS3VvUg==
X-Received: by 2002:a5d:5703:0:b0:307:8e1b:6cc7 with SMTP id
 a3-20020a5d5703000000b003078e1b6cc7mr1412211wrv.67.1684423668016; 
 Thu, 18 May 2023 08:27:48 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 a8-20020a05600c224800b003f42cc7aac4sm2351899wmm.37.2023.05.18.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:27:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>,  Fiona
 Ebner <f.ebner@proxmox.com>,  Leonardo Bras <leobras@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  qemu-devel@nongnu.org, Cleber Rosa
 <crosa@redhat.com>
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
In-Reply-To: <20230518110755-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Thu, 18 May 2023 11:10:18 -0400")
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
 <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
 <87wn15dgbs.fsf@secure.mitica> <ZGYnpQmc+5Sut3x8@x1n>
 <20230518110755-mutt-send-email-mst@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 17:27:46 +0200
Message-ID: <87wn15bqx9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> wrote:

[adding cleber]

> On Thu, May 18, 2023 at 09:27:01AM -0400, Peter Xu wrote:
>> One thing we can also do to avoid it in the future is simply having someone
>> do this check around each softfreeze (and we'll also need maintainers be
>> careful on merging anything that's risky though after softfreeze) rather
>> than after release (what I did for this time, which is late), try to cover
>> as much devices as possible. I don't know whether there's a way to always
>> cover all devices.
>> 
>> I'll volunteer myself for that as long as I'll remember.  Juan, please also
>> have a check or remind me if I didn't. :)
>> 
>> I am not sure whether I mentioned it somewhere before, but maybe it'll work
>> if we can also have some way we check migrating each of the vmsd from
>> old-qemu to new-qemu (and also new->old) covering all devices.  It doesn't
>> need to be a real migration, just generate the per-device stream and try
>> loading on the other binary.
>> 
>> It might be an overkill to be part of CI to check each commit, but if
>> there's some way to check it then at least we can run it also after
>> softfreeze.  I also don't know whether it'll be easy to achieve it at all,
>> but I'll think more about it too and update if I found something useful.
>
> I'm all for more testing but if it does not actually test that the
> values loaded are actually used correctly then the testing is of course
> lower quality. Better than nothing I guess ...

As said in my other email.  The problem that I have is that there is no
easy way to test two different qemu binaries. And what we would like is
testing at least:

qemu-8.0 -M pc-8.0 -> qemu-latest -M pc-8.0
qemu-latest -M pc-8.0 -> qemu-8.0 -M pc-8.0

Then we have the probem of:
- what architectures do we care?
  My bet is on x86_64, i386? (almost free with previous one), ppc64,
  aarch64, s390.
- what devices do we care?
  virtio-devices for sure.  Not sure with others.  Notice that if we
  want the test to run on CI, they need to be virtual devices.

Once the mechanism of testing and reporting is there, we can decide:
- what other devices we care
  no good ideas here: SATA, e1000e perhaps.
- what other versions we care
  perhaps it is not out of qestion to test the last two
  versions. i.e. to add:
  $ qemu-7.2 -M pc-7.2 -> qemu-latest -M pc-7.2
  $ qemu-latest -M pc-7.2 -> qemu-7.2 -M pc-7.2
  But we haven't been very good just allowing the latest version to add
  the latests two.

Cleber, any idea how difficult would be to add something like that?

For reference, we are trying to test, detect the failures described
here:

https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03285.html

See the three emails.

Thanks, Juan.


