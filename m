Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC8816375
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 00:41:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF0k3-0002sz-PZ; Sun, 17 Dec 2023 18:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rF0jx-0002sf-Ul; Sun, 17 Dec 2023 18:40:10 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rF0ju-00048I-CJ; Sun, 17 Dec 2023 18:40:09 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5534abbc637so412796a12.0; 
 Sun, 17 Dec 2023 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702856404; x=1703461204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uziIRJylELKltc+m/N7wveB0cr4xIQHZ2NwLv127Fdg=;
 b=emdTtRy/E/sgyqtQxRMJQSEwXr1EjC7uvLynetIGXq8cidiYFJiHMniInjyWG1kt/p
 TozbNEr7W+Ryt6GaTx/D0vbAGZfN9vXXJFMLtCMqBD5Gbc3DEKvCw4xWExKii/u9K9dE
 mKVIKBuV3gkCd4lAlXfMfLm9Wvvh8eq3AtIzTRmXU3Y6yO5e5Web9UA4dWbBSnAlHOYW
 UMy6g1sy6tyFiqUQ6HBoycfGtOZZytEZh+mbRa3mlcnU8V21abFITFQ36DXI8idvI/Hv
 eOv8UHjn9NSaV+xOfI59OeLcH+94ShxDHFtv2/VGJrYO1Bes3DHbZyGihXYrZcCIIc/7
 7LZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702856404; x=1703461204;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uziIRJylELKltc+m/N7wveB0cr4xIQHZ2NwLv127Fdg=;
 b=eU7YFzi4L5qyjnnBwCR1R12S+CN2VAjFgeq5KsjTLG6GjzCpyQxLUxwHPWrAML2XLr
 iIp2QdALq2KAXIYR9fr1QupFzz5bs+xRUFkLRCxJibXcjiozHsn6qJtUyC9zmozZ8h8A
 plc8UPtcUUXekBZnmeuagCu0XdHOrRJmTB8VeXA/HDVRg0bcSrElxkUmFMPy4qTwrxJm
 dfi8bi4CnfGZJdp/Zkk0gEgvCRvWX7lbnZ9uETRUQ3gMbkN6XNTwWBg2Dj4mTw+HbJH0
 qdep34E0Kj/BGuOUvfB236X1nS1jAkRzlQ2+u4PbuYmgTV0X3ONMdW6SJZscky4lQ9sG
 PNUg==
X-Gm-Message-State: AOJu0YwKY9njUiMdnfPwQE5DXxQBYi/08YAswYJzflztQzq2SzQ1OCkt
 qs73nv82yBHjLKSWZf6sxTs=
X-Google-Smtp-Source: AGHT+IHz3lbMCu39MiRwndfjI5Vavk6GBPmOwdb2KWOuDHRRIHKp4sMTyLBnn6bhd9KTb8RjXIBBgw==
X-Received: by 2002:a17:906:d0c9:b0:a23:552e:999 with SMTP id
 bq9-20020a170906d0c900b00a23552e0999mr360032ejb.16.1702856403668; 
 Sun, 17 Dec 2023 15:40:03 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 x19-20020a1709065ad300b00a23435ba68dsm1394739ejs.69.2023.12.17.15.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 15:40:03 -0800 (PST)
Date: Sun, 17 Dec 2023 23:39:55 +0000
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
In-Reply-To: <b4b1d529-f368-4f8f-b357-4ad5177a2951@eik.bme.hu>
References: <20231217144148.15511-1-shentey@gmail.com>
 <20231217144148.15511-5-shentey@gmail.com>
 <b4b1d529-f368-4f8f-b357-4ad5177a2951@eik.bme.hu>
Message-ID: <91BF37F6-494D-4656-9CE8-7FDA0C3C8F33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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



Am 17=2E Dezember 2023 15:47:33 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Sun, 17 Dec 2023, Bernhard Beschow wrote:
>> Exposing the internal header allows for exposing struct FDCtrlISABus wh=
ich is
>> encuraged by qdev guidelines=2E
>
>Hopefully the guidelines don't encourage this as object orientation indee=
d encourages object encapsulation so only the object itseld should poke its=
 internals and other objects should use methods the change object state=2E =
In QOM some object states were exposed in public headers to allow embedding=
 those objects in other objects becuase C needs the struct size to allow th=
at=2E This was to simplify memory management so the embedded objects don't =
need to be tracked and freed but would be created and freed with the other =
object embedding it but this does not mean the other object should poke int=
o these object or that this is a general guideline to expose internal objec=
t state=2E I'd say the exposed objects are an exception instead of recommen=
ded guideline and only allowed for objects that need to be embeded in other=
s but generally object encapsulation would be better to preserve where poss=
ible=2E This patch exposes objects so others can poke into them which would=
 make those other objects dependent on the implementation of these objects =
making these harder to chnage in the future so a better way may be to add m=
ethods to fdc and serial to allow changing their base address and map/unmap=
 their ports and keep their internals unexposed=2E

Each ISADevice sub class would need concenience methods as well as each st=
ate  class=2E This series touches three of each: fdc, parallel, serial=2E A=
nd each of those need two convenience methods: set_enabled() and set_addres=
s()=2E This would add another 12 functions on top of the current ones=2E

