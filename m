Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E227D267A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 00:13:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quggo-0003ys-5G; Sun, 22 Oct 2023 18:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1quggl-0003xj-RA; Sun, 22 Oct 2023 18:12:52 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1quggk-0000vP-8x; Sun, 22 Oct 2023 18:12:51 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so560982666b.0; 
 Sun, 22 Oct 2023 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698012768; x=1698617568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sCpnGD55Q7fObKJtDUP8c4YWGRzGNdECiLDWVn5FFdU=;
 b=OJ+6fcHDLduqtW/MLopTUz1b06LR5MZNHoooFmFf/vXmIk07OSfSryb4IjwaVnwRQp
 Q8TeROCZtHx30MZiFaErvaxRrFzKYUntrAz8ttTPvVcgsPImwZcqIeBCRgQD6xuWJd18
 t1PpTIOfuhH4IgC0vqtJBiLHzKprNgT3YWX19fQvj2pB+0MRZ1oDbikbMkAZ1YkY27Xg
 xzIq7znrd8MUcIuscDFHZAj1cdx+g9a99CdWuARkwm9LDNUQ4ZutROc96Y4brazZ5je0
 EXiiTY4g9FQesyddqq96mURAAoKfoYp8qtM7F9bHjex7oeqMAlnhr6ueeQNYFJS9uZ5M
 osGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698012768; x=1698617568;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sCpnGD55Q7fObKJtDUP8c4YWGRzGNdECiLDWVn5FFdU=;
 b=l9UB1pWUgYOHKLLHNMZ7TuvtNhm2spLErYQYbIF0DxxE6S1FaqK4KuKv7uOtVJWbve
 M8Rhu0VWX1vUfLvWKQ0iTmPCskQFcg8FAvncIOWsw7HYEmlVW3EA3F9cVtpQaO5hLyQI
 Hwf9xmMjYj4txug4YegZPcqHqJ6x5U5BsYRsc6N3S/n6pOk9RJGB94DZ8oLzlZ1xCGuf
 gckwC3dyvH4DO9VdI+V4S4FZu/r2a8Ov2jWdqBPormND8TKAis7IZkhYRGX4OHKr1wo9
 Ws7kn7fL3N9AcZkhZ7RNxwVsb0qHZxPVElt7eCCq1wVGmCU3GZsGkrAbn/Hz9hK8KC//
 rgWQ==
X-Gm-Message-State: AOJu0YyYK5izGRwPH7pcNr8tpmjsUyMvsWPjHO3ndAw9F5LcJJzR3onE
 Btlx9kK6vIXCrDtFsVQ0GWg=
X-Google-Smtp-Source: AGHT+IGEcsrBKK1HsKEA7RKuYPOIL0Qmt4TVxGIN4PT76gm5tCCWZ2d23DKHfB2n4rWAPrubupFSTQ==
X-Received: by 2002:a17:906:53d4:b0:9c8:5b61:7bd7 with SMTP id
 p20-20020a17090653d400b009c85b617bd7mr3152328ejo.22.1698012768016; 
 Sun, 22 Oct 2023 15:12:48 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-189-152.77.13.pool.telefonica.de.
 [77.13.189.152]) by smtp.gmail.com with ESMTPSA id
 w21-20020a170907271500b009ad81554c1bsm5583390ejk.55.2023.10.22.15.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 15:12:47 -0700 (PDT)
Date: Sun, 22 Oct 2023 22:12:41 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_4/4=5D_hw/isa/i82378=3A_Propagate?=
 =?US-ASCII?Q?_error_if_PC=5FSPEAKER_device_creation_failed?=
In-Reply-To: <20231020171509.87839-5-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
 <20231020171509.87839-5-philmd@linaro.org>
Message-ID: <18851B00-B0E0-4DA4-B58F-B07F80B78EFC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 20=2E Oktober 2023 17:15:08 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
>we neglected to give a change to the caller to handle failed
>device creation cleanly=2E Respect the caller API contract and
>propagate the error if creating the PC_SPEAKER device ever
>failed=2E This avoid yet another bad API use to be taken as
>example and copy / pasted all over the code base=2E
>
>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Suggested-by: Markus Armbruster <armbru@redhat=2Ecom>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/isa/i82378=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/hw/isa/i82378=2Ec b/hw/isa/i82378=2Ec
>index 79ffbb52a0=2E=2E203b92c264 100644
>--- a/hw/isa/i82378=2Ec
>+++ b/hw/isa/i82378=2Ec
>@@ -105,7 +105,9 @@ static void i82378_realize(PCIDevice *pci, Error **er=
rp)
>     /* speaker */
>     pcspk =3D isa_new(TYPE_PC_SPEAKER);
>     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_f=
atal);
>-    isa_realize_and_unref(pcspk, isabus, &error_fatal);
>+    if (!isa_realize_and_unref(pcspk, isabus, errp)) {
>+        return;
>+    }
>=20
>     /* 2 82C37 (dma) */
>     isa_create_simple(isabus, "i82374");

