Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E974E743FAA
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 18:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGwO-0004QY-QG; Fri, 30 Jun 2023 12:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qFGwN-0004QJ-0s
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qFGwL-00078m-D9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 12:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688142343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXISxuQdG5ekphAf/Kn6X0n8VK0VZ8Lei/ss2rG7264=;
 b=XYkOYMx7SQsaU4muCNo2qIU6Y7Ztwal/G8xzqO5QdCbqG4sOTp7U8gZ1zQz+nHgH1BUo/e
 ex/JZ7TTCCyS1yoO9/bKUFYaDO4W5mJHEZqtCWePiKzodH74zllemlD47I90X1iKAQi3r3
 h2DmF46+SUbd1HTFK+Ld+Y0Ww70o7KU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-lKUk9wTwOnSdN-GdEOR4Qg-1; Fri, 30 Jun 2023 12:25:42 -0400
X-MC-Unique: lKUk9wTwOnSdN-GdEOR4Qg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-765ad67e600so33719785a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 09:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688142342; x=1690734342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXISxuQdG5ekphAf/Kn6X0n8VK0VZ8Lei/ss2rG7264=;
 b=KeixrGi+nzsS5pDcbsr4rUBG/7fo+SMYho6DktGCAo/HwjGvYQ/9PxatFaGz3wQSvw
 kvyZbr4tTzWCMOm1LiWaiXpqRg7YokoYY/yRGmuHanh4AC8o+C1a9XVwbgm4FDwa3w2p
 Ww/qf1LItJuPYDaCfH7Rcv5ZsMIytc+ZQYnMKoUbsd2qBN6r47lVN4kzOP4uR2ypC92Q
 ECskiSuHesvMHtIrVyYnis+I2IaAuATOAQbHy8HOXSGcvi5GtDBmgs1WjPtPeJQEe8u9
 cO3qfg5xtQFZng6kyGkfPHStH8ErKRPEQwZMeNnmTgNYBEBdKxrI/HssQlacqFi2jaWh
 omDQ==
X-Gm-Message-State: AC+VfDzzujtqddMn4UVT08dxXakuPh0rsLmX+oP134f+QybFWGdoAu3T
 bvOOmjAyaBlYPdKUsyyjN3Bkim6bd/3Qo5EJT0h0Cg763kktIgLUfIcTcQfRq7I1FFIkGQ0ZZy2
 cbPDHaGsczJ5yr80=
X-Received: by 2002:a05:620a:4487:b0:765:435c:a4fa with SMTP id
 x7-20020a05620a448700b00765435ca4famr4085768qkp.0.1688142341833; 
 Fri, 30 Jun 2023 09:25:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+ZSLVCz3whMqPAdJMudmvIZabCvwnopbsiEV3yb14q1NyqoQgwXfYz7GGBB9EXK/kwJjZbA==
X-Received: by 2002:a05:620a:4487:b0:765:435c:a4fa with SMTP id
 x7-20020a05620a448700b00765435ca4famr4085749qkp.0.1688142341517; 
 Fri, 30 Jun 2023 09:25:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m18-20020ae9e012000000b0075d49ce31c3sm5582361qkk.91.2023.06.30.09.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 09:25:41 -0700 (PDT)
Date: Fri, 30 Jun 2023 12:25:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZJ8CAw1S1n0hp192@x1n>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-7-farosas@suse.de> <ZJ35d0yqB5YD+8IH@x1n>
 <874jmpq9cc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jmpq9cc.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Jun 30, 2023 at 12:05:23PM -0300, Fabiano Rosas wrote:
> >> +static void test_precopy_file_offset_bad(void)
> >> +{
> >> +    /* using a value not supported by qemu_strtosz() */
> >> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",
> >> +                                           tmpfs);
> >> +    MigrateCommon args = {
> >> +        .connect_uri = uri,
> >> +        .listen_uri = "defer",
> >> +        .error_str = g_strdup(
> >> +            "file URI has bad offset 0x20M: Unknown error -22"),
> >
> > "Unknown error" may imply that in Steve's patch the errno is inverted..
> >
> > Shall we not rely on the string in the test?  It might be too strict, I
> > worry, because error strings should be defined for human readers, and we
> > may not want some e.g. grammar / trivial change to break a test.
> >
> 
> Well, you just caught an issue with the errno by looking at the string,
> so maybe testing it is a good thing?
> 
> I'd expect anyone changing the string to run the test and catch the
> mismatch before sending a patch anyway.
> 
> I don't have a strong opinion about it, though. I can remove the
> error_str.

I can give a few other examples outside "grammar error" (which in this case
we can guarantee there's no grammar issue..): we can always try to append
something to an error, when error_setg_errno() got refactored, or even
someone just thinks better to make the 1st letter capitalized ("f" -> "F").

It's just too fragile to me..

Thanks,

-- 
Peter Xu


