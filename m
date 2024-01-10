Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F125B8292E6
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 05:00:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNPkD-0003DI-0v; Tue, 09 Jan 2024 22:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPk9-0003Cz-SM
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 22:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNPk4-0006CV-Jy
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 22:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704859139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VVXpYsiX+RCwfFpvr9eZjQilgn0Ln5LmxAb4vtB6T/8=;
 b=JR1EnU7jG0o/w2fv0jgRHAOsD4Pnjnu9yKi6iMKPHCGP7KGB4JgS+RT8gC7pSw5/Wi2aEc
 zhoAA5HmqMwcvhLkO1Imto12yf1jFVe2xib1FMHDuvc0R0DJ4AHGj+z5QqI0SJ59HgUzxI
 yGybFOZjPBByV/zuh0bmYiXb+2c6JI0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-JsaRA4wUMW2XGL7jtIauIg-1; Tue, 09 Jan 2024 22:58:57 -0500
X-MC-Unique: JsaRA4wUMW2XGL7jtIauIg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d44608e379so5800375ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 19:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704859136; x=1705463936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VVXpYsiX+RCwfFpvr9eZjQilgn0Ln5LmxAb4vtB6T/8=;
 b=wahmtVB1wIwv+XeN8uWejRfiuW/mGKWyUtsbxz/AE7pkOzu+Si02rkPilqFZlA0i/l
 05GfS1txqu617fKDIC6KJN5QnADqqbVhrEl9LXXi8/v5H73/IBzP9vKiDC0JwouTEQ3W
 1d3JwmCYDhlfPH9whiRPdowpUz/za3SN0qIfd2nI1w0eAp6+JACX56JOPK6WAh6JoZq0
 LwvpXPnT96WEyWKS/3eRDXP5UycPBN/qKo2EA0uNFv01A6iZV43YMZEJtXaFdPMjN6Ls
 zM3Zil7zLWCi0pp4sh7yGbhqHRwFAB3V0no36qZE/bz43RuvtCVVmAV4vE7Pq9jJGgXm
 AdBw==
X-Gm-Message-State: AOJu0YwT+7ZXM6YDiFf4RizHh+cTJMsL8AGkYvYpI3E6OxJZ5TzMZFj7
 mnNMdIUeCSiFVCDKhflBGy1eHQq8s1BGUkB5F1A2tB+q6kBJ2Xrgj6z8LqflzY+oBdGRasuWf2H
 vdy7AvzI1lqNc43sxdfuSm3/c71w+RjKIWA==
X-Received: by 2002:a17:902:9f88:b0:1d5:82e:e95c with SMTP id
 g8-20020a1709029f8800b001d5082ee95cmr772787plq.4.1704859136408; 
 Tue, 09 Jan 2024 19:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF18GkvtRGFJh5Aq2dZwiK2kbyVO/9PZDRiUhdPIyeXhU9wKhMINK+bpBDotO6KvqW8cKpO4A==
X-Received: by 2002:a17:902:9f88:b0:1d5:82e:e95c with SMTP id
 g8-20020a1709029f8800b001d5082ee95cmr772769plq.4.1704859136130; 
 Tue, 09 Jan 2024 19:58:56 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm2553744plr.70.2024.01.09.19.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 19:58:55 -0800 (PST)
Date: Wed, 10 Jan 2024 11:58:48 +0800
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
Message-ID: <ZZ4V-FukI0jN5-F1@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de> <ZZzyZhUbgt9WhaAP@x1n>
 <8734v68xwe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734v68xwe.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 09, 2024 at 10:00:17AM -0300, Fabiano Rosas wrote:
> > Can we opt-out those broken tests using either your "since:" thing or
> > anything similar?
> 
> If it's something migration related, then yes. But there might be other
> types of breakages that have nothing to do with migration. Our tests are
> not resilent enough (nor they should) to detect when QEMU aborted for
> other reasons. Think about the -audio issue: the old QEMU would just say
> "there's no -audio option, abort" and that's a test failure of course.

I'm wondering whether we can more or less remedy that by running
migration-test under the build-previous directory for cross-binary tests.
We don't necessarily need to cross-test anything new happening anyway.

IOW, we use both old QEMU / migration-test for "n-1", and we only use "n"
for the new QEMU binary?

-- 
Peter Xu


