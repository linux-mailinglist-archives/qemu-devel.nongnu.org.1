Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669379D36B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:18:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4DB-00044W-DY; Tue, 12 Sep 2023 10:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg4Cu-0003k9-JH
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:17:36 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg4Cr-0001LN-R6
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:17:36 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1d4c2a9f2ecso3863509fac.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694528252; x=1695133052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGiiixcGbz6CHmq4vkdZDdmt4qkC6TReYYELTJBPKuE=;
 b=hL8PFKoG8KV261fjfBm4xfqb839zjg7IVDkIArx8WKkocUCIAbMFZ1KiidNCPlPIhO
 Ykl0X7VJ8HKkyJRB+KJblL7iXPOk2o+9SFucaeNtwpvv1hYPlogjvh1PkRtRMhRhKC6x
 fUVBB0+rkkSlnxbMagjHIvgpKcaw2ozzeTQc8ZbX2GYP5TZeB7rOAGPphZ0qoajLq0y2
 i1mZrR4mD50ZAwBq0lfDt2dCtiopsZWoyqck6t8QGft/Kj5zFbCpuJe3azA19StDlULm
 /KKVyeQTr7Z+6BE27IGalLjIqVnDzgUhtvsfkGV9wBveURAkquf/5gGOGyf5f4Ir22al
 tufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528252; x=1695133052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGiiixcGbz6CHmq4vkdZDdmt4qkC6TReYYELTJBPKuE=;
 b=d8d3jv2GcxI8uHiSlUfSj1zNgqK8wbglvsrP7IznhC7ujz2pTMabHLVSsWSvAk68vq
 DpEEAmbWxwvM5KUHj3Jp4YZMvV3K54nPfp1ijH95TfDC8RLUwcy1oeqW9GH8zpEJic6A
 ucB73/bYLc4YP4/cUcXxJlm7unwSIQi7GON6JIKaBTLT3C9xK2S/ql6vRllLCSqJ9mYj
 L+e7OLemCLsooxZJnfTfhqiM9R/tKgvWkJDHN7yQjm2CxLbRjQD5iXCUSj44GD3yTCD6
 YDlhMZz5m0ug5S8Oqk5SKZeSPx0RhMEN2nnokLzoqr5hseGoL5CORca6eJbym3sr5jcq
 cvbQ==
X-Gm-Message-State: AOJu0Yydb+3FkvMLxs++k3IM9rFV9mxGkk9osXnfD38LPAhg6THeNaAx
 HeE6E102JI4X70CIfKojfSEoFnKH0+JFln1OjmE=
X-Google-Smtp-Source: AGHT+IGJX9STGxcNf2+9AoCx9bP+Mj7idfwHbSQdHqEFJgUsg/Olb2ebYIsS7bm6lFOfUhvYCW83WX4mNrP9/MI2Ym8=
X-Received: by 2002:a05:6871:808:b0:1b7:4168:e2db with SMTP id
 q8-20020a056871080800b001b74168e2dbmr13787491oap.43.1694528252574; Tue, 12
 Sep 2023 07:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230912133829.61352-1-stefanha@redhat.com>
 <ZQBtH7rBWm2Sze68@redhat.com>
 <CAJSP0QWUqry-CtrnL8hodgD6gsJGVCaY5vG5Tn5UHecZT0kQ3g@mail.gmail.com>
 <ZQBygFxijkkQWNO/@redhat.com>
In-Reply-To: <ZQBygFxijkkQWNO/@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 10:17:19 -0400
Message-ID: <CAJSP0QU-xTSkJaL9C8fWqMrK7jBrXiprZx+TXbzuXawQT+_6DA@mail.gmail.com>
Subject: Re: [PATCH] gitlab-ci/cirrus: Increase timeout to 100 minutes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
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

Thank you!

Stefan

On Tue, 12 Sept 2023 at 10:15, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Tue, Sep 12, 2023 at 10:02:17AM -0400, Stefan Hajnoczi wrote:
> > On Tue, 12 Sept 2023 at 09:53, Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > >
> > > On Tue, Sep 12, 2023 at 09:38:29AM -0400, Stefan Hajnoczi wrote:
> > > > The 80m timeout is not enough:
> > > >
> > > >   672/832 qemu:block / io-qcow2-041          OK             39.77s =
  1 subtests passed
> > > >   Timed out!
> > >
> > > IIUC, that 'timed out' message is coming from Cirrus CI logs, which
> > > we can see over on the cirrus task:
> > >
> > >   https://cirrus-ci.com/task/6462328380588032
> > >
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/5058610599
> > >
> > > This reports duration "64 minutes", vs a GitLab timeout of 1hr20.
> > >
> > > IOW, we're not hitting the gitlab timeout, we're hitting hte
> > > Cirrus CI timeout, which defaults to 60 minutes.  The other
> > > 4 minuts gitlab reports is likely because Cirrus queued the
> > > job for 4 minutes before starting execution.
> >
> > I'm glad you spotted that. I'm not familiar with Cirrus. Could you
> > send a patch that sets 'timeout_in'?
>
> Yes, testing now
>
>   https://gitlab.com/berrange/qemu/-/commit/c15d677de5ed2965464bc6212f049=
ed9785c4434
>
>   https://gitlab.com/berrange/qemu/-/jobs/5069195895
>
>   https://cirrus-ci.com/task/5135339078025216
>
> The cirrus CI job page looks to be picking up the elevated timeout.
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

