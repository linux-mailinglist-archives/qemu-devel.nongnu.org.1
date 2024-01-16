Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E580F82E9AD
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 07:49:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdFF-0003gc-0C; Tue, 16 Jan 2024 01:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPdFA-0003gC-HC
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPdF8-0005ca-FW
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705387693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPtJMuIPBfQ7u42tzPFCHIGpt1F59UnweyOUbEFXedI=;
 b=a8P+8mN1lU1a+GPWGg0tUPzaOLjOHqvSemsAK//0TvjbA3xAd/pF6jQjXHj8lx7u35Ts5s
 Hj1MmTPPWVff99mtZcOspgu0DoJLbFbUb9CultX2bWWdQChnCKf3mNXeuqquQhE5JCnYVt
 pURTdGt3BUEbJ8Ocf8Oplaxb9gybwGg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-iu4DNxgjMFuwi-DZxbJF4A-1; Tue,
 16 Jan 2024 01:48:11 -0500
X-MC-Unique: iu4DNxgjMFuwi-DZxbJF4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEDE538041C1;
 Tue, 16 Jan 2024 06:48:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C17A28AC;
 Tue, 16 Jan 2024 06:48:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 888F121E680D; Tue, 16 Jan 2024 07:48:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 01/19] qapi: sort pylint suppressions
In-Reply-To: <CAFn=p-YAm6WR-zzDjR_xcNo8evQN57JVf6sd1qDOMNV5rhWxfQ@mail.gmail.com>
 (John Snow's message of "Mon, 15 Jan 2024 14:58:47 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-2-jsnow@redhat.com>
 <8734uyeqng.fsf@pond.sub.org>
 <CAFn=p-YAm6WR-zzDjR_xcNo8evQN57JVf6sd1qDOMNV5rhWxfQ@mail.gmail.com>
Date: Tue, 16 Jan 2024 07:48:09 +0100
Message-ID: <87r0ih93km.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On Mon, Jan 15, 2024 at 7:18=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/pylintrc | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
>> > index 90546df5345..78b63af4df6 100644
>> > --- a/scripts/qapi/pylintrc
>> > +++ b/scripts/qapi/pylintrc
>> > @@ -16,14 +16,14 @@ ignore-patterns=3Dschema.py,
>> >  # --enable=3Dsimilarities". If you want to run only the classes check=
er, but have
>> >  # no Warning level messages displayed, use "--disable=3Dall --enable=
=3Dclasses
>> >  # --disable=3DW".
>> > -disable=3Dfixme,
>> > +disable=3Dconsider-using-f-string,
>> >          missing-docstring,
>> >          too-many-arguments,
>> >          too-many-branches,
>> > -        too-many-statements,
>> >          too-many-instance-attributes,
>> > -        consider-using-f-string,
>> > +        too-many-statements,
>> >          useless-option-value,
>> > +        fixme,
>> >
>> >  [REPORTS]
>>
>> Any particular reason for putting fixme last?
>>
>
> Uhh. You know, I have no idea? I swore I just used emacs to sort the
> lines, but ... lol? You'd think I'd notice that this wasn't in
> alphabetical order, but...
>
> *cough* sorry

No worries, happens to the best of us :)


