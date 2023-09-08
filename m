Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF87988A7
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecRV-0005nD-ER; Fri, 08 Sep 2023 10:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecRO-0005ls-8F
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qecRK-00033N-5b
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wo+3chfplA80bUThH7AQOr/RDZnMsUaVdGNlb5hIjsk=;
 b=V/29WDg3rP96bhcoCXUwH63uIg81vWtE13B9zFtydROSyIR1jm7BEPg0lJ98ko4ZNkVV0M
 XuGCQk5fSHfRwT12ctP+0v3BKJXC1ie+YcqIkaWAntqhQ6ln/1xpGG0eMB0oq2VeCXNqTJ
 e3m0j/tS1wesufb1iqqT5qnoXPSLUiI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-rZd2BOxHNR-EMRZARA8Gcw-1; Fri, 08 Sep 2023 10:26:27 -0400
X-MC-Unique: rZd2BOxHNR-EMRZARA8Gcw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2bd09fdec5cso25882691fa.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 07:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694183185; x=1694787985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wo+3chfplA80bUThH7AQOr/RDZnMsUaVdGNlb5hIjsk=;
 b=KB/07+Qp93QFSjRtj5PaApjJIp/ofKa6dI1+JfBzainlLgb+oPl+TfaUKPXxsvRZYM
 pxVTpjdvCAda+zBqmfoLuLPB1FmQrfI2n7frxerJadWjGafVluJwyrNcjDScCxhirFsW
 OPnjNWTWYRj8xIr8pVpBAknORDuHv8yRhhzmQxJ9OYXbDEfMxX+KP+Fq+Nhau+WuZa1c
 9YnGwu1cVRqfbQPBKvmd9zB6XtZHwXi0j162ZXZ+9o0tDHqfViIMzMeKDVAzIFUbLjJX
 qlZzWBX0Rcak1dMpcZ3PQM39CGd3jbpdp3kVAsMr4R6fOfJtBB8usN2BYHLs7Db45kk6
 io6Q==
X-Gm-Message-State: AOJu0YxbV0o05IXABoOJuij3CdkkFEijL5jPBDm1wSZpqZ1fJd0l7om1
 hntyRb+b2yAYCtuvgITu7lt+HOCLEGsVcOwHv4QwGVP2QR3W8rrF2IMrgIXQ5W9FcIVnFjWZJtV
 MZmRa2ZmqpvYP8aKfPkFMDpk=
X-Received: by 2002:a2e:b0e4:0:b0:2bc:ed80:46e with SMTP id
 h4-20020a2eb0e4000000b002bced80046emr2104454ljl.31.1694183185667; 
 Fri, 08 Sep 2023 07:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ7qCoPk6y+fg9vCqWfoahYXiivje0rnVJa0gQU2wAEPaT9PDNLwMnGYdQip/mYCygF2aNdw==
X-Received: by 2002:a2e:b0e4:0:b0:2bc:ed80:46e with SMTP id
 h4-20020a2eb0e4000000b002bced80046emr2104444ljl.31.1694183185365; 
 Fri, 08 Sep 2023 07:26:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z7-20020a1709060ac700b0099bc08862b6sm1112108ejf.171.2023.09.08.07.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 07:26:24 -0700 (PDT)
Date: Fri, 8 Sep 2023 16:26:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 02/10] target/i386: Fix feature names in
 FEAT_VMX_EPT_VPID_CAPS
Message-ID: <20230908162624.552487ba@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230908161731.50fa79f4@imammedo.users.ipa.redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-3-twiederh@redhat.com>
 <20230908161731.50fa79f4@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 8 Sep 2023 16:17:31 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri,  8 Sep 2023 14:45:26 +0200
> Tim Wiederhake <twiederh@redhat.com> wrote:
> 
> > Fix a copy-paste-mistake in the FEAT_VMX_EPT_VIPD_CAPS cpuid leaf.
> > The mistake became apparent as there were two features with the same name
> > in this cpuid leaf. The names are now in line with SDM volume 3, appendix A,
> > section 10.  
> 
> these names are user facing ABI, and changing
> them will break users that set these properties on command line.
> 
> maybe in addition opencode legacy aliases for them (initfn|realize time)
> + deprecate old names (so we can drop them eventually)
>    + warning if old name is used (not sure how to do it easily though)
>  

also you do here 2 different things here,
1 fixing duplicate
2 plain rename 

I'd split those in 2 different patches
and mention in commit message what features you are are actually changing

PS:
+ see next patch comment and apply it here as well

> > Fixes: 20a78b02d3 ("target/i386: add VMX features")
> > Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
> > ---
> >  target/i386/cpu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 7c2c48ac06..f10d343935 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -1322,8 +1322,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >              NULL, NULL, NULL, NULL,
> >              "vmx-invvpid", NULL, NULL, NULL,
> >              NULL, NULL, NULL, NULL,
> > -            "vmx-invvpid-single-addr", "vmx-invept-single-context",
> > -                "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
> > +            "vmx-invvpid-single-addr", "vmx-invvpid-single-context",
> > +                "vmx-invvpid-all-context", "vmx-invvpid-single-context-noglobals",
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, NULL, NULL,
> >              NULL, NULL, NULL, NULL,  
> 


