Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A2827CDA
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 03:27:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN1pA-0007DB-3z; Mon, 08 Jan 2024 21:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN1p7-0007CV-JZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:26:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN1p5-00064s-Vz
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 21:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704767194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDDU5mS/whInGRAd3fJpfjRisnmti5PX/sZsib7AXFU=;
 b=HY5ks/1st/N6ifiTEeJZ0aV45NJ/gKg1JMQBs6B5C+xSjPZbit2DzhG4rt9KUYaWEffIPB
 YPMGvkFIX5l/usIBL54lxX/QDuqM1yekG9RLeYslptczhfKM4qwPAnf9KAC/8xf35myIID
 awbO0s2nFqP1RHr8T+BtfVPYPVRCKrM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-XICVAO1COdKDxCO5uhoDqQ-1; Mon, 08 Jan 2024 21:26:32 -0500
X-MC-Unique: XICVAO1COdKDxCO5uhoDqQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso241808b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 18:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704767192; x=1705371992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDDU5mS/whInGRAd3fJpfjRisnmti5PX/sZsib7AXFU=;
 b=lb4upZO0rwGKvRMeCwiQBwFlIxxj7LgxAI9ySe+faN2WH36W8Ot5HTbSzSg06+DiwM
 9cm4F8RiUsx+IjMVOKOyWZ1J3KcP7jGRa+2YMQGqPTDtinq9Z6T86yHV7lyd6UTUR3O9
 Hg35PTMFopmsCJQ7EnM5oME3UE2skaqBbhGT9wkL4p0DaZMXS0hb+6kXmxszvJkHap/w
 Oxb4vrNNat3tLuWaNgupFr/eaSSsSrI9Hk9NpOl2BIQGKmAT56NN1GLJwAITjSo1KIxw
 c6i0+Xka1144DrSNJdeO7gAAu3pxu7kk5VjCQ6Ydu9Wjh9+Gq7ea+N4PTpmE64+wtBCi
 WktA==
X-Gm-Message-State: AOJu0Yx7kk106ylJ2ddnm48Mz9NZCIFvF02zJ4nzNTjfrLLuWfgJUcjI
 FFnn+PloPdRakR5mdbqjmoVrPQHHL8KZ0+oohbpsuFSh7PK7Ji/1jnDMOmIInCaWuI2E2lPb83G
 X3o3glAKfLOLlTAF71h/fQNE=
X-Received: by 2002:a05:6a00:4b0c:b0:6d9:edd1:4ede with SMTP id
 kq12-20020a056a004b0c00b006d9edd14edemr9350979pfb.2.1704767191792; 
 Mon, 08 Jan 2024 18:26:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0gtJOy7lvmWuNnLbHTexE7g1q9dx9sJLuePFMHzWoKE7xVgjYWqiWJbOU2htVEegUbRfFdQ==
X-Received: by 2002:a05:6a00:4b0c:b0:6d9:edd1:4ede with SMTP id
 kq12-20020a056a004b0c00b006d9edd14edemr9350956pfb.2.1704767191458; 
 Mon, 08 Jan 2024 18:26:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m11-20020a62f20b000000b006d9aa4b65fasm530637pfh.98.2024.01.08.18.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 18:26:31 -0800 (PST)
Date: Tue, 9 Jan 2024 10:26:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/4] tests/qtest/migration: Add infrastructure to skip
 tests on older QEMUs
Message-ID: <ZZyuzqbL5oaUVGhj@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-3-farosas@suse.de> <ZZuulnlKscT1ULS7@x1n>
 <87a5pf3mnq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5pf3mnq.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

On Mon, Jan 08, 2024 at 11:49:45AM -0300, Fabiano Rosas wrote:
> >> +
> >> +    if (major > tgt_major) {
> >> +        return -1;
> >
> > This means the QEMU version is newer, the function will return negative.
> > Is this what we want?  It seems it's inverted.
> 
> The return "points" to which once is the more recent:
> 
> QEMU version | since: version
> -1           0         1

Here if returns -1, then below [1] will skip the test?

> 
> > In all cases, document this function with retval would be helpful too.
> >
> 
> Ok.
> 
> >> +    }
> >> +    if (major < tgt_major) {
> >> +        return 1;
> >> +    }
> >
> > Instead of all these, I'm wondering whether we can allow "since" to be an
> > array of integers, like [8, 2, 0].  Would that be much easier?
> 
> I don't see why push the complexity towards the person writing the
> tests. The string is much more natural to specify.

To me QEMU_VER(8,2,0) is as easy to write and read, too.  What Dan proposed
looks also good in the other thread.

I don't really have a strong opinion here especially for the test case. But
imho it'll be still nice to avoid string <-> int if the string is not required.

[...]

> >> @@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >>          qtest_qmp_set_event_callback(*from,
> >>                                       migrate_watch_for_stop,
> >>                                       &got_src_stop);
> >> +
> >> +        if (args->since && migration_vercmp(*from, args->since) < 0) {

[1]

> >> +            g_autofree char *msg = NULL;
> >> +
> >> +            msg = g_strdup_printf("Test requires at least QEMU version %s",
> >> +                                  args->since);
> >> +            g_test_skip(msg);
> >> +            qtest_quit(*from);
> >> +
> >> +            return -1;
> >> +        }

-- 
Peter Xu


