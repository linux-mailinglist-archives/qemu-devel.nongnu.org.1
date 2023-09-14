Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA97A096F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoNq-0000tA-3n; Thu, 14 Sep 2023 11:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgoNn-0000sc-Vj
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgoNl-0004IC-PJ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694705752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9iHZTSaJ3ekYDv4W0CJUWXaTtOwjmt3niZg23N1KwJs=;
 b=WovhRZH1GfUqt5FT5wOn/xbDAz4kXhyk2n6HtTxeNOXNkP7QCxfDOM3gcTC21uj0d/Vq39
 S22Pf/vhGuDblx18zqsqBduOgsrFJ1HUET/jZS9TwrbBJIq6VkbS0hmMh+BUDsD5zmtV9I
 hmm8TOJ8w271FHdapU1uJqroEu5//24=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-wuCmV2FaOFaS9oG3qm8MMA-1; Thu, 14 Sep 2023 11:35:51 -0400
X-MC-Unique: wuCmV2FaOFaS9oG3qm8MMA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1a9e3f67989so293949fac.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694705750; x=1695310550;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9iHZTSaJ3ekYDv4W0CJUWXaTtOwjmt3niZg23N1KwJs=;
 b=CiMIVYyMzuSW1RKitQb4D4S039iiZioPEF7Rp4f714p7AfYPHbWDHQbdPwz4Xp0F7D
 B6GHhnp62F8COxl8GcEJXnrqJFHvoWg4c/VaGHI12NUa4Og7f4qk4GiQhWBShy041BI+
 5uH802X5kGj6n+h0WPrDSRBC9Uc0XER4gwVPtx7Jf1w9cSfIFvc4t3k1LicSx5bLVN5C
 gNw0mFYJ5BTKjKE5/AXi8DyU+BGfqPQK3LLJULv9VIxzZRCL2Ge1SC+LsmvbVW4GIZww
 OOQXm5giH93Hvr34DPZyAcPy+KDAZua4QvZT8Vnpk6fcNcZVmFa4bjNPts3yfYIem0vz
 e/jA==
X-Gm-Message-State: AOJu0YyOYvED0udq4WjLnBP/zEgJiaspZjRBh7sXrX/I4Nsgs+iVEgKG
 nXcmpGgaqgGV5JAG03/8Pz8QSb50gnVlZ5cavTQIaPJZvZxCbRj4xOmE1CmG6CQFDvlJws95hoZ
 qJVkyACP6Wh0aME8=
X-Received: by 2002:a05:6359:b9c:b0:13f:1503:92f8 with SMTP id
 gf28-20020a0563590b9c00b0013f150392f8mr4917081rwb.2.1694705750366; 
 Thu, 14 Sep 2023 08:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzjQGA88AFJW1dbfKeN942c5glE6of0AhiyaMJD2ykSZeT7wV0nCqIOGO3pQH15WCRve0IvA==
X-Received: by 2002:a05:6359:b9c:b0:13f:1503:92f8 with SMTP id
 gf28-20020a0563590b9c00b0013f150392f8mr4917064rwb.2.1694705749975; 
 Thu, 14 Sep 2023 08:35:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d3-20020a0caa03000000b00655e3e86ad7sm555750qvb.6.2023.09.14.08.35.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:35:49 -0700 (PDT)
Date: Thu, 14 Sep 2023 11:35:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQMoUzRH1BZKs39g@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edj0kcz7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 14, 2023 at 12:10:04PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 13, 2023 at 04:42:31PM -0300, Fabiano Rosas wrote:
> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >> 
> >> > Hi,
> >> > The following intermittent failure occurred in the CI and I have filed
> >> > an Issue for it:
> >> > https://gitlab.com/qemu-project/qemu/-/issues/1886
> >> >
> >> > Output:
> >> >
> >> >   >>> QTEST_QEMU_IMG=./qemu-img MALLOC_PERTURB_=116 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >> >   ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >> >   stderr:
> >> >   qemu-system-x86_64: Unable to read from socket: Connection reset by peer
> >> >   Memory content inconsistency at 5b43000 first_byte = bd last_byte = bc current = 4f hit_edge = 1
> >> >   **
> >> >   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
> >> >   (test program exited with status code -6)
> >> >
> >> > You can find the full output here:
> >> > https://gitlab.com/qemu-project/qemu/-/jobs/5080200417
> >> 
> >> This is the postcopy return path issue that I'm addressing here:
> >> 
> >> https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
> >> Subject: [PATCH v6 00/10] Fix segfault on migration return path
> >> Message-ID: <20230911171320.24372-1-farosas@suse.de>
> >
> > Hmm I just noticed one thing, that Stefan's failure is a ram check issue
> > only, which means qemu won't crash?
> >
> 
> The source could have crashed and left the migration at an inconsistent
> state and then the destination saw corrupted memory?
> 
> > Fabiano, are you sure it's the same issue on your return-path fix?
> >
> 
> I've been running the preempt tests on my branch for thousands of
> iterations and didn't see any other errors. Since there's no code going
> into the migration tree recently I assume it's the same error.
> 
> I run the tests with GDB attached to QEMU, so I'll always see a crash
> before any memory corruption.

Okay, maybe that stops you from seeing the above check_guests_ram() error?
Worth checking whether it fails differently always if you just don't attach
gdb to it; I had a feeling that it'll always fail in the other way (I think
migration-test will say something like "qemu killed" etc. in most cases),
further to identify the issues.

> 
> > I'm also trying to reproduce either of them with some loads.  I think I hit
> > some but it's very hard to reproduce solidly.
> 
> Well, if you find anything else let me know and we'll fix it.

I think Stefan's issue is the one I triggered once, but only once; I did
see check_guests_ram() lines.

I ran concurrently 10 migration-tests (on 8 cores; just to make scheduler
start to really work), each looping over preempt/plain for 500 times and
hit nothing..  I'm trying again with a larger host with more instances, so
far I've run 200 loops over 40 instances running together, I hit
nothing.. but I'm keeping trying.

-- 
Peter Xu


