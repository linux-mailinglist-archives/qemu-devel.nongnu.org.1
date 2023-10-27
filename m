Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 003177D8CA1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 02:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwB5l-0000SD-Oh; Thu, 26 Oct 2023 20:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qwB5h-0000Qw-2u
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 20:52:46 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qwB5b-0003bW-Hg
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 20:52:42 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-581b6b93bd1so879504eaf.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 17:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698367956; x=1698972756; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iqQ+ZsFgXDppICSAqCIq+BnsMXEFO+fIjovTTFTyKVE=;
 b=jgwy+W2AgLZSoc10dAIfzOWryDkYmitYjYH8b38wiJjozz/nj6OuWWSDWuM1kofU94
 j+WrNYjabwljIQ8FE0drUoG4XhpGIh3/aDUG2LKdkMjFGGRZ+aHdXvv7suOtX1ygj7XN
 1Rucb/tiS2TH3N9Xp1oTYOT+hlGYBOvrPyfiS1tWb/kU/05ZVW3HpJPa6ZaecZUuUZ0w
 7/5ZGG4wEKvBQJq5wN+HbaZW8aUCgnSFfrwaTUSGTTpZMI2Pm/5GTG6CZ0u/wRepc4BW
 kniSWEtcW/9lfOBF4K10Ly/G4e7UogUGoTxAy1GDUU/0+pfzAjKsYFFBxHAlVRkujObv
 1YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698367956; x=1698972756;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iqQ+ZsFgXDppICSAqCIq+BnsMXEFO+fIjovTTFTyKVE=;
 b=REm5vD4YPlYSLsc+DCmUV7J3etWDO485KADXfVoFKodEMUj7vYjK/M08Arcg3uD7Z6
 jLE9oMMZ4xDEzYnb8RaRtNCtCWoGiyURAYF7YUPh6TJIy79x7Deq6MM2rvkj84syN3LY
 +ExdKogCx5wKzWhF2Ps+V5AwIw3/Y++ucS17bIuGDIYCGi2N09JSNjyTfbEDVAyUxCq0
 1VxD9BpicdBBWiS2vL7cAv4vlRajyfaJRIgvoBIdKLBA5Qrt1IW9dm4A1SKRKVe6/sXb
 BMdtkg37KImCcRGsx1OhoKARvno4B5AM7qnXh+/XDxnhkmeiQg+mAIgBIoMmC2QUcF1W
 a5MQ==
X-Gm-Message-State: AOJu0Ywn9arSylvPE+greJo4k+M0Q/G2Ph93ui6SjY08JHKoOGI4eOVh
 t9dMEBgrVJL+YEjP5H2E3cnPSGgjACuQws9zrYU=
X-Google-Smtp-Source: AGHT+IHhrN0dKuRkOvvwcmQB2hLoe0+4ZLRFAFWYfDmG0C667HMIb57qIi48zWB0XuQE7U05l360Kk/sXJH/48fo0+8=
X-Received: by 2002:a05:6820:1346:b0:583:7653:2712 with SMTP id
 b6-20020a056820134600b0058376532712mr1456995oow.7.1698367956070; Thu, 26 Oct
 2023 17:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231026053115.2066744-1-armbru@redhat.com>
In-Reply-To: <20231026053115.2066744-1-armbru@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 27 Oct 2023 09:52:24 +0900
Message-ID: <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Enable -Wshadow=local
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@redhat.com, 
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org, bcain@quicinc.com,
 imp@bsdimp.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 26 Oct 2023 at 14:32, Markus Armbruster <armbru@redhat.com> wrote:
>
> Requires Brian's pull request and two patches from Thomas to compile:
>
>     [PULL 0/2] hex queue - GETPC() fixes, shadowing fixes
>     [PATCH v2] block/snapshot: Fix compiler warning with -Wshadow=local
>     [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
>
> Stefan, the PR was posted a week ago; anything blocking it?

It's not in a pull request, so I won't see it. I don't have tooling
that can spot individual patch series that need to go into
qemu.git/master, so I rely on being emailed about them.

Would you like me to merge this patch series into qemu.git/master?

Stefan

> Warner, I believe not waiting for your cleanup of bsd-user is fine.
> Please holler if it isn't.
>
> Based-on: <20231019021733.2258592-1-bcain@quicinc.com>
> Based-on: <20231023175038.111607-1-thuth@redhat.com>
> Based-on: <20231024092220.55305-1-thuth@redhat.com>
>
> Markus Armbruster (1):
>   meson: Enable -Wshadow=local
>
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> --
> 2.41.0
>
>

