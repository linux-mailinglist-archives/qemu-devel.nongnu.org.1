Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C20792189
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSTB-0001kv-7f; Tue, 05 Sep 2023 05:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdST3-0001kP-R4
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:35:30 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qdST1-0000Dx-Dd
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:35:29 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4bdso3167229a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693906525; x=1694511325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmfCKXS6GDIMgVWG20l7MYVW8dhC0au32yxx2pOBfT0=;
 b=j/a4KnJwUNaWO2lwtg2pr0XQB93Q0DLmEuxdCXr+VKbZcE7Q1yCwqnsCSs5+88oQny
 1MZpeq8riPZRsoYlG5goUgZpGZTnIp6yeBueVq3YkkTO8oIQXEGe23nvtAnMP6UBB8Pc
 ZJJHZW3EEH0QSpa2QOdl63+D7SqJzXMVewON9Xjmshvb4EEssDaJBDkmphhqGNBgVLVo
 1iSY6LsduvevCzr53KN1hKpbcLl8IMAt5yk5b9sNE72pQcN38PrRY351534RRJeZHA0o
 4DtRvFFkvWfIzHrFUO+vrcQBg8qNKdr8lR9r49rLFXr0JqJC4AOwejYHkmvMYb94c/6a
 J/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693906525; x=1694511325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmfCKXS6GDIMgVWG20l7MYVW8dhC0au32yxx2pOBfT0=;
 b=jpdmFGmMtSP+/TEiF1/humb3wPVpc/2vchhtlEIszRsamv2SMBUmNI/Fkf0BytC/1D
 ++Sz/TLzPhowMtv47OGTidufcxlG2Jfmgf3Hetdw/VneMUUMdDg+8OFoDD4DJ0iXcxQj
 c44bMd6UPEzIpatSFfp5GvIa4JeQlGfL5lu7TjjwvJKlL6Np6CyM6FvTIyKidwTlEjDv
 UbO7rkdYjYxjUgJQCarieZi98lWjcVzvc26omEMaU46le+kAufGUyUDc6psFIwNzUmZ2
 JNIZNru+8R4hPCvkiXefWGie0k1rUnmnmnqrp5cZOr8kNx2I2D0oQ1BeLY+ML63QM82M
 SrSQ==
X-Gm-Message-State: AOJu0Ywwsr8gVMa9t0Lp289UL69FvQiY+x2w5RWsUCUA0GH3YOpmPNTr
 AxFLl/cjnHD+GERbq6cY02jUTxFCH8WAB0Uxn0IKEw==
X-Google-Smtp-Source: AGHT+IHBGdPOT9iw+uT9Xa5qsUSFpOd97s5y/TTFeApIxa/FRzOT/2oJCrPMx+iKmJC187OBmRDlPxj5UEaT3KZKock=
X-Received: by 2002:aa7:da58:0:b0:523:d1e0:7079 with SMTP id
 w24-20020aa7da58000000b00523d1e07079mr8318565eds.21.1693906525367; Tue, 05
 Sep 2023 02:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com>
In-Reply-To: <ZPbt0io6He9mE2SB@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2023 10:35:14 +0100
Message-ID: <CAFEAcA8WyXaqpMsZbYW5hHa8EyqQTjZu=zW8WM6Ca0QpNKLCGA@mail.gmail.com>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 William Tsai <williamtsai1111@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 5 Sept 2023 at 09:59, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 04.09.2023 um 18:25 hat Daniel P. Berrang=C3=A9 geschrieben:
> > By the time of the 8.2.0 release, it will have been 2 years and 6
> > releases since we accidentally broke setting of array properties
> > for user creatable devices:
> >
> >   https://gitlab.com/qemu-project/qemu/-/issues/1090
>
> Oh, nice!
>
> Well, maybe that sounds a bit wrong, but the syntax that was broken was
> problematic and more of a hack, and after two years there is clearly no
> need to bring the exact same syntax back now.
>
> So I'd suggest we bring the funcionality back, but with proper QAPI
> lists instead of len-foo/foo[*].

I don't object, as long as somebody is proposing to actually
do this work (eg, in this release cycle), rather than merely
suggest the idea as a reason why we should continue to leave
this device's configurability broken...

thanks
-- PMM

