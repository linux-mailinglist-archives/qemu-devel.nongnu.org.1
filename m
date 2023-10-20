Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DD7D0B16
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlQU-0005fk-6h; Fri, 20 Oct 2023 05:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlQO-0005ag-Nk
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlQL-0004Wb-R9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792643;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7iOD38ZQAWCDHfMChkcturqXvPftdRJcTPsjG9smas=;
 b=V1RQwzRJpu7WJ3fuQkQt48uIJRQHeWeLX05sdyqGxzN7hLuTtyyRBabkxwAPL77eFdUEeb
 pFtetOM8VmO18qkYCuS3odhLQzWcz06lPTiPj77pwQqhdao3QJZWt1U+WqgX9VJjIWcmHM
 A3IA2I/cE5c7Fpz2x9mP2gXPbRoQhFs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287--A1roAHFMN2NfETkAKQySg-1; Fri, 20 Oct 2023 05:04:02 -0400
X-MC-Unique: -A1roAHFMN2NfETkAKQySg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5073588cbso4258211fa.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697792641; x=1698397441;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7iOD38ZQAWCDHfMChkcturqXvPftdRJcTPsjG9smas=;
 b=czqMe94ue9c2pBZ4kKaLCxtkbNLTDGQU/dx1eWkt1Gm/qCw2NsvyrcLkEz9Bx4ONa4
 r4ZGQ1JzvBnb3u22FoJ/2/7TQn2OY6RFEMlrefoI96xCaAbz8A0O8515ONOryj0Rlr7l
 MfHgHQWsv8gSpmscEd+q6I2FfftcMffn5U0sZhOpQcHEPQZzrkCfK9VfgQITjSe71XXt
 gk7no30NeurGiBzofTVERugHREFT2FLfIGnef3K1reOJ+zsDnVAzkNjSDG2JJFXT24UZ
 XuUgoIdcIgwsAL51PCHvYUWpc/yvkoiKeI2oRvd3pSEQTY2TA0x09LpmChDga+RfsxG8
 FbHA==
X-Gm-Message-State: AOJu0YwcBLNdcBzhiIFXkUByHSCOsJad9VAvPhz1tahWqonVGlGmUWlp
 R3yzcRAq1JWp2GoHpNOHmIRdyeFFAx8rYJ6BEIEpqldyPf9zVLSLymVb6xhkS1goIJ3aDeuWJPq
 An1nQHXnZ6DXEJQ0=
X-Received: by 2002:a2e:a22c:0:b0:2c5:1bd3:5658 with SMTP id
 i12-20020a2ea22c000000b002c51bd35658mr851910ljm.28.1697792640857; 
 Fri, 20 Oct 2023 02:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkaiweh5iqJMVBscdQZTW94gUX6yR/iNpwTsVA3OFSN4B0SDaaubRpGxr1P0+jzSwWVTsWtw==
X-Received: by 2002:a2e:a22c:0:b0:2c5:1bd3:5658 with SMTP id
 i12-20020a2ea22c000000b002c51bd35658mr851872ljm.28.1697792640483; 
 Fri, 20 Oct 2023 02:04:00 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c231100b00401d8181f8bsm6437426wmo.25.2023.10.20.02.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:04:00 -0700 (PDT)
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
Subject: Re: [PATCH 10/13] migration: Improve example and documentation of
 vmstate_register()
In-Reply-To: <8b7a67bf-6d45-374c-13ee-fbb85b4b21bc@linux.ibm.com> (Stefan
 Berger's message of "Thu, 19 Oct 2023 16:38:15 -0400")
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-11-quintela@redhat.com>
 <8b7a67bf-6d45-374c-13ee-fbb85b4b21bc@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:03:59 +0200
Message-ID: <87bkct1x8g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Stefan Berger <stefanb@linux.ibm.com> wrote:
> On 10/19/23 15:08, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   docs/devel/migration.rst | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>> index c3e1400c0c..a9fde75862 100644
>> --- a/docs/devel/migration.rst
>> +++ b/docs/devel/migration.rst
>> @@ -165,13 +165,17 @@ An example (from hw/input/pckbd.c)
>>         }
>>     };
>>
>> -We are declaring the state with name "pckbd".
>> -The ``version_id`` is 3, and the fields are 4 uint8_t in a KBDState str=
ucture.
>> -We registered this with:
>> +We are declaring the state with name "pckbd".  The ``version_id`` is
>> +3, and the fields are 4 uint8_t in a KBDState structure.  We
>
> and there are 4=C2=A0 uint8_t fields in the KBDState structure.

Done thanks.

>
>> +registered this with one of those.  The first one will generate a
>
> I am not sure what this means 'We registered this with one of
> those'. What is 'one of those'?

Changed to:

We
registered this ``VMSTATEDescription`` with one of the following
functions.

> Maybe you mean: We register the KBDState with one of the following
> functions.
>
>> +device ``instance_id`` different for each registration.  Use the
>> +second one if you already have an id different for each instance of
>> +the device:
> ... have an id that is is different for each ...

Done

>>
>>   .. code:: c
>>
>> -    vmstate_register(NULL, 0, &vmstate_kbd, s);
>> +    vmstate_register_any(NULL, &vmstate_kbd, s);
>> +    vmstate_register(NULL, instance_id, &vmstate_kbd, s);
>>
>>   For devices that are ``qdev`` based, we can register the device in the=
 class
>>   init function:

Thanks


