Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD269827F17
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:16:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6KO-0007xu-6p; Tue, 09 Jan 2024 02:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN6KJ-0007wm-4F
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN6KA-0001Cz-Tl
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704784497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h98Xsku7wk+kfIGM4qhYCdOfqicsonishslSH3Ji0F8=;
 b=OBodKZeL/iMylFU+NnloWdyVacbaCoPlRnN9ux0hLjUm0Zr+Ze2JnttjDfxalY1ar4Opww
 Itwr/wxeBKlka1aA7Hbou9VIXySr0UktXD0KoLw1Yn5sKXM9VXYyjeEvt0Svp2UWJ2FU+2
 qOl+qSQFNXFHbKCBbT0WRtLsm9nkAY8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-gidEvPTWOQW6-h0z4K0egQ-1; Tue, 09 Jan 2024 02:14:56 -0500
X-MC-Unique: gidEvPTWOQW6-h0z4K0egQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-59880be5eb0so62285eaf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:14:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704784495; x=1705389295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h98Xsku7wk+kfIGM4qhYCdOfqicsonishslSH3Ji0F8=;
 b=J66lm8elDt57EF+u+qk0v/7COrntJ6mTWNgYIHPD3bLV+fv78NiVhxRrEBq2H9q4uy
 rXy2m3NHlDqGjp7+p7ZTZRyC098Rwkf+JbHeLXrck1VZ1hxc5yaLS6bhuSj2FGJ+s7Vs
 5zmepJu+MBvGzMpj8TPOzr5ZlriLM9FXxY2Ysu5cYY9stkfczx8hhhMtK/IJVR3tfxdE
 NA6GcQ/WNajFjuLZY7BNCC75c04e2YoMlpeMQ8UnKS6ZNKEzS7cn9fCcKrT5WluV2/dZ
 +PnoTbcy6q3XPAhDrBmgmmyw+B06YOH+2tsV8xiRdjeWLM7nq4jWScWYc1WGtWogvXNL
 RBCg==
X-Gm-Message-State: AOJu0Yyz7ymHgpqhgqmy7RUPpQbUTsPiASrgAL7yFd7X1wOSzht0O5SR
 aNv2pDi6TSbmgZZvCyOLQukxGXNdT1sq8MFt7pvbGTd3vncMt5zo4ZtGY6ZU8qlN9CaCHzaNQn7
 gHi+hXfGLnbf7/k5qoTQEUOM=
X-Received: by 2002:a05:6358:c39b:b0:175:89aa:1300 with SMTP id
 fl27-20020a056358c39b00b0017589aa1300mr6217756rwb.1.1704784495040; 
 Mon, 08 Jan 2024 23:14:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWbgMsN9ljWXoIHhAzT1YGBKIORAVrp9RqXhA8ujaX8T3lpb9mJ9uzJ25veu51M6v4aEjDkg==
X-Received: by 2002:a05:6358:c39b:b0:175:89aa:1300 with SMTP id
 fl27-20020a056358c39b00b0017589aa1300mr6217741rwb.1.1704784494714; 
 Mon, 08 Jan 2024 23:14:54 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 2-20020a631742000000b005bd980cca56sm963009pgx.29.2024.01.08.23.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 23:14:54 -0800 (PST)
Date: Tue, 9 Jan 2024 15:14:46 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 3/4] ci: Add a migration compatibility test job
Message-ID: <ZZzyZhUbgt9WhaAP@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105180449.11562-4-farosas@suse.de>
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

On Fri, Jan 05, 2024 at 03:04:48PM -0300, Fabiano Rosas wrote:
> The migration tests have support for being passed two QEMU binaries to
> test migration compatibility.
> 
> Add a CI job that builds the lastest release of QEMU and another job
> that uses that version plus an already present build of the current
> version and run the migration tests with the two, both as source and
> destination. I.e.:
> 
>  old QEMU (n-1) -> current QEMU (development tree)
>  current QEMU (development tree) -> old QEMU (n-1)
> 
> The purpose of this CI job is to ensure the code we're about to merge
> will not cause a migration compatibility problem when migrating the
> next release (which will contain that code) to/from the previous
> release.
> 
> I'm leaving the jobs as manual for now because using an older QEMU in
> tests could hit bugs that were already fixed in the current
> development tree and we need to handle those case-by-case.

Can we opt-out those broken tests using either your "since:" thing or
anything similar?

I hope we can start to run something by default in the CI in 9.0 to cover
n-1 -> n, even if starting with a subset of tests.  Is it possible?

Thanks,

-- 
Peter Xu


