Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 779D4827FC4
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:50:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6qw-0002IH-02; Tue, 09 Jan 2024 02:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN6qt-0002Hu-Tx
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN6qr-0001vS-Pk
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704786524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k9g7b3I1NIA5f7yJpWxhKacg2hsZ9Z6utc5BKrnI4O0=;
 b=Tu246bHqEmlepsqnPJGMXYMq1ZLw3qaO7Hp5yX/pWD5as5WUts/q9eKwKlZVZpheBVWScp
 HyadSNxMJdEkJS4DyFaTeRJZCvTFjetp6RHnYIkTzodNR0tFyRtT7sir7jfXXvMN1nk4US
 PTuqmDCwohm2vyODp/sVa1kTRGGw4V8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-upPJsCNmPJimWcG40_1wTg-1; Tue, 09 Jan 2024 02:48:42 -0500
X-MC-Unique: upPJsCNmPJimWcG40_1wTg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5981e8cae08so597313eaf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704786522; x=1705391322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9g7b3I1NIA5f7yJpWxhKacg2hsZ9Z6utc5BKrnI4O0=;
 b=iAFCtkaQYu6RqVgRW3xgeVdnosUloFjceiMo/mbJ0uuqh7vEk/i0GMbhTKJEf8bYZu
 7Ty+laSul+Ms3CSuf4zQZVp2b0IzSZCijp0qmZAeFZ9IOSQOOKXgPXVH5Ykhkg8VHcEb
 JnsJaCx1gFgVUal/7leEuJunyi3s+TyNBHqs3/mVbaV3EGxx8+fc8KDbweFaIX8R9moO
 d41+MdjKxeNnldr8WPDiEW9WS2awrD3gY8Yv71AmkD2RrS3VYnH+h+dMOxgrtTbwaeKO
 TseI8tQFun6ylUU9RRPfZMXp43kPv1m61Ud9DBR0JP37+dzF+SU6hpaEApzJfERThNtQ
 noiQ==
X-Gm-Message-State: AOJu0YwRhGfPxslhEMVOvWIDu7bNjOc2I6QOJhFjTTpBVDweOnG2Y8fq
 74OJPouJ1qO5hDWoDaWSn0nP4jLk43mBbX5LodlV0WBaF1LGpdWMhV2eJ/sOFmA5IHzS9Ve27mN
 R2pHuHgW/hMIRsczi8Bjl/k8=
X-Received: by 2002:a05:6359:679e:b0:175:a479:7afb with SMTP id
 sq30-20020a056359679e00b00175a4797afbmr247384rwb.0.1704786522113; 
 Mon, 08 Jan 2024 23:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERx86UVW+KPJGpa0E9wyteNTcWm5BM5Oi6yCODTSgyOTPGqJ3pJPSpBhkC24+Aed3LcXzU2A==
X-Received: by 2002:a05:6359:679e:b0:175:a479:7afb with SMTP id
 sq30-20020a056359679e00b00175a4797afbmr247364rwb.0.1704786521770; 
 Mon, 08 Jan 2024 23:48:41 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o14-20020a62f90e000000b006dac9788c7dsm1058061pfh.16.2024.01.08.23.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 23:48:41 -0800 (PST)
Date: Tue, 9 Jan 2024 15:48:31 +0800
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
Message-ID: <ZZz6T8YU0_s-kNAt@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de>
 <87ttvjoexo.fsf@secure.mitica> <ZZuZcCxxIS6j_jHD@x1n>
 <87frz73nr7.fsf@suse.de> <ZZyrqnk3nJ3WIX8v@x1n>
 <5219f49a-c75d-4c42-86ba-4e4d90e58968@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5219f49a-c75d-4c42-86ba-4e4d90e58968@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi, Thomas,

On Tue, Jan 09, 2024 at 08:21:53AM +0100, Thomas Huth wrote:
> Sorry for that :-(

Not at all!  I actually appreciate more people looking after it.

> Maybe it's better if we remove the migration-test from
> the qtest section in MAINTAINERS? Since the migration test is very well
> maintained already, there's IMHO no need for picking up the patches via the
> qtest tree, so something like this should prevent these problems:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3269,6 +3269,7 @@ F: tests/qtest/
>  F: docs/devel/qgraph.rst
>  F: docs/devel/qtest.rst
>  X: tests/qtest/bios-tables-test*
> +X: tests/qtest/migration-*
> 
>  Device Fuzzing
>  M: Alexander Bulekov <alxndr@bu.edu>
> 
> (as you can see, we're doing it in a similar way for the bios tables test
> already)
> 
> If you agree, I can send out a proper patch for this later today.

Currently the file is covered by both groups of people, which is the best
condition to me:

$ ./scripts/get_maintainer.pl -f tests/qtest/migration-test.c 
Peter Xu <peterx@redhat.com> (maintainer:Migration)
Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
Thomas Huth <thuth@redhat.com> (maintainer:qtest)
Laurent Vivier <lvivier@redhat.com> (maintainer:qtest)
Paolo Bonzini <pbonzini@redhat.com> (reviewer:qtest)
qemu-devel@nongnu.org (open list:All patches CC here)

It makes sense to me e.g. when qtest reworks the framework, and we'd like
migration-test.c to be covered in that same reworks series and
reviewed/pulled together, for example, then those can go via qtest's tree
directly.

If patch submitter follows the MAINTAINERS file it means all of us will be
in the loop and that's the perfect condition, IMHO.  It's just that this
patch didn't have any migration people copied, which caused a very slight
confusion.

It'll be great in that case if qtest maintainers can help submitters to
copy us if the submitters forgot to do so.  I think we should do the same
when there's major changes for qtest framework for a new migration test.
Would that work the best for us?

Thanks,

-- 
Peter Xu


