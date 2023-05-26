Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B37121A8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:56:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SIN-00035o-MR; Fri, 26 May 2023 03:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SIM-00035F-5P
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SIK-0001Ol-CS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685087727;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sb+z89tDZonl3xiR0bG5FH4KJEXKYCWAxu27JmgGx7g=;
 b=eqqRORe03ue5ilXgXiUzIYtV8EXxVwawoJcL6449eUFFHzOsGPPTjjkv42h93ZNijPeTEK
 kdr0b07h3kkvWQDESylSozDwm4vCeWed6jR34DmtEJMkSbK/YHV3WMe3RoagQdwBnxrzd6
 pqSDf0kX3WsBwKQfeYC7ImG6ZW/wWgc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-CWz4z_gAPbC1RwKswXDLpw-1; Fri, 26 May 2023 03:55:25 -0400
X-MC-Unique: CWz4z_gAPbC1RwKswXDLpw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ab548ba06so290808f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685087724; x=1687679724;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sb+z89tDZonl3xiR0bG5FH4KJEXKYCWAxu27JmgGx7g=;
 b=SNmzS8q9Mcly5P5L5ASWhun8J6S85h2gLQM2S+5NU1gDqtzjHXu/TpCZwnu02OWYci
 nMMt4eS6amEQ5DxxjaY/qifHYIu2uNprI61dGVKrG8cTR1vERi0t6FJhv0/Uj3FHF4Ct
 FJS0hBy++qfdY4XYRYUECMxYu+K6Th/5OyEC+jT35cX6qZSXM1P0/4rXIaDsU0yhhLOh
 r29akk2Ei0vhO6qV+UyoEa3YDzotVfOQzBBnJPucezc/uG5DFXs1Q29W9pCSDNRqYgld
 G1KY2Z6RVE38YfakiGf2xcAFFEstywc2kbMEWHOGdrun+EEgizEl8LVfP9xa65qadR+m
 RlBw==
X-Gm-Message-State: AC+VfDx4S37ptgr4rrBPO140Z2wE8K7Y6v6C43vnSXfme4FXDBebcV8U
 6x17MPfT8c9LJiyD1N7Uz93b0CLqzqouVh/lfCPfmIUWk5seCFZJNC0R+q4xG+UYEyLvxLE7bDU
 7zCEVzdxcgdFQ3c8=
X-Received: by 2002:adf:f3c9:0:b0:30a:c35d:25d3 with SMTP id
 g9-20020adff3c9000000b0030ac35d25d3mr846227wrp.52.1685087724437; 
 Fri, 26 May 2023 00:55:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7YpLhsQXaRpYLe83D6dEuiS6KJVUz3PGXIl0sow72/+M8Fs2lyIcrIGsX7S0vKaxtjXdNb6w==
X-Received: by 2002:adf:f3c9:0:b0:30a:c35d:25d3 with SMTP id
 g9-20020adff3c9000000b0030ac35d25d3mr846199wrp.52.1685087724067; 
 Fri, 26 May 2023 00:55:24 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 b14-20020adff90e000000b00307972e46fasm4091929wrr.107.2023.05.26.00.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 00:55:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Fiona Ebner
 <f.ebner@proxmox.com>,  Leonardo Bras <leobras@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org,  Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
In-Reply-To: <ZGuJXf9B0xEeDGe6@orkuz.int.mamuti.net> (Jiri Denemark's message
 of "Mon, 22 May 2023 17:25:17 +0200")
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <20230511064306-mutt-send-email-mst@kernel.org>
 <8735435c0c.fsf@secure.mitica> <ZGuJXf9B0xEeDGe6@orkuz.int.mamuti.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 09:55:22 +0200
Message-ID: <87ilcf4jdh.fsf@secure.mitica>
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

