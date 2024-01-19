Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF08326C8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:34:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQlFr-0005XF-Ky; Fri, 19 Jan 2024 04:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rQlFn-0005Vk-4v
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rQlFl-0004IJ-Fk
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705656811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0XaQp9gl6RniiiOsmsfC5uDV2i6ClQWKZDfAJZnZsI=;
 b=QXpyZZzIvGNTNPwOL0LKcGrk7KE9bQ1dJW676xG8lBXRNM/1zPw4a4dyRmaanGZ4dn6udJ
 bAIA8BuPFnX5jmT5Tlupn1A9vczj7LllUHfDy4bJpgqUJAAYgeE26OdrXPlKrKiKGVr9ir
 +8cSlr7Mg3squ4iisQgqrb9nPCjSY3E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-4WcAQunYPca9_99jk2f-dg-1; Fri, 19 Jan 2024 04:33:29 -0500
X-MC-Unique: 4WcAQunYPca9_99jk2f-dg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-429d02a63baso6501521cf.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 01:33:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705656809; x=1706261609;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0XaQp9gl6RniiiOsmsfC5uDV2i6ClQWKZDfAJZnZsI=;
 b=BfRHTzaIhAOYoY/PJBZmcQqkGMKODRauR4MKHMiqxQsXHoAruHLjFYYy9HORHiTUhL
 UVUVRgxEXaSKZQfZKHcWPqauSaL2cVL4a9q542b/I4FSqIdRHuLBLbeMX5NcdE648Pkg
 EHRtO/d2huOmxnLKslgx2cxVrY4/i1aKQu0L/JO9ygqMMWpfEnbikzm+9qfaT/tiKllw
 lbV86k7zVLdqLEtKsj8Fs7oNk2bD9XzM6bHlFhNXrs9Ylx2FPb6UmKUlPZ9V0HQ+21+S
 cCiIqfuRL6VrkzMyR8VXvxHXwuzeZ/ZefnLPrD/PKxByU7NVG0L8jnuO5bcf0gvTk8mw
 obUw==
X-Gm-Message-State: AOJu0Yx44qckepHPjDxE+Yrr52tCN5qSJfcXH6ZAxdq9NU1CY8QPPBLQ
 I/z3n4OypoxzEqMlCl6mSXFE6pJKSCMEmn8BNhWIt8eEUIv0ZHGmyhk1rKm3a6IzvPZ8VWtOLpr
 bb1TdUHQUs6ClMYzEBWbyRQ0LkQkp1j7spaW+yYTv3jBcKr0zQAeEYlgxs1Liimy33lsD31yQ14
 KJWWzE8p8WnCKbFvAs9ZkozsoD0R0=
X-Received: by 2002:ac8:5796:0:b0:42a:296e:5bdf with SMTP id
 v22-20020ac85796000000b0042a296e5bdfmr168622qta.104.1705656809106; 
 Fri, 19 Jan 2024 01:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERtkGwVRd5rQmTgmFlpYIMtNS2S/L2mZCmNDZ7u6wzLYvNzoDCzy8hZgalegysR9eiNZJlpLRNeeVmNub4noQ=
X-Received: by 2002:ac8:5796:0:b0:42a:296e:5bdf with SMTP id
 v22-20020ac85796000000b0042a296e5bdfmr168618qta.104.1705656808800; Fri, 19
 Jan 2024 01:33:28 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jan 2024 01:33:27 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20240117164227.32143-1-farosas@suse.de>
 <98f6648c-59ce-42db-9afa-04f0a5521cba@tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <98f6648c-59ce-42db-9afa-04f0a5521cba@tls.msk.ru>
Date: Fri, 19 Jan 2024 01:33:27 -0800
Message-ID: <CABJz62NhxaGBEjC8kAPPzeWFsbcDSfhpmvP0K65CyuOdGhNqjQ@mail.gmail.com>
Subject: Re: Re: [PATCH v2] tests/docker: Add sqlite3 module to openSUSE Leap
 container
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 19, 2024 at 10:12:37AM +0300, Michael Tokarev wrote:
> 17.01.2024 19:42, Fabiano Rosas :
> > Avocado needs sqlite3:
>
> > --- a/tests/docker/dockerfiles/opensuse-leap.docker
> > +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> > @@ -90,6 +90,7 @@ RUN zypper update -y && \
> >              pcre-devel-static \
> >              pipewire-devel \
> >              pkgconfig \
> > +           python311 \
> >              python311-base \
> >              python311-pip \
>
> Isn't python311 already pulls in python311-base?

Yes, but lcitool doesn't know that :)

The information that is provided to the tool is:

  * the python3 interpreter is in the python311-base package;
  * the venv module is also in the python311-base package;
  * the sqlite3 module is in the python311 package;

(via tests/lcitool/mappings.yml), as well as:

  * QEMU needs the python3 interpreter plus the venv and sqlite3
    packages to build;

(via tests/lcitool/projects/qemu.yml).

Based on that, it concludes that the python311-base and python311
package need to be installed.

Notice how the former shows up only once in the Dockerfile, despite
being mentioned twice in the list of dependencies for the project,
because some basic deduplication is applied.

Of course the extra line doesn't matter at all in practice:

  # zypper install python311
  The following 4 NEW packages are going to be installed:
    libexpat1 libpython3_11-1_0 python311 python311-base

  4 new packages to install.
  Overall download size: 12.8 MiB. Already cached: 0 B.
  After the operation, additional 50.4 MiB will be used.

  # zypper install python311 python311-base
  The following 4 NEW packages are going to be installed:
    libexpat1 libpython3_11-1_0 python311 python311-base

  4 new packages to install.
  Overall download size: 12.8 MiB. Already cached: 0 B.
  After the operation, additional 50.4 MiB will be used.

This is the main reason why we never really bothered trying to avoid
it.

Hope this helps!

-- 
Andrea Bolognani / Red Hat / Virtualization


