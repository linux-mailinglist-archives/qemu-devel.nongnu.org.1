Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EBF70D4C4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MHh-0003Lp-AO; Tue, 23 May 2023 03:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1MHe-0003LS-5X
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1MHc-0001IT-6n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684826290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+Cjv9CsSltHAOzTmWHC+ps8z9YBN+ChG2RBm/KOMew=;
 b=XZ3M8QSlXRSvnxLxfSjzOqUKk9UJ2d7PhVa2JmXSojhOFWOKDpV7Re3vmEJBcwaR0MSdzc
 mvG88WyBkqBd5ivbfBJ5NF/41zEqlgbb2oFLEAcoF1CpOzGPmsNRSyZR3UL3RJRknZXLsE
 Lk1m743VtHA8N8j3pYeMpzt4JX9i6i4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-_CkmEx7RNIWK_ht6hKoouA-1; Tue, 23 May 2023 03:18:06 -0400
X-MC-Unique: _CkmEx7RNIWK_ht6hKoouA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 096BF29AB40E;
 Tue, 23 May 2023 07:18:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A50840C6CCF;
 Tue, 23 May 2023 07:18:03 +0000 (UTC)
Date: Tue, 23 May 2023 08:18:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 7/8] python/qemu: allow avocado to set logging name space
Message-ID: <ZGxoqSumgqphaqY3@redhat.com>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
 <20230518162034.1277885-8-alex.bennee@linaro.org>
 <CAFn=p-YLTqv6bQGi9xFeZ1fCw71EdqiTLw2xv2yWnJmWfzw+vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-YLTqv6bQGi9xFeZ1fCw71EdqiTLw2xv2yWnJmWfzw+vQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, May 18, 2023 at 04:15:03PM -0400, John Snow wrote:
> On Thu, May 18, 2023 at 12:20 PM Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Since the update to the latest version Avocado only automatically
> > collects logging under the avocado name space. Tweak the QEMUMachine
> > class to allow avocado to bring logging under its name space. This
> > also allows useful tricks like:
> >
> >   ./avocado --show avocado.qemu.machine run path/to/test
> >
> > if you want to quickly get the machine invocation out of a test
> > without searching deeply through the logs.
> >
> 
> Huh. That's kind of weird though, right? Each Python module is
> intended to log to its own namespace by design; it feels like Avocado
> really ought to have configuration options that allows it to collect
> logging from other namespaces. I'm not against this patch, but if for
> instance I wind up splitting qemu.machine out as a separate module
> someday (like I did to qemu.qmp), then it feels weird to add options
> specifically for fudging the logging hierarchy.

I'd consider this a regression in Avocado. Logging should log
everything from any module by default. Avocado should not presume
that users are only interested in Avocado's own namespace. The
namespaces used by the individuals test are more interesting to
users of Avocado IMHO.

> Also, what about the QMP logging? I don't suppose this will trickle
> down to that level either.
> 
> Worried this is kind of incomplete.

Agreed, I'd push this back onto Avocado to fix the regression.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


