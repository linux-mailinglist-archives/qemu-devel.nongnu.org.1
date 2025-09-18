Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4DB80998
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuAB-00078j-6r; Wed, 17 Sep 2025 11:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyuA5-000783-KX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyuA3-0003DJ-B6
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758123214;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ew2COTqYj9my89kDvlcJmVvel1h0MKChoM8bwKGPRY0=;
 b=E95JlB/pvR0H1fmHoFU/eS7uUm12WJK2UA5xvCbYkVAXrdqUiZuYoR1LtJsSX0DZVLO0fq
 zHVwiepKJAKONuVXz1gsEKDi4RRhM7Am9HcBjM1H6cSVVBV6TwBGYOHILC5aOHhkEFD94W
 /mmSnb26svrEe7M3nOJvzrOE7eQNRRM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-A_o0bkV5PZqDz8gg1galPw-1; Wed,
 17 Sep 2025 11:33:20 -0400
X-MC-Unique: A_o0bkV5PZqDz8gg1galPw-1
X-Mimecast-MFC-AGG-ID: A_o0bkV5PZqDz8gg1galPw_1758123199
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB71119560B2; Wed, 17 Sep 2025 15:33:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC6130001B5; Wed, 17 Sep 2025 15:33:08 +0000 (UTC)
Date: Wed, 17 Sep 2025 16:33:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 08/20] log: avoid repeated prefix on incremental
 qemu_log calls
Message-ID: <aMrUrca-L89L-TbP@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-9-berrange@redhat.com>
 <87wm5x2mov.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wm5x2mov.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 17, 2025 at 04:11:44PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Some code makes multiple qemu_log calls to incrementally emit
> > a single message. Currently timestamps get prepended to all
> > qemu_log calls, even those continuing a previous incomplete
> > message.
> >
> > This changes the qemu_log so it skips adding a new line prefix,
> > if the previous qemu_log call did NOT end with a newline.
> >
> 
> Have you considered
> 
>   Fixes: 012842c07552 (log: make '-msg timestamp=on' apply to all qemu_log usage)
> 
> ?
> 
> > Reported-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/log.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/util/log.c b/util/log.c
> > index abdcb6b311..2642a55c59 100644
> > --- a/util/log.c
> > +++ b/util/log.c
> > @@ -143,6 +143,12 @@ void qemu_log_unlock(FILE *logfile)
> >      }
> >  }
> >  
> > +/*
> > + * 'true' if the previous log message lacked a trailing '\n',
> > + * and thus the subsequent call must skip any prefix
> > + */
> > +static __thread bool incomplete;
> 
> Thread-local only because we have @log_per_thread, isn't it?

Pretty much. If you're not using log_per_thread, then code which
incrementally emits a single line using multiple qemu_log calls
is doomed in a concurrency sitation, but this __thread at least
doesn't make the situation worse than it already is.

> 
> > +
> >  void qemu_log(const char *fmt, ...)
> >  {
> >      FILE *f;
> > @@ -154,7 +160,7 @@ void qemu_log(const char *fmt, ...)
> >       * was emitted if we are delayed acquiring the
> >       * mutex
> >       */
> > -    if (message_with_timestamp) {
> > +    if (message_with_timestamp && !incomplete) {
> >          g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> >          timestr = g_date_time_format_iso8601(dt);
> >      }
> > @@ -170,6 +176,7 @@ void qemu_log(const char *fmt, ...)
> >          va_start(ap, fmt);
> >          vfprintf(f, fmt, ap);
> >          va_end(ap);
> > +        incomplete = fmt[strlen(fmt) - 1] != '\n';
> >          qemu_log_unlock(f);
> >      }
> >  }
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


