Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5164833274
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 03:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR1CZ-0006k7-Nw; Fri, 19 Jan 2024 21:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rR1CW-0006iu-Nn
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 21:35:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rR1CU-00079s-Td
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 21:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705718113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0revJ7EEcKoDHWlED646z2cFqeMqS7veKpBvA1/7gJQ=;
 b=W39+9uhrhkacjqYixkFTMGIme7K69qp9H1JkE049r+asV/bnomjiBIlku6k7Euv1chgeEK
 PdCuxI11q5sGmiIHVaqP5oMDKW/ofI9yoOf4dwR0RHS8Ha27V6lUoHud9pSMmA3c2aNU34
 MIUd2/wMXqcGzBpC9ClHypAY7o1PRgY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ELPMEH3lMNSWyi-WayDHpw-1; Fri, 19 Jan 2024 21:35:11 -0500
X-MC-Unique: ELPMEH3lMNSWyi-WayDHpw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so385114b3a.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 18:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705718110; x=1706322910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0revJ7EEcKoDHWlED646z2cFqeMqS7veKpBvA1/7gJQ=;
 b=XhG3CaMr2DzSHZGn8vEV6IWR5qkhJGYBAo542WEz5Y1r1S3sh48JUeWgZP04wnT/PW
 aIIPb6NGBGyNJXJzmJcilu3BYfzqdP0h9llVefAa3bNJbR/AqN7QqjOUYQTC3u3WDw+Y
 7YQEFHFpm8wjodvWPNIGlS5ZYTTL2aiLp+COYUNFUKUN9FwI/orBKV0s5k4Cg7jKwpfC
 l1cqx1wgDIGQn/A2SXsH+KH1cpk6rYycVKyk0CJ3YWUl9diG3udSKruWp9OLoOkPsO7n
 ddCZbOC4Du//e0oW9XdOfCvmvZHxqsf8V5JF55yccGDeFMkm7ihMgs/zdHy6r2gI3i5R
 v6kA==
X-Gm-Message-State: AOJu0YyTNpC8J4cKSAcHhrxLi9AJite8Kb3jsc387YzeEXrES9MHOgXP
 F486TvemYokipc93p6qf2O7rhp66OjngbpoU18GxNBNdH9AR22PdWk4heKMFaIVDIy+wmPPPxDd
 ZMPGfVXIfgBMEpB34swCot6eZGL/ZSywWEHb6WAXG8QLnFJfxp1c1
X-Received: by 2002:a05:6a20:93a2:b0:199:501f:a08b with SMTP id
 x34-20020a056a2093a200b00199501fa08bmr2015586pzh.3.1705718110694; 
 Fri, 19 Jan 2024 18:35:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg8Cv3ckzMLRc8fQfgssNm1DM5FOAlzXCNGJvqh9QPxod9sPcQkB1sWtiOKfTLAcHYBCS2tQ==
X-Received: by 2002:a05:6a20:93a2:b0:199:501f:a08b with SMTP id
 x34-20020a056a2093a200b00199501fa08bmr2015563pzh.3.1705718110348; 
 Fri, 19 Jan 2024 18:35:10 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g3-20020aa78743000000b006dbce74e18fsm240036pfo.191.2024.01.19.18.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 18:35:10 -0800 (PST)
Date: Sat, 20 Jan 2024 10:35:05 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v4 3/3] ci: Disable migration compatibility tests for
 aarch64
Message-ID: <ZasxWV7etv8CiKnH@x1n>
References: <20240118164951.30350-1-farosas@suse.de>
 <20240118164951.30350-4-farosas@suse.de> <Zan0EOYX1pEEzlFz@x1n>
 <87sf2tzd6v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf2tzd6v.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 19, 2024 at 10:04:56AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jan 18, 2024 at 01:49:51PM -0300, Fabiano Rosas wrote:
> >> Until 9.0 is out, we need to keep the aarch64 job disabled because the
> >> tests always use the n-1 version of migration-test. That happens to be
> >> broken for aarch64 in 8.2. Once 9.0 is out, it will become the n-1
> >> version and it will bring the fixed tests.
> >> 
> >> We can revert this patch when 9.0 releases.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  .gitlab-ci.d/buildtest.yml | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> >> index f0b0edc634..b344a4685f 100644
> >> --- a/.gitlab-ci.d/buildtest.yml
> >> +++ b/.gitlab-ci.d/buildtest.yml
> >> @@ -217,10 +217,14 @@ build-previous-qemu:
> >>      - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
> >>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
> >>  
> >> +# This job is disabled until we release 9.0. The existing
> >> +# migration-test in 8.2 is broken on aarch64. The fix was already
> >> +# commited, but it will only take effect once 9.0 is out.
> >>  migration-compat-aarch64:
> >>    extends: .migration-compat-common
> >>    variables:
> >>      TARGET: aarch64
> >> +    QEMU_JOB_OPTIONAL: 1
> >
> > Optionally you can move the whole migration-compat-aarch64 from previous
> > patch to here, then even if someone kicks off CI for previous commit it
> > won't fail.
> 
> I want to avoid having to think about this when 9.0 is out. This way
> it'll be just a revert of this patch.

That's ok.

> 
> >
> > Would QEMU_JOB_SKIPPED suits more here?
> >
> >         https://www.qemu.org/docs/master/devel/ci.html
> >
> >         QEMU_JOB_OPTIONAL
> >
> >         The job is expected to be successful in general, but is not run by
> >         default due to need to conserve limited CI resources. It is
> >         available to be started manually by the contributor in the CI
> >         pipelines UI.
> >
> >         QEMU_JOB_SKIPPED
> >
> >         The job is not reliably successsful in general, so is not currently
> >         suitable to be run by default. Ideally this should be a temporary
> >         marker until the problems can be addressed, or the job permanently
> >         removed.
> >
> > I suppose they all fall into "manual trigger" as a result, but just in case
> > it'll behave differently in the future.
> >
> Ok, we can use SKIPPED.

No need to repost then; if this is the only thing to change I can do it
when queuing.  Will wait a bit more for comment on patch 2.

-- 
Peter Xu
 


