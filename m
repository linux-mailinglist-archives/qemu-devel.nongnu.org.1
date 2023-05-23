Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F375A70E540
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 21:21:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1XXa-0002OV-Do; Tue, 23 May 2023 15:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1XXO-0002OD-GR
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1XXM-0006fK-GT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 15:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684869551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESSxzZLf9mcEHtLF2kYUwJME/SxM5ayrapzxhF0aGxI=;
 b=MSPuXHwDWufeH8/al9Mu4RZ212FHMWoxjwLrohILvBNSZRVzPtArZtG92bZBbaBV4gvha1
 vF8NbDBrwKgc7urFnq6Y2F+8Ic+TO/ly1evzA86VbHcdZYKHJ0vVpcbMR/GKGtKwmPQ9w0
 R3MCekw8g46o9dvQG5/FE7mIN65mZ4s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-oopLKMblPqegKwC_yhg4zw-1; Tue, 23 May 2023 15:19:09 -0400
X-MC-Unique: oopLKMblPqegKwC_yhg4zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 454563C0BE42;
 Tue, 23 May 2023 19:19:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5F3940D1B60;
 Tue, 23 May 2023 19:19:08 +0000 (UTC)
Date: Tue, 23 May 2023 14:19:07 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v3 04/19] test-cutils: Test more integer corner cases
Message-ID: <dl65ot7lh2hstviwk2yltgun2jgnz2vypvgoid6d3zstku52xf@trj4rhrs7qri>
References: <20230522190441.64278-1-eblake@redhat.com>
 <20230522190441.64278-5-eblake@redhat.com>
 <5720a801-a6b7-1b9e-efdb-bceb7e55c6ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5720a801-a6b7-1b9e-efdb-bceb7e55c6ce@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 07:25:28PM +0200, Hanna Czenczek wrote:
> On 22.05.23 21:04, Eric Blake wrote:
> > We have quite a few undertested and underdocumented integer parsing
> > corner cases.  To ensure that any changes we make in the code are
> > intentional rather than accidental semantic changes, it is time to add
> > more unit tests of existing behavior.
> > 
> 
> > +    if (LONG_MAX == INT_MAX) {
> > +        str = "0xffffffff00000001"; /* ULLONG_MAX - UNIT_MAX + 1 (not 1) */
> 
> s/UNIT/UINT/

Yep, and this comment is new to v3.

> 
> > +        endptr = "somewhere";
> > +        res = 999;
> > +        err = qemu_strtol(str, &endptr, 0, &res);
> > +        g_assert_cmpint(err, ==, -ERANGE);
> > +        g_assert_cmpint(res, ==, LONG_MIN);
> > +        g_assert_true(endptr == str + strlen(str));
> > +    }
> 
> [...]
> 
> > @@ -1325,31 +1799,87 @@ static void test_qemu_strtoul_max(void)
> 
> [...]
> 
> >   static void test_qemu_strtoul_underflow(void)
> >   {
> > -    const char *str = "-99999999999999999999999999999999999999999999";
> > -    char f = 'X';
> > -    const char *endptr = &f;
> > -    unsigned long res = 999;
> > +    const char *str;
> > +    const char *endptr;
> > +    unsigned long res;
> >       int err;
> > 
> > +    /* 1 less than -ULONG_MAX */
> > +    str = ULONG_MAX == UINT_MAX ? "-4294967296" : "-18446744073709551616";
> > +    endptr = "somewhere";
> > +    res = 999;
> >       err = qemu_strtoul(str, &endptr, 0, &res);
> > +    g_assert_cmpint(err, ==, -ERANGE);
> > +    g_assert_cmpint(res, ==, ULONG_MAX);
> 
> Should be g_assert_cmpuint().

Looks like I missed one of the spots, even though I did get most of
them from your same comment on v2.

I can fix both things before applying, if it goes through my tree, or
trust that whoever else queues it can do likewise.

> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


