Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B54767D2693
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 00:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qugr2-0005z1-Ij; Sun, 22 Oct 2023 18:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugr0-0005yn-NQ; Sun, 22 Oct 2023 18:23:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugqz-0002pF-4w; Sun, 22 Oct 2023 18:23:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso4027388a12.1; 
 Sun, 22 Oct 2023 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698013402; x=1698618202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Wl80BntDXLJ5alJtSfXBhCLSDKvstWU6Z6plzeUDXY=;
 b=gVhHDTHq68dFH87zIcXyFg3SaWzdJF6yO5Sficm3GoabmIIyZhvPAz2h12gskB6hym
 QSq4cMTeOHVzuSUBM2c+0V6PNMaWuvj6g0YnYKnwO1kwZnLnqYCDE2iMYICqs7PXsTbT
 wX6Cc2GMH8fqw7DuSQ/wAsYUf5X+x/ohy0FUZlUqQJNNbRWO/aZ0+yIlUJ/Znb7CPtrD
 44z7UdONJ8r8u3H2YIvKnm9hv5XhXTJtpfNyWLAD3uPBuVViK1dluoIMdz+s7Dl0Gyv+
 2guYD076oKaUEhARwspHg6/8CjxQuwIxL77t7TecZ8FstA5V2kTWRAz0RcCylXPOvugH
 3sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698013402; x=1698618202;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Wl80BntDXLJ5alJtSfXBhCLSDKvstWU6Z6plzeUDXY=;
 b=aDP+Ue5covwwtmjm5khrXzme8OL+nzgHSGxVXJ7Vpl+U3d4M2LE9Gto+OQEW3FU2+e
 iYt7JpOhyMYdOytw3ltq/zy+K7JtbR3K5WRiCwlmv0P9hBwSabZSmQeOPjNOfF/MiuUv
 WCLOTp3yS9aWnnMAY5F40g8RrMcnRnvJ+HBj+vOpogRzBadLmCVS60VQmmmd1O7jPkMj
 dMz1Ll1AAvRhTq6DwZwAc2MIApHOSJEVM7HK8o9q7ShQ/hzeKwF3Mqo6KtmjRPQd4S/i
 00Gw1al4nc2FhaEOYuMu+XL5LZA7vDUykpK++Wjo694YjzgcieuXJXxeBBsSztwXE0XA
 e0Fg==
X-Gm-Message-State: AOJu0Yzoqnb5S/qOxJb17vH50Tm71v+qpv7JAWSWfRz794arXZxLh4cp
 cnjWDZRXBDTvhYmygRfICxQ=
X-Google-Smtp-Source: AGHT+IEfnk8URp8iLoKNbfQ5GGkdS9jJItpHE8+j+i0zUJIf4ydJh51GF+OhJIX1lXwn86KQdBzFVQ==
X-Received: by 2002:a17:907:7293:b0:9ae:4878:1172 with SMTP id
 dt19-20020a170907729300b009ae48781172mr5895556ejc.7.1698013402220; 
 Sun, 22 Oct 2023 15:23:22 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-189-152.77.13.pool.telefonica.de.
 [77.13.189.152]) by smtp.gmail.com with ESMTPSA id
 qx17-20020a170906fcd100b00997c1d125fasm5642275ejb.170.2023.10.22.15.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 15:23:21 -0700 (PDT)
Date: Sun, 22 Oct 2023 22:23:14 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 0/4] hw/audio/pcspk: Inline pcspk_init()
In-Reply-To: <20231020171509.87839-1-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
Message-ID: <D0ECDB9D-F04B-46F5-BFE6-94257FB4FF65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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



Am 20=2E Oktober 2023 17:15:04 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>Unfortunately v2 was merged as commit 40f8214fcd,
>so adapt v3 to clean the mess=2E
>
>Philippe Mathieu-Daud=C3=A9 (4):
>  hw/i386/pc: Pass Error** argument to pc_basic_device_init()
>  hw/i386/pc: Propagate error if HPET device creation failed
>  hw/i386/pc: Propagate error if PC_SPEAKER device creation failed

I'm not sure if I'd do these first three patches=2E The reason is that mac=
hines don't inherit from DeviceState and therefore don't have canonical met=
hods such as realize() to propagate errors=2E Propagating the errors in the=
 machine init helper methods seem a bit ad-hoc to me=2E

>  hw/isa/i82378: Propagate error if PC_SPEAKER device creation failed

The reason I suggested use of `errp` here is that it is already a paramete=
r=2E

Best regards,
Bernhard

>
> include/hw/i386/pc=2Eh |  5 +++--
> hw/i386/pc=2Ec         | 15 +++++++++++----
> hw/i386/pc_piix=2Ec    |  2 +-
> hw/i386/pc_q35=2Ec     |  2 +-
> hw/isa/i82378=2Ec      |  4 +++-
> 5 files changed, 19 insertions(+), 9 deletions(-)
>

