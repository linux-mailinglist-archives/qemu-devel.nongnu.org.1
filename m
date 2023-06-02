Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB5372032E
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 15:24:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q54lH-0003VC-HR; Fri, 02 Jun 2023 09:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q54lC-0003TN-6m
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q54lA-0001rp-Fo
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685712243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQPYVToZYlozlRJAp2LtPIHEMYZtrMr/ZiRid6iL7lo=;
 b=CrzbBWK2ewr0i4kT/CM0HbmoCU0dN58OuyKQG073eNlEwdtkAnzrXT8UTgSksIJK8MpPbc
 +9VeV8C92UXaHyTKHL2kcoywJRNLLTF6VDiHWLwyfshsV4wvKypBRczWjY7aU9zMrQpvA8
 hvfpD0CaV/4gZluIQm6St7hmIDSbq5Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-6l5g8p1VMYCFqpDKauC0VQ-1; Fri, 02 Jun 2023 09:24:02 -0400
X-MC-Unique: 6l5g8p1VMYCFqpDKauC0VQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f6c58d57adso2257171cf.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685712242; x=1688304242;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQPYVToZYlozlRJAp2LtPIHEMYZtrMr/ZiRid6iL7lo=;
 b=U2o8oHih6mSN9qP7beiiL4OmoX3XV2Ac3OToXSU2WopWhsv8lR20obz4nwc0XWclSl
 3uHLfG6qhq9YFH5XaKH5BNX/cyPp/usCzy7BCFmcoFcnNEfwjwU7DlHmaJK8KCD2pSKs
 WfvBk+mUWEcDFQJf+UCXq2vhDstsr5X+Q4DO6WL3W988nAt3DvB+qSKCX6xar/mt3Y41
 dq6/tDfr4F1hB6FJJYZVPYIVOk4KgZqWIL2TGHXTtlSHghVsJlzWgQsNXiA2CeLTZ+dk
 5d6vJoAPKmeCEqSoJJee4gXJChxttpqh6ihk99ah/CXU5bOqBrsRExmLB6m0YUGmHKuj
 5tnA==
X-Gm-Message-State: AC+VfDzfZXpMfl9Zpp60cvpQMjWYJOu5LTLeAiITfVtkA/nXPqBjURA9
 V4syb0vssT92ZZfFpOG69rqgdl5t+Nq00jMr4Klt5J47D4KnOr0mvWE9mXtqIZgkn9PFCQ3gGJC
 jDbnk0wI0MLaDTSA=
X-Received: by 2002:a05:622a:1a9c:b0:3f6:a9a2:3b66 with SMTP id
 s28-20020a05622a1a9c00b003f6a9a23b66mr15495777qtc.5.1685712241911; 
 Fri, 02 Jun 2023 06:24:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GJ3tGSi9HnCokmIjwGQZKa4o7sWob85LEIggKgVLjgBvKBrJUsjMb0ZAeJkQkab14IhNCGw==
X-Received: by 2002:a05:622a:1a9c:b0:3f6:a9a2:3b66 with SMTP id
 s28-20020a05622a1a9c00b003f6a9a23b66mr15495756qtc.5.1685712241669; 
 Fri, 02 Jun 2023 06:24:01 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 hg9-20020a05622a610900b003f532993912sm742034qtb.74.2023.06.02.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 06:24:01 -0700 (PDT)
Date: Fri, 2 Jun 2023 09:23:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH RFC 3/3] qtest/migration: Use switchover-hold to speedup
Message-ID: <ZHntby+Tl1Bf59X4@x1n>
References: <20230602011626.226640-1-peterx@redhat.com>
 <20230602011626.226640-4-peterx@redhat.com>
 <ZHnMaQ4NFCUQ5gmN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHnMaQ4NFCUQ5gmN@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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

On Fri, Jun 02, 2023 at 12:03:05PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 01, 2023 at 09:16:26PM -0400, Peter Xu wrote:
> > Use the switchover-hold flag rather than tuning bw+downtime to guide test
> > convergence.
> > 
> > This can achieve similar goal of previous patch "tests/qtest: massively
> > speed up migration-test" but without magic offset to write or monitoring.
> > 
> > The initial solution can reduce migration-test time from 8min to 1min40s,
> > this patch can further reduce it from 1m40s to 1m1s per my local test.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration-test.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index b0c355bbd9..62bdd67fd9 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -433,16 +433,15 @@ static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> >  
> >  static void migrate_ensure_non_converge(QTestState *who)
> >  {
> > -    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> > -    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> > -    migrate_set_parameter_int(who, "downtime-limit", 1);
> > +    /* Hold off switchover for precopy only */
> > +    migrate_set_parameter_bool(who, "switchover-hold", true);
> >  }
> >  
> >  static void migrate_ensure_converge(QTestState *who)
> >  {
> > -    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> > -    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> > -    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> > +    /* No limitation on bandwidth so converge faster */
> > +    migrate_set_parameter_int(who, "max-bandwidth", 0);
> 
> You're already setting max-bandwith==0 in migrate_postcopy_prepare.
> 
> If you also set it in test_precopy_common, so we don't need to
> set it here, and we'll avoid the initial phase running with
> bandwidth=32mbs.

There are more tests than test_precopy_common() that leverages this, so I
used to kept it there to still share some code:

test_migrate_auto_converge[2021] migrate_ensure_converge(from);
test_multifd_tcp_cancel[2349]  migrate_ensure_converge(from);

But I think you're right - moving the bw=0 setup out should be cleaner.
I'll see whether I should just move it into all the specific tests.

Thanks,

-- 
Peter Xu


