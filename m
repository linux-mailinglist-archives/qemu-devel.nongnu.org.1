Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B657CF09F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 09:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtN2b-000353-Vq; Thu, 19 Oct 2023 03:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtN2Z-00034f-VI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtN2Y-0006cy-3J
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 03:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697698913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dx91PzshmhTVrfm7PvzzhQ4DDoykCwwngesk0rwncCg=;
 b=HXL/kzkRmpboyaTgypb5bQOT3iF8j8GkGHcSEzJurQQdb7h2WJBk/6W+yk0gGP8HREiZUg
 ic2Qhk3vIx3n9driO7rqqNTZujLyGvXOZtrXodQY4JeL3z1fQqYXF2Ns/p6qCtPWpNNSrj
 QAtvMTHccL/D96dq5dXRF9te/SnN1YU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-IMAtytQLNZW4wR0-6tXvBQ-1; Thu, 19 Oct 2023 03:01:46 -0400
X-MC-Unique: IMAtytQLNZW4wR0-6tXvBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F904185A7A7;
 Thu, 19 Oct 2023 07:01:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B373940C6F7B;
 Thu, 19 Oct 2023 07:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96B5F21E6A1F; Thu, 19 Oct 2023 09:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  qemu-block@nongnu.org,  qemu-devel@nongnu.org,
 eblake@redhat.com,  dave@treblig.org,  eduardo@habkost.net,
 pbonzini@redhat.com,  hreitz@redhat.com,  kwolf@redhat.com,
 raphael.norwitz@nutanix.com,  yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru,  daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
 <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
 <878r80tdyd.fsf@pond.sub.org>
 <20231018064912-mutt-send-email-mst@kernel.org>
 <ZS+6g+vtYz9Uh6G3@redhat.com> <87o7gwp29r.fsf@pond.sub.org>
 <87a2b829-3622-4c5d-a449-73fedfebf7ed@yandex-team.ru>
Date: Thu, 19 Oct 2023 09:01:44 +0200
In-Reply-To: <87a2b829-3622-4c5d-a449-73fedfebf7ed@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 18 Oct 2023 15:39:52 +0300")
Message-ID: <87bkcvksdj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 18.10.23 15:02, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Wed, Oct 18, 2023 at 06:51:41AM -0400, Michael S. Tsirkin wrote:
>>>> On Wed, Oct 18, 2023 at 12:36:10PM +0200, Markus Armbruster wrote:
>>>>>> x- seems safer for management tool that doesn't know about "unstable=
" properties..
>>>>>
>>>>> Easy, traditional, and unreliable :)
>>>>
>>>>>> But on the other hand, changing from x- to no-prefix is already
>>>>>> done when the feature is stable, and thouse who use it already
>>>>>> use the latest version of interface, so, removing the prefix is
>>>>>> just extra work.
>>>>>
>>>>> Exactly.
>>>>>
>>>>
>>>> I think "x-" is still better for command line use of properties - we
>>>> don't have an API to mark things unstable there, do we?
>>>
>>> Personally I like to see "x-" prefix present *everywhere* there is
>>> an unstable feature, and consider the need to rename when declaring
>>> it stable to be good thing as it sets an easily identifiable line
>>> in the sand and is self-evident to outside observers.
>>>
>>> The self-documenting nature of the "x-" prefer is what makes it most
>>> compelling to me. A patch submission, or command line invokation or
>>> an example QMP command, or a bug report, that exhibit an 'x-' prefix
>>> are an immediate red flag to anyone who sees them.
>> Except when it isn't, like in "x-origin".
>>=20
>
> Interesting how many such stable x-FOO things we have?

I don't know.

I think the more interesting question is how many *unstable* things we
have that aren't named x-FOO.  I'm thinking of stuff that was never
intended to be exposed externally.  QOM/qdev properties, mostly.  For
extra spiciness, throw in qom-get and especially qom-set.

> Probably we could deprecate and than rename them?

I guess we can if we care :)