Then ISASuperIODevice would require at least 6 more such methods (not coun=
ting the unneeded ones for IDE which might be desirable for consistency)=2E=
 So in the end we'd have at least 18 more methods=2E Is this really worth i=
t?

I didn't feel very comfortable going this route, so ended up with the curr=
ent solution poking the states directly=2E I'm open to different approaches=
 including the one above but I'd really like to know the opinion of the mai=
ntainers, too=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> MAINTAINERS                                       | 2 +-
>> hw/block/fdc-internal=2Eh =3D> include/hw/block/fdc=2Eh | 4 ++--
>> hw/block/fdc-isa=2Ec                                | 2 +-
>> hw/block/fdc-sysbus=2Ec                             | 2 +-
>> hw/block/fdc=2Ec                                    | 2 +-
>> 5 files changed, 6 insertions(+), 6 deletions(-)
>> rename hw/block/fdc-internal=2Eh =3D> include/hw/block/fdc=2Eh (98%)
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b4718fcf59=2E=2E939f518701 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1945,9 +1945,9 @@ M: John Snow <jsnow@redhat=2Ecom>
>> L: qemu-block@nongnu=2Eorg
>> S: Odd Fixes
>> F: hw/block/fdc=2Ec
>> -F: hw/block/fdc-internal=2Eh
>> F: hw/block/fdc-isa=2Ec
>> F: hw/block/fdc-sysbus=2Ec
>> +F: include/hw/block/fdc=2Eh
>> F: include/hw/block/fdc-isa=2Eh
>> F: tests/qtest/fdc-test=2Ec
>> T: git https://gitlab=2Ecom/jsnow/qemu=2Egit ide
>> diff --git a/hw/block/fdc-internal=2Eh b/include/hw/block/fdc=2Eh
>> similarity index 98%
>> rename from hw/block/fdc-internal=2Eh
>> rename to include/hw/block/fdc=2Eh
>> index 1728231a26=2E=2Eacca7e0d0e 100644
>> --- a/hw/block/fdc-internal=2Eh
>> +++ b/include/hw/block/fdc=2Eh
>> @@ -22,8 +22,8 @@
>>  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALIN=
GS IN
>>  * THE SOFTWARE=2E
>>  */
>> -#ifndef HW_BLOCK_FDC_INTERNAL_H
>> -#define HW_BLOCK_FDC_INTERNAL_H
>> +#ifndef HW_BLOCK_FDC_H
>> +#define HW_BLOCK_FDC_H
>>=20
>> #include "exec/memory=2Eh"
>> #include "exec/ioport=2Eh"
>> diff --git a/hw/block/fdc-isa=2Ec b/hw/block/fdc-isa=2Ec
>> index 6387dc94fa=2E=2E7058d4118f 100644
>> --- a/hw/block/fdc-isa=2Ec
>> +++ b/hw/block/fdc-isa=2Ec
>> @@ -39,6 +39,7 @@
>> #include "hw/qdev-properties-system=2Eh"
>> #include "migration/vmstate=2Eh"
>> #include "hw/block/block=2Eh"
>> +#include "hw/block/fdc=2Eh"
>> #include "sysemu/block-backend=2Eh"
>> #include "sysemu/blockdev=2Eh"
>> #include "sysemu/sysemu=2Eh"
>> @@ -47,7 +48,6 @@
>> #include "qemu/module=2Eh"
>> #include "trace=2Eh"
>> #include "qom/object=2Eh"
>> -#include "fdc-internal=2Eh"
>>=20
>> OBJECT_DECLARE_SIMPLE_TYPE(FDCtrlISABus, ISA_FDC)
>>=20
>> diff --git a/hw/block/fdc-sysbus=2Ec b/hw/block/fdc-sysbus=2Ec
>> index f18f0d19b0=2E=2Ecff21c02b3 100644
>> --- a/hw/block/fdc-sysbus=2Ec
>> +++ b/hw/block/fdc-sysbus=2Ec
>> @@ -28,8 +28,8 @@
>> #include "qom/object=2Eh"
>> #include "hw/sysbus=2Eh"
>> #include "hw/block/fdc-isa=2Eh"
>> +#include "hw/block/fdc=2Eh"
>> #include "migration/vmstate=2Eh"
>> -#include "fdc-internal=2Eh"
>> #include "trace=2Eh"
>>=20
>> #define TYPE_SYSBUS_FDC "base-sysbus-fdc"
>> diff --git a/hw/block/fdc=2Ec b/hw/block/fdc=2Ec
>> index 2bd6d925b5=2E=2E0e2fa527f9 100644
>> --- a/hw/block/fdc=2Ec
>> +++ b/hw/block/fdc=2Ec
>> @@ -39,6 +39,7 @@
>> #include "hw/qdev-properties-system=2Eh"
>> #include "migration/vmstate=2Eh"
>> #include "hw/block/block=2Eh"
>> +#include "hw/block/fdc=2Eh"
>> #include "sysemu/block-backend=2Eh"
>> #include "sysemu/blockdev=2Eh"
>> #include "sysemu/sysemu=2Eh"
>> @@ -47,7 +48,6 @@
>> #include "qemu/module=2Eh"
>> #include "trace=2Eh"
>> #include "qom/object=2Eh"
>> -#include "fdc-internal=2Eh"
>>=20
>> /********************************************************/
>> /* debug Floppy devices */
>>=20

