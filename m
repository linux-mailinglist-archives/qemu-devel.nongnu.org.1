Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1F71A305
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kV9-0005Ji-Pg; Thu, 01 Jun 2023 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kV8-0005Io-Fd
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kV5-0007Pq-St
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685634367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ui7n38g9s1EteqMIhMLplly7qBSmVGu+pcxs5Pb+0OM=;
 b=RBLF1cn6kQygcp+tOtXwBm3wov0GVcZoLgLztT/h+hTfheGJKpMNc0szisleU3Nv2tpqCy
 XTdGG/00CMSpMS4SVftHjJRsnnZovdIs21NktkTqz2nqxQwS+OlXKYc54dz+jxa/W5um3i
 6/Jl7Ylc8zqhyX5uLN0NfTN76b1T/lc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-qHGNxLSnOAqTX9IYABFHYg-1; Thu, 01 Jun 2023 11:46:06 -0400
X-MC-Unique: qHGNxLSnOAqTX9IYABFHYg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-75b147a2548so19891785a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685634365; x=1688226365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ui7n38g9s1EteqMIhMLplly7qBSmVGu+pcxs5Pb+0OM=;
 b=SmvDrVIW7D4sUQEouktSRCArfr5/GWNKLK4omlpr/uCe+5+hPMn5QXp+wfVndFwB18
 pCqjHcYFOReGVWIlQsZHsA0V8t5VToFcUT82NHzikPqoWhDJj0Zf+6U7W0+z/m/3Tp8/
 Cz1Owcg7PW+/st0ymnRNpMv8WfFGpOp5thIsQTE6YZ+VeqjmlZN/uyIvgjL2/V0u6mU2
 +VL6YVJeVQEenOdysMG1JCP6zdUN9ctNgMutY6ohIFbKph7cpW1PG2kMPy2uCO4eVVw0
 Rkz3VgOA8Hl05FOCS07IBgm4AkndoKRMTcuxI+MtxBFTbn4yb/ZQZ5aWgopQ4WTTR0p6
 v2PQ==
X-Gm-Message-State: AC+VfDxHUlOgfbbIelZO+5tFxa9+IaMLcbvby/I5lzsWJrfWGJHZQlg7
 wfJlo77FCAHbsnj2ykSNcW9hBHi59xGexKGaWbr+zWzPnU3qVLJcvmGbWzWdIJO63e5W91ZLTWm
 p3ukgLCp5d+5Ur4o=
X-Received: by 2002:a05:620a:6542:b0:75b:23a1:69ee with SMTP id
 qc2-20020a05620a654200b0075b23a169eemr6411971qkn.5.1685634365254; 
 Thu, 01 Jun 2023 08:46:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TjqMEHoPEtG+zXsKsw9bz34Z274SSEfns8bJlbs4MZemacoLyTpD9O17G5WS6vItcyOYgHA==
X-Received: by 2002:a05:620a:6542:b0:75b:23a1:69ee with SMTP id
 qc2-20020a05620a654200b0075b23a169eemr6411939qkn.5.1685634364930; 
 Thu, 01 Jun 2023 08:46:04 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s11-20020ae9f70b000000b007594a7aedb2sm6761761qkg.105.2023.06.01.08.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 08:46:04 -0700 (PDT)
Date: Thu, 1 Jun 2023 11:46:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Message-ID: <ZHi9OQz8PGuHMPpN@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531132400.1129576-10-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Wed, May 31, 2023 at 02:24:00PM +0100, Daniel P. Berrangé wrote:
> The migration test cases that actually exercise live migration want to
> ensure there is a minimum of two iterations of pre-copy, in order to
> exercise the dirty tracking code.
> 
> Historically we've queried the migration status, looking for the
> 'dirty-sync-count' value to increment to track iterations. This was
> not entirely reliable because often all the data would get transferred
> quickly enough that the migration would finish before we wanted it
> to. So we massively dropped the bandwidth and max downtime to
> guarantee non-convergance. This had the unfortunate side effect
> that every migration took at least 30 seconds to run (100 MB of
> dirty pages / 3 MB/sec).
> 
> This optimization takes a different approach to ensuring that a
> mimimum of two iterations. Rather than waiting for dirty-sync-count
> to increment, directly look for an indication that the source VM
> has dirtied RAM that has already been transferred.
> 
> On the source VM a magic marker is written just after the 3 MB
> offset. The destination VM is now montiored to detect when the
> magic marker is transferred. This gives a guarantee that the
> first 3 MB of memory have been transferred. Now the source VM
> memory is monitored at exactly the 3MB offset until we observe
> a flip in its value. This gives us a guaranteed that the guest
> workload has dirtied a byte that has already been transferred.
> 
> Since we're looking at a place that is only 3 MB from the start
> of memory, with the 3 MB/sec bandwidth, this test should complete
> in 1 second, instead of 30 seconds.
> 
> Once we've proved there is some dirty memory, migration can be
> set back to full speed for the remainder of the 1st iteration,
> and the entire of the second iteration at which point migration
> should be complete.
> 
> On a test machine this further reduces the migration test time
> from 8 minutes to 1 minute 40.

The outcome is definitely nice, but it does looks slightly hacky to me and
make the test slightly more complicated.

If it's all about making sure we finish the 1st iteration, can we simply
add a src qemu parameter "switchover-hold"?  If it's set, src never
switchover to dst but keeps the iterations.

Then migrate_ensure_non_converge() will be as simple as setting
switchover-hold to true.

I am even thinking whether there can even be real-life use case for that,
e.g., where a user might want to have a pre-heat of a migration of some VM,
and trigger it immediately when the admin really wants (the pre-heats moved
most of the pages and keep doing so).

It'll be also similar to what Avihai proposed here on switchover-ack, just
an ack mechanism on the src side:

https://lore.kernel.org/r/20230530144821.1557-3-avihaih@nvidia.com

-- 
Peter Xu


