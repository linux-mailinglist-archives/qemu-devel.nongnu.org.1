Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D307D7E3B71
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:04:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0KoN-0007pg-JP; Tue, 07 Nov 2023 07:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r0KoM-0007p3-2V
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:04:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r0KoJ-0008EH-Gg
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 07:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699358638;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sLHNwdr7LWpYGcngSl/ZseknMDndyN0VUYnAj84bI8=;
 b=BrqK6dYPODsdmpeY4+LSRF/Xw9EnN0BphU0hcHTIzAwmmwlMKEUFm56W0MbE88Y/v9S7yM
 JgG8nEAnEP7brP+Zy/U9C4Ulayt1NK3Uu8G/SmEj472rkTES6U6J/pcrgkuDXYb1q7dNqg
 eaxVWP0bK5hq3n0QMf0lpEkW5YxGsB8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-1sGt6OJ8PqyBYSBA-GiaWw-1; Tue, 07 Nov 2023 07:03:47 -0500
X-MC-Unique: 1sGt6OJ8PqyBYSBA-GiaWw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d9751ca2cso2667113f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 04:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699358626; x=1699963426;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/sLHNwdr7LWpYGcngSl/ZseknMDndyN0VUYnAj84bI8=;
 b=SY+ibLyyleA5ra3P0rQX6+0EvERz+jvIwtUm5psQRRH6lsDW2nSDWmWHZ8cESlT9Sc
 092WnVFhBTM2cC1A8D6Z3EKmywCpVsyl396V00JPvkpB7tSwENJpTNCVBeAHrtxgwXUP
 8alssjpu2agzrXUWKO86gkBaR5fWA5K1KSp0mt8l41GBtMpR6Wbb25Iy0pWlqiIdKD2g
 ceKHkk630xe1yBqrn8mujgdqbinkJ9gCospANYtvpUwmG6LrIgyzebTLb7xk0frcMZfw
 FOfPtXNmaZykwM8hXxsjPFR5cWhgBc6WZqNenmAZZ08e3iLCBmbsnubmjMNGo1GMKTnK
 Fj3g==
X-Gm-Message-State: AOJu0YxEWRqvGrry2jlCG8gcKbC5fgInwu2uDoHkzzvr5Dv/RtRvihZw
 wmk4OB0MU/+plvazZuUpecTDGG+vQVuOk/f/mEnZJ2GyRwTV77akHB2M8tDSnboUbkHnjl1OqcN
 vNQqa0QqnP7f76JU=
X-Received: by 2002:a05:6000:71b:b0:32f:8064:86c0 with SMTP id
 bs27-20020a056000071b00b0032f806486c0mr23028869wrb.12.1699358626462; 
 Tue, 07 Nov 2023 04:03:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IES3dDMZvgp1IRZbwglRmFRckMhFiWyQhJpa1gjx+TlMjzJZl2kekEuz7rN37bCyKeBfuK3YQ==
X-Received: by 2002:a05:6000:71b:b0:32f:8064:86c0 with SMTP id
 bs27-20020a056000071b00b0032f806486c0mr23028854wrb.12.1699358626084; 
 Tue, 07 Nov 2023 04:03:46 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s17-20020a5d5111000000b0032dbf32bd56sm2164133wrt.37.2023.11.07.04.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:03:45 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: marcandre.lureau@redhat.com,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,  qemu-block@nongnu.org,  Hanna Reitz
 <hreitz@redhat.com>,  Jason Wang <jasowang@redhat.com>,  John Snow
 <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/6] migration: check required entries and sections
 are loaded
In-Reply-To: <20231106124405-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Mon, 6 Nov 2023 12:44:53 -0500")
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
 <20231106124405-mutt-send-email-mst@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 07 Nov 2023 13:03:44 +0100
Message-ID: <87zfzpkbxb.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> On Mon, Nov 06, 2023 at 03:35:54PM +0400, marcandre.lureau@redhat.com wro=
te:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> Hi,
>>=20
>> Surprisingly, the migration code doesn't check that required migration e=
ntries
>> and subsections are loaded. Either optional or required sections are both
>> ignored when missing. According to the documentation a "newer QEMU that =
knows
>> about a subsection can (with care) load a stream from an older QEMU that=
 didn't
>> send the subsection". I propose this behaviour to be limited to "optiona=
l"
>> sections only.
>>=20
>> This series has a few preliminary fixes, add new checks that entries are
>> loaded once and required ones have been loaded, add some tests and
>> documentation update.
>>=20
>> thanks
>
> I think this kind of thing is better deferred to the next release -
> unless you have something specific in mind this fixes?

I agree with you.

Later, Juan.

>> v3:
>>  - rebased, drop RFC status
>>  - switch from tracepoint + returning an error to report for missing
>>    subsections, as we worry about potential regressions
>>  - add r-b tags
>>=20
>> v2:
>>  - add "migration: rename vmstate_save_needed->vmstate_section_needed"
>>  - add "migration: set file error on subsection loading"
>>  - add subsection tests
>>  - update the documentation
>>=20
>> Marc-Andr=C3=A9 Lureau (6):
>>   block/fdc: 'phase' is not needed on load
>>   virtio: make endian_needed() work during loading
>>   migration: check required subsections are loaded, once
>>   migration: check required entries are loaded, once
>>   test-vmstate: add some subsection tests
>>   docs/migration: reflect the changes about needed subsections
>>=20
>>  docs/devel/migration.rst  |  17 +++---
>>  hw/block/fdc.c            |   5 ++
>>  hw/virtio/virtio.c        |   6 +-
>>  migration/savevm.c        |  43 ++++++++++++++
>>  migration/vmstate.c       |  40 ++++++++++++-
>>  tests/unit/test-vmstate.c | 116 ++++++++++++++++++++++++++++++++++++++
>>  6 files changed, 215 insertions(+), 12 deletions(-)
>>=20
>> --=20
>> 2.41.0


