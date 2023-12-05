Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DB804D3D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:09:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAROz-0004CC-DP; Tue, 05 Dec 2023 04:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAROu-0004Br-IO
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:07:32 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rAROs-00079X-Pr
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:07:32 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54cff638658so1175645a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 01:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701767248; x=1702372048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o4LUhuAQmdNvhNwoAmcjERPVwyQQTyUv0QlU/6hTOSo=;
 b=L5/mGBRQj40c6NPQiBPWNXbsYYZenXkm5ARO9YLnPPAus7tO99s1ACrzgZwE77CSie
 VPfMCNEXNHNXriBCGvRPspgdGj4UTl3JFVS2ov3RSHMAgwSXM0KsrSe1IsblObN0N3FM
 B54ddL827kDqEuJpc1GnQhrEoK0g3w/Fxx8UfT9vGk7BAidBMcxXAFo92bg0Axvm17ck
 W05IHWxG6gl81Y1B9RlbyYoIGszMooJaunmrhHIIHfoNbnecZxWdGlDFD6iADmWYE4CN
 w5pF/2NOMZpbk2xfzxcSuM7zQbSFPYU7VSTKuOsflCvUmYV2UdeCK8+KvLgUTTab8pR/
 EXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701767248; x=1702372048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o4LUhuAQmdNvhNwoAmcjERPVwyQQTyUv0QlU/6hTOSo=;
 b=NuaRuvFRwmy50jRJ8tqH/2xU4ym7VosVuLfmcufhJW9hBPlhEb89e+NPiN3rf4q9yQ
 CePzRPTx+Z/6TRv/eiyWlp3QicJysdaqNkNVU0Ix+rs3La6BnFH5vapiV7cwsMNEcuQh
 wuQ5Jp5QoD12ApzDZjIr9UHes4qwylYqcYTwCieNRRV4dkiwKUv9KKsWdKAVWjajGH30
 cLJRRbyN5To0Ql9oNveZfYd6Cdpf3TiB6v1mT8j7TjSL3I0y+s3e95SWDSBFHu30rcgi
 JDp99SbbFTxeehACmwXmChxfPe6iGG5AY+bF7+5istTagvMEKq8DFU+uLmeCmPhbJ/DQ
 onzQ==
X-Gm-Message-State: AOJu0YyfRJUNLy3ER861Nl5/0e5pW+LQaQF6GzL+04LouaUHLxKwSQn1
 qoEeOLUsESdt7rIpvLSbPD+MszheWldpsFhYyGz3sA==
X-Google-Smtp-Source: AGHT+IEsl7r/T66q/2nawImcw3+DWNafkP4WbX/oa2zzOTZAvYhNx6w3uF+tAesfb7vdto1EgJboRJa/t5cX/Hjb1Jw=
X-Received: by 2002:a50:9b50:0:b0:54c:4837:81e2 with SMTP id
 a16-20020a509b50000000b0054c483781e2mr4056401edj.51.1701767248699; Tue, 05
 Dec 2023 01:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20231202044846.258855-1-arorajai2798@gmail.com>
 <CA+9mx632wGOa2egPZBKLnr5UZLzeX74V8wF0=pkfO+jQg0dM2A@mail.gmail.com>
In-Reply-To: <CA+9mx632wGOa2egPZBKLnr5UZLzeX74V8wF0=pkfO+jQg0dM2A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Dec 2023 09:07:17 +0000
Message-ID: <CAFEAcA-Mpv_Braq_wPNb4nE_Bh5FFDsd7jC_R4QOwx=9BZVOAQ@mail.gmail.com>
Subject: Re: [PATCH v5] accel/kvm: Turn DPRINTF macro use into tracepoints
To: JAI ARORA <arorajai2798@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com, 
 alex.bennee@linaro.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 5 Dec 2023 at 04:05, JAI ARORA <arorajai2798@gmail.com> wrote:
>
> Hello maintainers,
>
> This is a friendly ping.
> Are there any other review comments for this patch?

Hi; the patch looks good and it's been reviewed; but we're
in the middle of codefreeze for the upcoming 8.2 release
at the moment, so the patch won't be applied until that
has gone out the door (should be in a few weeks' time).

thanks
-- PMM

