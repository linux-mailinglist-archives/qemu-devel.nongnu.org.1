Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 240CA7B85B7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo56J-0001to-3z; Wed, 04 Oct 2023 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo56H-0001ko-7S
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo56F-00089Y-JK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=H2jDc0iGAqLpKxVUMiY0b5Rf7aLh1Kx3WpxnR9dRkkE=;
 b=iA1PUocjPop07IGp1u1A4Y1SbFTq5ZIOZQXl2FMkf8m6yEfpCU8pNdMWlgK+3t9Ar1fKZJ
 1/m1Bwdkn4WHYhs2sbekgiAunlnTgGD7lVi8Jw4O9cFFhUnB4xUrQtvfKg3Wle6h8NRiy9
 xebriWX0ppNSy+ttodK2juzNypUVOGY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-q6MRWggBMGWhKQq05rF4Gg-1; Wed, 04 Oct 2023 12:51:49 -0400
X-MC-Unique: q6MRWggBMGWhKQq05rF4Gg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4030ae94fedso43485e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438308; x=1697043108;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2jDc0iGAqLpKxVUMiY0b5Rf7aLh1Kx3WpxnR9dRkkE=;
 b=C7WmszoS1IO4HWHtjx7PanUUyYltWV3BoqWIqucBnVwocUIYmQVw8SFZDBwlJwlTxb
 F3zbt281iWOmPaIHTrc70euu0nWGnfLPpSGQSzdiIt9YjY40kuw0P5ShUkw5OcwmXVeU
 38l0RZVmOclAt9HH4RJr7/zebVyFiNjXpVEhhreBML6QieToOskp8ujZBew7hEwE+VK7
 uwkHQV0uCMsmGGT23mGYnfm2cfn8vtAum6xm0IS/3XuTgKAZ8WZmVTKvpogeCv0ANkln
 ttTjsZK+Z2FtnetEFmV27XhkY2ckJ+qXJe62C6/jktglqI/jNX46bnDTCsaal5p0oemE
 d3pQ==
X-Gm-Message-State: AOJu0YwesIwEipSFdajH+Ga4HaW0MedGchDqi8tu/+cCjnwrEtu80eNj
 5P6Hl7HmdeHhrtJmPNqP5x6anfXGeEZUDbdPWj3TIKKuohjk59kgxLokGp+iwPv6Ur0+CqfGyQD
 SJgjGKl6mmSLQqnQ=
X-Received: by 2002:a05:600c:230d:b0:401:dc7c:2494 with SMTP id
 13-20020a05600c230d00b00401dc7c2494mr3035666wmo.27.1696438308315; 
 Wed, 04 Oct 2023 09:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/csLG03m3EYw6g+4m64zm4GsuMT0vw/uqZPbiIfv5KCGE9gEyl0CLI6YR75oS4TbWkR73ZA==
X-Received: by 2002:a05:600c:230d:b0:401:dc7c:2494 with SMTP id
 13-20020a05600c230d00b00401dc7c2494mr3035644wmo.27.1696438307920; 
 Wed, 04 Oct 2023 09:51:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm1941740wmi.27.2023.10.04.09.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:51:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 33/53] migration/rdma: Fix error handling around
 rdma_getaddrinfo()
In-Reply-To: <20230928132019.2544702-34-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:59 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-34-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 18:51:42 +0200
Message-ID: <87zg0ytjoh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> qemu_rdma_resolve_host() and qemu_rdma_dest_init() iterate over
> addresses to find one that works, holding onto the first Error from
> qemu_rdma_broken_ipv6_kernel() for use when no address works.  Issues:
>
> 1. If @errp was &error_abort or &error_fatal, we'd terminate instead
>    of trying the next address.  Can't actually happen, since no caller
>    passes these arguments.
>
> 2. When @errp is a pointer to a variable containing NULL, and
>    qemu_rdma_broken_ipv6_kernel() fails, the variable no longer
>    contains NULL.  Subsequent iterations pass it again, violating
>    Error usage rules.  Dangerous, as setting an error would then trip
>    error_setv()'s assertion.  Works only because
>    qemu_rdma_broken_ipv6_kernel() and the code following the loops
>    carefully avoids setting a second error.
>
> 3. If qemu_rdma_broken_ipv6_kernel() fails, and then a later iteration
>    finds a working address, @errp still holds the first error from
>    qemu_rdma_broken_ipv6_kernel().  If we then run into another error,
>    we report the qemu_rdma_broken_ipv6_kernel() failure instead.
>
> 4. If we don't run into another error, we leak the Error object.
>
> Use a local error variable, and propagate to @errp.  This fixes 3. and
> also cleans up 1 and partly 2.
>
> Free this error when we have a working address.  This fixes 4.
>
> Pass the local error variable to qemu_rdma_broken_ipv6_kernel() only
> until it fails.  Pass null on any later iterations.  This cleans up
> the remainder of 2.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


