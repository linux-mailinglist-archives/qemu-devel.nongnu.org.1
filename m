Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FB477E619
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 18:14:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWJ9R-0007yD-2Y; Wed, 16 Aug 2023 12:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWJ9H-0007uw-Ms
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:13:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWJ9F-0003C3-ES
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 12:13:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so62121575e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692202408; x=1692807208;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PE+5vPO5L4lpzbk4FSPJLB/bASu0Bpa8jODvIl8YnIk=;
 b=WyGOzuIgHH9s8yGCNmuFr+cdY6u0IvFzTg/b+nCqbbfdsW4HHj3LqlGJOr1fPuBZQK
 Jx2DzttKuCt0qPrGTlr4LShefU5LrokBpINU4cJVKMXJ2/3Z80MpZxx1WVS5jcz5gUSR
 cPkiiL5iV3Fumuhwn4FDP4awMitXFhMkIgfxYEpLDmaJfxgjlqUVuu1acpB9H60XX/2y
 Vqm+U2JrqF63AebmjGBNcP15cYPBCYvZLjoDD2sFecVHMBcsKmgypczT+rau1fwpvWz/
 m9Wm23C6qQVO/XK8P3GbUZ7ud9mnm9wzFssgJ9mGDVVZ3g1lpaAgYsLmAgopknT2mNMc
 /zZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692202408; x=1692807208;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PE+5vPO5L4lpzbk4FSPJLB/bASu0Bpa8jODvIl8YnIk=;
 b=Kv6RW7LCBsCZLr2qZF1kFWabodXKYPIHl1nBAq8yvjlV840Ld5Zst+Rezcrn5/6tjK
 5ULDJpoMzbNggJ4Mkx0vPfp/mLG9VwYBlexV/N8DnlvcsnAqXinE2K8zeSF6FkzAL6zM
 eA1IuMz5EqeVuAAvOfTP4Dv7KuQO7Pf7UG28RSUkiPvBJ4+pAJbrPsItZqx4NaAT7hpM
 9DPEZOL3apNS4fFlv/A+WMhpkqxDFk6XpoEUcwUbHKzFPdJtnrwWTQgLrxAeEQhbzvxY
 AlwpysR57HB5pAvlVZEjqJXbIXNtRgNiR6oLUVj2VZJTUO+ojvRMMTyrzGocsASGUsDA
 TiGg==
X-Gm-Message-State: AOJu0YyXLupTVnyFuAowlBgGrZPacK9w7dNkSAnuFwtpx511jNphhpSQ
 vq3Exn7rLPPP86cssi0yBFGdNw==
X-Google-Smtp-Source: AGHT+IFCqPMiKRBixd1fFQGz5nrl9nifXktIxYomw7za2ETzgc4h9FgsXwEHCiGVZO17Q6MzlQRvSg==
X-Received: by 2002:a7b:c5c5:0:b0:3fe:25b3:951d with SMTP id
 n5-20020a7bc5c5000000b003fe25b3951dmr1992920wmk.5.1692202407906; 
 Wed, 16 Aug 2023 09:13:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a05600c458600b003fe15ac0934sm1089643wmo.1.2023.08.16.09.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 09:13:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 09B631FFBB;
 Wed, 16 Aug 2023 17:13:27 +0100 (BST)
References: <20230816091522.1292029-1-thuth@redhat.com>
 <CAFEAcA8xna5-ewGMUjoVjJTsFKVeBbOPXJj481+GEC=ZzqgVug@mail.gmail.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Olaf Hering
 <olaf@aepfle.de>
Subject: Re: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a
 problem with compiler warnings
Date: Wed, 16 Aug 2023 17:11:57 +0100
In-reply-to: <CAFEAcA8xna5-ewGMUjoVjJTsFKVeBbOPXJj481+GEC=ZzqgVug@mail.gmail.com>
Message-ID: <87msyrnexl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 16 Aug 2023 at 10:16, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Update the berkeley-testfloat-3 wrap to include a patch provided by
>> Olaf Hering. This fixes a problem with "control reaches end of non-void
>> function [-Werror=3Dreturn-type]" compiler warning/errors that are now
>> enabled by default in certain versions of GCC.
>>
>> Reported-by: Olaf Hering <olaf@aepfle.de>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  subprojects/berkeley-testfloat-3.wrap | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems like a reasonable place to ask: should we just pull
> in the testfloat and softfloat repos to be part of the main
> qemu repo?

We've definitely forked the softfloat inside QEMU with the refactor some
time ago. For the testing repos we have lightly modified them to build
the test code but only by a few patches. We might want to keep the
ability to re-base on a new release if say test float gains fp16 or
bfloat16 support.=20

> AIUI we've definitively forked both of these, so
> we don't care about trying to make it easy to resync with
> upstream. Having them in separate git repos seems to have some
> clear disadvantages:
>  * it's harder to update them
>  * changes to them can end up skipping the usual code
>    review process, because it's a different patch flow
>    to the normal one
>  * we get extra meson subproject infrastructure to deal with
>
> Are there any reasons to keep them separate ?
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

