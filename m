Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BDC15231
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 15:22:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkZ0-0006rD-KC; Tue, 28 Oct 2025 10:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDkYf-0006ol-NV
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDkYY-00023E-Sj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761661205;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xbQK3vtw6oGGXXV9+YfpCztC/anqY5sPum9Q9WRftak=;
 b=Ec/J/ATzYiy8ar1QOBD8cGVgfAPUOqCVtJ0ykuq6q46Ssd1vDT35/yFfs3NVUbOZRo5SCn
 mIYhNeI/Tzogg9uKFAUQQzmC0qOWj0duBcKd3vum2Rz+znXSD9YW5rG0gz+EyyecIJQYJO
 j2EskYTcxpGwOn1x/76DaQ4vI4udIjg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-XY-o1LG_PB6L6_FrVkLoPw-1; Tue,
 28 Oct 2025 10:20:00 -0400
X-MC-Unique: XY-o1LG_PB6L6_FrVkLoPw-1
X-Mimecast-MFC-AGG-ID: XY-o1LG_PB6L6_FrVkLoPw_1761661199
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D92E21956096; Tue, 28 Oct 2025 14:19:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18B1D1800353; Tue, 28 Oct 2025 14:19:55 +0000 (UTC)
Date: Tue, 28 Oct 2025 14:19:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 7/9] chardev/char: Preserve %errno in qemu_chr_write()
Message-ID: <aQDRCOXmeKAmyGeL@redhat.com>
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-8-philmd@linaro.org>
 <CAJ+F1CJj+00rCtuNkpSfcFN5Amvbe_JiKAXQ8XnBcOHcL5Duaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJj+00rCtuNkpSfcFN5Amvbe_JiKAXQ8XnBcOHcL5Duaw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 06:00:33PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Oct 22, 2025 at 7:10 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
> >
> > qemu_chr_write() dispatches to ChardevClass::chr_write(),
> > and is expected to propagate the backend error, not some
> > unrelated one produce by "best effort" logfile or replay.
> > Preserve and return the relevant %errno.
> 
> Indeed.. imho we should avoid using errno, it's too easy to clutter.
> Even qemu mutex, which may use trace, may change it...
> 
> patch lgtm anyway
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Given you say 'qemu mutex, which may use trace, may change it...'
then surely this patch is broken....


> > @@ -154,6 +156,7 @@ static int qemu_chr_write_buffer(Chardev *s,
> >           */
> >          qemu_chr_write_log(s, buf, len);
> >      }
> > +    errno = saved_errno;
> >      qemu_mutex_unlock(&s->chr_write_lock);

^^^ This mutex_unlock call may clobber 'errno' that we've just tried
to restore.

> >
> >      return res;

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


