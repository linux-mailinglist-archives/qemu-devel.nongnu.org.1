Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E69817A23
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIkb-00037f-8p; Mon, 18 Dec 2023 13:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIjy-0002qq-3Q; Mon, 18 Dec 2023 13:53:23 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIjv-0000D8-S9; Mon, 18 Dec 2023 13:53:21 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a233a60f8feso237416566b.0; 
 Mon, 18 Dec 2023 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925597; x=1703530397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LXUiSHNk6IH0G7+C1olfxGi/mVy7xyPXmSVgDEQyEU=;
 b=SHj2x8555bPh9x1tcnEURntwducZg28T/D+vm7QqQZUBqIPADBP9frCzWwYzQtOVUO
 MWgjqh2E5hB5mHvjtFsrdUcnifqfQEixK9Y6C9qPh6+kwiqbkBS+OgB9qoLZCG7yJxrS
 3c4XKgzr59lAYFR48CTZwB2lmA/juBjzr/gKvBGgfx5YC3mvaKZGnjE3DyprmLL7tbtj
 YWascN1pwGMUIFqJ+0vWp6pCxY3AdF7JrXbvQeyrVLbWpc5Kf35HGcjjkMO+HuSwJ1Ba
 yHneKjAVyMzbl0/qKL7eg/MNXOffKymlpMb0Dhed/6j9Mleo6N/uL2p09Pw8oVsccdGy
 1zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925597; x=1703530397;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LXUiSHNk6IH0G7+C1olfxGi/mVy7xyPXmSVgDEQyEU=;
 b=F+LwtyHuTUNlh6mhWGLaPkImWTMaxPZWuZW7yoBXlUOKS48bISCMne64AANQbwWF4x
 9iPo77D5RaeF9yCpYN5g5162mnh/DxviTICVYuSG4pTtGM4frr5vy4gnMM+oXNnX2adK
 0BwTXgaS6nKzHnUB9xLXSotbHQj9mEN3S+ntdSpIh0logqZQKMPycyoIrWzn/iEc45FZ
 FwNUk12lGrUErohSkLepsGWBO0a4NgC6i3oexwrueOep51yTXg1kV/cS/+TZeLBa4rhZ
 +ngst5TONDuqyKqrwWYM27j/tuIdi/r0jELpotIXAgen0clXgLo9XI9iwgeKwe1ZIMt6
 wc8w==
X-Gm-Message-State: AOJu0YzU6+QlLSp1byIZxqhdMJEjvAjZEnxbwea+K1YlUWKrT8ke1PlB
 8XPG54XCO+ZF8sKzMTDsD10=
X-Google-Smtp-Source: AGHT+IGLc+8HG008XRrUI48JYtCbVZMC0aVZGKgh1pUueSuVLG+sBjs0dT+YmEoRzyriVN+iBOHRGA==
X-Received: by 2002:a17:906:5352:b0:a1f:9617:99a with SMTP id
 j18-20020a170906535200b00a1f9617099amr5947460ejo.94.1702925597476; 
 Mon, 18 Dec 2023 10:53:17 -0800 (PST)
Received: from [127.0.0.1] (dynamic-092-224-039-156.92.224.pool.telefonica.de.
 [92.224.39.156]) by smtp.gmail.com with ESMTPSA id
 rd12-20020a170907a28c00b00a097c5162b0sm14328402ejc.87.2023.12.18.10.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 10:53:17 -0800 (PST)
Date: Mon, 18 Dec 2023 18:53:09 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 04/12] hw/block/fdc: Expose internal header
In-Reply-To: <26832f40-8202-5f48-a197-ba213d4a0128@eik.bme.hu>
References: <20231217144148.15511-1-shentey@gmail.com>
 <20231217144148.15511-5-shentey@gmail.com>
 <b4b1d529-f368-4f8f-b357-4ad5177a2951@eik.bme.hu>
 <91BF37F6-494D-4656-9CE8-7FDA0C3C8F33@gmail.com>
 <26832f40-8202-5f48-a197-ba213d4a0128@eik.bme.hu>
Message-ID: <987BBA5E-3A7F-4A3C-B45E-E31183BB5F46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



