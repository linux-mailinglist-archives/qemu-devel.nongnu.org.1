Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAF978EEB5
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhoU-000419-CR; Thu, 31 Aug 2023 09:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhoR-00040Z-Ql
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qbhoP-0000yc-4z
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3pfHIXwmJE+RzAPh6+qCCNkWjjUOWN6J/XHMwIrdc4=;
 b=XqB7ROoMz5BItibFtIotmdW6ZSl0rK9PL2jW+BWSDQjUNE8S85Zn76jLYMl8UaFsnDXeQv
 i1S2gZv4ia8ZfINGeXtv55O7To/fitF2/4sng71tX0MTO0BnW1n5gfcVgretcpEQFOU3Dg
 /4gwHywsiLC6/eATw4uEmTr144TOZEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-yaVsgl8INTiW00cG1brNPw-1; Thu, 31 Aug 2023 09:34:12 -0400
X-MC-Unique: yaVsgl8INTiW00cG1brNPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A156E185A793;
 Thu, 31 Aug 2023 13:34:11 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA3040C2063;
 Thu, 31 Aug 2023 13:34:11 +0000 (UTC)
Date: Thu, 31 Aug 2023 08:34:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 qemu-block <qemu-block@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] util/iov: Avoid dynamic stack allocation
Message-ID: <275ynzhnmup7qno7vrlqp4atbsf5hu5dphrgm5kqjfvlbgjm54@4iukyvjdobug>
References: <20230824164706.2652277-1-peter.maydell@linaro.org>
 <358c92fd-8384-97b6-f47c-0ba60bd024af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <358c92fd-8384-97b6-f47c-0ba60bd024af@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 31, 2023 at 10:26:17AM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing qemu-block@ (I suppose this will go via a block tree)

Makes sense.

I can queue it through my NBD tree if no one else beats me (since the
nbd code is a heavy user of iovs).

> 
> On 24/8/23 18:47, Peter Maydell wrote:
> > From: Philippe Mathieu-Daudé <philmd@redhat.com>
> > 
> > Use autofree heap allocation instead of variable-length array on the
> > stack.
> > 
> > The codebase has very few VLAs, and if we can get rid of them all we
> > can make the compiler error on new additions.  This is a defensive
> > measure against security bugs where an on-stack dynamic allocation
> > isn't correctly size-checked (e.g.  CVE-2021-3527).
> > 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


