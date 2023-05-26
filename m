Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8551C712222
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Sk4-0003KP-Rf; Fri, 26 May 2023 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Sk1-0003JL-9z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Sjy-00086t-Gi
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089441;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTRvTvi+iv5pcWs8Qhc4bIBXCgL3XdFjfBqVAraITJ8=;
 b=fKD0GnhrjVtDrdwm4F8N4RSpUgBPsr3J3zAUigNuYMX7tKfFQJIS5clXkGQRk12w+GAjWe
 KzPONF/PfyluBzJ9Bubig2Lm/1bJnfOjHJPNL+oXzRiu5m/rdrOms3EEtYFElWxQO/6ECZ
 rDMm4jhSKQrb87+796XEJsMrsj7qlEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TYebjO95NCeytK1Jz4X9LQ-1; Fri, 26 May 2023 04:23:59 -0400
X-MC-Unique: TYebjO95NCeytK1Jz4X9LQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f518f2900eso3782325e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089438; x=1687681438;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rTRvTvi+iv5pcWs8Qhc4bIBXCgL3XdFjfBqVAraITJ8=;
 b=Cwm2wzEkWTOcQd28m/0TpltGzayVr7KKVQZsuO/vGfjoF3EBlfudb3QSeDjfvqTk7U
 unRtHmHwHM4GXNxpJ950LLHyXyray+KJvREisPRcVavwXKqBRzzmclvWp02LM4DWuqLH
 C3IFAxtZ+99z7IOlCxp7FBglRa/2IqDseQVWwodfbmi0jTTN+7oYZ0Pp4zzQiSsS6tKu
 jVd+KC0qYS3WZkvXcBJevpTWQrkRLGtuTntKLUMd8HFpvE0Ev5Z/tn13jAUpOmKBhkD+
 2JqfOkZVX6H5TPgWGG0OCne+J3/obO3pdJ7PUYKzU2D91nE9PSu38SKPUtJpcwYB/Eqj
 s/mg==
X-Gm-Message-State: AC+VfDwOSCTGNaX3zGwOoVIUyYyIpLPmBaeZMPL/Gu8zJx+gUvbXzC4B
 6ABu+++WSJWcRsPmw4Dr+9//+BNg0hYpnmN1miojsiqSbl7zv+b7rp9mIW18XrU5/gLh1bmVpeZ
 mQYpV71Klpc1mmcU=
X-Received: by 2002:a05:600c:21c6:b0:3f6:89a:94c8 with SMTP id
 x6-20020a05600c21c600b003f6089a94c8mr698574wmj.24.1685089438729; 
 Fri, 26 May 2023 01:23:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bqH8N10mqZt5djT7EJiljBprDbt4SeImePX5mB2QhsqkHMv5MHmgUBdMOHOS6rhA0lMV0AQ==
X-Received: by 2002:a05:600c:21c6:b0:3f6:89a:94c8 with SMTP id
 x6-20020a05600c21c600b003f6089a94c8mr698557wmj.24.1685089438436; 
 Fri, 26 May 2023 01:23:58 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 x21-20020a05600c21d500b003f6041f5a6csm4417720wmj.12.2023.05.26.01.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:23:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Greg Kurz
 <groug@kaod.org>,  qemu-s390x@nongnu.org,  Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 16/16] migration/multifd: Compute transferred bytes
 correctly
In-Reply-To: <17c133c69e5207e81784c081dd82950a31b8d826.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Thu, 25 May 2023 05:38:32
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-17-quintela@redhat.com>
 <17c133c69e5207e81784c081dd82950a31b8d826.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:23:57 +0200
Message-ID: <87jzwv33he.fsf@secure.mitica>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
>> In the past, we had to put the in the main thread all the operations
>> related with sizes due to qemu_file not beeing thread safe.  As now
>> all counters are atomic, we can update the counters just after the
>> do the write.  As an aditional bonus, we are able to use the right
>> value for the compression methods.  Right now we were assuming that
>> there were no compression at all.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/multifd.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index aabf9b6d98..0bf5958a9c 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -175,6 +175,7 @@ void multifd_register_ops(int method, MultiFDMethods=
 *ops)
>>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **er=
rp)
>>  {
>>      MultiFDInit_t msg =3D {};
>> +    size_t size =3D sizeof(msg);
>>      int ret;
>>=20=20
>>      msg.magic =3D cpu_to_be32(MULTIFD_MAGIC);
>> @@ -182,10 +183,12 @@ static int multifd_send_initial_packet(MultiFDSend=
Params *p, Error **errp)
>>      msg.id =3D p->id;
>>      memcpy(msg.uuid, &qemu_uuid.data, sizeof(msg.uuid));
>>=20=20
>> -    ret =3D qio_channel_write_all(p->c, (char *)&msg, sizeof(msg), errp=
);
>> +    ret =3D qio_channel_write_all(p->c, (char *)&msg, size, errp);
>>      if (ret !=3D 0) {
>>          return -1;
>>      }
>> +    stat64_add(&mig_stats.multifd_bytes, size);
>> +    stat64_add(&mig_stats.transferred, size);
>>      return 0;
>>  }
>
> Humm, those are atomic ops, right?
>
> You think we could have 'multifd_bytes' and 'transferred' in the same cac=
heline,
> to avoid 2 cacheline bounces?

Don't matter on next series.

mig_stats.transferred is dropped.

And transferred becomes:

qemu_file_transferred + multifd_bytes + rdma_bytes.

So everytime that we do a write, we only update one counter.

> Well, it's unrelated to this patchset, so:
>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>


