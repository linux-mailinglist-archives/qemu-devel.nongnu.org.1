Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407187CCF8A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 23:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsrzh-0005uk-J3; Tue, 17 Oct 2023 17:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qsrzd-0005uV-4r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qsrzb-0007jz-7k
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 17:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697579563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSPtkiuj8aRMGBE14v725Qq+saVmS0v8CCRsIBqAVz0=;
 b=WES7IDHkOlLutR6pWG4DBkKoMnCmVU1X+AFG8v40+8cTv4YnKESdxMGNyTZu3axqGvCMmy
 aVelxdFr0jWWXeR4/3UhUW1F+2eWajjkVQAzLGRp+ckIOMyJG/tEcHibVca4qLDerbTyBb
 3G0V5hGjsIJSqeES3qI9WkhzpGCB8Ow=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-qPQfQxMJPJ6rsW_ixk7hDA-1; Tue, 17 Oct 2023 17:52:26 -0400
X-MC-Unique: qPQfQxMJPJ6rsW_ixk7hDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2098C3C28643;
 Tue, 17 Oct 2023 21:52:26 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B867625C8;
 Tue, 17 Oct 2023 21:52:25 +0000 (UTC)
Date: Tue, 17 Oct 2023 16:52:24 -0500
From: Eric Blake <eblake@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 00/78] Strict disable implicit fallthrough
Message-ID: <sujy5au5epxhg7urtyf626m2syrthpsbzdxdd4f2ua6fzkjnzu@2g3zzocqgyld>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Fri, Oct 13, 2023 at 10:56:27AM +0300, Emmanouil Pitsidianakis wrote:
> /* resubmitted because git-send-email crashed with previous attempt */
> 
> Hello,
> 
> This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> back in 2019.[0]
> We take one step (or two) further by increasing it to 5 which rejects
> fall through comments and requires an attribute statement.
> 
> [0]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a035d552a93b
> 
> The line differences are not many, but they spread all over different
> subsystems, architectures and devices. An attempt has been made to split
> them in cohesive patches to aid post-RFC review. Part of the RFC is to
> determine whether these patch divisions needs improvement.
> 
> Main questions this RFC poses
> =============================
> 
> - Is this change desirable and net-positive.

I think so - consistency eases code maintenance, and being able to
define a keyword-like macro used like any other control-flow statement
is nicer than a magic comment.

> - Should the `fallthrough;` pseudo-keyword be defined like in the Linux
>   kernel, or use glib's G_GNUC_FALLTHROUGH, or keep the already existing
>   QEMU_FALLTHROUGH macro.

This seems like it only affects the one place where we define the
keyword.  As long as all switch statements actually using it stick to
one style, I'm less concerned about the magic used to get the style
working in the first place.

> - Should fallthrough comments be removed if they do not include extra
>   information.

That would be fine by me - but we'll see what other reviewers say.
I'm going to review on just the files I normally touch.

> 
> Some external resources
> =======================
> 
> See the RFC discussion in the kernel:
> 
> https://lore.kernel.org/lkml/1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com/
> 
> The `fallthrough;` pseudo-keyword in the kernel source code:
> 
> https://elixir.bootlin.com/linux/latest/C/ident/fallthrough
> 
> In summary, I quote the doc comment and definition:
> 
>     /*
>      * Add the pseudo keyword 'fallthrough' so case statement blocks
>      * must end with any of these keywords:
>      *   break;
>      *   fallthrough;
>      *   continue;
>      *   goto <label>;
>      *   return [expression];
>      *
>      *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
>      */
>     #if __has_attribute(__fallthrough__)
>     # define fallthrough                    __attribute__((__fallthrough__))
>     #else
>     # define fallthrough                    do {} while (0)  /* fallthrough */
>     #endif
> 
> Background - Motivation
> =======================
> 
> The C switch statement allows you to conditionally goto different labels
> depending on a value. A break; statement conveniently goto's the end of
> the switch. If a "case" does not end in a break, we say that the control
> flow falls through the next case label, if any, implicitly. This can
> lead to bugs and QEMU uses the GCC warning -Wimplicit-fallthrough to
> prevent this.
> 
> Currently, QEMU is built with -Wimplicit-fallthrough=2. This makes GCC's
> static analyzer check for a case-insensitive matches of the .*falls?[
> \t-]*thr(ough|u).* regular expression. This means the following list of
> comments taken from QEMU all disable the implicit fallthrough warning:
> 
> - /* FALLTHRU */
> - /* fall through */
> - /* Fall through.  */
> - /* Fall through... */
> - /* fall through if hEventTimeout is signaled */
> - /* FALL THROUGH */
> 
> To keep a constistent code style, this commit adds a macro `fallthrough`
> that looks like a C keyword but expands to an attribute statement in
> supported compilers (GCC at the moment).
> 
> Note: there was already such a macro, QEMU_FALLTHROUGH, and it was used
> only around 7 times in the code base. The first commit replaces it.

Seems reasonable to me; we'll see what other comments you get.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


