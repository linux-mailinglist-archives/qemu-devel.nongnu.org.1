Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DFAB03862
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 09:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubDzQ-0001Qr-Oo; Mon, 14 Jul 2025 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubDUz-00087d-6N
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubDUx-0003Aq-2c
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 03:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752477671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Ja6H3c5MYq2KwEjgLefTnXo/1e69DRPjinokkx8xNo=;
 b=h3oCFICZ1Lx7MtzeEi0jDheJw3ASy76pvk7RLGughI9WkkRjPhYie84Q9jcI0XicQiwsqJ
 Lpf/Xn6J49VDDoAeLad1yT+JyRjdZ39bTO6Fnfd1/5804idg1+pMxVFRZ5raJtDzWzsHen
 EYJYUVRPlgB0/6VoLZHBs4qChaotNZY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-uFxGKCrEMSWSzdIZfa8Tbg-1; Mon,
 14 Jul 2025 03:21:07 -0400
X-MC-Unique: uFxGKCrEMSWSzdIZfa8Tbg-1
X-Mimecast-MFC-AGG-ID: uFxGKCrEMSWSzdIZfa8Tbg_1752477664
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0E4F1800366; Mon, 14 Jul 2025 07:21:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A35FD1977000; Mon, 14 Jul 2025 07:21:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06D4521E6A27; Mon, 14 Jul 2025 09:20:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Jiri Pirko <jiri@resnulli.us>,  Fan
 Ni <fan.ni@samsung.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kashyap Chamarthy <kchamart@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,  Ani Sinha <anisinha@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?=
 Le Goater <clg@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex Williamson
 <alex.williamson@redhat.com>,  Zhenwei Pi <pizhenwei@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,  Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v3 4/5] docs/sphinx: remove special parsing for freeform
 sections
In-Reply-To: <875xgd9zpj.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 30 Jun 2025 14:32:56 +0200")
References: <20250618165353.1980365-1-jsnow@redhat.com>
 <20250618165353.1980365-5-jsnow@redhat.com>
 <874iw1o6jt.fsf@pond.sub.org>
 <CAFn=p-ZkBt8ck7WWg_1FFBi5GoYmyEhVPZGfdL4ODN6GBn3YSw@mail.gmail.com>
 <875xgd9zpj.fsf@pond.sub.org>
Date: Mon, 14 Jul 2025 09:20:58 +0200
Message-ID: <87o6tn6xwl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> On Fri, Jun 27, 2025, 5:52=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>> > This change removes special parsing for freeform sections and allows
>>> > them to simply be unmodified rST syntax. The existing headings in the
>>> > QAPI schema are adjusted to reflect the new paradigm.
>>>
>>> "Allows them to" suggests the patch enables use of rST headings.  Is
>>> this the case?  Or do they just work, and this patch just switches
>>> schema code to use them, and drops now unnecessary generator code?
>>>
>>
>> Ehm... Kind of both? I guess I hadn't considered that rST headings might
>> already work without the switch. I guess they didn't because of the
>> headerless freeform section bug I fix in this series.

[...]

> So you're right, "kind of both": they work just fine with the new doc
> generator, except for the "=3D=3D=3D=3D" rST headings, because the parser=
 still
> recognizes them as old-style schema doc headings.
>
>> I guess you're technically right, I just never thought of it in that way.
>>
>> I'll update the message so I don't confuse you in the future.
>
> Yes, please.
>
> [...]

I'm going with

    docs/sphinx: remove special parsing for freeform sections

    Remove the QAPI doc section heading syntax, use plain rST section
    headings instead.

    Tests and documentation are updated to match.

    Interestingly, Plain rST headings work fine before this patch, except
    for over- and underlining with '=3D', which the doc parser rejected as
    invalid QAPI doc section heading in free-form comments.


