Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD571F49F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 23:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4pnr-0006uQ-1O; Thu, 01 Jun 2023 17:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4pnZ-0006sv-LI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4pnY-0000kG-7R
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 17:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685654731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFbur0D6WVf1JAGf8b5TDVl+j9BTbSAOkrQIwrxJQx0=;
 b=drU39cmWvn9SXQMyX6ygRnNN1ivKceR0n5szpVngS+HVQ0b0HvUfDNcrtN1cySo2AdJk2w
 O/WTMCk/t4JiLvmDrxUX8vr31+EnvSaJnggWyOTIPz5Pj3KWp0py8eLAA/j0SiQB/XeWo6
 EPHF5e7jVbHkQIRlzXff4tvSXva+ThE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-U08PEHM_NGiMQQOCz_EPkg-1; Thu, 01 Jun 2023 17:25:28 -0400
X-MC-Unique: U08PEHM_NGiMQQOCz_EPkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13FAA29A9D36;
 Thu,  1 Jun 2023 21:25:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 85FF88162;
 Thu,  1 Jun 2023 21:25:27 +0000 (UTC)
Date: Thu, 1 Jun 2023 16:25:25 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Subject: Re: [PATCH] qcow2: Explicit mention of padding bytes
Message-ID: <ovvwkvusgyrkgatqmfl4k2a52c5vj2xldrq3lgbbf5nnzegxv5@adkiugvgh242>
References: <20230522184631.47211-1-eblake@redhat.com>
 <b4127b37-1be6-91f5-aa76-429ef4e97a11@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4127b37-1be6-91f5-aa76-429ef4e97a11@yandex-team.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, May 22, 2023 at 11:26:03PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 22.05.23 21:46, Eric Blake wrote:
> > Although we already covered the need for padding bytes with our
> > changes in commit 3ae3fcfa, commit 66fcbca5 (both v5.0.0) added one
> > byte and relied on the rest of the text for implicitly covering 7
> > padding bytes.  For consistency with other parts of the header (such
> > as the header extension format listing padding from n - m, or the
> > snapshot table entry listing variable padding), we might as well call
> > out the remaining 7 bytes as padding until such time (as any) as they
> > gain another meaning.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Not strictly related to NBD, but I'll pick it up since I'm about to do a pull request.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


