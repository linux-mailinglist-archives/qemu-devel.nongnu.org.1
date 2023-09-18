Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A07A494D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:11:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiD5O-0007ME-NA; Mon, 18 Sep 2023 08:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiD5L-0007M0-W5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qiD5K-0001iK-Dc
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695039037;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Di1DbymDlRuVr74aSXrGgFG7BrXnrGaVV92M3e3e9qg=;
 b=EFuaw+OMKMfSbtE1D6Pbevr1PnAJ9BynTj60zXr4qGSpO+6lrVeFSWzpvXoTk+DFuRlbup
 gqhb+sAyq6JoXqoptqu+HvsfDvwTfIrytngeXWpfP67QWL5AJmtj14D2sPmuqdF6ystIU7
 dy1cJ77IUAJPUcn+p1UsxQ0wvzWMkQ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563--Q7N5OjAMgWciZst-nBeig-1; Mon, 18 Sep 2023 08:10:36 -0400
X-MC-Unique: -Q7N5OjAMgWciZst-nBeig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B05229AA3B0;
 Mon, 18 Sep 2023 12:10:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1D110D14C7;
 Mon, 18 Sep 2023 12:10:34 +0000 (UTC)
Date: Mon, 18 Sep 2023 13:10:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 qemu 0/3] Allow dump-guest-memory to output standard
 kdump format
Message-ID: <ZQg+NzzKrigE0rG0@redhat.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 13, 2023 at 06:03:12PM -0700, Stephen Brennan wrote:
> Hello all,
> 
> This is the second version of my patch series about the kdump format,
> you can see the first version here [1].
> 
> The current output format for dump-guest-memory's kdump compressed
> format is actually the "makedumpfile flattened" format. It was done
> intentionally to allow the flexibility to write to non-seekable file
> descriptors, like pipes [2], without using temporary files. Currently
> libvirt uses this ability when VIR_DUMP_BYPASS_CACHE flag is set, to
> avoid the dump process using page cache. The standard kdump output
> format needs the page cache so that it can seek back and forth as part
> of writing the dump file.
> 
> So the default kdump dump format cannot be changed to the standard
> format. This patch series adds the ability to use the standard format,
> and adds a QMP / HMP argument to enable it.
> 
> An open question for Daniel et al.:
> 
> Would it be possible to make flattened the default only for libvirt? I
> totally agree that this would be a bad backward incompatible change
> there. But for QMP / HMP commands, I think using the standard, broadly
> compatible format as the default is important for user friendliness. If
> a user needs to know the difference between flavors of kdump formats
> like the flattened format, in order to set the correct option, then
> we've already lost.

The default is 'elf' - any use of kdump formats is already an opt-in,
and with the new kdump variants represented as enums, the user can
just specify which they want explicitly.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


