Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67659832656
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:13:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQkuk-0001FL-56; Fri, 19 Jan 2024 04:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQkuh-0001Bj-Pk
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:11:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQkug-0007pX-37
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705655504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ouz5VBT6zrBAsovHr1OLvq7DapDzo98Y9+vm2mI+xQ=;
 b=VgTmRIP3EoQeb1KWcTk/TPiSzC4NIdzCu6Q+zxEDZDLcn76T6m/0OvrORUce8Tv0S04JQt
 BkOL8TAhRHXaKg6bhEJba3UbKV7pERyXAhALLxIx066rr+ppqWLzF7Mu620zuopDm0BnY5
 qLsudEFoIFndePoJJlluHHPHlL98MIE=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qZNcu_kgOyy9UpLRZp5x2A-1; Fri, 19 Jan 2024 04:11:40 -0500
X-MC-Unique: qZNcu_kgOyy9UpLRZp5x2A-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-599263d15feso134794eaf.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 01:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705655500; x=1706260300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ouz5VBT6zrBAsovHr1OLvq7DapDzo98Y9+vm2mI+xQ=;
 b=pkBn6AVbWwtg0dAvzRuPlXBK0NHZoD2TjIwu1yNu/AOGYFCzN1nFIZLml6rLqqfDY1
 bcd6EWbKPZcCENbREaoTRBafgcLEZfIqsAafHl4/eDH9zWPrXzfY7jXY/Ry5jYexDexS
 /rXypZ1Z9nVImp/BOVSZp+xWIIbiA+HeHbNaM+usnm7bfm51ATOxxEQBD4c27Q8ckB6j
 SFgYtkgIz4j4oKMfmOErGZr4MBHuhzhNIvkRp3aWj/EAL41X0Vge6kU0ZgEqtMR5rVIB
 0twloQsSiokTuUv0YFo8dPS6jU3hO3ovsqy8lrz2bFC5n21stmCXxL6blUNQuhjzh7U+
 awIQ==
X-Gm-Message-State: AOJu0YxtTJI6X+O14vCB5wSH52aj12Vv7KkawFlIsnfclhV+cKqnp5xh
 6qOL0vIS5g3BTqiwEHHzg/xaZVzIODSvgxYsSx4Km3HOOf6F9Km29EZ/TjHKOwEltvn5KVx+KRl
 47ln4OpXJCdlBuvfpowgukjmfG02YMrMqYcFGNIRv7wmAM2f8j8+I
X-Received: by 2002:a05:6359:4c1b:b0:176:28fd:7ae8 with SMTP id
 kj27-20020a0563594c1b00b0017628fd7ae8mr1844352rwc.2.1705655499988; 
 Fri, 19 Jan 2024 01:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9+6ET7ErGvfsPa75sRWwAgINpIPc8Rj7uKPVtILIcFwvnpkPFtN30nnhqXyq6OUpfPgt+fQ==
X-Received: by 2002:a05:6359:4c1b:b0:176:28fd:7ae8 with SMTP id
 kj27-20020a0563594c1b00b0017628fd7ae8mr1844338rwc.2.1705655499573; 
 Fri, 19 Jan 2024 01:11:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fa18-20020a056a002d1200b006d996ce80a6sm4575375pfb.0.2024.01.19.01.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 01:11:39 -0800 (PST)
Date: Fri, 19 Jan 2024 17:11:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 0/3] migration & CI: Add a CI job for migration compat
 testing
Message-ID: <Zao8whp3WCWOPb-9@x1n>
References: <20240118164951.30350-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240118164951.30350-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

Fabiano,

On Thu, Jan 18, 2024 at 01:49:48PM -0300, Fabiano Rosas wrote:
> Here's the second half of adding a migration compatibility test to CI.
> 
> We've already added support for running the full set of migration
> tests with two QEMU binaries since commit 5050ad2a380
> ("tests/qtest/migration: Support more than one QEMU binary"), now
> what's left is adding it to the CI.
> 
> changes since v3:
> 
> - Removed all the 'since' logic and started using the n-1 version of
>   the tests.
> 
> - New patch to fix the aarch64 cpu. We shouldn't have been using
>   'max'.
> 
> - New patch to disable aarch64 tests while the fix^ doesn't reach a
>   released version.
> 
> v3:
> https://lore.kernel.org/r/20240105180449.11562-1-farosas@suse.de
> v2:
> https://lore.kernel.org/r/20240104171857.20108-1-farosas@suse.de
> v1:
> https://lore.kernel.org/r/20231207155809.25673-1-farosas@suse.de

I gave it a try but build-previous-qemu somehow failed..

  https://gitlab.com/peterx/qemu/-/jobs/5965634871

You normally attach a "CI run" which I wanted to reference, but it's gone
in this v4 unfortunately.  The error:

  error: pathspec 'v8.2.0' did not match any file(s) known to git

is pretty weird, and I had a feeling it was something wrong before that.
Maybe it's because I tried to run this specific test multiple times (and
all failed), somehow the wrong thing was cached, so the real error (of the
1st run when there is no cache) could have got lost.  Not sure.

Please have a look when you have time, thanks.

> 
> Fabiano Rosas (3):
>   tests/qtest/migration: Don't use -cpu max for aarch64
>   ci: Add a migration compatibility test job
>   ci: Disable migration compatibility tests for aarch64
> 
>  .gitlab-ci.d/buildtest.yml   | 64 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/migration-test.c |  2 +-
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> -- 
> 2.35.3
> 

-- 
Peter Xu


