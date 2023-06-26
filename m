Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A96B173DB7D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDidx-00044j-VQ; Mon, 26 Jun 2023 05:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDidv-000447-ID
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDidt-0002WY-QR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687772176;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+N44F6EbeW+cGZH7sx27tkQENl/aJfEu6zVzxCzFOx4=;
 b=Hi1gQUBjgMJx4NuRAq7In2mcTNd2fYNT8NtokcwU7ks76A7ayl2hFrAmT0bV7lKwa3dAhe
 oCFRu57Ah0L3mr3Uzt8CLcLDg7Z2c1jElH2SRtBcQnTpwBN7fXL3Zk+K73lau5NY9HT86m
 dB/tZcdoplIcpgDfpFUahDfaoJxmp1Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-ulByWGVJMmqobPFopcfVnQ-1; Mon, 26 Jun 2023 05:36:13 -0400
X-MC-Unique: ulByWGVJMmqobPFopcfVnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74F358CC203
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:36:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 167FC40C6F5A;
 Mon, 26 Jun 2023 09:36:13 +0000 (UTC)
Date: Mon, 26 Jun 2023 10:36:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] target/i386: allow using named CPU modeles with
 user mode emulation
Message-ID: <ZJlcC0Qd7v71yuJm@redhat.com>
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <ZJlYbXKwd4SxoaxY@redhat.com>
 <CABgObfa2ft-j0CdDyV78awrKu1nowXDSVxeqtQoFG_+qOp=6tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa2ft-j0CdDyV78awrKu1nowXDSVxeqtQoFG_+qOp=6tw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jun 26, 2023 at 11:27:54AM +0200, Paolo Bonzini wrote:
> On Mon, Jun 26, 2023 at 11:20 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > - for qemu-i386, the issue is that this emulator is restricted to running
> > >   programs on a 32-bit processor, even though it is actually emulating
> > >   programs that use the 32-bit kernel ABI on any processor.  The behavior
> > >   the processor in compatibility (32-bit CS, EFER.LMA=1) mode is mostly
> > >   the same as when EFER.LMA=0 and the little code that is needed to handle
> > >   64-bit ring-0 is even present in the qemu-i386 binary, just hidden
> > >   behind checks for HF_LMA_MASK.  So, LM can also be treated as a feature
> > >   that is only relevant in kernel mode; not entirely, so this cannot yet
> > >   be extended to bsd-user, but the required changes are minimal.
> >
> > IMHO in this case we should hard block all named CPUs with
> > 'lm' set from qemu-i386. It only makes sense to use named CPU
> > models that were actually from the 32-bit era with qemu-i386.
> >
> > If someone wants Nehalem then they should be using qemu-x86_64.
> > If someone wants qemu-i386 then they should be using an older
> > named CPU model predating 'lm'.
> 
> What you write is true for qemu-system-*, but the problem is that
> qemu-user binaries are only able to run one ELF target. qemu-x86_64 is
> not able to run i386 binaries, unlike a 64-bit kernel; and that's
> really intrinsic in the design of qemu-user because implementing
> multiple ABIs (including multiple definitions of structs and syscall
> numbers) would require compiling the same files multiple times.

Oh, right, yes, ignore my comment.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


