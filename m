Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D27D098E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:32:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjyC-0000aA-3g; Fri, 20 Oct 2023 03:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjy8-0000ZG-6A
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtjy5-00067F-V5
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697787049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=amJOxqJ+raTBxywBm3QL8jBcO8MOp3+kljTW/J9MJh0=;
 b=LoPBDhc5mS6JCEdi1/V3P3d/VDzUuxf4GBe0K6RRQW7E1b6b2iZk3Z2a50hUmpg7Sf+K63
 umOLPiUDzOohAT6G5rRidazwhbEPeGji+2BFd4LfXBr5D1M7RV7PnqG3fxDlvVfqCfnSkf
 P14M7O3qHV6+vkyQq8pN69JhzkV9wvw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-78JwHeEnN26vKpgjJBQYbA-1; Fri, 20 Oct 2023 03:30:47 -0400
X-MC-Unique: 78JwHeEnN26vKpgjJBQYbA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32da8de4833so277879f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697787046; x=1698391846;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amJOxqJ+raTBxywBm3QL8jBcO8MOp3+kljTW/J9MJh0=;
 b=bYGiXKkpbe2dugYgEkmp+8bu55CE37HuWtqoYbY5+eaHtgGF+eRdOJZ+xGRdToMECy
 EjwFeYAk1pT5TXjmoyJTatl+Xr5aHMz+jVKIzUb6lKWVgYMkeIhZgcymBQLYDUd300i0
 9+og2LAlSA3Z6J1eSm+R2ikvnYd6qZbYalKCgAvOmH+pxO69Xv6rZXdH6Pksl6IXBES+
 F6mvA1W9WlQf5tl/zmGDtpRYfa7b+k6jChVF6gZ+eu4yq6RlSOcYzYcFYtF3Io0khrV1
 4EoGKw4lBYwrcKb+UdKn1Tzr1X+YCWtv7R0SySfzb2Q5kjeqn2o3AlcS40Rj2Uc2+qzj
 8dVw==
X-Gm-Message-State: AOJu0YzCgu7yZ2jp5rzu2/y1EXdp9Nd9R65W+f8rvIcFWVoUEuyUvw3w
 D86rJ9wnmS825qaSi7NUxcwIRU/ppUzw8XEn5mW4pEkSbf9cLVqrYudgf9vRzBn/2jR4dTZLo3B
 7y9Firpi9Gk3BypA=
X-Received: by 2002:adf:ea4a:0:b0:317:50b7:2ce3 with SMTP id
 j10-20020adfea4a000000b0031750b72ce3mr631605wrn.51.1697787046224; 
 Fri, 20 Oct 2023 00:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDUPox7z9DaAZYJDb96PV6OjeJFVU9LPyApjjVmPo7AzU/cWzVIEKMgW3vMYK/3c9h54ShoQ==
X-Received: by 2002:adf:ea4a:0:b0:317:50b7:2ce3 with SMTP id
 j10-20020adfea4a000000b0031750b72ce3mr631565wrn.51.1697787045842; 
 Fri, 20 Oct 2023 00:30:45 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r3-20020adff103000000b0032d9337e7d1sm1081841wro.11.2023.10.20.00.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:30:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: <qemu-devel@nongnu.org>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>,  <qemu-s390x@nongnu.org>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>,  Fabiano Rosas <farosas@suse.de>,
 "Eric Farman" <farman@linux.ibm.com>,  Peter Xu <peterx@redhat.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,  John Snow
 <jsnow@redhat.com>,  <qemu-block@nongnu.org>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefan Weil <sw@weilnetz.de>,
 <qemu-arm@nongnu.org>,  Jason Wang <jasowang@redhat.com>,  Corey Minyard
 <minyard@acm.org>,  Leonardo Bras <leobras@redhat.com>,  "Thomas Huth"
 <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,  David
 Gibson <david@gibson.dropbear.id.au>,  Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
In-Reply-To: <20231019233958.17abb488@bahia> (Greg Kurz's message of "Thu, 19
 Oct 2023 23:39:58 +0200")
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 09:30:44 +0200
Message-ID: <875y313g4b.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Greg Kurz <groug@kaod.org> wrote:
> On Thu, 19 Oct 2023 21:08:25 +0200
> Juan Quintela <quintela@redhat.com> wrote:
>
>> Current code does:
>> - register pre_2_10_vmstate_dummy_icp with "icp/server" and instance
>>   dependinfg on cpu number
>> - for newer machines, it register vmstate_icp with "icp/server" name
>>   and instance 0
>> - now it unregisters "icp/server" for the 1st instance.
>> 
>> This is wrong at many levels:
>> - we shouldn't have two VMSTATEDescriptions with the same name
>> - In case this is the only solution that we can came with, it needs to
>>   be:
>>   * register pre_2_10_vmstate_dummy_icp
>>   * unregister pre_2_10_vmstate_dummy_icp
>>   * register real vmstate_icp
>> 
>> As the initialization of this machine is already complex enough, I
>> need help from PPC maintainers to fix this.
>> 
>> Volunteers?
>> 
>> CC: Cedric Le Goater <clg@kaod.org>
>> CC: Daniel Henrique Barboza <danielhb413@gmail.com>
>> CC: David Gibson <david@gibson.dropbear.id.au>
>> CC: Greg Kurz <groug@kaod.org>
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  hw/ppc/spapr.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index cb840676d3..8531d13492 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -143,7 +143,12 @@ static bool pre_2_10_vmstate_dummy_icp_needed(void *opaque)
>>  }
>>  
>>  static const VMStateDescription pre_2_10_vmstate_dummy_icp = {
>> -    .name = "icp/server",
>> +    /*
>> +     * Hack ahead.  We can't have two devices with the same name and
>> +     * instance id.  So I rename this to pass make check.
>> +     * Real help from people who knows the hardware is needed.
>> +     */
>> +    .name = "pre-2.10-icp/server",
>>      .version_id = 1,
>>      .minimum_version_id = 1,
>>      .needed = pre_2_10_vmstate_dummy_icp_needed,
>
> I guess this fix is acceptable as well and a lot simpler than
> reverting the hack actually. Outcome is the same : drop
> compat with pseries-2.9 and older.
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

I fully agree with you here.
The other options given on this thread is deprecate that machines, but I
would like to have this series sooner than 2 releases.  And what ppc is
doing here is (and has always been) a hack and an abuse about how
vmstate registrations is supposed to work.

Thanks, Juan.


