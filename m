Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B7934E7D
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 15:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURVK-0006Rt-Vp; Thu, 18 Jul 2024 09:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURVE-0006Gl-94
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURVC-0004f5-K2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721310537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lF8G5dGvUUCjPCOpytlvirSXzAoLbuo5rBXXaqxAZOo=;
 b=IyUU+VbpD4GqYOUFoTJIF2pEa/D0x7pVRXG18LUAC6eVqRwBzcDmlln3sxAN6X1o5L6p5v
 AitBut9NCO7B6OwL1w726pL4TZsE75LsHCmkHZ45+ZZmvb8DIiFiEJfiy3ABdWV04vdd/S
 LD3cYtZZc+ARbXkWfMBDWM8DE2Wjgq8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-93AyKE-FOn25Dywx2vyG4g-1; Thu,
 18 Jul 2024 09:48:54 -0400
X-MC-Unique: 93AyKE-FOn25Dywx2vyG4g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62FCD1955F28; Thu, 18 Jul 2024 13:48:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0066719560B2; Thu, 18 Jul 2024 13:48:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5F9121E668F; Thu, 18 Jul 2024 15:48:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
Cc: Markus Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Dau?=
 =?utf-8?Q?d=C3=A9?=
 <philmd@linaro.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap
 Chamarthy <kchamart@redhat.com>,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v5 2/4] docs/interop/firmware.json: add new enum
 FirmwareArchitecture
In-Reply-To: <20240718152757-ea83949a-2ef8-4bf8-aeff-c1412baa753c@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Thu, 18 Jul 2024
 15:29:13 +0200")
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-2-0dba12d7aaf5@linutronix.de>
 <871q3qon3k.fsf@pond.sub.org>
 <20240718152757-ea83949a-2ef8-4bf8-aeff-c1412baa753c@linutronix.de>
Date: Thu, 18 Jul 2024 15:48:50 +0200
Message-ID: <878qxyn73x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Wei=C3=9Fschuh <t-8ch@linutronix.de> writes:

> On Thu, Jul 18, 2024 at 03:18:07PM GMT, Markus Armbruster wrote:
>> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
>>=20
>> > Only a small subset of all architectures supported by qemu make use of
>> > firmware files. Introduce and use a new enum to represent this.
>> >
>> > This also removes the dependency to machine.json from the global qapi
>> > definitions.
>> >
>> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>> > ---
>> >  docs/interop/firmware.json | 29 +++++++++++++++++++++++++++--
>> >  1 file changed, 27 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
>> > index a26fe81bf2fe..2eb0be11d595 100644
>> > --- a/docs/interop/firmware.json
>> > +++ b/docs/interop/firmware.json
>> > @@ -14,7 +14,10 @@
>> >  # =3D Firmware
>> >  ##
>> >=20=20
>> > -{ 'include' : 'machine.json' }
>> > +{ 'pragma': {
>> > +    'member-name-exceptions': [
>> > +        'FirmwareArchitecture' # x86_64
>> > +    ] } }
>> >=20=20
>> >  ##
>> >  # @FirmwareOSInterface:
>> > @@ -59,6 +62,28 @@
>> >  { 'enum' : 'FirmwareDevice',
>> >    'data' : [ 'flash', 'kernel', 'memory' ] }
>> >=20=20
>> > +##
>> > +# @FirmwareArchitecture:
>> > +#
>> > +# Enumerations of architectures for which Qemu uses additional firmwa=
re files.
>>=20
>> docs/devel/qapi-code-gen.rst section "Documentation markup":
>>=20
>>     For legibility, wrap text paragraphs so every line is at most 70
>>     characters long.
>>=20
>> > +# The values are a subset of the enum SysEmuTarget.
>
> Ack.
>
>> Will consumers of firmware.json care for this?
>
> Most probably not.
>
>> Or is it just a reminder for developers to keep the two enums in sync?
>
> I guess so.
> Should I drop it?

You can drop it.

If you think it's useful for developers, you can instead make it a
non-doc comment, like ...

>>=20
>> > +#
>> > +# @aarch64: 64-bit Arm.
>> > +#
>> > +# @arm: 32-bit Arm.
>> > +#
>> > +# @i386: 32-bit x86.
>> > +#
>> > +# @loongarch64: 64-bit LoongArch.
>> > +#
>> > +# @x86_64: 64-bit x86.
>> > +#
>> > +# Since: 9.1
>>=20
>> The enum type is indeed since 9.1, but its members are since 3.0, and
>> that's what matters.  Except for @loongarch, which is since 7.1.0 (not
>> documented in qapi/machine.json; I'll fix that).
>>=20
>> > +##
>> > +{ 'enum' : 'FirmwareArchitecture',
>> > +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }

... here:

      # The values are a subset of the enum SysEmuTarget defined in
      # qapi/machine.json.

If you do, consider adding a similar note to FirmwareFormat in the
previous patch.

>> > +
>> > +
>>=20
>> Drop one blank line, please.
>
> Ack.
>
>>=20
>> >  ##
>> >  # @FirmwareTarget:
>> >  #
>> > @@ -80,7 +105,7 @@
>> >  # Since: 3.0
>> >  ##
>> >  { 'struct' : 'FirmwareTarget',
>> > -  'data'   : { 'architecture' : 'SysEmuTarget',
>> > +  'data'   : { 'architecture' : 'FirmwareArchitecture',
>> >                 'machines'     : [ 'str' ] } }
>> >=20=20
>> >  ##
>>=20