Am 18=2E Dezember 2023 10:54:56 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Sun, 17 Dec 2023, Bernhard Beschow wrote:
>> Am 17=2E Dezember 2023 15:47:33 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>> On Sun, 17 Dec 2023, Bernhard Beschow wrote:
>>>> Exposing the internal header allows for exposing struct FDCtrlISABus =
which is
>>>> encuraged by qdev guidelines=2E
>>>=20
>>> Hopefully the guidelines don't encourage this as object orientation in=
deed encourages object encapsulation so only the object itseld should poke =
its internals and other objects should use methods the change object state=
=2E In QOM some object states were exposed in public headers to allow embed=
ding those objects in other objects becuase C needs the struct size to allo=
w that=2E This was to simplify memory management so the embedded objects do=
n't need to be tracked and freed but would be created and freed with the ot=
her object embedding it but this does not mean the other object should poke=
 into these object or that this is a general guideline to expose internal o=
bject state=2E I'd say the exposed objects are an exception instead of reco=
mmended guideline and only allowed for objects that need to be embeded in o=
thers but generally object encapsulation would be better to preserve where =
possible=2E This patch exposes objects so others can poke into them which w=
ould make those other objects depe
>ndent on the implementation of these objects making these harder to chnag=
e in the future so a better way may be to add methods to fdc and serial to =
allow changing their base address and map/unmap their ports and keep their =
internals unexposed=2E
>>=20
>> Each ISADevice sub class would need concenience methods as well as each=
 state class=2E This series touches three of each: fdc, parallel, serial=2E=
 And each of those need two convenience methods: set_enabled() and set_addr=
ess()=2E This would add another 12 functions on top of the current ones=2E
>
>If all ISA devices need this then these should really be methods of ISADe=
vice but since that's just an empty wrapper over devices each of which hand=
les its own ports, the ISADevice does not know about those and since each d=
evice may have different ports and not all of them uses portio lists for th=
is, moving port handling to ISADevice might be too big refactoring to do fo=
r this=2E Keeping these functions with the superio component devices so the=
ir implementation is kept private still worth it in my opinion so even if t=
hat adds 2 functions to superio component devices (which is not all ISA dev=
ices just a limited set) seems to be a better approach to me than breaking =
encapsulation of objects=2E These are simple access methods for internal ob=
ject state which are common in object otiented programming=2E
>
>> Then ISASuperIODevice would require at least 6 more such methods (not c=
ounting the unneeded ones for IDE which might be desirable for consistency)=
=2E So in the end we'd have at least 18 more methods=2E Is this really wort=
h it?
>
>We may do without these if we say superio is just a container of componen=
ts so don't add forwarding methods but we can call the accessor methods of =
component objects from vt82c686=2Ec=2E That's still better than reaching in=
to object internals from foreign objects=2E

