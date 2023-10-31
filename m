Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9127DC6E5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 08:06:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxio7-0005Ap-NS; Tue, 31 Oct 2023 03:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxio6-0005Ah-Ef
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:04:58 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxinu-0002Ac-4t
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:04:58 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cc44736f2so39094581cf.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698735885; x=1699340685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucltFnCXkeFj7YLsU4TC5x/GxybTsoXKv0SH/ZgzoKU=;
 b=nXLE+VGbl2LNUYAL8zqYzYp4XTgQx05OQFeAq3Ba0eOgGz6SfCPbNOkaWkm4bLP2Im
 rkVgwsPHXW6QcWN6Y+3ju3fEutTW7qzuKkOmsQExeKp13jRt2iW5Ao14NgVl+rNxIqrS
 RGtQVrN3XkYIC8GDo0SObGGrySODAvbaOEZoTOEEamhhhphG1CsgdgkTMoU2S7+Nzd/C
 T9h8nFynvcGEldxU7o+7jGHFHeEQhYx0jE7t3SREPl36iaE/emC4NaZ5Wb+RZwJnpkv2
 i7TLH8ZDTXOIOtGmAn9/8eW4hAYviwhXujbPhIjtjfeZqz4qHtXEP+M6TXeAmJhYwfa9
 AHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698735885; x=1699340685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucltFnCXkeFj7YLsU4TC5x/GxybTsoXKv0SH/ZgzoKU=;
 b=euCLchNLjKdanQs+nLRaFoKQU1628085oASB9PvAaq5doAHavHDOK/YR1Hwqcozi20
 k1VLPf8gnpH29eh7E8CgqFczy6pXDXKWy085k9qDxYmJUaz4+RXqeewh6DQs0wOKBpux
 BigOVnXg6n8jGQW0or7aU2XGPHPvLoS+6cht4QvVqerrWhWm9LOxrLAgyVr1Dvw/jAkv
 +7X0QAb9HGEhRLNlyBGSxZBgS8C/IoOSgNw9MB0Z2cj66NaeQM/tc3BMn2mjIojgmn3p
 UQe/Y8BA3GM4MRiWwq/v3OBOh/C5KxdaOTTu9jfVHNMn9xnUhlLyCY7DWjDDhwkIeiVC
 bASw==
X-Gm-Message-State: AOJu0YyySpzWczjkZoEf5tmFP96hctuP3RQN0H+1ZDpi28aqha7kpODw
 NM0NXGmx1wHVyzcSs7Fiuggi1AwN5SIX3iHmgHA=
X-Google-Smtp-Source: AGHT+IF89MwDRV1Jy+BxlF6KJPb97nlP9If7q5emtQs4VCiv0BiWqBS1DMvIRg48bK+fR/luESc6Wp1TgRsMG4b2M8U=
X-Received: by 2002:ac8:5846:0:b0:41c:bf67:37bb with SMTP id
 h6-20020ac85846000000b0041cbf6737bbmr17660837qth.59.1698735884835; Tue, 31
 Oct 2023 00:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231030104755.124188-1-marcandre.lureau@redhat.com>
 <e1b841d3-9423-4257-b45d-9a5f269813f2@tls.msk.ru>
In-Reply-To: <e1b841d3-9423-4257-b45d-9a5f269813f2@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Oct 2023 11:04:33 +0400
Message-ID: <CAJ+F1CLgPEPoT-5KbZvzyBhQBWX6iZcRVi7ZnXRTeUgus2HMQA@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] Make Pixman an optional dependency
To: Michael Tokarev <mjt@tls.msk.ru>, Anton Kochkov <anton.kochkov@proton.me>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Oct 30, 2023 at 9:29=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> (Trim Cc: list)
>
> 30.10.2023 13:47, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > QEMU system emulators can be made to compile and work without Pixman.
>
> Out of curiocity (not opposing to this in any way), - why pixman is such =
a
> big dependency to require quite a lot of code refactoring?

It's not a big dependency (70k loc), but it's one we can drop to a
have smaller UI-less qemu. The changes to accomodate an optional
pixman are imho fairly small.

Anton, are there other reasons?

--=20
Marc-Andr=C3=A9 Lureau

