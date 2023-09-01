Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3E78F9B7
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:13:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzGK-0005H4-4R; Fri, 01 Sep 2023 04:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbzG6-0005GU-5S
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbzG3-0008OM-S7
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693555917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4y8KpasydNTki6EwLl4CjttzvFm5eCWdJftrgP8a/k=;
 b=K6MxpnjHmjUXokQ1ivot1VMGNfhkvD9722dhGpgWHolUZFZlWF+SLX4fbJdmvA16c/adkR
 NGlWpTmJJ5LrBkUJDqmbOFvBxhu3IX0zj9cAYI2IxTDKo5d5n3D8VE7Jx3YHye0iHW+C0i
 hqtCAcvQmphLj7tg5PPx9ooUwnayVtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-695-TzfSF95gMmykgvPpw4gz5g-1; Fri, 01 Sep 2023 04:11:54 -0400
X-MC-Unique: TzfSF95gMmykgvPpw4gz5g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C212B801005;
 Fri,  1 Sep 2023 08:11:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81723492C13;
 Fri,  1 Sep 2023 08:11:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E84221E692A; Fri,  1 Sep 2023 10:11:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  kwolf@redhat.com,  hreitz@redhat.com,
 eblake@redhat.com,  vsementsov@yandex-team.ru,  jsnow@redhat.com,
 idryomov@gmail.com,  pl@kamp.de,  sw@weilnetz.de,
 sstabellini@kernel.org,  anthony.perard@citrix.com,  paul@xen.org,
 pbonzini@redhat.com,  marcandre.lureau@redhat.com,  berrange@redhat.com,
 thuth@redhat.com,  philmd@linaro.org,  stefanha@redhat.com,
 fam@euphon.net,  quintela@redhat.com,  peterx@redhat.com,
 leobras@redhat.com,  kraxel@redhat.com,  qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org,  alex.bennee@linaro.org
Subject: Re: [PATCH 3/7] ui: Clean up local variable shadowing
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-4-armbru@redhat.com>
 <CAFEAcA-0yYGkeg1gOtz8GRp-DbaxMQCzhRf=B4rq=Bz_DrsxNA@mail.gmail.com>
Date: Fri, 01 Sep 2023 10:11:52 +0200
In-Reply-To: <CAFEAcA-0yYGkeg1gOtz8GRp-DbaxMQCzhRf=B4rq=Bz_DrsxNA@mail.gmail.com>
 (Peter Maydell's message of "Thu, 31 Aug 2023 15:53:59 +0100")
Message-ID: <875y4ul3cn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 31 Aug 2023 at 14:25, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Local variables shadowing other local variables or parameters make the
>> code needlessly hard to understand.  Tracked down with -Wshadow=3Dlocal.
>> Clean up: delete inner declarations when they are actually redundant,
>> else rename variables.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
>> diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
>> index c107d8affc..edf42d4a6a 100644
>> --- a/ui/vnc-enc-zrle.c.inc
>> +++ b/ui/vnc-enc-zrle.c.inc
>> @@ -153,11 +153,12 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PI=
XEL *data, int w, int h,
>>      }
>>
>>      if (use_rle) {
>> -        ZRLE_PIXEL *ptr =3D data;
>> -        ZRLE_PIXEL *end =3D ptr + w * h;
>>          ZRLE_PIXEL *run_start;
>>          ZRLE_PIXEL pix;
>>
>> +        ptr =3D data;
>> +        end =3D ptr + w * h;
>> +
>>          while (ptr < end) {
>>              int len;
>>              int index =3D 0;
>> @@ -198,7 +199,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXE=
L *data, int w, int h,
>>          }
>>      } else if (use_palette) { /* no RLE */
>>          int bppp;
>> -        ZRLE_PIXEL *ptr =3D data;
>> +        ptr =3D data;
>>
>>          /* packed pixels */
>>
>> @@ -241,8 +242,6 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXE=
L *data, int w, int h,
>>  #endif
>>          {
>>  #ifdef ZRLE_COMPACT_PIXEL
>> -            ZRLE_PIXEL *ptr;
>> -
>>              for (ptr =3D data; ptr < data + w * h; ptr++) {
>>                  ZRLE_WRITE_PIXEL(vs, *ptr);
>>              }
>
> For this one I'm tempted to suggest instead moving the
> pix and end currently at whole-function scope into their
> own block, so it's clear these are actually four
> completely independent uses of ptr/end. But either way

You have a point.  However, we'd need to splice in a block just for
that, which involved some reindenting.  Can do if the assigned
maintainers (Gerd and Marc-Andr=C3=A9) prefer it.  Else, I'll stay with
minimally invasive.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!


