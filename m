Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92173B53D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCe1I-0000Hh-SP; Fri, 23 Jun 2023 06:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCe1G-0000HC-5n
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCe1E-0001Fr-Dj
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687516074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOWNJKyjbPFIAPEoZ9eGsTLHJ3IBBWgmzh1N8FrMjIo=;
 b=YpI+JUFXR9yC4eDbAXqfpbkQ+IKe/1g6i45fFpxZlyPGYQWgFHdE8D2QvN9Fsnmhd+/kxZ
 /CfsjL6Og+br61Pe5JcSCxfIyoQJ5DhA3Be0FJ2tkyt0ow8BpqBrfMCxmLp3Rm420+V6A1
 etP9b+4eYDu8Bzk4j7VxoAhQTl6EdCc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-8obqrwYmOPik-iAJ6JlguA-1; Fri, 23 Jun 2023 06:27:50 -0400
X-MC-Unique: 8obqrwYmOPik-iAJ6JlguA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AE8329AB3E2;
 Fri, 23 Jun 2023 10:27:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB404F41C8;
 Fri, 23 Jun 2023 10:27:49 +0000 (UTC)
Date: Fri, 23 Jun 2023 11:27:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Miroslav Rezanina <mrezanin@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] keymaps: use 'ara' X11 keyboard map instead of 'ar'
Message-ID: <ZJVzoxfRtLvwWEMN@redhat.com>
References: <20230623094025.72295-1-berrange@redhat.com>
 <CAFEAcA-DZ=LO_qctUeqjZY5Umf-_kV6=BsFhqtT9ZDdyE2B-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-DZ=LO_qctUeqjZY5Umf-_kV6=BsFhqtT9ZDdyE2B-vw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jun 23, 2023 at 11:12:13AM +0100, Peter Maydell wrote:
> On Fri, 23 Jun 2023 at 10:40, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The keyboard mapping name 'ar' was a legacy name only available from
> > xkeyboard-config via a (15 year old) backcompat mapping. This mapping
> > was finally removed in the latest upstream release 2.39:
> >
> >   https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/commit/470ad2cd8fea84d7210377161d86b31999bb5ea6
> 
> Hi; I sent a patch to fix this a couple of days ago:
> https://patchew.org/QEMU/20230620162024.1132013-1-peter.maydell@linaro.org/
> (That one's already been reviewed and has a bit more detail
> in its commit message.)

Ah perfect, sorry I missed that.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