Version 2 is out which should address all of your comments=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> I didn't feel very comfortable going this route, so ended up with the c=
urrent solution poking the states directly=2E I'm open to different approac=
hes including the one above but I'd really like to know the opinion of the =
maintainers, too=2E
>>=20
>> Best regards,
>> Bernhard
>>=20
>>>=20
>>> Regards,
>>> BALATON Zoltan
>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>> MAINTAINERS                                       | 2 +-
>>>> hw/block/fdc-internal=2Eh =3D> include/hw/block/fdc=2Eh | 4 ++--
>>>> hw/block/fdc-isa=2Ec                                | 2 +-
>>>> hw/block/fdc-sysbus=2Ec                             | 2 +-
>>>> hw/block/fdc=2Ec                                    | 2 +-
>>>> 5 files changed, 6 insertions(+), 6 deletions(-)
>>>> rename hw/block/fdc-internal=2Eh =3D> include/hw/block/fdc=2Eh (98%)
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index b4718fcf59=2E=2E939f518701 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1945,9 +1945,9 @@ M: John Snow <jsnow@redhat=2Ecom>
>>>> L: qemu-block@nongnu=2Eorg
>>>> S: Odd Fixes
>>>> F: hw/block/fdc=2Ec
>>>> -F: hw/block/fdc-internal=2Eh
>>>> F: hw/block/fdc-isa=2Ec
>>>> F: hw/block/fdc-sysbus=2Ec
>>>> +F: include/hw/block/fdc=2Eh
>>>> F: include/hw/block/fdc-isa=2Eh
>>>> F: tests/qtest/fdc-test=2Ec
>>>> T: git https://gitlab=2Ecom/jsnow/qemu=2Egit ide
>>>> diff --git a/hw/block/fdc-internal=2Eh b/include/hw/block/fdc=2Eh
>>>> similarity index 98%
>>>> rename from hw/block/fdc-internal=2Eh
>>>> rename to include/hw/block/fdc=2Eh
>>>> index 1728231a26=2E=2Eacca7e0d0e 100644
>>>> --- a/hw/block/fdc-internal=2Eh
>>>> +++ b/include/hw/block/fdc=2Eh
>>>> @@ -22,8 +22,8 @@
>>>>  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEAL=
INGS IN
>>>>  * THE SOFTWARE=2E
>>>>  */
>>>> -#ifndef HW_BLOCK_FDC_INTERNAL_H
>>>> -#define HW_BLOCK_FDC_INTERNAL_H
>>>> +#ifndef HW_BLOCK_FDC_H
>>>> +#define HW_BLOCK_FDC_H
>>>>=20
>>>> #include "exec/memory=2Eh"
>>>> #include "exec/ioport=2Eh"
>>>> diff --git a/hw/block/fdc-isa=2Ec b/hw/block/fdc-isa=2Ec
>>>> index 6387dc94fa=2E=2E7058d4118f 100644
>>>> --- a/hw/block/fdc-isa=2Ec
>>>> +++ b/hw/block/fdc-isa=2Ec
>>>> @@ -39,6 +39,7 @@
>>>> #include "hw/qdev-properties-system=2Eh"
>>>> #include "migration/vmstate=2Eh"
>>>> #include "hw/block/block=2Eh"
>>>> +#include "hw/block/fdc=2Eh"
>>>> #include "sysemu/block-backend=2Eh"
>>>> #include "sysemu/blockdev=2Eh"
>>>> #include "sysemu/sysemu=2Eh"
>>>> @@ -47,7 +48,6 @@
>>>> #include "qemu/module=2Eh"
>>>> #include "trace=2Eh"
>>>> #include "qom/object=2Eh"
>>>> -#include "fdc-internal=2Eh"
>>>>=20
>>>> OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
>>>>=20
>>>> diff --git a/hw/block/fdc-sysbus=2Ec b/hw/block/fdc-sysbus=2Ec
>>>> index f18f0d19b0=2E=2Ecff21c02b3 100644
>>>> --- a/hw/block/fdc-sysbus=2Ec
>>>> +++ b/hw/block/fdc-sysbus=2Ec
>>>> @@ -28,8 +28,8 @@
>>>> #include "qom/object=2Eh"
>>>> #include "hw/sysbus=2Eh"
>>>> #include "hw/block/fdc-isa=2Eh"
>>>> +#include "hw/block/fdc=2Eh"
>>>> #include "migration/vmstate=2Eh"
>>>> -#include "fdc-internal=2Eh"
>>>> #include "trace=2Eh"
>>>>=20
>>>> #define TYPE_SYSBUS_FDC "base-sysbus-fdc"
>>>> diff --git a/hw/block/fdc=2Ec b/hw/block/fdc=2Ec
>>>> index 2bd6d925b5=2E=2E0e2fa527f9 100644
>>>> --- a/hw/block/fdc=2Ec
>>>> +++ b/hw/block/fdc=2Ec
>>>> @@ -39,6 +39,7 @@
>>>> #include "hw/qdev-properties-system=2Eh"
>>>> #include "migration/vmstate=2Eh"
>>>> #include "hw/block/block=2Eh"
>>>> +#include "hw/block/fdc=2Eh"
>>>> #include "sysemu/block-backend=2Eh"
>>>> #include "sysemu/blockdev=2Eh"
>>>> #include "sysemu/sysemu=2Eh"
>>>> @@ -47,7 +48,6 @@
>>>> #include "qemu/module=2Eh"
>>>> #include "trace=2Eh"
>>>> #include "qom/object=2Eh"
>>>> -#include "fdc-internal=2Eh"
>>>>=20
>>>> /********************************************************/
>>>> /* debug Floppy devices */
>>>>=20
>>=20
>> 

