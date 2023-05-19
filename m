Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71995709EB8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04RY-0000OG-Gn; Fri, 19 May 2023 14:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04RU-0000NF-QZ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q04RT-00075D-BC
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684519382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9lNXxV1zUZYrDspBUxzU864D9HvFfM8LOEU5Gj42LqM=;
 b=MM0US8I/rx1ajieTpPCwbjBlcT2Ul2in0X2wRO0OLupcVQ6fv+rR8wWc85KrATA8E4HvYk
 NUxKiCzGJYYTGA3Kne6rnmNjRp5X84LH6hDrV0jlyCZSSAsvherVfmVCBkAx7zQDfh54FB
 eem1tq8MSWnGJh3C7G7mutlI6jg40c4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-RBap21yZMxChnCTpzh-vZw-1; Fri, 19 May 2023 14:03:00 -0400
X-MC-Unique: RBap21yZMxChnCTpzh-vZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08A3E2801A45;
 Fri, 19 May 2023 18:03:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 924D22026D49;
 Fri, 19 May 2023 18:02:59 +0000 (UTC)
Date: Fri, 19 May 2023 13:02:54 -0500
From: Eric Blake <eblake@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2 14/19] test-cutils: Add more coverage to
 qemu_strtosz11;rgb:1e1e/1e1e/1e1e
Message-ID: <6krldtbtwytpcd7f3eqgo4kevjosjphsj2pscoiom5zckn7vtp@xwhq5vbm26kx>
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-15-eblake@redhat.com>
 <bbea3ac2-2890-0606-3f0f-f1b80ec27ad7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbea3ac2-2890-0606-3f0f-f1b80ec27ad7@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

On Fri, May 19, 2023 at 05:26:12PM +0200, Hanna Czenczek wrote:
> On 12.05.23 04:10, Eric Blake wrote:
> > Add some more strings that the user might send our way.  In
> > particular, some of these additions include FIXME comments showing
> > where our parser doesn't quite behave the way we want.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > 
> > ---
> > 
> > v2: even more tests added, pad a string to avoid out-of-bounds
> > randomness [Hanna]
> > ---
> >   tests/unit/test-cutils.c | 147 +++++++++++++++++++++++++++++++++++----
> >   1 file changed, 135 insertions(+), 12 deletions(-)
> 
> The subject line appears as if it contained an ANSI escape sequence.

Yep, and I even flagged that in reply to the cover letter.

> 
> > diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
> > index 1936c7b5795..7800caf9b0e 100644
> > --- a/tests/unit/test-cutils.c
> > +++ b/tests/unit/test-cutils.c
> > @@ -3162,7 +3162,12 @@ static void do_strtosz_full(const char *str, qemu_strtosz_fn fn,
> >       ret = fn(str, &endptr, &val);
> >       g_assert_cmpint(ret, ==, exp_ptr_ret);
> >       g_assert_cmpuint(val, ==, exp_ptr_val);
> > -    g_assert_true(endptr == str + exp_ptr_offset);
> > +    if (str) {
> > +        g_assert_true(endptr == str + exp_ptr_offset);
> > +    } else {
> > +        g_assert_cmpint(exp_ptr_offset, ==, 0);
> > +        g_assert_null(endptr);
> > +    }
> 
> This patch adds no new cases that call do_strtosz*() with a NULL str – did
> you intent for this to go into patch 12?

Oh, indeed - it was patch 12 that added do_strtosz(NULL, -EINVAL,
0xbaadf00d, 0); it's a shame the compiler doesn't complain about 'NULL
+ 0' as being an odd expression.  Yes, I'll hoist this hunk to 12 for
v3...

> 
> Regardless (with the subject fixed, though):
> 
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

...while keeping your R-b.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


