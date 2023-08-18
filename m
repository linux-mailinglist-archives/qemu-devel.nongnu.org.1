Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96D8780FB0
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 17:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX1qS-0004JS-AZ; Fri, 18 Aug 2023 11:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1qL-0004Gb-EA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qX1qJ-0004PS-BN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 11:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692374213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/H4HBXONUQLn6sboejxhiBws/tGr9Q1HOypv3OwSVA=;
 b=E7jWagKV0YzVsJhX0OW0p6JmbMfw2UrNDQ4AUC642rF9MeQFtsn/M0wdlVMOSfVAJAxKli
 NnOw78N5UFpRup/9yVyMuGw/vHhxUs8AelMPX08fJVg114KWDzlf2UlNNbiJ1bapB0v+Mz
 pLu7Auzfk9F/imtIL3wFQAK/dQ/ZeT4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-696-rVY3QHYbNLWEA8Wz8XPnvQ-1; Fri, 18 Aug 2023 11:56:50 -0400
X-MC-Unique: rVY3QHYbNLWEA8Wz8XPnvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 319063806109;
 Fri, 18 Aug 2023 15:56:50 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43C6140C6E8A;
 Fri, 18 Aug 2023 15:56:49 +0000 (UTC)
Date: Fri, 18 Aug 2023 17:56:48 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] block/iscsi: Document why we use raw malloc()
Message-ID: <ZN+UwJ3/D5vKfxEe@redhat.com>
References: <20230727150705.2664464-1-peter.maydell@linaro.org>
 <CAFEAcA-0prmwQ+En=oZnR=AH_v9DBUU=C7qjK+z436WDygBnhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-0prmwQ+En=oZnR=AH_v9DBUU=C7qjK+z436WDygBnhA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 27.07.2023 um 17:15 hat Peter Maydell geschrieben:
> On Thu, 27 Jul 2023 at 16:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > In block/iscsi.c we use a raw malloc() call, which is unusual
> > given the project standard is to use the glib memory allocation
> > functions. Document why we do so, to avoid it being converted
> > to g_malloc() by mistake.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > There aren't many uses of raw malloc() in the codebase
> > other than third-party library sourcecode. Mostly we have
> > a comment noting when we're doing it deliberately.

Thanks, applied to the block branch.

> The other option here would be to use scsi_create_task(),
> if we're OK with requiring libiscsi 1.13 or better (that's
> 9 years old at this point, so should be OK...)

I wouldn't mind either way, but since this patch exists and the other
doesn't, I'm applying this one for now.

Kevin


