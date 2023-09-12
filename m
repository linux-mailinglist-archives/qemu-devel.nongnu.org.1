Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123179D371
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4Eh-00061V-Hm; Tue, 12 Sep 2023 10:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4Ef-0005xa-Ip
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:19:25 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4Ec-0002ec-46
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:19:25 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so7404309a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694528360; x=1695133160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XsWrXbkxIvZFGiWnbvbpyh5T4pVHS/J3lD13FdWfc3g=;
 b=BBAJC1F9UwDIQKSB5yvX2OeqnBqndakPZt6nDE0Tv7noPgycsf5NlUzib3/kGzF9PR
 y+O6UWQAityzuSvz6oqch3TNg5NsFp9jzK+l/jJcvhywdNJu6ty7SRGi6l3hLeBt+ZF5
 o1CEAwSP6yYPaA5SmWeOyJBy0bV+oIGVq0GS1zTPoP4Vnlfzfn3qAyKbU4lPnhGEPd+a
 Le64GQc0KERLRzPuDcsCMOjXbkRcuWuTjJHecZgtCGrg3rn+UeOZppC5YlKhpl/ehPHy
 Ei1g5GzLndphuH6eVyXjIurNHNiHQKfEd1EUbt4zZu4NcQeFXskeugysOnigaGsQLBJP
 k3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528360; x=1695133160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsWrXbkxIvZFGiWnbvbpyh5T4pVHS/J3lD13FdWfc3g=;
 b=AT/q/zCcVSKIbszycvXbCEuqFu3I7GG0AqLPJ3MHf33y4qSnwunDwPTPN+4ZaG0M69
 HVvMPvfyrb+b8a3IOkK8KGQfTrPjjlEleNxdJXVWIh5hyAWIp9Rq3F9Y5ZVgyI1eXD3H
 sP1ajtgDVjmrI4oEdbcaHGP2VDBNhnGSynO9NcbCouNC8m3QDELl8i4/aBKl+k/zM8q/
 4dQs4P7UIbgyOWd+flpzOhw4CR5bSsVL8vCe5TjDgJP6EAu6ggxc8V9dVfPk3jN0T8Qt
 jMHY+2OEBaxUYbWQ60EI7qm2akVHaTFcXmkYHe9w99fV59XH7hgk9LT8MgMQWk7qiNEQ
 X1PA==
X-Gm-Message-State: AOJu0YyzvQFwebr9xduVCsEJmuImGEfMai5+lRW9BVgHurSyYDnhLJPc
 p33kixi9BNP6n9c1IKeRPqPOkEt+rcJkOPKPIjlnduWLEaVIVdLf
X-Google-Smtp-Source: AGHT+IGF6eBs6G7UJh8VveDLsMWTEcbJdRRTzrTejM9GwIh41AOlkD1NQULFuUqli8iw3t8xoZtKppsZ5rVZ/4WEEDw=
X-Received: by 2002:aa7:da4d:0:b0:523:4acb:7f41 with SMTP id
 w13-20020aa7da4d000000b005234acb7f41mr10108306eds.14.1694528359777; Tue, 12
 Sep 2023 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
In-Reply-To: <20230818155846.1651287-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 15:19:08 +0100
Message-ID: <CAFEAcA9uqbCRyAH4a-yMtfTNdz+73ye_Ty1cONd8cfBOyedwpA@mail.gmail.com>
Subject: Re: [PATCH 0/2] audio/jackaudio: avoid dynamic stack allocations
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

Hi Gerd; this series has been reviewed. Did you want to take it
via the audio tree? Or I can put it in via target-arm.next
if you prefer.

thanks
-- PMM

On Fri, 18 Aug 2023 at 16:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset removes two variable length arrays from the jack audio
> backend.  The codebase has very few VLAs, and if we can get rid of
> them all we can make the compiler error on new additions.  This is a
> defensive measure against security bugs where an on-stack dynamic
> allocation isn't correctly size-checked (e.g.  CVE-2021-3527).
>
> The first one is fairly straightforward (although the JACK API's
> requirement that (a) you don't pass it an overlong client name and
> (b) that maximum length is provided by calling a function, not as a
> compile time constant makes it a little less clean than it might be.
>
> The second one avoids the dynamic allocation, but if the audio
> subsystem has a compile-time upper bound on the number of
> channels then we could use a fixed-size stack array rather than
> the awkward "allocate a working buffer at init time" that I
> have in this patch. Suggestions for improvements welcome.
>
> Disclaimer: tested only with "make check", which doesn't actually
> exercise the audio subsystem.
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   audio/jackaudio: Avoid dynamic stack allocation in qjack_client_init
>   audio/jackaudio: Avoid dynamic stack allocation in qjack_process()
>
>  audio/jackaudio.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

