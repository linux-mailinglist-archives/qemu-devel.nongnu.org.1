Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 992727092E4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwIb-00065x-90; Fri, 19 May 2023 05:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwIX-00065H-5T
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:21:17 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzwIV-00047X-Lv
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:21:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5112cae8d82so597292a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684488074; x=1687080074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lI9Uy75B3jWMnEHGhSiOejzd6AMTOTsbEavQnkvQx4I=;
 b=D4VRWhTx8LXTPIrTVC5p0UB6SV+Drq4YXsvt7KHdJ/Roh+57+Geq0luu62z1ga52Hi
 8/1MveeZFAjqZe3CXxskWqiJ+k2KKZg/SRfBWiWOU1lqdWxRmGk4DqOFjhhLStBLuvda
 rwpa/dXKXxZJhHzyUtUoF6exU1W/fdYzPKaSNAVaX19GcBT1vzZSmTDJVAs1QVX96xZ2
 l9Ed0Ar4a0ap3lbSKP7+PwM3PKmEKs5Kvjtpt9jXaR5yjAo6jY8qVYKIPIJva3ZtwjBK
 KuDBg2u+pXlw0DQSrgVsN9f/tY5AQcgVHv46WOygnfGhM/Chfra0Pez6QJN7REjPc1LU
 BJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684488074; x=1687080074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lI9Uy75B3jWMnEHGhSiOejzd6AMTOTsbEavQnkvQx4I=;
 b=JR5s9G+sx3xKQHcoYuyNQTiPUavJxucti4+c3pJliIGzaPdQbORz9XfwbUJP6WRvyg
 FqUc6eXqS1ORAfAWZwwJNIRu8kz2uhJ3ZMSmgatxcaPjSSk8p6X7SDf9W3k1Y3w67Uk7
 QtlKlRK4h+7sqquiEPyMiq223K3iDBozeG2oAiuLGniCkuC+YZf2adNt7PNlYLOgIUAl
 4I5Lsci9l8zT4O4TiZylRLeJdYEGJPCpQqI9833DRtWTpBPERc+i54KbI36qZ6At4y3F
 OIw0q1rEXbXr01ycR1CenmXOOxQT/qmKVePoXVy5MtHkursX23hdycLJw0lOZq+YH/UD
 /APw==
X-Gm-Message-State: AC+VfDw/QKtoCfHoDegnWkI9VtqKLhrwuN79i1LgShGNnt2cRhSSsV6A
 SO4k/7cDNjqxt2j2RUGi6XpgVu+DCAgiZWlXAQn16w==
X-Google-Smtp-Source: ACHHUZ6CSYh4kX4tWyneSgNI2+iBJpO5i03JPEbwQLr1QllDGg3hfst6J9V3WYnYy/ukEFqotVGgaQ5WowAnaXs5L7o=
X-Received: by 2002:a05:6402:544:b0:50c:646:da42 with SMTP id
 i4-20020a056402054400b0050c0646da42mr1087640edx.28.1684488074016; Fri, 19 May
 2023 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230519085647.1104775-1-pbonzini@redhat.com>
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 10:21:03 +0100
Message-ID: <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 19 May 2023 at 09:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> QEMU bundles a copy of dtc and keycodemapdb.  They both support meson,
> so we can run their build system via subproject() instead of hardcoding
> their contents.
>
> In fact, now that QEMU's configure script knows how to install missing
> Python dependencies, we can replace submodules altogether with .wrap
> files, which have several advantages, either immediate or potential:

So do we have a path for getting rid of submodules entirely?
I'd be all in favour of that, but I'm somewhat less in favour
of "some things are submodules and some things are this new
.wrap file setup"...

thanks
-- PMM

