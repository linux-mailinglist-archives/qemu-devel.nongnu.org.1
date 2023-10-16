Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234B7CA2F0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJPy-0001Ao-0r; Mon, 16 Oct 2023 04:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJPs-00018s-HQ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qsJPq-0002nk-Sg
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697446653;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZLTwjF+F4Mgjy/DHjtCZX1PwDT0iWNCuwFJXv8/jUy0=;
 b=D74YdkOwqM4I8a5Khj7wKkoCr2r6BCWpwyGSacwD/xYu7ppcmrUzm7jDTVL0d2Zxhi8pUL
 4dKE4JKtxYzHJZP3UW+K0/AO1/R2epSW1R9F3FyxjJ3Qs6PR/CL7VYLe3zUmgU7pYgAtOH
 IqWrMcCbbK5CN0kUR+MftndchlNRFJE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-y7SeVTEjO7iuFmve1MtpcA-1; Mon, 16 Oct 2023 04:57:26 -0400
X-MC-Unique: y7SeVTEjO7iuFmve1MtpcA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43C021C01529;
 Mon, 16 Oct 2023 08:57:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEB5A492BFA;
 Mon, 16 Oct 2023 08:57:24 +0000 (UTC)
Date: Mon, 16 Oct 2023 09:57:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: -drive if=none: can't we make this the default?
Message-ID: <ZSz68rm5JdiMLdt+@redhat.com>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sat, Oct 14, 2023 at 10:16:16PM +0300, Michael Tokarev wrote:
> Can't we make -drive if=none the default?
> 
> Yes, I know current default is ide, and whole world have to use if=none explicitly
> to undo this.  I think at this point we can deprecate if=ide default and switch to
> if=none in the next release.  I think it will be a welcome change.

IMHO we'd be better off investing more effort in pushing people towards
-blockdev though better documentation of the latter.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


