Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE327D0992
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtk1I-0004Mm-1o; Fri, 20 Oct 2023 03:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtk1F-0004L9-7d
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtk1C-0008At-HY
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697787241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Tt+iXBcR4c4RWOWKyyGEdBlQOV3XSZZUzDwjSYXAcIc=;
 b=eRYBgyfkaXrih4Mu3+DdHvbTwGA0Q/p/SeKNt3gxdKsce3FdFvo55Oo37U3gvbwzBuqXoV
 MPwcwoSP3ZbqlhQGyHa0bhiVUIhk3S7oz2RNdbh4Q1YJGP951YqplqrKbpRq9nHYwclEQn
 hs+3IBWtzlMeX/ylMD6r2Sq0d/zsbNo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-KWOimUqVMy2nSRvPAGyCPQ-1; Fri, 20 Oct 2023 03:33:59 -0400
X-MC-Unique: KWOimUqVMy2nSRvPAGyCPQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32de39ce109so191379f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697787238; x=1698392038;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tt+iXBcR4c4RWOWKyyGEdBlQOV3XSZZUzDwjSYXAcIc=;
 b=vHEXfdrWvtRKLrekeUdkg3Td5OOgwCZOwd0QiqSgNJ06ZsFgniv/VorYo0SP+VZaB1
 VOmsepVLJhzrwqIMASm19kCvjQZB3azFc5Wm1AxZH9RgfhdaD/yriieHdBXgSdt+1Znn
 nE+fsM+GWWlSFXlKutcEgCIO2lwznT0TaJ9330wtnbbZ4dwh2vja7MDISc+SldXcC6+d
 vM/aJZmhAdJT7CTHXl6db9LVHX/35iM+aPRPJif64dOkbVC531BV1iycA0AbulWTK+RI
 yAbPbfn31dI0RZYvxCvwt7TKGhdju47u9tAlnryolDjl2rj5dv4y62n6Ay+LJHzWA+YD
 W86g==
X-Gm-Message-State: AOJu0YwJMlwN/im3TDeRc2lSPpkpv5t4leC8uUKdzOQEpbKrYC18DVFN
 HFWH3Ful9jqRRldlSQGYEXJzMpUOOhcvZjLO1NYPj0CUVLkjBQl9NzT1XJwRrBNRP64VJDaY78j
 ywPE+t+NiU24WxeY=
X-Received: by 2002:a5d:6941:0:b0:32d:a022:855a with SMTP id
 r1-20020a5d6941000000b0032da022855amr663029wrw.20.1697787238695; 
 Fri, 20 Oct 2023 00:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsptop42mQsH91sa2iYqoYxhHyLbWbxtU4tfeRsCVKI7vv+mzZ9G5beA88VAAkicSE8tWplA==
X-Received: by 2002:a5d:6941:0:b0:32d:a022:855a with SMTP id
 r1-20020a5d6941000000b0032da022855amr662990wrw.20.1697787238333; 
 Fri, 20 Oct 2023 00:33:58 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d470a000000b0032d9efeccd8sm1077950wrq.51.2023.10.20.00.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:33:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,  qemu-s390x@nongnu.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Corey Minyard
 <minyard@acm.org>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  David
 Gibson <david@gibson.dropbear.id.au>,  Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 13/13] migration: Use vmstate_register_any() for vmware_vga
In-Reply-To: <7f200fc5-3db3-cb13-3b9c-9861dfb358ec@linux.ibm.com> (Stefan
 Berger's message of "Thu, 19 Oct 2023 16:42:07 -0400")
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-14-quintela@redhat.com>
 <7f200fc5-3db3-cb13-3b9c-9861dfb358ec@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 09:33:57 +0200
Message-ID: <871qdp3fyy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 10/19/23 15:08, Juan Quintela wrote:
>> I have no idea if we can have more than one vmware_vga device, so play
>> it safe.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> ---
>>   hw/display/vmware_vga.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
>> index 09591fbd39..7490d43881 100644
>> --- a/hw/display/vmware_vga.c
>> +++ b/hw/display/vmware_vga.c
>> @@ -1264,7 +1264,7 @@ static void vmsvga_init(DeviceState *dev, struct vmsvga_state_s *s,
>>
>>       vga_common_init(&s->vga, OBJECT(dev), &error_fatal);
>>       vga_init(&s->vga, OBJECT(dev), address_space, io, true);
>> -    vmstate_register(NULL, 0, &vmstate_vga_common, &s->vga);
>> +    vmstate_register_any(NULL, &vmstate_vga_common, &s->vga);
>
> And the first one registered with 'any' will again have instance_id =
> 0 assigned. So there's no side effect to be expected with any of these
> device, I suppose.

I will really change all the remaining registrations with 0 to any.

* If there is only a registration for that device: nothing changes
* If there is more than one registration for that device: It *could*
  work (from the migration point of view).

But then there are devices that *clearly* will not be able to have more
than one instance, so 0 is the best option there.  On top of my head:

* cpu-timers
* replay
* migration global_state

And the rest that I put on the cover letter are basically devices that
are used only once on the board initilization routine, so I feel safe
leaving them with zero.

Thanks for the review, Juan.


