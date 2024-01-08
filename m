Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97F2826831
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 07:44:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMjLu-0007z8-Gc; Mon, 08 Jan 2024 01:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMjLr-0007xI-Ko
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 01:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rMjLp-0000ET-N6
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704696188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5hoEd8nBMCehcpUOrj41K+m6Q1X9VEC1UF58a6cw2g=;
 b=XKa+bQIQqcNTIZOeflymr47m0dz43PiXubvE63DXk4URI2eLv2NCqYqNbFbLp13XUX6lLz
 JzlI67b/PhtqvKc+WmgivxvK2YBh7HKT+ZzYy69zA+w5TpLt04f4iidg+DesDd9Nkba1Wk
 /13PjnZk3W8wdbfWeW9DPWP945HTqvs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-zdzsG7BmNomnqFWBN7Ydyg-1; Mon, 08 Jan 2024 01:43:06 -0500
X-MC-Unique: zdzsG7BmNomnqFWBN7Ydyg-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28cb02a6027so315377a91.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jan 2024 22:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704696185; x=1705300985;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5hoEd8nBMCehcpUOrj41K+m6Q1X9VEC1UF58a6cw2g=;
 b=XQ2K47LFnuNa70b+oxJoN9s4NSTr5f39fvvAqaDyeaYgCU6kMIzeE3ed3hInU8aEYL
 4fnHQiTxMtL/OdfNiYkrhKEJLjW6SNY6xw9RPUIZn7Nb7Jd6Fum1Md958jw0xUMNIkar
 UDaZUHsZkF+pAHGDtWqggpAgrD5eactgd2LlPgWqRjjxZboQoIIUs9LgArOJDXB+/U4v
 T8ECRQiLO7metufi0UAlMc1xxDGPQGSAH5Q2RjidSs8Uny6jWSC3CiV8aMJuBocWWRGR
 nsnaQ0+Ku2ZRUrfxR2NyfPv3aLSJAn+J1OLtBvtC3kqsomOg5ahwCWRFCMUKICsIwGDm
 cvFg==
X-Gm-Message-State: AOJu0YzSCGrNQRMKbkUR0XJ5zWBGupp7Ke/N8tR80c3vjA3uMJK9b2zM
 A1sRpSivgLbiOpzTuhZISawmuTiwdjBsTNiD40pINrYMGCjvMAasoow6SNdr8LQ7umZ0v9m2WoY
 pV+2CqCcl4UOLwOclVvS8Cts=
X-Received: by 2002:a05:6a20:baa6:b0:199:6bdc:72c3 with SMTP id
 fb38-20020a056a20baa600b001996bdc72c3mr6598054pzb.0.1704696185459; 
 Sun, 07 Jan 2024 22:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu+c9VI5sfmpxkHuM2wxNIxbvr6Xt3TiPXqvSzVCTqWVLyHcBLwOj/MndML9SeYuFF3Emedw==
X-Received: by 2002:a05:6a20:baa6:b0:199:6bdc:72c3 with SMTP id
 fb38-20020a056a20baa600b001996bdc72c3mr6598040pzb.0.1704696185139; 
 Sun, 07 Jan 2024 22:43:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b006da8b181bfbsm5203175pfb.169.2024.01.07.22.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 22:43:04 -0800 (PST)
Date: Mon, 8 Jan 2024 14:42:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Message-ID: <ZZuZcCxxIS6j_jHD@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de>
 <87ttvjoexo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ttvjoexo.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, Jun 07, 2023 at 10:27:15AM +0200, Juan Quintela wrote:
> Fabiano Rosas <farosas@suse.de> wrote:
> > We've found the source of flakiness in this test, so re-enable it.
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  tests/qtest/migration-test.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index b0c355bbd9..800ad23b75 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
> >      }
> >      qtest_add_func("/migration/multifd/tcp/plain/none",
> >                     test_multifd_tcp_none);
> > -    /*
> > -     * This test is flaky and sometimes fails in CI and otherwise:
> > -     * don't run unless user opts in via environment variable.
> > -     */
> > -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> > -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
> > -                       test_multifd_tcp_cancel);
> > -    }
> > +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
> > +                   test_multifd_tcp_cancel);
> >      qtest_add_func("/migration/multifd/tcp/plain/zlib",
> >                     test_multifd_tcp_zlib);
> >  #ifdef CONFIG_ZSTD
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
> There was another failure with migration test that I will post during
> the rest of the day.  It needs both to get it right.

This one didn't yet land upstream.  I'm not sure, but maybe Juan was saying
about this change:

        commit d2026ee117147893f8d80f060cede6d872ecbd7f
        Author: Juan Quintela <quintela@trasno.org>
        Date:   Wed Apr 26 12:20:36 2023 +0200

        multifd: Fix the number of channels ready

Fabiano, did you try to reproduce multifd-cancel with current master?  I'm
wondering whether this test has already been completely fixed, then maybe
we can pick up this patch now.

-- 
Peter Xu


