Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6618373C8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 21:31:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS0vv-0002cQ-4a; Mon, 22 Jan 2024 15:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bugaevc@gmail.com>)
 id 1rRz0b-000171-2V; Mon, 22 Jan 2024 13:26:57 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bugaevc@gmail.com>)
 id 1rRz0Z-00043P-Ib; Mon, 22 Jan 2024 13:26:56 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-21481a3de56so14941fac.2; 
 Mon, 22 Jan 2024 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705948013; x=1706552813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zbwe4WGeVsrGfvPSuuJRnkc+RwzuXQPgAoSGJSHxkhw=;
 b=b65wTzluYmVugRdfK78eYMZshdSsRi9NZ5uBUwabfju6jdsmdd6C7bNlMPMLQ6GQ0H
 7rW55o2fE/loPtU3oXywlO7RHyJPtJAIzJJ2owb4XpG3l1rm9WtTcRZvhDFi8oAHlDqE
 s32i38xZmKT+h68v38j+4c5vqNX4974ebgp7obu+vHKblE3K5OhGsY0LhGaqf4rK74jL
 kootSqunutc1wuTgIa5LL0IE+vEma3tDKI3vOkXwQewNnUbeL1EAgzvY8Uwb5GpHL1qA
 iqTxMc3rMDI803hv35Uz0EoeTxYjKsFIJBnPWpStYOHaB5ZSeuhcMe7MIl00ow7HDiTc
 ejTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705948013; x=1706552813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zbwe4WGeVsrGfvPSuuJRnkc+RwzuXQPgAoSGJSHxkhw=;
 b=bO3+nlxlubDbi4zdwitUdCY/i6XEL7TIxInxCdO/EBbptq/IIApkrC8DooOVEV0NwY
 3y1hX4nzMGKIFjlpEniwDWeNZKbUqfCZFrJGg7OsF+p4HLzJ4t0Uz2yPC5nDaGv5PSJq
 7I9t8z1I/T0GjgYyc2FcNLQJIn8+UmRwc1b0tPILUucZBoGsl55nLVYK+vO9oxvAlOrm
 ZRClhf8noOlRliKki2L36rvFWxCdR5CeudLMg/M9SnScakr1wmCoF3OZqLa+IpWD+lsF
 6msZZBe34qGTd3AmmcoL28j1SjsI0f5zeEI3p/n2pf4/T2ZecpshDKel9p1wHTuCMxr2
 vQQA==
X-Gm-Message-State: AOJu0YyJILGtY1E+gcmnEbh01bubbOJMAAlPqstzPTFVxLgUMvWeASms
 sG3xPHdloUbcukO2FnJHjj/WNd7HnL4h6YC64b0Grmq1JAegvC1bdnKK+ux8J+bPJeXorIdhMev
 5SlUuYVs+jlraKmVm6eIe0qGoM/E=
X-Google-Smtp-Source: AGHT+IF3wOjgU4sPlvVpR6v9IgYnw2Kg3ithAR36X/m01b9d6XaH3TgNmY60cCMEKq2NoibdR5Ni6b3AEIQs4C6KR8c=
X-Received: by 2002:a05:6871:4413:b0:206:e3d:16c7 with SMTP id
 nd19-20020a056871441300b002060e3d16c7mr331104oab.105.1705948013469; Mon, 22
 Jan 2024 10:26:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
 <CAFEAcA-9LS2hP=Ju6K_wWdhFWVrwhYinSaq6P0s5xmcE6pDtKw@mail.gmail.com>
 <CAN9u=Hd7rnsE4XMvhTOQD0F3gBZ68L3kUvHphQjEKnnsY0iDrQ@mail.gmail.com>
In-Reply-To: <CAN9u=Hd7rnsE4XMvhTOQD0F3gBZ68L3kUvHphQjEKnnsY0iDrQ@mail.gmail.com>
From: Sergey Bugaev <bugaevc@gmail.com>
Date: Mon, 22 Jan 2024 21:26:42 +0300
Message-ID: <CAN9u=HcYOTc8_-2xwEsra+yiEaP55k3quVrMzYCJU1vrjxUi0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
To: Peter Maydell <peter.maydell@linaro.org>,
 Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=bugaevc@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jan 2024 15:30:10 -0500
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

On Mon, Jan 22, 2024 at 9:23=E2=80=AFPM Sergey Bugaev <bugaevc@gmail.com> w=
rote:
> call such a function. For example on GNU/Linux, remove(2) is a stub,

(That was supposed to say revoke(2), of course.)

