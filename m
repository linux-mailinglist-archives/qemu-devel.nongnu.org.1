Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 706387B076E
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlVwx-0003az-Qa; Wed, 27 Sep 2023 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlVwv-0003Zh-Qh
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:55:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlVwt-00079h-MY
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 10:55:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533d9925094so10012049a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695826534; x=1696431334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ncsAv6p8fB1I/jEqJ2f7aQx/Ey/J+BHHfFEgFUUXAo=;
 b=QQgefLVG1XUccRNtpfktT5sonAxRe8ExP8AyMoNR3sC3tQNzrNwbehTvxdViNlyGty
 li61xcs+SGNVjzpMiQfBw5Bym4ewgLvip6a0fnJmFm9Uvf6YvvobSlSuVe8tnv98AqF6
 F4MpbKsfaormxCDvD+T9lRM3YegQ98bp/FWIu6RaqFc4NIPdw/Vld5Cj5XSUW/FmnhYy
 ZzkLWBoLSopEhHi/vOgCLe8qw7eGnNswtr4lfUnSzB/yOdytLM+h/He/HvRnoQCcYktE
 VzIf5p8bPCo55QY+Ra4NDUf0NKGKJDP+XQfZbkAJirt4hHPD+vsnk5EuHLaMhjFPGzNO
 Jjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695826534; x=1696431334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ncsAv6p8fB1I/jEqJ2f7aQx/Ey/J+BHHfFEgFUUXAo=;
 b=cG/qNi7+DTH+ejB68kTISJevokM2ZQrHIMEIKTlFYfDiz8Eqfu6swC6B8r1zxZmuTW
 KKRpuJZM8NfSvHxa+k2WRgGK8OJgx/tUuynI9hVWjoVgSk62/2bIge4D4A9pOGY03Pf9
 IwtxxdyhqIY957m55D+K7M1OwfUX5NrRWWGCrpJ0uIJYYQlhAdhYIeqIyngx9zsrpf4c
 L4upnVp7z7RvMmcP6ViCGLQOZk0oJ4dD86QX9VEVr+SymU0LUFfZmC4oKKe9jGyhll+s
 rYMn0xcRteJMUFZTTnZwM/R1lqATYz21Yp2+A0zSxWJIZe0N8n8oE+0YVjg0lPGFbsLB
 LJcw==
X-Gm-Message-State: AOJu0YwyU0WVWOkEJXqbQM3OhGxOOvsgozW63CgrwKTbf73eEzEPtx87
 gSGwF1ljP2TN5gxP/sjqyqlw3NloTwZT5PAW9/KBmA==
X-Google-Smtp-Source: AGHT+IHmbnqildvsnN0qVu6+PLy0Jz3p7z5TG0eVWt97xR7xsh/RT7CaOHI/oZftkfxkjAJEJe5paqvjTXQNuvzZQEI=
X-Received: by 2002:a05:6402:1810:b0:534:2fd8:a9e6 with SMTP id
 g16-20020a056402181000b005342fd8a9e6mr2588806edy.24.1695826533773; Wed, 27
 Sep 2023 07:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230927143815.3397386-5-eblake@redhat.com>
 <20230927143815.3397386-7-eblake@redhat.com>
In-Reply-To: <20230927143815.3397386-7-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2023 15:55:15 +0100
Message-ID: <CAFEAcA-RQHSeE9-5vcF4b22N=pCVS8fw78L5qLOn+Q2eCegTYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] maint: Tweak comments in mailmap regarding SPF
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, andrey.drobyshev@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 27 Sept 2023 at 15:40, Eric Blake <eblake@redhat.com> wrote:
>
> From: Eric Blake <eblake@redhat.com>
>
> Documenting that we should not add new lines to work around SPF
> rewrites sounds foreboding; the intent is instead that new lines here
> are okay, but indicate a second problem elsewhere in our build process
> that we should also consider fixing at the same time, to keep the
> section from growing without bounds.  While we have been doing that
> for qemu-devel for a while, we jut recently fixed that for qemu-block:
> https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392
>
> Mentioning DMARC alongside SPF may also help people grep for this
> scenario, as well as documenting the 'git config' workaround that can
> be used by submitters to avoid the munging issue in the first place.
>
> Note the subtelty: 'git commit' sets authorship information based on
> user.name and user.email (where name is usually unquoted); while 'git
> format-patch' includes a body 'From:' line only when sendemail.from is
> present but differs from authorship information.  Hence the use of
> quotes in sendemail.from (not a semantic change to email, but enough
> of a difference to add the body 'From:').
>
> Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

