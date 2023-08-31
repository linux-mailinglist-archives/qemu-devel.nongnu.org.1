Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A078E7F4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbd11-0002Wv-El; Thu, 31 Aug 2023 04:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbd0u-0002Wc-3f
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbd0r-0000S2-K7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693470408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fDL3J2Yu6MPNEPzJwQrhG+Xw7kqRJPUukRL0CLgSaM=;
 b=g6CmDQF/pPwBiE1vhYM4CA3kRQT6GZqqbqPoF8HZI4VeG68vmPYBxh+crWW8QA1kjuPaQY
 +1ml/nGc/J+AVKki+gWtodEltbyp5QUJc1Gyqtqoxq8kFBAmEa7nL/8UDeykSPhv6pyaJr
 bSiHf+fGl80leLUolc+CfZewE0nDPt0=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-O2oj-CDGPDGelP2dvuvTBw-1; Thu, 31 Aug 2023 04:26:46 -0400
X-MC-Unique: O2oj-CDGPDGelP2dvuvTBw-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-44d5ac106ddso323681137.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693470406; x=1694075206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fDL3J2Yu6MPNEPzJwQrhG+Xw7kqRJPUukRL0CLgSaM=;
 b=LZ+6f2fd5r7VbUMW0cru/m/qAWyw1SOPCWx0q9kMHhXUccn41agBM6nhVYcbul7fuu
 3mt9WirFp5+fl/FsxDF7zqXbfUbv1AWhR+dOadIO6aSNFDDiJ4Jsq7i4GGzf86kkp9es
 Ma3Sm964WIecR8fLRu2/T+wZO7zM62HEQsH31ppKfNcI/ahzgJrpfIqMFd7PWK9tQ0My
 CS5t+vtdhC+OUmjsCgoW0n2oesresdi0ldJTkLDN0qp/UFk7dbaqbipfL9rXv0LfDyrI
 NOhM3a/pbLn0tsFb8zTbs8VuLj2Wr/X9je4Lz0d8BH6QtF1lF4qHS2mpRO8Jce9WdSiZ
 rfww==
X-Gm-Message-State: AOJu0Ywu7JQtjGJjURXd9RUoBHOKxtSFpZ1mCO6FxPm87g97xpFUCtZS
 HIBKFMZ6SYvih/WT9YMBizzdbjaTNRMGUg2uqWkgKyevG0iMDi9TK1zkDqJHrYpfeFzVx7PbgzZ
 bGPb12IZbM+M9jKN99my659tXExjP+us=
X-Received: by 2002:a67:db8d:0:b0:44d:4904:e080 with SMTP id
 f13-20020a67db8d000000b0044d4904e080mr4379002vsk.31.1693470406011; 
 Thu, 31 Aug 2023 01:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFGX52JH5XKbV6sKQuHChi+h6yLqtwt2czK4GHaoMtF5xbKhaUxwMCqps+d+rzOfjHrSg5lBuxKUxlp1RVg3w=
X-Received: by 2002:a67:db8d:0:b0:44d:4904:e080 with SMTP id
 f13-20020a67db8d000000b0044d4904e080mr4378995vsk.31.1693470405753; Thu, 31
 Aug 2023 01:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-5-pbonzini@redhat.com>
 <ZO4ndKXdF5oQSHlU@redhat.com>
In-Reply-To: <ZO4ndKXdF5oQSHlU@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Aug 2023 10:26:34 +0200
Message-ID: <CABgObfYtyTM3_2ykLsHNV8TCnm0U0u9BK3ZTdnKP=JDSO2EHeA@mail.gmail.com>
Subject: Re: [PATCH 04/10] configure: create native file with contents of
 $host_cc
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 7:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Aug 29, 2023 at 10:29:25AM +0200, Paolo Bonzini wrote:
> > The argument of --host-cc is not obeyed when cross compiling.  To avoid
> > this issue, place it in a configuration file and pass it to meson
> > with --native-file.
> >
> > While at it, clarify that --host-cc is not obeyed anyway when _not_
> > cross compiling.
>
> I presume that's refering to this piece of code
>
> if test -z "${CC}${cross_prefix}"; then
>   cc=3D"$host_cc"
> else
>   cc=3D"${CC-${cross_prefix}gcc}"
> fi
>
> which is using $host_cc *before* --host-cc is processed, thus
> meaning it is always at its default value of 'cc'.

That, plus the fact that --native-file is only used in cross
compilation scenarios; when doing a native compilation there's no
difference between "native: true" and "native: false" as far as Meson
is concerned.

> Perhaps the above code snippet should just be changed to
>
>   if test -z "${CC}${cross_prefix}"; then
>     cc=3D"cc"
>   else
>     cc=3D"${CC-${cross_prefix}gcc}"
>   fi
>
> to make it clear that we were not intending to honour the
> --host-cc value for this code.

Since I have to send a v2 anyway for the (un)supported OS message,
I'll do the change.

Paolo


