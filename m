Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60272C3C6
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gRs-0006LN-93; Mon, 12 Jun 2023 08:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8gRp-0006Km-4Q; Mon, 12 Jun 2023 08:15:01 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8gRn-0006nw-2A; Mon, 12 Jun 2023 08:15:00 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51480d3e161so6358211a12.3; 
 Mon, 12 Jun 2023 05:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686572096; x=1689164096;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=YwVb4gXx7wlwuwCvqEDya5MASlaigw9GNB1V82FFchg=;
 b=InLf3OYGB6zRtqO+JoaVMR3YqUHBIM141xrmUcQYo6zE/sOXEYT4Lx497r9NrLMp9+
 B9pk7908pH69b5M2Wfdz6rJ8qffJcRIzqmqXaNsyvIQ9vcP2pKKmTwYP60mgJsHZtS0A
 rjBMGWBlLCLMdtVT1BOrEbj8spb5CU7bUAE3a30z5R0m5Ad1qh0lowKAeI4hSH9lI8KY
 PGpUUwlcIoaPPgpGiNkE+F5N0V2VwAQ0kTI/7pR2Tr/GiteId4ell6qbvepwGI1GSXhW
 zKIXsNDzgVLqsL4IVgq6a028tC9HoeRQpXxmufD1TJu4M9iRR5gWp3oBc/hjN2mDsBY/
 0HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686572096; x=1689164096;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwVb4gXx7wlwuwCvqEDya5MASlaigw9GNB1V82FFchg=;
 b=iAgzVHkNUC+Hg9GK+4KbVgt3KztKAOSFEoUoJQHu4Qp2wgTo1pxFXLC7oCdsnpCHIy
 xSCs49YeBJK+B3gutarlGPJV8FNLr1Bpm2wjbGuIaizqoNFvjH2YxuKUplZhLlRat1SW
 1vCdfR0DqUh3IOf/+75IpmdYEzWS4n3+yQo9Nqn3XuoWWhWIyqN06obRMAR4FL0CStXw
 rpjb9jOZ5XmW+6evvzZ0HbMEk8q0i7kKwrwcNgZPUXPDbrmPJ17kvh3vOhh6MGdCcQp8
 xv+5RT/BZZef0Jxrdz/1uBOn5jAU7Ax6tCAJeC26kBCdUwPVtu+FhOuWdgJsg5EBJ7tb
 D+XQ==
X-Gm-Message-State: AC+VfDxExaDHdPEO9P6LUAcri4jQPrEp55KG2IkUaxd/3B7sO8TovKPv
 dEnViWeAY+tq+UdKlAj+6sY=
X-Google-Smtp-Source: ACHHUZ4FlDjuXmGVucOxZgoG5HIWSVwSOS923UsqRqbuV1viJH4l2OMNunXaCgPG2Z6Ufz8JH46SiQ==
X-Received: by 2002:a05:6402:88e:b0:516:81d3:2627 with SMTP id
 e14-20020a056402088e00b0051681d32627mr5789861edy.0.1686572096075; 
 Mon, 12 Jun 2023 05:14:56 -0700 (PDT)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 y13-20020a056402134d00b005106975c7a1sm5035908edw.23.2023.06.12.05.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 05:14:55 -0700 (PDT)
Date: Mon, 12 Jun 2023 09:21:45 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/5=5D_cmd646=3A_create_separa?=
 =?US-ASCII?Q?te_header_and_QOM_type_for_CMD646=5FIDE?=
In-Reply-To: <20230609185119.691152-3-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
 <20230609185119.691152-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <3A202437-705C-49FB-BB8D-FA3CEFF0CAD7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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



Am 9=2E Juni 2023 18:51:16 UTC schrieb Mark Cave-Ayland <mark=2Ecave-aylan=
d@ilande=2Eco=2Euk>:
>This will enable CMD646-specific fields to be added to CMD6464IDEState in
>future=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>---
> hw/ide/cmd646=2Ec         |  4 +++-
> include/hw/ide/cmd646=2Eh | 38 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 41 insertions(+), 1 deletion(-)
> create mode 100644 include/hw/ide/cmd646=2Eh
>
>diff --git a/hw/ide/cmd646=2Ec b/hw/ide/cmd646=2Ec
>index 20f1e41d57=2E=2Ea3e227fba7 100644
>--- a/hw/ide/cmd646=2Ec
>+++ b/hw/ide/cmd646=2Ec
>@@ -33,6 +33,7 @@
> #include "sysemu/reset=2Eh"
>=20
> #include "hw/ide/pci=2Eh"
>+#include "hw/ide/cmd646=2Eh"
> #include "trace=2Eh"
>=20
> /* CMD646 specific */
>@@ -339,9 +340,10 @@ static void cmd646_ide_class_init(ObjectClass *klass=
, void *data)
> }
>=20
> static const TypeInfo cmd646_ide_info =3D {
>-    =2Ename          =3D "cmd646-ide",
>+    =2Ename          =3D TYPE_CMD646_IDE,
>     =2Eparent        =3D TYPE_PCI_IDE,
>     =2Eclass_init    =3D cmd646_ide_class_init,
>+    =2Einstance_size =3D sizeof(CMD646IDEState),
> };
>=20
> static void cmd646_ide_register_types(void)
>diff --git a/include/hw/ide/cmd646=2Eh b/include/hw/ide/cmd646=2Eh
>new file mode 100644
>index 0000000000=2E=2E4780b1132c
>--- /dev/null
>+++ b/include/hw/ide/cmd646=2Eh
>@@ -0,0 +1,38 @@
>+/*
>+ * QEMU IDE Emulation: PCI cmd646 support=2E
>+ *
>+ * Copyright (c) 2003 Fabrice Bellard
>+ * Copyright (c) 2006 Openedhand Ltd=2E
>+ *
>+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
>+ * of this software and associated documentation files (the "Software"),=
 to deal
>+ * in the Software without restriction, including without limitation the=
 rights
>+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
>+ * copies of the Software, and to permit persons to whom the Software is
>+ * furnished to do so, subject to the following conditions:
>+ *
>+ * The above copyright notice and this permission notice shall be includ=
ed in
>+ * all copies or substantial portions of the Software=2E
>+ *
>+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
>+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
>+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT S=
HALL
>+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
>+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
>+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
>+ * THE SOFTWARE=2E
>+ */
>+
>+#ifndef HW_IDE_CMD646_H
>+#define HW_IDE_CMD646_H
>+
>+#define TYPE_CMD646_IDE "cmd646-ide"
>+OBJECT_DECLARE_SIMPLE_TYPE(CMD646IDEState, CMD646_IDE)
>+
>+#include "hw/ide/pci=2Eh"
>+
>+struct CMD646IDEState {
>+    PCIIDEState parent_obj;

No public / private sections here? From the naming this attribute is often=
 considered private and the rest public=2E I guess what this scheme communi=
cates is that `parent_obj` should be accessed via `IDE_PCI()` only=2E

>+};
>+
>+#endif

