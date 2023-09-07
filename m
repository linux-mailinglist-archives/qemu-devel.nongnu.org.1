Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BFC797148
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeBQP-0003jS-II; Thu, 07 Sep 2023 05:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeBQI-0003in-Pu
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:35:39 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeBQG-0006hL-Ae
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:35:38 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso938388a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694079333; x=1694684133; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzXl+6/MUPKrN5COciqoqPAh22vssMsnbzoiwxSp2P0=;
 b=URtHTVUmNo4TfsA90Ss9aSMaS1yhPEyfTCJzcPS6Wrez/me8Jo0+kBaHjB/VVD6OQI
 N9XkHJ5WzCC2skHHdjmFcr25qoFd7JuxuLgQqZCmpsuDlMHxHd0/web9/mx8l/TQzDl3
 oMK9Kq6oJGoF3LKrUklhndf/NCTIVKnGRcsLzVjQqMXi8EtPGEkp+8IiG9VrpJkFddzq
 /J1zukEzM2OgVHV0ofC9naqyw142QAT/YMm/BOX+1dTmRMCQkuy0r/ini/TFV0/ja7QV
 ETvBOKacxZkWY3+v7uqWr5rP4C0kidAQCuzdwH/rOerv4L5lz4qhTziqnNuTpbRj/Its
 ncZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694079333; x=1694684133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzXl+6/MUPKrN5COciqoqPAh22vssMsnbzoiwxSp2P0=;
 b=Cb3DXL8/Yd7/j4DgkQ1l+CrzVRVr3BGH9MNyaoSfjuRwZnUt8JLc2w4e00r+fxpymE
 ctxLTJSYxVDqTmQDw4+s5DDlpXLdSBowUl70WZ7xIt1H4Td9U8NTKQrf+9hRpdbkbiel
 ArSzR2jKmuROodDckwhQr834sMe140XdIcI0yiCpfg1XdRFsXLD52WAXwk1XeZ3rBYvI
 te6TtowuJsX4woGdaoBZ3uzhV8GN+2fIDYQqujt7CeqDQmtxvrejMaLo74b4nd7ZsQL+
 0i9OMo5oKsr8UGpoC+zVR2XaZ/a0C2c68/78u3l52Tdqv5c+mzJ4XGjn8QRwZxIZSvaI
 TL4w==
X-Gm-Message-State: AOJu0YyOjKFrt6ASAyGW2f3Iofjy397ZcIfB4UhP2MvGunNvrL6Hagh5
 VQEb6iuFvoZbqCbxZhmuoDiMByqFgp/n6i8sgn59vQ==
X-Google-Smtp-Source: AGHT+IH9pUOVAAxTxc3/bdA15Bbilg9am3xKBLGHAR3oM7e6CKZ2/sWHhNGGbS8DK/ytSUvbmXYOuZ4/x9JigTiMRng=
X-Received: by 2002:a50:ed03:0:b0:52e:1d58:a6fc with SMTP id
 j3-20020a50ed03000000b0052e1d58a6fcmr4489262eds.5.1694079333353; Thu, 07 Sep
 2023 02:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
In-Reply-To: <87edja9vkr.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2023 10:35:22 +0100
Message-ID: <CAFEAcA-OVUqhwUprR2MJW24yxWpvz9zxv7u7iGqnYhtaGNM96w@mail.gmail.com>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, William Tsai <williamtsai1111@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 7 Sept 2023 at 10:33, Markus Armbruster <armbru@redhat.com> wrote:
>
> Kevin Wolf <kwolf@redhat.com> writes:
>
> > Am 04.09.2023 um 18:25 hat Daniel P. Berrang=C3=A9 geschrieben:
> >> By the time of the 8.2.0 release, it will have been 2 years and 6
> >> releases since we accidentally broke setting of array properties
> >> for user creatable devices:
> >>
> >>   https://gitlab.com/qemu-project/qemu/-/issues/1090
> >
> > Oh, nice!
>
> Nice?  *Awesome*!
>
> > Well, maybe that sounds a bit wrong, but the syntax that was broken was
> > problematic and more of a hack,
>
> A monstrosity, in my opinion.  I tried to strangle it in the crib, but
> its guardians wouldn't let me.  Can dig up references for the morbidly
> curious.

I don't care about the syntax on the command line much (AFAIK that's
just the rocker device). But the actual feature is used more widely
within QEMU itself for devices created in C code, which is what it
was intended for. If you want to get rid of it you need to provide
an adequate replacement.

-- PMM

