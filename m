Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C01117B5C33
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 22:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnPkW-0004nq-RS; Mon, 02 Oct 2023 16:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnPkO-0004jS-Qk
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnPkL-0003U9-Od
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 16:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696279348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsYBsw19Z9EFJS4LkANaChMku/xFpF/8CD1qsZilSjo=;
 b=Zsim6Y0CNme7fzT3RtYI6ORhj6VCnPvoUjRoaw7dEPvti/ru31w0DDO8AKN+wwR7Cpm6+E
 9G20gvqc9ew1aJeLr2T7q5z7eDT0NiooN2miw40keZJDW4Lc/RhuU32qHWlk2hmcLtWgen
 4Z98EGp9uCpECwe7mlMdeTwEizvhsRY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-nbIxkPgRPzOpj9cZ5Sd6Cw-1; Mon, 02 Oct 2023 16:42:12 -0400
X-MC-Unique: nbIxkPgRPzOpj9cZ5Sd6Cw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-637948b24bdso378896d6.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 13:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696279331; x=1696884131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsYBsw19Z9EFJS4LkANaChMku/xFpF/8CD1qsZilSjo=;
 b=crrLFTD9x0ZFKChp/eVf4shsgZGrP/zwwbJjva/WuP8bMsj1NGRWwlr0Q/DPlMXDY2
 GpT11s109lNL8cJEntibZOqpvR9PWEq+io5KCfu390rXzTbq7in+2HSUZnDFjRRELB/e
 Ln2TgZAebEddUoof1uB0zG4i+5YycrrE1TTng7AS5RpARMrnPwy5/d7iHACwZGdO17t0
 N3qhdIcxnFvrIuniQw829uuqqzX0VZ0v6gpfPazUjF0o7tw42Q8lHNGWibyc8wvFWoU1
 aLYpVQffwUgFvftyeTc9RPQgBQ+jF+lz++s+dOMbRF8ywJCMM6RR9eSRkYtPDu9r8Esi
 xfpQ==
X-Gm-Message-State: AOJu0YxYLZf2AELp3lGcgzwkGCzR3eqGi6Bi1Zs9Lg05ITKGV4lT/GPg
 vOH3tQ00q6G79889717rUyoZ5cB3AwWXqc16j2bvhNA7plHe8DvSHZSS+lfFokMpx0m2NgGzFpw
 P9fC5JUq+dsGnXxY=
X-Received: by 2002:ad4:5d6d:0:b0:65a:fc65:b235 with SMTP id
 fn13-20020ad45d6d000000b0065afc65b235mr14407734qvb.2.1696279331726; 
 Mon, 02 Oct 2023 13:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoa5fG1lnvtk2kAf9s2SnHK39Nvj35nfJxlMP/wwtHCcE76CWaZHoidthOkX9CU3q5OkxCUA==
X-Received: by 2002:ad4:5d6d:0:b0:65a:fc65:b235 with SMTP id
 fn13-20020ad45d6d000000b0065afc65b235mr14407719qvb.2.1696279331444; 
 Mon, 02 Oct 2023 13:42:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d28-20020a0caa1c000000b0065b17b925d0sm6260466qvb.38.2023.10.02.13.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 13:42:11 -0700 (PDT)
Date: Mon, 2 Oct 2023 16:42:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Message-ID: <ZRsrG5QdnEh0jiXd@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
 <87a5t8is2d.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5t8is2d.fsf@pond.sub.org>
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

On Tue, Sep 26, 2023 at 10:43:22PM +0200, Markus Armbruster wrote:
> Loophole...  Here's the stupidest solution that could possibly work:
> 
>     ##
>     # @MigrationParameter:
>     #
>     # TODO: elide from generated documentation (type is used only
>     #     internally, and not visible in QMP)
>     #
>     # Features:
>     #
>     # @unstable: Members @x-checkpoint-delay and @x-vcpu-dirty-limit-period
>     #     are experimental.
>     #
>     # Since: 2.4
>     ##
> 
> Works because the QAPI generator currently doesn't flag missing member
> documentation, and quietly substitutes "Not documented" instead.

Didn't work for me..

In file included from ../qapi/qapi-schema.json:61:
../qapi/migration.json:681:1: unexpected de-indent (expected at least 4 spaces)

L681 points to the "Features:".

But maybe I did it wrong somewhere?

> Looks like
> 
>     "MigrationParameter" (Enum)
>     ---------------------------
> 
> 
>     Values
>     ~~~~~~
> 
>     "announce-initial"
>        Not documented
> 
>     "announce-max"
>        Not documented
> 
> and so forth.  Sure ugly, but is it really worse than before?  It's now
> obviously useless, whereas before it was unobviously useless.
> 
> This will break when we tighten up the QAPI generator to require member
> documentation.  Along we a few hundred other violators.
> 
> We might want to add a way to say "members intentionally undocumented".
> Could be useful for qapi/ui.json's QKeyCode.  Most of its 162 members
> don't really need documentation...

Yes I'd be super happy if we can declare that in qapi/.

Please let me know if I missed something above on the trick; you're right
it's only about the documentation we want to get rid of.  If we can achieve
that with qapi generating the helpers that'll definitely be perfect.

Thanks,

-- 
Peter Xu


