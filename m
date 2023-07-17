Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E290756C94
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 20:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTNh-0007tg-PT; Mon, 17 Jul 2023 14:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qLTNg-0007tV-Jr
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:55:36 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qLTNf-0001YF-7j
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 14:55:36 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-992b27e1c55so635070066b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689620133; x=1692212133;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igfhO1XH2k0W0bRP0DeCNIEtPp+BKviP90EvwCdDjkk=;
 b=dMd9+8PUw0XGtNy/MCqk5+0hc1WEJGq83LVOWS8ZzYWsbjXTmNsZJlvGQ0UZoNoeFK
 MA8Q/AadebqGopmEHM9ujdntpdf6b5SjMj6hVxksyK9PwFDsC1ETNTXyTE1XVVXdne9z
 l/VqFKXhI/RW4dH24VYP/+WwMxecfcX23J7DmIwiUwSj8fd/d8SZ6tg57qTd5RTFW7MT
 a/RwwZuaU/6NZVeN0NryxnrJVY+gFubZTgyI4+eqvRO6lqWnVmQwDARky7qdGbeGbxEv
 ITRIhHvgwjDxwuwJjsFbu06exVCxoWPwlo756eleFHCFo2lLKW8nxdSLOTBbx+EqNERR
 c9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689620133; x=1692212133;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igfhO1XH2k0W0bRP0DeCNIEtPp+BKviP90EvwCdDjkk=;
 b=LaWW1676yM1FPUbq0c3yR3n1XCsfSu01/NaQ7RM7+VZsYvP1I0aAP2yJyPxZbCsWUd
 +J5CCpTiKa0gGaKUzMA2L/ek4jPy3Yn4Is8sKtd/+xmA4oA+vP0uiDmKyUyiy2y3ysKZ
 s/HqZvLbpVRr/tCgYUmaymCPo2FvZEIi8Q590ergJx7PE7ygAGeeAb1xtHSQuWWmfEFE
 pEVbFDvEi1MZ1iRUGOB/LccGRx/KnHy3dX+W6IOMdaFuDVLDgf+6nF3QdQzCjqA2hlD5
 MDe56b3QCD0ZRcalg86tnoV8l3qnNlUBZLOaRV70YtBQCsmXI7IhC4du/mWbh0r5MiyK
 QyOQ==
X-Gm-Message-State: ABy/qLbk9VdocYirf7tkP9sEqUprOZFPt9Sj2WDetPx3LA97yQZq1rUx
 O2daO9VLjd7EoK47mdjg9h4=
X-Google-Smtp-Source: APBJJlEu5r+2nZ6F6URCfLPXOwFx+UL0pfUcgCvpUGRYO+Fj7fxv4ZQ3DE2uZF7PDtAa1aqxCJGJrA==
X-Received: by 2002:a17:906:224a:b0:991:caa8:fc3a with SMTP id
 10-20020a170906224a00b00991caa8fc3amr11076579ejr.72.1689620133184; 
 Mon, 17 Jul 2023 11:55:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-239-067.77.191.pool.telefonica.de.
 [77.191.239.67]) by smtp.gmail.com with ESMTPSA id
 r4-20020a170906c28400b0098921e1b064sm20858ejz.181.2023.07.17.11.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 11:55:32 -0700 (PDT)
Date: Mon, 17 Jul 2023 18:55:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
In-Reply-To: <20230717130338.29b7a911.olaf@aepfle.de>
References: <20230701174659.10246-1-olaf@aepfle.de>
 <62EDA748-11A3-473F-913D-F9464335A382@gmail.com>
 <20230703095929.6e793dcf.olaf@aepfle.de>
 <93902CB6-7A6E-49E5-A55F-432C6B4BC00F@gmail.com>
 <dded4d33-d64f-9369-0742-a57a1e173153@redhat.com>
 <20230705120121.4f353ba6.olaf@aepfle.de>
 <DA75E02A-FAB3-4262-90B6-37A213ACFA47@gmail.com>
 <20230717130338.29b7a911.olaf@aepfle.de>
Message-ID: <7A2E5B3E-6487-4D77-B732-A9F77E1180A4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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



Am 17=2E Juli 2023 11:03:38 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Mon, 17 Jul 2023 08:46:16 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> The PIIX fix alone just fixes the syptom, not the underlying problem=2E=
 The underlying problem is that the BAR isn't deactivated, and with the PII=
X patch it will stay at address zero rather than in the USB function addres=
s range=2E
>
>Did you mean to say USB will not work now? It actually does with just 230=
dfd9257 backported to v4=2E2+=2E

What I'm saying is that the PIIX-IDE BAR is still a zombie, possibly threa=
tening other innocent devices instead of USB=2E

Best regards,
Bernhard

>
>Either way, I will test and send the additional change for pci_xen_ide_un=
plug in the next days=2E
>
>
>Olaf

