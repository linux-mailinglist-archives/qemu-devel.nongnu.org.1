Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A973B72C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfp6-000139-Pa; Fri, 23 Jun 2023 08:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfp4-0000mk-0Q
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:23:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfp1-0004uT-Of
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:23:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51be61663c8so548220a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523006; x=1690115006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXp47oGLNh9p2YnDXCzSE7S/t6QJAgmJXuUvykEqQAE=;
 b=Q+YawrYlrpeHKJX2qcSO6u8gwQ1K3lZjYRbiAyZF6MOg+GHX75utIYjiHecHsm/aCQ
 cPmiEZNni7TniKOoiptIW28d9/DutqDdBjWjFrgaReczbZaX+AVmhxJ2vtGC5O9SHoCG
 mWTH/Hj2w6fF3Z5ZFnN7hCjNw4ESUIXHE+AMT/mSAGDr9nbSlTBy6Ra9zWz7OWKKicFT
 GpgW31s027jcVQcx0wzuLRwxyGKOdyMpf45Jklp2Q7Gxyjd3r0h0QoRHT4S3FaOOVBry
 kHJiJ7Hz1HR4QjClpleLfocrKhg5hYUDjj+8sUZebNJqvsFiDKPHbwJmEwf8bM3gbnTv
 wHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523006; x=1690115006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vXp47oGLNh9p2YnDXCzSE7S/t6QJAgmJXuUvykEqQAE=;
 b=SG3XPjezMVgDsDSMsHWxZXiickxtLvpbV0tfB6RtR+JkEbbYkqBAQ0UOIJxXmLniYP
 B+Sd1ru7JyQRZFAYg8xRD8++ufgcEA5ZeHMY6ywZKRAU+CM+NMdRHVwd5TQC1RlOszFV
 4+WLNbg3QDRiohzED2ApkP2iE5P3itfUuBIOar0hINwgGLnY65MGqVJDYNJ3JcRasPVw
 bpt391HBcMWQEmICLC51cqV8Sa7ywnuFdnxqu4nHkZAuX7/udq7XRd7i/BGh+2oGIMs/
 l6wPbI0jhSKyvdWHoRrTgfbpVwIuqTLDemxRcv+0yoQFevcfbm7UVetcfOqOI3NVOLap
 Ncug==
X-Gm-Message-State: AC+VfDy/4DWD7KlKti63svn6gTcCDgzuoMxqBZTkAqIbcpEoondtTjeJ
 zX0kcra4nWkYnJMO+7RcGWqSsUQs7ahfL3bWyBO+6g==
X-Google-Smtp-Source: ACHHUZ4r9jd68vB29U8iK50jwchhhoExqSjN6sScXPRI08pugh2SsMCvYLBOJ3iumiS2/PPw9cTeNojbADZicfrbbtA=
X-Received: by 2002:aa7:d148:0:b0:51b:f860:29a5 with SMTP id
 r8-20020aa7d148000000b0051bf86029a5mr1279156edo.4.1687523006160; Fri, 23 Jun
 2023 05:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-7-alex.bennee@linaro.org>
In-Reply-To: <20230623122100.1640995-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 13:23:15 +0100
Message-ID: <CAFEAcA-Ghv6bybS8gxd-S+iFqTLvWBDw8rJ_HbVWevYaAbOBqA@mail.gmail.com>
Subject: Re: [PATCH 06/26] qemu-keymap: use modern name for Arabic keymap
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Juan Quintela <quintela@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Alexander Bulekov <alxndr@bu.edu>, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 23 Jun 2023 at 13:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The very old compatibility alias of "ar" has been removed from more
> modern versions of keymap. Lets move with the times.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  pc-bios/keymaps/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There are already two versions of this patch on the mailing
list, both of which have better commit messages than
this one :-) The first one is:
https://patchew.org/QEMU/20230620162024.1132013-1-peter.maydell@linaro.org/

-- PMM

