Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370174100E
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETLX-00019z-0q; Wed, 28 Jun 2023 07:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qETLU-00019p-9S
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qETLS-00056x-3v
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:28:23 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51d9128494cso3993095a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687951699; x=1690543699;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m71/o/G171aVR8A+7xTRHGvVpEgwswY5zKXzBViWocU=;
 b=k2isNveHKZxBtTLEMMulb1S/ua0NYPqk6AAPGIdZM9KMdHYEE12hHA2gjCRoRw7aA+
 x2tsDVYe5yDuitLP7uap7gIacGYdTbX8+i9EkkUfpueft2TdeK+gOloOhLRBnx9SGijj
 jEyD4gtyuMiCaMzm7Wp2388t1qZwzcM32xZpALDH4H4EPyc9KYDoBJW7do2kIEYyTvL/
 8RqYCVPMxsmVgLkdbKXhDa9+Eqb8lYxYXFIxNM+PUNuF8WB+d0lYHAH2eIrwQsfWNf0/
 ErT9Zyf1fOzle7Z5AZIh4TalyZh/jS/3/2eZYKvPslexdtZIK42o9i0e4w7XjdZzkUZ3
 luvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687951699; x=1690543699;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m71/o/G171aVR8A+7xTRHGvVpEgwswY5zKXzBViWocU=;
 b=KrMSXf0Ykzki/DPuovyZ4gecbGO0H2Gw+KZA8EF5Xb7S2w/8U/ZuUlRZwPXKMGNMqW
 Y0scidxvNorllBXhbp8bECCtH43VA1yIZbYSDCw18RzxWIf3o7NNbuerLA9zK24htqFE
 5v3p+fdZ+tGK3Ir/zkiXDaJcgS24ERTcyagsV78OpIkNZ2JaphifkUDs0/I3Vq2Q/FMA
 SgYoPiWaZXiYusxw/8rbAJFkitQUgBfhHefI2Q2m/ihzQWhZpVQZy/BmQdXvBsXsEtQk
 qfrE9c8fJeDVcn4Jq+SoQ2ziDtreAFVvjMNXJYzbsMwIdfR1doaZatmtpuven/XmgcuS
 Qthg==
X-Gm-Message-State: AC+VfDw9RUOde8UcuNBUXxkxwycdGGpW7pf54Cdv2K3F3VEHhP1D37Bz
 xB85dRkveZJiXQdpRXguYfY=
X-Google-Smtp-Source: ACHHUZ53bBhM+ZFnfkclLsOB3uAYk8E4AwmHM6NQwKQFrXZxP0QjGSDsDw12FR2s8QmYxIHZThdZnQ==
X-Received: by 2002:a17:907:1c9c:b0:960:d9d:ffb5 with SMTP id
 nb28-20020a1709071c9c00b009600d9dffb5mr34137625ejc.41.1687951698870; 
 Wed, 28 Jun 2023 04:28:18 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 v21-20020a170906565500b00991bba473e1sm3565236ejr.3.2023.06.28.04.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:28:18 -0700 (PDT)
Date: Wed, 28 Jun 2023 09:27:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Olaf Hering <olaf@aepfle.de>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <20230627140740.2736f6e8.olaf@aepfle.de>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
Message-ID: <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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



Am 27=2E Juni 2023 12:07:40 UTC schrieb Olaf Hering <olaf@aepfle=2Ede>:
>Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail=2Ecom>:
>
>> The BAR is a 32 bit register whose default value is 0x00000001=2E I thi=
nk what's supposed to happen here is a pci_set_long() rather than a pci_set=
_byte()=2E
>
>Indeed, the u32 at that address changes from c121 to c101 with the curren=
t code=2E

Neat! Would you mind sending a patch fixing the BMIBA register to be reset=
 as 32 bit?

Best regards,
Bernhard
>
>Olaf

