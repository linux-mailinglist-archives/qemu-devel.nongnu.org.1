Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 577DE7EAD62
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:51:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2q4m-0000Sb-0E; Tue, 14 Nov 2023 04:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2q4i-0000S9-Mu
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r2q4g-0001pM-OR
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699955473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUfVVyxKxp8nmPIUQXIY5bF6nOriVH/SuR23saAG9D0=;
 b=Exh7NhG+s17/76K6oMLXQL71CZfTD4L+6eK/+pFJg+LL25fFMvbt6NVJOAU/9YUb+69uwy
 1DJDlugPKvfQBxBxa9ZGeJpDj9nh3INU7NgaC5hIsGSe4XHOGelStasbo5gUDvL8+cbiBF
 qDzN9/OJ77Z19uw72+HbegJN7Hqg0sI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-geuh3tAAPOuCYHrqRg2vEg-1; Tue, 14 Nov 2023 04:51:09 -0500
X-MC-Unique: geuh3tAAPOuCYHrqRg2vEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D18A82B9D4;
 Tue, 14 Nov 2023 09:51:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0562F1C060AE;
 Tue, 14 Nov 2023 09:51:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C0FE21E6A1F; Tue, 14 Nov 2023 10:51:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, alistair@alistair23.me,  edgar.iglesias@gmail.com,
 peter.maydell@linaro.org,  francisco.iglesias@amd.com,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/2] Replace anti-social QOM type names (again)
References: <20231113134344.1195478-1-armbru@redhat.com>
 <ZVIo3FsmwpfHzsh8@redhat.com> <87y1f0hjdh.fsf@pond.sub.org>
 <fb41ec92-d953-4536-b217-8c06f63115ef@redhat.com>
Date: Tue, 14 Nov 2023 10:51:08 +0100
In-Reply-To: <fb41ec92-d953-4536-b217-8c06f63115ef@redhat.com> (Thomas Huth's
 message of "Tue, 14 Nov 2023 09:06:13 +0100")
Message-ID: <871qcsfysz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 14/11/2023 08.41, Markus Armbruster wrote:
>> Cc: the other QOM maintainers
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Mon, Nov 13, 2023 at 02:43:42PM +0100, Markus Armbruster wrote:
>>>> We got rid of QOM type names containing ',' in 6.0, but some have
>>>> crept back in.  Replace them just like we did in 6.0.
>>>
>>> It is practical to add
>>>
>>>     assert(strchr(name, ',') =3D=3D NULL)
>>>
>>> to some place in QOM to stop them coming back yet again ?
>>
>> This adds a naming rule to QOM.  Right now, QOM has none whatsoever,
>> which I've long called out as a mistake.
>>
>> I'm all for correcting that mistake, but I'd go further than just
>> outlawing ','.
>
> What prevents us from fixing this "mistake"?

1. Having to clean up the naming messes we made.  This involves backward
compatibility arguments and work-arounds.

2. Inertia.

> Is there any compelling reason for keeping the current lax naming rules o=
f QOM?

Can't think of any but avoiding 1.

> Would there be migration issues if we'd rename the current offenders? (an=
d even if so, couldn't we simply fix that issue by curating an allowlist of=
 old names?)

I believe migration should not be affected, since migration section
names are entirely separate.  Mind, I'm no migration expert.


