Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A57D437D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4ko-0001N4-C5; Mon, 23 Oct 2023 19:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1qv4kk-0001Mh-Qy
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:54:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1qv4kV-0004Fg-H7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 19:54:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso30216345e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698105252; x=1698710052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6o+DekYjjnj3xmt+pxvdI6YmCXVRtdmhxWyk/XPyGoU=;
 b=RFMuBy2Q7ylAzpwsTsqWSxGAdC1wXCh8S1vxFICIrECz6EmlZRCy3ALkPuwg2QDk6m
 GEYg2fkesRRino78h+rx1CV37X9b4Z7qfagWQUTE4k+j37+ZI4ecDHO9iaN1rvE8AkXJ
 ynqqoDSHqQZTCbuaoYYU5IfhCccw4RPVaAH0MzhDAaSC6prepnJoiilEFcFcouWPHR7o
 Ztzu+VU/i7ejvsOfWmZEaGn1f6MvCk4M8rnoBJwLgjd2qPACSQjA+df7+rLvmBf6EFH0
 OEQ2JoCchh0XgfRNOfwWKpRbrtf7zY7e7Cedqib/x36w1SZE4ETuqrd/LgAvfNcXUJ7g
 2Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698105252; x=1698710052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6o+DekYjjnj3xmt+pxvdI6YmCXVRtdmhxWyk/XPyGoU=;
 b=SKgpGDpyzrLiTufWjZ7o2mmtW8LKITQhyUTijrjg4J7dausTdeImYmFQvHF1vx+ZY1
 wIRNuCoCz0MrHFvjeDfF+4Mv4KlxaUq2Viywzg+lDe9VOzLNTfUGfpY4vDWg+eMCCP/7
 eRcjclYXv3Ai3vQGvjuhS+xBhGlZ9sQyPo721Ld3yZt5Q+VyCx90PlwEPbu7ApIQIjSO
 tZzyxSez2GF241EUqra+uGEts8VY/s49fG0UPd+Im6wzYQ32oOfrB8wvOvNmxknq0Di2
 N4NwoP3jnBAl3d3SXGMJoCgyRwGWC2ao7X9q44xdO+Rtq1IHOWHyzisR7fi7/0/4VR7z
 qK1w==
X-Gm-Message-State: AOJu0YxS5kG6b7kzQCA3bmgoflj86A3xCm5oTtbe0Tz7ahgMlU7MZ50e
 XA7Ovre3lIMfed3ZXiZs9Hg/U0LHKhNz2D+cYfsCcw==
X-Google-Smtp-Source: AGHT+IFXA5BXYASV66wpZJBzx7v/e6rwYJWG3ZIXSts0YIzwAU5oJ7L/Pz/nKcYoXhaptq2vOhv0XRL9b9HMdpPJWCU=
X-Received: by 2002:a5d:4e06:0:b0:32c:d0e0:3e70 with SMTP id
 p6-20020a5d4e06000000b0032cd0e03e70mr7758101wrt.56.1698105252332; Mon, 23 Oct
 2023 16:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231023180837.91785-1-titusr@google.com>
 <874jih40a3.fsf@linaro.org>
In-Reply-To: <874jih40a3.fsf@linaro.org>
From: Titus Rwantare <titusr@google.com>
Date: Mon, 23 Oct 2023 16:53:36 -0700
Message-ID: <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, minyard@acm.org, philmd@linaro.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=titusr@google.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, 23 Oct 2023 at 12:16, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

> You seem to have missed a number of tags from previous postings:
>
>   https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#pro=
per-use-of-reviewed-by-tags-can-aid-review
>
> (although I notice we only mention Reviewed-by in the docs)
>
> You can use a tool like b4 to apply a series and collect the tags. It
> will also collect the Message-Id's which are also useful.
>
> Once you've fixed up your tags I think as the maintainer you can submit
> a pull request.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

Thanks for the tip about b4, I spent some time getting to grips with
it and it's a huge timesaver.
I haven't quite figured out how to get it to produce and send a signed
pull request, but I don't need that just yet.

-Titus

