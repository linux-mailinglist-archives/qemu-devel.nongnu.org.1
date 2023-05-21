Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 121CA70AC8E
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 07:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0byx-0006y6-DY; Sun, 21 May 2023 01:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q0byk-0006xj-RW
 for qemu-devel@nongnu.org; Sun, 21 May 2023 01:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q0byi-0004SS-SW
 for qemu-devel@nongnu.org; Sun, 21 May 2023 01:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684648294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eFn7Co6twJRnlAGdii0nPqqEcSCoCAsd+Y2ZTEqCATY=;
 b=AK9NanVy55CQ+7jnWSP8iorIaaGHTR1/y6xmslkcVjALulh0L04TmXKEV6teY0EzC1qS6r
 mPfaFhdeOgCI+W2IhFmZ77VQoqSyHEeI79+TwO329WojmfQKUP7pX5P0bUnroXERTtUR8x
 QBWIlK9n7wM0m7WKwlgMXBiMUqf/iaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-DHf79wgrOs-Ol3TCkiOw2Q-1; Sun, 21 May 2023 01:51:33 -0400
X-MC-Unique: DHf79wgrOs-Ol3TCkiOw2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso16281065e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 22:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684648292; x=1687240292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFn7Co6twJRnlAGdii0nPqqEcSCoCAsd+Y2ZTEqCATY=;
 b=P7x0QLj5zMdyh0Lx6b4esizP/OgI2pq3U1yZQaX2kuMnvjj/LErSfG+3HGOhBQuDds
 n0dZ8SwRqmT6qv9UMjc19Q/tcpIa3iAwvSx0EVhIlqv9RTJLHchC62iU4wJurczQYnzC
 mPmHdgTa9xn/aeXXZrlOwhxjnQcnv6axsaBB78i5QIQ5AqkZKt+krBs6AZZQxYu2YljR
 4f6m2aTb59Y5tzDqRq54AV+Ua04T/aQysilvYKcRL5OHDIy65bT/SUqtWDekfFEOsxSV
 BnvjWJBP1H2RfhVSAkU9EtEdqfty/jB0GF6BV7SJJfKsqFL6Udq8/zEaqCFUy0X8NF6T
 5YTg==
X-Gm-Message-State: AC+VfDwFApRE8NLckgYigFRAR+hndGj3WSyl20I98cE+O4hkr/zw3hEF
 EQsQM604ZDhq+bxAJDrAT7OZsLOz+yncWsNaFNfFHJt3/hqFOf2cFuYKfsb3pBCffdMCuSWcfxQ
 hzMlJElqYlqR/4OU=
X-Received: by 2002:a7b:cd0d:0:b0:3f1:7aff:e14a with SMTP id
 f13-20020a7bcd0d000000b003f17affe14amr4609446wmj.39.1684648292183; 
 Sat, 20 May 2023 22:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ndVEg9dSuKLtbTi25t0LlE9JhrR20d7F6mQ+jQ3/Lcit39w6Yu0ra9hTxfqxBIkIgs1l8Wg==
X-Received: by 2002:a7b:cd0d:0:b0:3f1:7aff:e14a with SMTP id
 f13-20020a7bcd0d000000b003f17affe14amr4609434wmj.39.1684648291831; 
 Sat, 20 May 2023 22:51:31 -0700 (PDT)
Received: from redhat.com ([2.52.11.67]) by smtp.gmail.com with ESMTPSA id
 c11-20020a05600c0acb00b003f4285629casm4092135wmr.42.2023.05.20.22.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 22:51:30 -0700 (PDT)
Date: Sun, 21 May 2023 01:51:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/avocado/bits: enable bios bits avocado tests
 on gitlab CI pipeline
Message-ID: <20230521015057-mutt-send-email-mst@kernel.org>
References: <20230517065357.5614-1-anisinha@redhat.com>
 <501EE8C0-D6C2-4FDE-9747-90932F70EB77@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501EE8C0-D6C2-4FDE-9747-90932F70EB77@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, May 19, 2023 at 08:44:18PM +0530, Ani Sinha wrote:
> 
> 
> > On 17-May-2023, at 12:23 PM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > Biosbits avocado tests on gitlab has thus far been disabled because some
> > packages needed by this test was missing in the container images used by gitlab
> > CI. These packages have now been added with the commit:
> > 
> > da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove genisoimage as dependencies")
> > 
> > Therefore, this change enables bits avocado test on gitlab.
> > At the same time, the bits cleanup code has also been made more robust with
> > this change.
> > 
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> 
> Michael, did you forget to queue this?


Not that I forgot but it takes me time to process new patches.
This came after I started testing the pull.

> > ---
> > tests/avocado/acpi-bits.py | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > Pipeline is green:
> > https://gitlab.com/anisinha/qemu/-/pipelines/869670000
> > bios bits tests passing:
> > https://gitlab.com/anisinha/qemu/-/jobs/4298116787#L189
> > 
> > diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
> > index 14038fa3c4..3ed286dcbd 100644
> > --- a/tests/avocado/acpi-bits.py
> > +++ b/tests/avocado/acpi-bits.py
> > @@ -123,9 +123,9 @@ def base_args(self):
> >         """return the base argument to QEMU binary"""
> >         return self._base_args
> > 
> > -@skipIf(not supported_platform() or missing_deps() or os.getenv('GITLAB_CI'),
> > -        'incorrect platform or dependencies (%s) not installed ' \
> > -        'or running on GitLab' % ','.join(deps))
> > +@skipIf(not supported_platform() or missing_deps(),
> > +        'unsupported platform or dependencies (%s) not installed' \
> > +        % ','.join(deps))
> > class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
> >     """
> >     ACPI and SMBIOS tests using biosbits.
> > @@ -356,7 +356,7 @@ def tearDown(self):
> >         """
> >         if self._vm:
> >             self.assertFalse(not self._vm.is_running)
> > -        if not os.getenv('BITS_DEBUG'):
> > +        if not os.getenv('BITS_DEBUG') and self._workDir:
> >             self.logger.info('removing the work directory %s', self._workDir)
> >             shutil.rmtree(self._workDir)
> >         else:
> > -- 
> > 2.39.1
> > 


