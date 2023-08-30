Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FE78D63A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLRP-0008BV-Gt; Wed, 30 Aug 2023 09:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLRN-0008As-Pj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLRL-0007oK-Lc
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:41:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401f68602a8so3951335e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693402858; x=1694007658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4skyAPGu6D16wOCDK55AMUBYuBFtZUeSrH+It0+wt8=;
 b=z5I0DekrdlR3n9ly7oYadZqVaff1tJOjQyjyQLSS1CVtKv1az8B15LynHnO39CVPti
 BmD/h4Dqt3bijJjjovEGF/52DC86dKL8ezeksmSEJ7S+FB3CLST7VG7CQVQ9I3PKDxe3
 Xc3UboyVRes7bTQ5Me2AUQeLT+Xq39B5hLF/z6YoM4fHF/Mikmrn1vvt0RAR/JYrCn69
 V+J5Q4bgAMfIJxkBf4n/z0ZeoYOQqI/UsMXo4DCjgCTovZYtR37KSz6rjkHWl7RDXUFI
 oP0/FkLTkED9cKEQUOqiJXuEJpwkcXd3sUGURcoLxqMS8LaylRotOUAPVpmxxo3wrGgW
 p1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402858; x=1694007658;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l4skyAPGu6D16wOCDK55AMUBYuBFtZUeSrH+It0+wt8=;
 b=MYp9Q2pHfZzoIltjBot7NQcZ+Vaie6THNU9XTl6JSWRBRyLXacE6ZPRxFet5bjxygz
 mc6xgn+s+RtSaBC/fivfMVjjggLPXhdHMfbMhCDkJixQiBeLTQlZVgLaNfBWTOqt435p
 M6FwzsPD34YeUMVpr6AFJ8E1yJa4PdfCU85ZEjZSbT8NKulU53VAkqkS0EDOB2zbLN2q
 PFd/34an8xSUUm2LFCCIimcL3cOvC3KwyTWRtOipdHRg3q0s8r9siK14iM/7ihfZHW76
 U5YzSlj8+qqQF3RvE6zPl9yDC8/bhV1VOdMhkRXrwL7hk3SF+n1MniNhZ8w79TFfphcY
 LCPQ==
X-Gm-Message-State: AOJu0Yxy51qw9FK5XlgUKc/R3AKAAAZ060edo56fDilp60sve92wTleS
 /VSO9vInP0Y7rtJ4pd+HyorV/A==
X-Google-Smtp-Source: AGHT+IHHXBgQnBQlLZjNi7wF2wU3mnqZ211LFgkF4+QtJ3vGMzJePfk8oVvnp9CHxD/XPKLaaTbgEg==
X-Received: by 2002:a5d:6604:0:b0:317:c2a9:9b0c with SMTP id
 n4-20020a5d6604000000b00317c2a99b0cmr1625040wru.50.1693402858263; 
 Wed, 30 Aug 2023 06:40:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adfee0e000000b0031c56218984sm16620169wrn.104.2023.08.30.06.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:40:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77BAF1FFBB;
 Wed, 30 Aug 2023 14:40:57 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOh?=
 =?utf-8?B?Z8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
Date: Wed, 30 Aug 2023 14:40:23 +0100
In-reply-to: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <874jkgsl5i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This patch series adds an audio device implementing the recent virtio=20
> sound spec (1.2) and a corresponding PCI wrapper device.

And you can have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the whole series.

mst,

are you going to pull via your tree?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

