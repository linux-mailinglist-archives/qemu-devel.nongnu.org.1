Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 465167D3C87
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxo2-00070S-8F; Mon, 23 Oct 2023 12:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1quxo0-0006zD-JH
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1quxny-00052w-Mp
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698078565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUODFSYjipcgmzOC15MVxjEsAVqcfyFfniq3Ax+2nEQ=;
 b=YCRxYQGVvNdEGFEaAoJjkXeZG5MMZPE+VGrtKQOQx2zuG7nBNeMx8TKSKE6HKAa2u96kY8
 WGPhHN3VDD5odVsJTx+wy4uhG6iYR7vV3SoXvToJcJpdw6TpbjfivTusvOVKhlYMUPVMmz
 ar1pEDEbvAh1s+G6VUFhXyZ+NZ2n/5Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Sk-VXekRNRiSEpcBrrmOmg-1; Mon, 23 Oct 2023 12:29:24 -0400
X-MC-Unique: Sk-VXekRNRiSEpcBrrmOmg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so7683005e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698078563; x=1698683363;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUODFSYjipcgmzOC15MVxjEsAVqcfyFfniq3Ax+2nEQ=;
 b=uysO7Q+Y43j2vLhDR4kYsumfVDWJcxjQOPBIH+FR7J+SBBFpd6yV3IhA4cPc7kLPVN
 OT2YefUj0cXlVp0RyNmLJvMckIy6QqPwyIesnuSRjkTfy6va4+zJK5hBct5mE8VkBtg3
 gfhU4h0Jdb4hN0NjlHv0xF15Hx/MPbaFRHBZD75C6zIJFS3Jx6sm53VSAs0OiH/xZZxE
 lWxLo+XGmehN0OiXG8V5O+CF+DQmkohv36CXS4iRcsME9qp6G6hyasjYGoii2aIjO6by
 LFNBgNEAP60OpN9PbHMCtMgRr4oCDAIALAhFw7JFY1R2bogymxzkcha9GKwhVRi7Y8HS
 Iiww==
X-Gm-Message-State: AOJu0YyTAw/ZQQHquEzpuT8bslps90RXx5I8M6NYCJbStQSwyKBDxCOR
 Hk/K6CZXMW548PQYRlmIz72so7tvP5ZnOzqVpUxlwcv98LMcCeD2kApCsXcWpcsNxveRoqkPSpC
 1kaU+dX1J8QN+H8E=
X-Received: by 2002:a05:600c:1c8d:b0:402:ea83:45cf with SMTP id
 k13-20020a05600c1c8d00b00402ea8345cfmr8228562wms.2.1698078563111; 
 Mon, 23 Oct 2023 09:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6wMNzzY6+4cXSrK4FKAQ8aSB6N276VmyoVMtg5m78lLrFcviNTp+jr3mHv7XGJC/uPqmLZQ==
X-Received: by 2002:a05:600c:1c8d:b0:402:ea83:45cf with SMTP id
 k13-20020a05600c1c8d00b00402ea8345cfmr8228534wms.2.1698078562660; 
 Mon, 23 Oct 2023 09:29:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c1c1400b004065daba6casm14798055wms.46.2023.10.23.09.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:29:22 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Harsh
 Prateek Bora <harshpb@linux.ibm.com>,  David Hildenbrand
 <david@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,  Eric
 Farman <farman@linux.ibm.com>,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  David Gibson
 <david@gibson.dropbear.id.au>,  Corey Minyard <cminyard@mvista.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Corey Minyard <minyard@acm.org>,  Stefan Berger
 <stefanb@linux.vnet.ibm.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Halil Pasic <pasic@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>,  John Snow <jsnow@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,  Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Jason
 Wang <jasowang@redhat.com>,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Stefan Weil <sw@weilnetz.de>,  Stefan
 Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 11/13] migration: Use vmstate_register_any() for audio
In-Reply-To: <3217207d-7b75-4354-8923-c637b19700fa@t-online.de> ("Volker
 =?utf-8?Q?R=C3=BCmelin=22's?= message of "Sat, 21 Oct 2023 16:55:59 +0200")
References: <20231020090731.28701-1-quintela@redhat.com>
 <20231020090731.28701-12-quintela@redhat.com>
 <3217207d-7b75-4354-8923-c637b19700fa@t-online.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 23 Oct 2023 18:29:21 +0200
Message-ID: <87o7gpb8v2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Volker R=C3=BCmelin <vr_qemu@t-online.de> wrote:
> Am 20.10.23 um 11:07 schrieb Juan Quintela:
>> We can have more than one audio card.
>
> Hi Juan,
>
> I wouldn't use the term "audio card" here. In QEMU speak, Audiodev is an
> "audio backend".

Thanks.  Changed that.

> With best regards,
> Volker
>
>>
>> void audio_init_audiodevs(void)
>> {
>>     AudiodevListEntry *e;
>>
>>     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
>>         audio_init(e->dev, &error_fatal);
>>     }
>> }
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  audio/audio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/audio/audio.c b/audio/audio.c
>> index e9815d6812..f91e05b72c 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -1781,7 +1781,7 @@ static AudioState *audio_init(Audiodev *dev, Error=
 **errp)
>>=20=20
>>      QTAILQ_INSERT_TAIL(&audio_states, s, list);
>>      QLIST_INIT (&s->card_head);
>> -    vmstate_register (NULL, 0, &vmstate_audio, s);
>> +    vmstate_register_any(NULL, &vmstate_audio, s);
>>      return s;
>>=20=20
>>  out:


