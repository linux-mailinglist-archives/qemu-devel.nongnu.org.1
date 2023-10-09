Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536527BD545
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:33:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplgo-0005JU-Dy; Mon, 09 Oct 2023 04:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qplgm-0005Hl-Ud
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qplgl-0000VH-2m
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696840349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oV2qeWKhGtahxPQFRTzJMNNy9fxuV7526nbdg4Trw0A=;
 b=eRN5/Ig3jqVfNHQAYNaFhgSMWmF8cEid1P0KzPKrkxK/hqtJFgl0780VtwMdtQOKi4h228
 UmPZf2jhuUOA9dZ73WXoTRg+kVtjdtjvpTdIPOn68I9Pc+91YwJ+fCf0FbSvkVMOpSbAM0
 qq3Jj9UpCK4i6ggO5q0zmmaNInSNggM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-r-LeOhyJNlaR-0y7CHRTUg-1; Mon, 09 Oct 2023 04:32:11 -0400
X-MC-Unique: r-LeOhyJNlaR-0y7CHRTUg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 568E5810BD9;
 Mon,  9 Oct 2023 08:32:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9174E400F36;
 Mon,  9 Oct 2023 08:32:10 +0000 (UTC)
Date: Mon, 9 Oct 2023 09:32:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/2] topic: meson: add more compiler hardening flags
Message-ID: <ZSO6h395Tut6Roqv@redhat.com>
References: <20231005173812.966264-1-berrange@redhat.com>
 <62196cb3-72e4-5db2-c0c4-ec1e74c8d432@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62196cb3-72e4-5db2-c0c4-ec1e74c8d432@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 09, 2023 at 09:21:01AM +0200, Thomas Huth wrote:
> On 05/10/2023 19.38, Daniel P. Berrangé wrote:
> ...
> > 
> > I also tested enabling -ftrapv, to change signed integer
> > overflow from wrapping, to trapping instead. This exposed a
> > bug in the string-input-visitor which overflows when parsing
> > ranges, and exposed the test-int128 code as (harmlessly)
> > overflowing during its testing. Both can be fixed, but I'm
> > not entirely sure whether -ftrapv is viable or not. I was
> > wondering about TCG and whether it has a need to intentionally
> > allow integer overflow for any of its instruction emulation
> > requirements ?
> I'm not an expert when it comes to this question, but as far as I
> understood, we are using -fwrapv (with "w", not "t") on purpose, see
> meson.build:
> 
> # We use -fwrapv to tell the compiler that we require a C dialect where
> # left shift of signed integers is well defined and has the expected
> # 2s-complement style results. (Both clang and gcc agree that it
> # provides these semantics.)
> 
> And according to the man-page of gcc:
> 
>  The options -ftrapv and -fwrapv override each other,
>  so using -ftrapv -fwrapv on the command-line results
>  in -fwrapv being effective.
> 
> If I got that right, this means you cannot use -ftrapv with QEMU.

Opps, I didn't notice we had -fwrapv in our flags, that is clearly
mutually exclusive with -ftrapv, so nothing further to do here.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


