Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8376C878
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:39:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR7Mv-0008AR-F3; Wed, 02 Aug 2023 04:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qR7Mt-0008AG-5N
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:38:07 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qR7Mr-0002Jh-NV
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:38:06 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-585fd99ed8bso9703647b3.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 01:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690965484; x=1691570284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJmuCQ2aYUZqeDeja7tRCPWUFuH1o5surr5PC0uGj5M=;
 b=BidEGrQQqSMVOymNvD2iVPfuQsA+8zYqmWIoVFkvOETTIaCGRcX1zZTHYTpMjAMLwY
 eRuNfiOAjADNLs7l7dmB5paauJ+v5esGOyXin7xXCu7ddjdCl8e8q2LV8QhN6jbkVI2S
 He0NX547A0Ecrcibewk8yiu0bjKs91CSKsgIMIeg1jlMM8QEnANKAJhxGrWcmYJX+BD6
 2i5nkk8cvgrt03Q2VXpYBny7DDka0QPKlxFVpBmGPs7cBbLXQ2sdu+bUREF2e4fDtyEX
 qdg9SUgeAueMPn/3JNwQIuzT1J1+K/ATpBb4tw3WIwpYCN/OYqGiJBKVH534sn16p8a9
 X9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690965484; x=1691570284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJmuCQ2aYUZqeDeja7tRCPWUFuH1o5surr5PC0uGj5M=;
 b=IDlw9dDHszGN4goUYzVP+EPr5ackaGeDCfyrl2xeR54Q6pbVBMog1eUXyje47uydBb
 TUOajYkAbzjfcq8vXfWl7tGbh/XAiz9+fgo5VTGP7LyUI9u30vr17uRJoNbtIEBnAxHh
 uQ9cD5craFFNaJum+vKJzEFnSOPZm5sHwU7L20OuWxevQkuaX5kuwjAjRigdyKA3TjPo
 UPiNUElfLX8188vAzNUTOGPF3/hLO4IxemyX2FjK8tCFDuKb/cRv27lI0zu+6LLQu+od
 d1wNxMAAZy/xIqjSpUHMJ2rAdAWCKdJzyZXWQB82+OyhmQNYlrAFC2qmgrcMzuzNLWHR
 Fe6w==
X-Gm-Message-State: ABy/qLZw+nBq0cAVh2KmQRrrkPA93SYXdzeXq1lcDia6pi9scbYO3oYN
 pqcQpjjNOx2CtqaFPSLP3IILwvIQN3wwfn4ZO7M=
X-Google-Smtp-Source: APBJJlHTjzu7QebWbAEFuzN0jvIFjatkGH8YvxTrQjRexjppVg9dSQJzMsJnhZHDdB1I7GXHq/34j3J5rz5ptnqFt40=
X-Received: by 2002:a0d:dd15:0:b0:56c:f0c7:7d72 with SMTP id
 g21-20020a0ddd15000000b0056cf0c77d72mr16959340ywe.4.1690965484140; Wed, 02
 Aug 2023 01:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230727233405.35937-1-mike.maslenkin@gmail.com>
 <892a9975-1901-862d-4766-bd76fbb5d7cc@linaro.org>
 <1dea4954-900b-d2be-b9bf-c2c10198b7f2@gmail.com>
In-Reply-To: <1dea4954-900b-d2be-b9bf-c2c10198b7f2@gmail.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Wed, 2 Aug 2023 11:37:28 +0300
Message-ID: <CAL77WPBKh=uR9rwUajRo_TsSB6gP1t7gZeZpKfByKsJzJUSY3w@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/ufs: fix compilation warnings
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yw1-x1135.google.com
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

Hello All,

I'm ok with that.

Regards,
Mike.

On Wed, Aug 2, 2023 at 3:52=E2=80=AFAM Jeuk Kim <jeuk20.kim@gmail.com> wrot=
e:
>
> On 8/2/2023 6:03 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Mike,
> >
> > On 28/7/23 01:34, Mike Maslenkin wrote:
> >> This patchset contains a trivial compilation fixes for UFS support
> >> applied to block-next tree.
> >
> > Since the series isn't merged, it would be clearer to send
> > a v9 of "hw/ufs: Add Universal Flash Storage (UFS) support"
> > with the fixes squashed in (there is still time).
> >
> > Regards,
> >
> > Phil.
> >
>
> Hi Phil,
> Thanks for your comment.
> If Mike is okay, I'll send v9 of "hw/ufs: Add Universal Flash Storage
> UFS) support" with the fixes.
>
> To Mike,
> Is it okay with you if I make a patch v9, incorporating your fixes?

