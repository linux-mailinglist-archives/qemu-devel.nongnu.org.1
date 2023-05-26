Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB77121D7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SVu-0002z2-0N; Fri, 26 May 2023 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SVr-0002xt-5B
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:09:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SVo-0004EH-W2
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685088564;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0bC1KYfIsDszkXXWSVi3fCxsIyug58a7GasCPmZ3TE=;
 b=IOvSE5nR+P/m3gxes/nBVn7qikMOS/VWVew9rvABezzQSzDH22IfnqxaWcicuEXY9lYInl
 adbDywMZ+U5yFdDiHQtja31kvDjz4kpSvOLCmh4lNfA//1bkM+S2o7gVZ7ENyM8uYqeLyj
 AV5PW4tq6KOAOJRH9tAfKR1E+ilNebw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540--PldfGXRNaqlF7oNiQAK-A-1; Fri, 26 May 2023 04:09:22 -0400
X-MC-Unique: -PldfGXRNaqlF7oNiQAK-A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30ac4ed46e8so304382f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088561; x=1687680561;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B0bC1KYfIsDszkXXWSVi3fCxsIyug58a7GasCPmZ3TE=;
 b=Dxk0tDsOHkCGHS3C63psLnTQJQvnk+sUVA9APFo/SCz/2l2RNp3Fy+7A3iLkW78pdB
 RpsO0kgBktHv7nipGuCHXzrnd5gbeXMZ8+e9wF1lk3jXalSPO6sb5YK3DfwVOW2kXTV1
 QOm0kfQ2sCGi1tpDgrQv8Y058hTx0kibXe+wV5n20kqC7fNMaFaI4oviZ156QvB8Rv19
 +hiHKX08rIgxY4fyhKF/bDeLmUllX66RnqYS/stqk8WSNIfej7tJgrWIN9vXS6PH+FxO
 eP1aSQgsE4H6XhkxMa5+HrYVBnntZv0FlmA6z+rqU8e+7R5MNVs5uBtXl7tj6AoSAJm7
 0OTw==
X-Gm-Message-State: AC+VfDwAbLIAPS+5zIy7UWpZNe8FZcrVw0JKX2okpOVeexna5X+lCuVf
 EAxShvc2odRSyFGG99luGkpbtq6tJE3m908OZSDCvXsbA2w17bXbs95HuyjBjzbLq1vdRbuxDWC
 NtplIPRYLtJAe1DA=
X-Received: by 2002:adf:f58a:0:b0:306:43a4:86b with SMTP id
 f10-20020adff58a000000b0030643a4086bmr820873wro.4.1685088561252; 
 Fri, 26 May 2023 01:09:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5W8qECEVZ6hdWwxP5/AufV0ovp0mUtJKSP+gw2GZ/6bR9oN7vFg5gV1ll6QK2ekVLwhSoR9Q==
X-Received: by 2002:adf:f58a:0:b0:306:43a4:86b with SMTP id
 f10-20020adff58a000000b0030643a4086bmr820794wro.4.1685088560222; 
 Fri, 26 May 2023 01:09:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v1-20020a5d6781000000b002fae7408544sm4172998wru.108.2023.05.26.01.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:09:19 -0700 (PDT)
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
Subject: Re: [PATCH v2 04/16] qemu-file: Account for rate_limit usage on
 qemu_fflush()
In-Reply-To: <d964a469a3231e1d98b2b39a5348832eecf44bf9.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Wed, 24 May 2023 22:33:39
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-5-quintela@redhat.com>
 <d964a469a3231e1d98b2b39a5348832eecf44bf9.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:09:18 +0200
Message-ID: <871qj34iq9.fsf@secure.mitica>
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

Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
>> That is the moment we know we have transferred something.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  migration/qemu-file.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
>> index 4bc875b452..956bd2a580 100644
>> --- a/migration/qemu-file.c
>> +++ b/migration/qemu-file.c
>> @@ -302,7 +302,9 @@ void qemu_fflush(QEMUFile *f)
>>                                     &local_error) < 0) {
>>              qemu_file_set_error_obj(f, -EIO, local_error);
>>          } else {
>> -            f->total_transferred +=3D iov_size(f->iov, f->iovcnt);
>> +            uint64_t size =3D iov_size(f->iov, f->iovcnt);
>> +            qemu_file_acct_rate_limit(f, size);
>> +            f->total_transferred +=3D size;
>>          }
>>=20=20
>>          qemu_iovec_release_ram(f);
>> @@ -519,7 +521,6 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_=
t *buf, size_t size,
>>          return;
>>      }
>>=20=20
>> -    f->rate_limit_used +=3D size;
>>      add_to_iovec(f, buf, size, may_free);
>>  }
>>=20=20
>> @@ -537,7 +538,6 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf=
, size_t size)
>>              l =3D size;
>>          }
>>          memcpy(f->buf + f->buf_index, buf, l);
>> -        f->rate_limit_used +=3D l;
>>          add_buf_to_iovec(f, l);
>>          if (qemu_file_get_error(f)) {
>>              break;
>> @@ -554,7 +554,6 @@ void qemu_put_byte(QEMUFile *f, int v)
>>      }
>>=20=20
>>      f->buf[f->buf_index] =3D v;
>> -    f->rate_limit_used++;
>>      add_buf_to_iovec(f, 1);
>>  }
>>=20=20
>
> If we are counting transferred data at fflush, it makes sense to increase=
 rate-
> limit accounting at the same place. It may be less granular, but is more
> efficient.

Yeap, the whole point is that in my next series, rate_limit_used
dissapear, we just use transferred for both things(*).

Later, Juan.

*: It is a bit more complicated than that, but we go from three counters
 to a single counter.


