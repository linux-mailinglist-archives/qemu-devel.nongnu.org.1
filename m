Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DDD724521
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XEQ-0007ho-6a; Tue, 06 Jun 2023 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6XEM-0007gW-4B
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:00:14 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6XEI-00035R-Ce
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:00:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-977d02931d1so420229166b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686060007; x=1688652007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXLVIqQ17af9AEIo8rlemNN90m6YTPIeXzw7tdLiZEE=;
 b=aYi8RCRN24CihPu3rfC+PppboqT91taImifWWh450XuvPYf5HvDJSRtBTesUjnYoQ4
 M1NaRu8qGV6Iqt6kXW63ejIs6nZaLACnUT3OLZRF0kXsBt4JiHgFF92UGiROC0+kuecv
 2LThmEC18EOBT0DcgPy8HdOCvWYkN3BH9VizlXFjFb8y5A2uwpFZaAKKwqO49UfN85vo
 XDxwzzlbCtm9abE1rFtzPJDJNL7pV6MnZyPrZcDVBPp7NfzbWLLUzOCpiIWQNoHbwXvM
 eJ8woXsKLKEjsluinoBangALCKOwNn2kF3cAkbzlwtZBF5uUkGGTKnyGuSxL97iDkhMw
 KppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686060007; x=1688652007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXLVIqQ17af9AEIo8rlemNN90m6YTPIeXzw7tdLiZEE=;
 b=ktt91/oHXZDa849dynn35xvO9UrgFQjw0w54Jotzr+hnS2xD4++2RxcM6o28HpUweg
 Ts7ojmVaoT2BAf1SuIrIo40fBUKN9eCaJgamQ4r8SptuItJUe2ajM3CJlinlqGsdbBcR
 gKJPAat+83og58skyaFm5HW1tfWlHGPmiGCoOXXH6SCvP6fIKYDEcHf0efoDDpR5/fqe
 XZZHtzTAB9IX7Y4l9F8CFLyx6f0vfZQm4t3SYtZMij9I4MS816ULrBuRP4NjHYa2tQg/
 C/GvTWM1fBXO7LfzzyMsPKaHUXi3xQPoupq4yhTe6GuHl0P2S3zdGWPQ19eeyDiBRkAF
 +t4Q==
X-Gm-Message-State: AC+VfDzdSj2OOf5gEroio9NnzP576KZh5C44lmvUnIvr49/mTKTILuJ5
 mKrgFRh4GnFUoJnh3AENKZAgigBhOyaJkboxh/cXrw==
X-Google-Smtp-Source: ACHHUZ6VitUdgbdTCsWGEzpBzgM7WC+Ye9htS5ehC59LcYCZYnD8qfnoUbU3o1G+d/6hQfYyUkD/oVzez5TaW9Q5kcM=
X-Received: by 2002:a17:907:3da7:b0:96a:17f4:c9bb with SMTP id
 he39-20020a1709073da700b0096a17f4c9bbmr2387154ejc.58.1686060006649; Tue, 06
 Jun 2023 07:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606134913.93724-1-philmd@linaro.org>
In-Reply-To: <20230606134913.93724-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 14:59:55 +0100
Message-ID: <CAFEAcA-EgmjaMJkmiNF62Fqxu72V_UrFJj8Ae+21OL24S8GfQg@mail.gmail.com>
Subject: Re: [PATCH] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 6 Jun 2023 at 14:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> event_notifier-posix.c is registered in meson's util_ss[] source
> set, which is built as libqemuutil.a.p library. Both tools and
> system emulation binaries are linked with qemuutil, so there is
> no point in including this source file.
>
> Introduced in commit bd36adb8df ("multi-process: create IOHUB
> object to handle irq").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Note, --enable-multiprocess doesn't seem to be covered in CI.
> ---
>  hw/remote/proxy.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 1c7786b52c..2052d721e5 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -22,7 +22,6 @@
>  #include "qom/object.h"
>  #include "qemu/event_notifier.h"
>  #include "sysemu/kvm.h"
> -#include "util/event_notifier-posix.c"

Including one .c file from another is definitely very weird;
if it is by some chance not incorrect then it needs a big
comment describing why it's necessary...

-- PMM

