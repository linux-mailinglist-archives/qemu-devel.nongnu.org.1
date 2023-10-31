Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B59B57DD65C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 19:57:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtuq-0001tp-8s; Tue, 31 Oct 2023 14:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtuo-0001tc-Oz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtun-0005sL-BE
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AdNdSoEivyXKXxRYwlgm2ANHha1I/iDS58qeyg/WAjk=;
 b=VuqAZnZMvFLJrGgzTLhUO80Q67vPoEwL59t4t7MzWykibHWWVMH1dFkpE5CwlK6atj+vtL
 nYWv+3exx0tcIdETK27+T1B/fqkYoTH8h3+E+Qb1tYNSsnbheFBtV8NZb5R0yyu258WJm/
 GnuJkWyr8KwxOjTh8hVF96NNVT9oab4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-NTsDEZSINMGyD-nTp-tUvw-1; Tue, 31 Oct 2023 14:56:32 -0400
X-MC-Unique: NTsDEZSINMGyD-nTp-tUvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992EB821C27;
 Tue, 31 Oct 2023 18:56:31 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2BC22026D4C;
 Tue, 31 Oct 2023 18:56:30 +0000 (UTC)
Date: Tue, 31 Oct 2023 19:56:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Subject: Re: -drive if=none: can't we make this the default?
Message-ID: <ZUFN3QEhOA4BItk8@redhat.com>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <bfc0ea0d-afda-50c6-d1d2-a89a227ad4f9@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc0ea0d-afda-50c6-d1d2-a89a227ad4f9@eik.bme.hu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 14.10.2023 um 21:59 hat BALATON Zoltan geschrieben:
> On Sat, 14 Oct 2023, Michael Tokarev wrote:
> > Can't we make -drive if=none the default?
> > 
> > Yes, I know current default is ide, and whole world have to use if=none
> > explicitly
> > to undo this.  I think at this point we can deprecate if=ide default and
> > switch to
> > if=none in the next release.  I think it will be a welcome change.
> 
> I don't think that would be welcome by all people now using -drive
> media=disk,format-raw,file= shortcut (which they were forced to use instead
> of the previous -hda shortcut just to specify format=raw)

Nobody forces you to give up -hda. You get the warning at startup for
raw files just so that you're not surprised if your guest gets I/O
errors for writing a qcow2 header into its boot sector, but I don't
think your guest is very likely to do this.

(But if you do use -drive, media=disk is the default, so you don't need
to specify it explicitly.)

Kevin


