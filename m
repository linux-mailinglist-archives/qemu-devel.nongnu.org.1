Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2379D31B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3yk-00072x-5D; Tue, 12 Sep 2023 10:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg3yP-0006y2-Du
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:02:40 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg3yJ-0003Ne-2o
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:02:37 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5739965a482so2937031eaf.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694527349; x=1695132149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsFss5CmRMLBn7t3Flsp8ilInFHsll14Lbqq5qecXEQ=;
 b=g7WDAxRCmooeAjtKLx0kkpHeWYJsW64CJXj1grlgquWWZz3qGZoThoTxaTlL8VHxMq
 5JfJGFWA01MP9iLzbLpzikucgtJGM29Tkp7+EMnZjOkj2lJzTEigeIHlu4hqJ3yCz5aK
 X67lt5fLQA21GNpoqiKfKCgVeOimEWZ1XJWJ9HgqM+SVRo+AVE8judhkacLA0LXax3Rj
 x62ZflB/S520EfKw6ubDWE0UG2ZXoKMWIcLke3DNkLhKMXQOjJ8in5ksnpKxzpg3IyVI
 RVtGQkXm763EudE0+I8+3ZvP2g5T6uXVmxYD7JXz4BoG2qu8dHEuDXHn5906WYvIeOq7
 XLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527349; x=1695132149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsFss5CmRMLBn7t3Flsp8ilInFHsll14Lbqq5qecXEQ=;
 b=mHCoWNJWa3V+5Y2dudsDGs8kd1YYHEOlBAVEJEyXk+DsDg2qXhZN0DSC1w6GP+B3ie
 qA11h328d8R+F4cdTpggE9PmTRBfV80AIsWmXiqK0Kois4+aZp9UlDWPDTS4ah8sWXpo
 oOI92jU1R98PSP3nDvMMejm0CytPk4upD/RXZTvQNiquvHFJqEb4HCZO29/L1Zy37MkP
 83vs8qx4+ywgeEcKdb3Gw2qwN3LrsFu1WKS1A0UDWPBRhxaHHgYDN4kBQJJ6OKlF9o70
 bDgGNbjlBX2pojRMQvttOf/aMyHYHar3CH9bcgpJfFqUXMMZc7oH7PbyWk2hY4lLGjbg
 52mg==
X-Gm-Message-State: AOJu0YzMCuMC8Uj2oZPyfEWYsZUYVzttLa7Lj6wleXww3KrNL84FiDSC
 pL1CZC4lsFqd9URaBF4eKfI9dV+jtTdnqW7admg=
X-Google-Smtp-Source: AGHT+IEK1MQCSfd3g/PjuyDseVFcZPyjfJeoE5A7vvq8SmbKVaVnffKvRxxg7Ajdt8GrLDH8qI77sfNOIKgPwlvwVxo=
X-Received: by 2002:a05:6870:9a1f:b0:1b7:273d:780a with SMTP id
 fo31-20020a0568709a1f00b001b7273d780amr1400725oab.22.1694527349271; Tue, 12
 Sep 2023 07:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230912133829.61352-1-stefanha@redhat.com>
 <ZQBtH7rBWm2Sze68@redhat.com>
In-Reply-To: <ZQBtH7rBWm2Sze68@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 10:02:17 -0400
Message-ID: <CAJSP0QWUqry-CtrnL8hodgD6gsJGVCaY5vG5Tn5UHecZT0kQ3g@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci/cirrus: Increase timeout to 100 minutes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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

On Tue, 12 Sept 2023 at 09:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Tue, Sep 12, 2023 at 09:38:29AM -0400, Stefan Hajnoczi wrote:
> > The 80m timeout is not enough:
> >
> >   672/832 qemu:block / io-qcow2-041          OK             39.77s   1 =
subtests passed
> >   Timed out!
>
> IIUC, that 'timed out' message is coming from Cirrus CI logs, which
> we can see over on the cirrus task:
>
>   https://cirrus-ci.com/task/6462328380588032
>
> > https://gitlab.com/qemu-project/qemu/-/jobs/5058610599
>
> This reports duration "64 minutes", vs a GitLab timeout of 1hr20.
>
> IOW, we're not hitting the gitlab timeout, we're hitting hte
> Cirrus CI timeout, which defaults to 60 minutes.  The other
> 4 minuts gitlab reports is likely because Cirrus queued the
> job for 4 minutes before starting execution.

I'm glad you spotted that. I'm not familiar with Cirrus. Could you
send a patch that sets 'timeout_in'?

Thanks,
Stefan

>
> >
> > Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1882
> > Fixes: d06f3bf92267 ("gitlab-ci/cirrus: Increase timeout to 80 minutes"=
)
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  .gitlab-ci.d/cirrus.yml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> > index 41d64d6680..d19633f758 100644
> > --- a/.gitlab-ci.d/cirrus.yml
> > +++ b/.gitlab-ci.d/cirrus.yml
> > @@ -15,7 +15,7 @@
> >    stage: build
> >    image: registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master
> >    needs: []
> > -  timeout: 80m
> > +  timeout: 100m
> >    allow_failure: true
> >    script:
> >      - source .gitlab-ci.d/cirrus/$NAME.vars
>
> IIUC, we need to put a 'timeout_in' setting someone in
> .gitlab-ci.d/cirrus/build.yml instead, to override
> Cirrus 60 minute limit:
>
> https://cirrus-ci.org/faq/#instance-timed-out
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>

