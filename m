Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3D715BD2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wcs-0002uT-Ry; Tue, 30 May 2023 06:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3wcq-0002tv-VK
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3wcp-00059I-7K
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685442646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11LHMJpje45c7UNHt+x3s5P5Bd0fl3HEeGnN2w8Bv8Q=;
 b=iRgnrNilnZp0LR4xH+dMmLKb+KOOSae1ToYfKTKHjUhr6wRbcWDTGJijGVg/1FbAkCAqNn
 BgdfBo+3LEvGWEgMew3w6aGUY9kyQn53TJUX3WGUnV+pK8RvshsK9tO8PnPmHjMmSHlRHQ
 jEi1p7FqHUOdghoPlHFOS0ooZALXh5w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-xIBAYPzQOIWQdQ-l-3sSJA-1; Tue, 30 May 2023 06:30:44 -0400
X-MC-Unique: xIBAYPzQOIWQdQ-l-3sSJA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3062e5d0cd3so1633872f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685442643; x=1688034643;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=11LHMJpje45c7UNHt+x3s5P5Bd0fl3HEeGnN2w8Bv8Q=;
 b=GFKf1hPpadvklV/uI0zpNdZbS3UqsjnOIDsLYRsW+eMOYYvD4B2vMquCctyikizQkC
 XsaVNdg6q9/0z9hGfLB94Qy2a2D6En2ZXAq22XftyfbFvTmLb56FK1Q5oWn1t5PKDbfb
 erRWgqdFmbZaptS/XnSj2v3eMdjtne4l9JbQskIOYSFs34xJNhsb1hoedJ9o3J8QrGbS
 FaualBwopXX64VsEW9cEZQFaoQDiuAkqt23BjS8pVva9ZnR5zqU3eZrPf0xoVst6/aXM
 2dEX1O+N0cOiR/jiftuRxI3TAkFzl9PZWvFsc2KwgzUJdI9s8z1kRrwa10fky+zBvaXB
 vZFw==
X-Gm-Message-State: AC+VfDwGL8Z4+530KbOw1Xe43b/fbEA4weR11dH5+Y3YbOfj38X4vsHK
 Qwtlge4R9rIUW8moIM9eUwa1JzD9hc8FT0mU5ZjvDHS/znJFjWHo+h6xUPIySHzmxUuSInlaQWh
 3ETeCAZm35AUmC2k=
X-Received: by 2002:a5d:568d:0:b0:2f0:e287:1fbc with SMTP id
 f13-20020a5d568d000000b002f0e2871fbcmr1307039wrv.11.1685442643493; 
 Tue, 30 May 2023 03:30:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TDMMGpfp8eQIPdUiWQnsTnBawTjP6s4i5AnVpu7ncLmCzKIsrpo6QuZ8IbJvX9rwHRX9s+A==
X-Received: by 2002:a5d:568d:0:b0:2f0:e287:1fbc with SMTP id
 f13-20020a5d568d000000b002f0e2871fbcmr1307011wrv.11.1685442643229; 
 Tue, 30 May 2023 03:30:43 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o11-20020a5d670b000000b0030ada01ca78sm2815029wru.10.2023.05.30.03.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 03:30:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo Bras Soares Passos <leobras@redhat.com>
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
Subject: Re: [PATCH v2 02/16] migration: Correct transferred bytes value
In-Reply-To: <CAJ6HWG7N_YGNxU4dd4DMumFjqWWhQRqP=RngkAUYQ52E-29G5g@mail.gmail.com>
 (Leonardo Bras Soares Passos's message of "Fri, 26 May 2023 15:50:52
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-3-quintela@redhat.com>
 <1e3a3735a5ba81abb562e8f6c21ab33f38992af5.camel@redhat.com>
 <87a5xr4iy8.fsf@secure.mitica>
 <CAJ6HWG7N_YGNxU4dd4DMumFjqWWhQRqP=RngkAUYQ52E-29G5g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 12:30:41 +0200
Message-ID: <87jzwqw1pq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

Leonardo Bras Soares Passos <leobras@redhat.com> wrote:
> On Fri, May 26, 2023 at 5:04=E2=80=AFAM Juan Quintela <quintela@redhat.co=
m> wrote:
>> > Maybe too much?
>>
>> I dropped this patch for two reasons:
>>
>> - reviewers gave me a bad time with it O:-)
>> - it was there only so if anyone was meassuring that new counters are
>>   the same that old counters.
>>
>> But as I have already checked that, we don't need it.
>>
>> I drop it on the next round that I send.
>> > Maybe, it would be nice to have qemu_put_* to return the value, and in=
 this
>> > case:
>> >
>> > size +=3D qemu_put_be64(...)
>> >
>> > What do you think?
>>
>> Even more important than that is to return an error value, but that
>> is a very long project.
>>
>> See on my next series that qemu_fflush() return errors, so code gets
>> simplifed:
>>
>> qemu_fflush(file);
>> if (qemu_file_get_error(file)) {
>>     handle error;
>> }
>>
>> to:
>>
>> qemu_fflush(file);
>> if (qemu_file_get_error(file)) {
>>     handle error;
>> }
>>
>
> They look the same to me, what changed?

I did copy paste without changing:

if (qemu_fflush(file)) {
    handle error;
}



>> We need to do basically all qemu_put_*() and qemu_get_*() functions, but
>> it is a step on the right direction.
>>
>> Later, Juan.
>>


