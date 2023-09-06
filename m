Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA0793E39
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 15:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdt2X-00074s-Ui; Wed, 06 Sep 2023 09:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qdt2V-00074X-RR
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:57:51 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qdt2R-0006rN-3q
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 09:57:51 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57354433a7dso1995425eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694008665; x=1694613465; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2Smp2aBwuIRNZtLWcjlS8jG1YQykyl/Y7n9k5HqWmI=;
 b=OP5AxoyWDvwkSE6k2cjyYpiKIM/n8+HNYL8LkdkNhjB1Xrdat72mjtvJ/PFOY2t3uW
 YW/EoewtlLqQiEMuicj3fAjtDIOghche0NqoMA3OCTTVw8JH0b5KOVFRNcFpL98Up3oU
 r6PjQrzoE+iSj9YKrsFwL/j1rusxZIBi+Q+VSIHePMdOdzSo6mVAxy+RlNwbfrUHQnCk
 pqXxS1lylbl6XwBBjHdMhoqfvoWwk8yKBDdetm95Qn/bOcOLicMakZBI1AiXcIE21Pk2
 Bljdmb4RgYL3cUwhQXSCXVJMS6TIjFTODUgO6jZYE4926gTq6fLX4CZC8rG8gJar56fb
 l2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694008665; x=1694613465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2Smp2aBwuIRNZtLWcjlS8jG1YQykyl/Y7n9k5HqWmI=;
 b=BplbFMeTylAqjLyHmadzTafHXKt40eOROYkkOfksU5MKBrgjT+Fc3iTdVbasxuDlkO
 zZTFXmCKD6ACOb7I19DhIfNtxbzSq99Ypn/5KGvynZxD8BGh+yzyW1FBQTkUHUyPE3rO
 uOYdjfGAlDO87GbHm48iC6P/8eyVNtkyCuagexpZQBFtC6drMYvOajmi959X3d9W1Pes
 71zI/6SdNDonl9ydBsIUtX1jbLmhJHiGCQpSViKcI5v8q3JnYjDOxy3dEYepiAK0lmEp
 yzvbkvoGgDTtH5uEpyd40ySKV7a0CMwRj3Jc/KEW9TkH5zSeNfcPGqEunMuqet0Bx61J
 AoYA==
X-Gm-Message-State: AOJu0YyjuonCM7l+g2Vs6ECcgyFu7DG4OZZqi8Xv26h7AQgC0EqDb/w+
 jz+fmAYV6m/Z0ONrBN8SSrj245yUBD+o8I3PE5o=
X-Google-Smtp-Source: AGHT+IFpSCC4SxoIZJ7m6xPj2BMky4w2nU+wdFvqtzwnQmFwXpCxHSAvQS5MhQ1iW7pQGur1T+w1H5TrbF2d+YPR9tk=
X-Received: by 2002:a4a:314b:0:b0:56c:cd04:9083 with SMTP id
 v11-20020a4a314b000000b0056ccd049083mr13802709oog.1.1694008665228; Wed, 06
 Sep 2023 06:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <87v8grlzu9.fsf@linaro.org>
 <CAJSP0QX+NeJ8Z5d+2ocUUVj4EGopxKT+trmEfacgvhE7TqCokQ@mail.gmail.com>
 <5e6b1bbd-bc0a-cff5-119c-639a9d15e72a@linux.dev>
In-Reply-To: <5e6b1bbd-bc0a-cff5-119c-639a9d15e72a@linux.dev>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Sep 2023 09:57:33 -0400
Message-ID: <CAJSP0QUZ51y4bBTRgp_g6AO_6iEFamhOqMbcfFi5UiWBCkJQJQ@mail.gmail.com>
Subject: Re: [Virtio-fs] Status of DAX for virtio-fs/virtiofsd?
To: Hao Xu <hao.xu@linux.dev>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 virtio-fs@redhat.com, Erik Schilling <erik.schilling@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
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

On Wed, 6 Sept 2023 at 09:07, Hao Xu <hao.xu@linux.dev> wrote:
> On 5/18/23 00:26, Stefan Hajnoczi wrote:
> > On Wed, 17 May 2023 at 11:54, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> > Hi Alex,
> > There were two unresolved issues:
> >
> > 1. How to inject SIGBUS when the guest accesses a page that's beyond
> > the end-of-file.
>
> Hi Stefan,
> Does this SIGBUS issue exist if the guest kernel can be trusted? Since in
>
> that case, we can check the offset value in guest kernel.

The scenario is:
1. A guest userspace process has a DAX file mmapped.
2. The host or another guest that is also sharing the directory
truncates the file. The pages mmapped by our guest are no longer
valid.
3. The guest loads from an mmapped page and a vmexit occurs.
4. Now the host must inject a SIGBUS into the guest. There is
currently no way to do this.

I believe this scenario doesn't happen within a single guest, because
the guest kernel will raise SIGBUS itself without a vmexit if another
process inside that same guest truncates the file.

Another scenario is when the guest kernel access the DAX pages. A
vmexit can occur here too.

If you trust the host and all guests sharing the directory not to
truncate files that are mmapped, then this issue will not occur.

Stefan

