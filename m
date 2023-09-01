Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09778FF7B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:51:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Ti-0007AV-Qa; Fri, 01 Sep 2023 10:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc5Td-000793-Bl
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc5TV-0000VK-PB
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693579814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paHLoHNKtg8UFBFt/WB+m2kHfbeuo7pAuQSEBP1sizg=;
 b=JsojMRJ6K3QNCSOuwR5SOkQLfAVy0CHgGLpNR77Qm9hhqRFdRUX5+GcXI+x1MRP6GhW0QM
 6Qh5KZtiYotsvD6mn4drBY767z703/GQGr0AIs6UwpopeaFrA8zswfD4BAF47vtJmCdtEi
 mNKaIEm4oiXVBipmx7aAy0xggj9TquU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-esBF9IBpOe2aBcfYjXur5w-1; Fri, 01 Sep 2023 10:50:05 -0400
X-MC-Unique: esBF9IBpOe2aBcfYjXur5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F4641817905;
 Fri,  1 Sep 2023 14:50:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B9AE1460FE5;
 Fri,  1 Sep 2023 14:50:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3048A21E692A; Fri,  1 Sep 2023 16:50:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Eric Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,
 kwolf@redhat.com,  hreitz@redhat.com,  vsementsov@yandex-team.ru,
 jsnow@redhat.com,  idryomov@gmail.com,  pl@kamp.de,  sw@weilnetz.de,
 sstabellini@kernel.org,  anthony.perard@citrix.com,  paul@xen.org,
 pbonzini@redhat.com,  marcandre.lureau@redhat.com,  berrange@redhat.com,
 thuth@redhat.com,  philmd@linaro.org,  stefanha@redhat.com,
 fam@euphon.net,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com,  kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 7/7] qobject atomics osdep: Make a few macros more hygienic
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-8-armbru@redhat.com>
 <vfkfi6uld3gbd4urmqdlzkv6djtws6mkbluc5qvwcla6btszhu@ff66zfyd7smm>
 <7b8a4589-7f29-e564-4904-9b1a4fd342af@kaod.org>
Date: Fri, 01 Sep 2023 16:50:02 +0200
In-Reply-To: <7b8a4589-7f29-e564-4904-9b1a4fd342af@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Fri, 1 Sep 2023 14:59:22 +0200")
Message-ID: <87ttsevtgl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 8/31/23 16:30, Eric Blake wrote:
>> On Thu, Aug 31, 2023 at 03:25:46PM +0200, Markus Armbruster wrote:
>> [This paragraph written last: Bear with my stream of consciousness
>> review below, where I end up duplicating some of the conslusions you
>> reached before the point where I saw where the patch was headed]
>>=20
>>> Variables declared in macros can shadow other variables.  Much of the
>>> time, this is harmless, e.g.:
>>>
>>>      #define _FDT(exp)                                                 =
 \
>>>          do {                                                          =
 \
>>>              int ret =3D (exp);                                        =
   \
>>>              if (ret < 0) {                                            =
 \
>>>                  error_report("error creating device tree: %s: %s",   \
>>>                          #exp, fdt_strerror(ret));                     =
 \
>>>                  exit(1);                                              =
 \
>>>              }                                                         =
 \
>>>          } while (0)
>> Which is why I've seen some projects require a strict namespace
>> separation: if all macro parameters and any identifiers declared in
>> macros use either a leading or a trailing _ (I prefer a trailing one,
>> to avoid risking conflicts with libc reserved namespace; but leading
>> is usually okay), and all other identifiers avoid that namespace, then
>> you will never have shadowing by calling a macro from normal code.
>
> I started fixing the _FDT() macro since it is quite noisy at compile.
> Same for qemu_fdt_setprop_cells(). So are we ok with names like 'ret_'
> and 'i_' ? I used a 'local_' prefix for now but I can change.

I believe identifiers with a '_' suffix are just fine in macros.  We
have quite a few of them already.

> I also have a bunch of fixes for ppc.

Appreciated!


