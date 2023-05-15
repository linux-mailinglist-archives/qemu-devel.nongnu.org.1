Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5775703A0D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pycH5-0006QC-2N; Mon, 15 May 2023 13:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pycH3-0006Pw-DR
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pycH1-00076b-81
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684172773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qibu7BpovhZATYhi3t1ZHYhDdTEDgQYz2uCmeZqdPo=;
 b=M6RefVbsgelsXuJGjEHxxLyHvbULymL5ZLA2CMHC+6PTqvUyklLW1RBNcIZjQQK9UlPnR4
 eO3J9Iexl0RQ3vjoNe9Y0YEKdsHERWD8AtuDT6d6w1sbqrrZbQeDZKSNxtuLKUVMcHr4FJ
 LkARqpxCETgOYkbswF/GtyIvffC+MtQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-wRxtr8WyOYKjFY5J9SBvDg-1; Mon, 15 May 2023 13:46:11 -0400
X-MC-Unique: wRxtr8WyOYKjFY5J9SBvDg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f348182ffcso78560825e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684172769; x=1686764769;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Qibu7BpovhZATYhi3t1ZHYhDdTEDgQYz2uCmeZqdPo=;
 b=ZHq7YlKbaTSzosvtNCdOMlwRf9xp8nYTZHsG0CNDBQ4MSlYmUGMvbs5ofJaaOCwUCt
 GDDKoVOI2859Aj1MDPeRe3X5W4wjOcLtlHXx/0m0M8tbLCHXjiKNHkAW86pIkh+JfVRa
 +MnwVkV4pOIu2CYkuhm28g64Rva4ZkK8MsIgPhH18kAwJFjvUo+XLqxIZWVAHoNtteHW
 Pqt5Mo/dvI9FWrzh3YXXxMbf/bTNE5dk/UpM32oX9ypYw6o7KCoPiLmpKvEIRIkNg1wn
 qlHHQDIT1xO+NUcUFWgzPhPIln5HNcJhlx8iLGHopNUYhBZYuZ9+LdQ5UuTFF2475Xok
 d8wA==
X-Gm-Message-State: AC+VfDwqw0j7y+RHow4KQHcnYAhuV3C4TeygQD3HI6p622pWlk/2yeuR
 l17ZYRo3MgBSxtibuuZJoYrFJ995DEmsghWPmr+3xTETwiCf0sl/DMzkV0DpxQGd5uUwudCVfui
 XYKIHppLDXCR04D4=
X-Received: by 2002:a5d:6442:0:b0:306:32be:f0fe with SMTP id
 d2-20020a5d6442000000b0030632bef0femr22161183wrw.67.1684172769439; 
 Mon, 15 May 2023 10:46:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58Abpbqkp9oQL+XNp2ohGErROjlIICuPgmTkrOE8DUsbhIHtFzgJaxvg7yP8HtbMtwUoZPpA==
X-Received: by 2002:a5d:6442:0:b0:306:32be:f0fe with SMTP id
 d2-20020a5d6442000000b0030632bef0femr22161173wrw.67.1684172769076; 
 Mon, 15 May 2023 10:46:09 -0700 (PDT)
Received: from redhat.com ([2.52.26.5]) by smtp.gmail.com with ESMTPSA id
 a13-20020adff7cd000000b0030632833e74sm471804wrq.11.2023.05.15.10.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 10:46:08 -0700 (PDT)
Date: Mon, 15 May 2023 13:46:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: missing boot rom: is it really a fatal error?
Message-ID: <20230515134512-mutt-send-email-mst@kernel.org>
References: <d6f3e06c-ee84-5101-c583-220aa90c0c12@msgid.tls.msk.ru>
 <20230508062407-mutt-send-email-mst@kernel.org>
 <5492f69f-021d-cf25-5a92-8310255fddca@msgid.tls.msk.ru>
 <20230508074529-mutt-send-email-mst@kernel.org>
 <CANCZdfqybuKuDpkb4FsftfoCvZkq8OhixA0yj8K27WVeUjLN0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfqybuKuDpkb4FsftfoCvZkq8OhixA0yj8K27WVeUjLN0g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 15, 2023 at 10:02:43AM -0600, Warner Losh wrote:
> 
> 
> On Mon, May 8, 2023 at 5:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Mon, May 08, 2023 at 01:42:04PM +0300, Michael Tokarev wrote:
>     > 08.05.2023 13:28, Michael S. Tsirkin wrote:
>     > > On Sun, May 07, 2023 at 08:56:23PM +0300, Michael Tokarev wrote:
>     > ..
>     >
>     > > > I'm about to revert that old change on debian, to make it just a
>     warning instead
>     > > > of an error (the code is different now, but the same principle
>     applies), - because
>     > > > I dislike dependencies which are useless 99.9% of the time and are
>     trivial to
>     > > > install when actually needed.
>     > ..
>     > > I advise against it.
>     > > If you boot guest on a system with boot rom not installed you will not
>     > > be able to migrate to a system with boot rom installed.
>     > > why not? because we don't know how big to make the rom BAR.
>     > > And users will not discover until much much later after they have
>     > > painted themselves into a corner.
>     >
>     > Yes, I know about the migration. Actually there's an old bug report open
>     > against debian qemu package, - the context is similar to the old bios128
>     > vs bios256 thing in qemu upstream, - boot roms might change in size too.
>     >
>     > In this context though, the talk is not about migration at all. The
>     missing
>     > dep is in Xen HVM qemu package, a xen-only build of qemu-system-i386. And
>     > this one fails to start unless the boot roms are provided. It is not even
>     > capable of migration to begin with :)
>     >
>     > Thank you for the reminder, - very useful.
>     >
>     > /mjt
> 
>     I guess we decided we'd rather not handle reports from users about net
>     boot not working. It's true most users don't need net boot but then
>     that's true for most qemu functionality - 99% of users
>     probably need 1% of the functionality. It's just a different 1% for each
>     user...
> 
> 
> Yea, but to every user, their 1% is the most important thing ever...
> Or so it seems some days :)
> 
> Warner

Yep. So I do not think we will be reverting this change in QEMU.

-- 
MST


