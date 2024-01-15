Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC082E37B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:30:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPWO5-0004K3-0N; Mon, 15 Jan 2024 18:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPWO1-0004Js-2R
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPWNy-0002UW-Dl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705361330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pc0WzwQhWoYlHV9r6po0htrfark34bjBrdXxDbBifcw=;
 b=cSecHbWg5hbAWRsOolrRUd78eCw/jubuHtV1EfjoKwK+evhagGiYT4SyEC5h0aZHt5qIyW
 RvCDspfcq0Paw9GOE4D11FokAZo/GqLjxKP9P9AJmwlUR9xi73Kbc793C47dLxvJ+DoVQF
 DmWIP1LpMLt1hr6JtyaGhtzfWr1T5n4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-z4KbLx0NMBmknjqE7vybaw-1; Mon, 15 Jan 2024 18:28:49 -0500
X-MC-Unique: z4KbLx0NMBmknjqE7vybaw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d5a4416df4so10030005ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705361328; x=1705966128;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pc0WzwQhWoYlHV9r6po0htrfark34bjBrdXxDbBifcw=;
 b=wIoaLRN8avVCxNoTnFQ0WJEc9VpHa5k78zSykVwN/5RvNTKDA/NdETfTedws6NEH8E
 DyDFHEiLmfZVzOueEH+I2reSdtn3zUMenMVWsYBcFmliJsal4fO4dfoS7r3RI4p+qYnZ
 RHUTH6fxvgkRv6Hn6fMeB4s3dBYkGp0xW62gdb831fYHcGQPD7ftHosVGTsd0fGKI6iw
 flD0rP348f5tSk5I2NZ99hoMbqkcDEnqHbsMdvD0P4NqXGPSbjJZ9tXS4ua0+ZkSQ7hz
 dOM2+VF6IftKDOUXu6sW1C2P9DwyMgMGvrmWRfOB1zjuab0zbxxNbGRjzhzQA0ccYyLR
 CwoA==
X-Gm-Message-State: AOJu0YzDNoy1iMYHLLNrGw0oUTNYRxjhBpRlm3lQSivfzkRnleShzeCW
 ibUwQrFfgjPmX7n/BB6cGC+7zaAaT9BwsoahIlArv9i1lLdkBxQ3E/3ZN65DigyLUUmxBfrf4Sb
 i9q1kA+Kr4vxV39FuuygISUc=
X-Received: by 2002:a17:902:d50d:b0:1d5:4c03:9988 with SMTP id
 b13-20020a170902d50d00b001d54c039988mr12513911plg.2.1705361328164; 
 Mon, 15 Jan 2024 15:28:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6V0UyEqr72gLdF+RDIyhFKT9IbA7rgLZbDgpm3U66mgdmBgTo+DSKnvxWmrB57tf4RpuN1A==
X-Received: by 2002:a17:902:d50d:b0:1d5:4c03:9988 with SMTP id
 b13-20020a170902d50d00b001d54c039988mr12513900plg.2.1705361327882; 
 Mon, 15 Jan 2024 15:28:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001d3ef57d937sm8139524plf.18.2024.01.15.15.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 15:28:47 -0800 (PST)
Date: Tue, 16 Jan 2024 07:28:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZaW_qQcYdGmeAKv1@x1n>
References: <ZZuvDREDrQ07HsGs@x1n> <877ckj3kfp.fsf@suse.de>
 <ZZzC1n0GotQZukqJ@x1n> <87zfxe7eev.fsf@suse.de>
 <ZZ4YOw6Cy5EYo_f4@x1n> <87zfxd6yid.fsf@suse.de>
 <ZZ9T2XSy3zaOEu_W@x1n> <874jfknf8m.fsf@suse.de>
 <ZaSwzM95tm24Uqyu@x1n> <87bk9m677m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk9m677m.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 15, 2024 at 10:45:33AM -0300, Fabiano Rosas wrote:
> > IMHO the n-1 tests are not for this.  The new FOO cap can only be enabled
> > in n+ versions anyway, so something like above should be covered by the
> > normal migration test that anyone would like to propose the new FOO cap.
> 
> You're being too generous in thinking new code will always restrict
> itself to implementing new functionality and never have a bug that
> affects a completly different part of the code. There could be an
> innocent refactoring along with cap FOO that breaks the migration only
> when FOO is enabled.

The question is even if we run cross-binary migration-test with current
version ("n") we can't detect such issue, right?  Because afaiu with that
we need to let migration-test always understand qemu versions, and it
should skip the new test that will enable FOO for cross-binary test since
it should detect the old binary doesn't support it.

> 
> But fine. We can't predict every scenario. Let's get this series out the
> door.
> 
> Thanks for the comments so far. I'll spin another version.

Yes if you think that is a good start point, we can start from simple.
That's so far the only solution I can think of that has mostly zero
maintanence burden for the tests meanwhile hopefully start to cover some
spots for us.  Said that, the discussion can keep going no matter what.

-- 
Peter Xu