Jiri Denemark <jdenemar@redhat.com> wrote:
> On Thu, May 11, 2023 at 13:43:47 +0200, Juan Quintela wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> [Added libvirt people to the party, see the end of the message ]
>
> Sorry, I'm not that much into parties :-)
>
>> That would fix the:
>> 
>> qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2
>> 
>> It is worth it?  Dunno.  That is my question.
>> 
>> And knowing from what qemu it has migrated from would not help.  We
>> would need to add a new tweak and means:
>> 
>> This is a pc-7.2 machine that has been isntantiated in a qemu-8.0 and
>> has the pciaerr bug.  But wait, we have _that_.
>> 
>> And it is called
>> 
>> +    { TYPE_PCI_DEVICE, "x-pcie-err-unc-mask", "off" },
>> 
>> from the patch.
>> 
>> We can teach libvirt about this glitch, and if he is migrating a pc-7.2
>> machine in qemu-8.0 machine, And they want to migrate to a new qemu
>> (call it qemu-8.1), it needs to be started:
>> 
>> qemu-8.1 -M pc-7.2 <whatever pci devices need to do>,x-pci-err-unc-mask="true"
>> 
>> Until the user reboots it and then that property can be reset to default
>> value.
>
> Hmm and what would happen if eventually this machine gets migrated back
> to qemu-8.0?

It works.
migrating to qemu-7.2 is what is not going to work.
To migrate to qemu-8.0, you just need to drop the
"x-pci-err-unc-mask=true" bit.  And it would work.

So, to be clear, this machine can migrate to:

- qemu-8.0, you just need to drop the "x-pci-err-unc-mask=true" bit

- qemu-8.0.1 or newer, you just need to maintain the
  "x-pci-err-unc-mask=true" bit.

Let's just assume that qemu-7.2.1 don't get the
"x-pci-err-unc-mask=true" bit, so it will not be able to migrate there.


> Or even when the machine is stopped, started again, and
> then migrated to qemu-8.0?

If you do what I call a hard reset (i.e. poweroff + poweron so qemu
dies), you should drop the "x-pci-err-unc-mask=true" bit.  And then you
can migrate to qemu-7.2 and all qemu-8.0.1 and newer.

Basically what we need is a "mark" inside libvirt that means something
like:

- this is weird machine that looks like pc-7.2
- but has "x-pci-err-unc-mask=true"
- so it can only migrate to qemu-8.0 and newer.
- but if it even reboots in qemu-8.0.1 or newer, we want it back to
  become a "normal" pc-7.2 machine (i.e. drop the
  x-pci-err-unc-mask=true).

That would be the perfect world.  But as we are in an imperfect world,
something like:

- this machine started in qemu-8.0 -M pc-7.2, we know this is broken and
  it can't migrate outside of qemu-8.0 because it would fail to go to
  either qemu-7.2 or qemu-8.0.1.

I would argue that if you do the second option doing the "right" option
i.e. the first one is not much more complicated, but that is a question
that you should be better to answer.

And then we have the other Michael question.  How can we export that
information so libvirt can use it.

In this case we can comunicate libvirt:
- In qemu-8.0 we broke pc-7.2.
- The problem is fixed in qemu-8.0.1 using property
  "x-pci-err-unc-mask=false".
- You can migrate from qemu-8.0 in newer if you set that property as
  true.
- Guests started in qemu-8.0 -M pc-7.2 should reboot in qemu-8.0.1 or
  newer to become "normal pc-7.2".
- If we publish this on qemu, we can only publish it on qemu-8.0.1 and
  newer.
- Or we can publish it somewhere else and any libvirt can take this
  information.
- Or we can comunicate this to libvirt, and they incorporate it on their
  source anywhere that you see fit.

The point here is that when we use a property on a machine type, it can
be for two reasons:

- We detected at the right time that we changed the value of something,
  and we did the right thing on hw_compat_X_Y, so libvirt needs to do
  nothing.

- We *DID NOT* detect that we broke compatibility before release, and we
  need to make a property to identify that problem.  This is where we
  need to do this dance.

Notice that normally we detect lots of problems during development and
this *should* not happen.  But when it happens, we need to be able to do
something.

And also notice that normally we broke just some device, not a whole
machine type.  But as you can see we have broke it this time.  We are
trying to automate the detection of this kind of failures, but we are
still on design stage, so we need to plan how to handle this.

Any comments?

Later, Juan.






