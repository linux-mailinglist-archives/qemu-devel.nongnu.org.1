Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25375B2DA9B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 13:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uogkE-0004y5-6m; Wed, 20 Aug 2025 07:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogk9-0004xY-Tm
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uogk7-0000eC-3m
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755688351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KItwXQGBngwiBsV5NFrGzwH4Wlt+6Q/lLle1noSPPb0=;
 b=f6gUXjE2EyjnyHbPLtX+bOkhbnRd7ZSdkSziZCE/3NUvl4gYHVgL4L6/fb39chhSbofjFl
 BHMsBv6okTUGTgHoM0R9gu4FHdUb6iHXpbyDc0U83TUlZAm/uV3myxqNGq9lJBXOVUmMQh
 ZJEdgzg9+Y4YR5kmV41kav84lEVuQpM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-egURKCgsOB2o-LdgPgisoA-1; Wed,
 20 Aug 2025 07:12:27 -0400
X-MC-Unique: egURKCgsOB2o-LdgPgisoA-1
X-Mimecast-MFC-AGG-ID: egURKCgsOB2o-LdgPgisoA_1755688346
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B6A180035C; Wed, 20 Aug 2025 11:12:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 772BC1800294; Wed, 20 Aug 2025 11:12:25 +0000 (UTC)
Date: Wed, 20 Aug 2025 12:12:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/12] util: convert error-report & log to message API
 for timestamp
Message-ID: <aKWtleZB4fqAzuhc@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-9-berrange@redhat.com>
 <ac90c3c6-64ae-4abf-a850-59c862400b89@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac90c3c6-64ae-4abf-a850-59c862400b89@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 20, 2025 at 08:02:14AM +1000, Richard Henderson wrote:
> On 8/20/25 06:27, Daniel P. Berrangé wrote:
> >   void qemu_log(const char *fmt, ...)
> >   {
> >       FILE *f;
> > -    g_autofree const char *timestr = NULL;
> > -
> >       /*
> > -     * Prepare the timestamp*outside* the logging
> > -     * lock so it better reflects when the message
> > -     * was emitted if we are delayed acquiring the
> > -     * mutex
> > +     * Prepare the context*outside* the logging
> > +     * lock so any timestamp better reflects when
> > +     * the message was emitted if we are delayed
> > +     * acquiring the mutex
> >        */
> > -    if (message_with_timestamp) {
> > -        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
> > -        timestr = g_date_time_format_iso8601(dt);
> > -    }
> 
> Something that really ought to be handled better is that we currently use
> qemu_log to print pieces of a larger message.  E.g. looping over the general
> registers to print the whole cpu state.
> 
> (1) We don't want timestamps in the middle, and
> (2) we don't want unnecessary memory allocation in the middle.

Interestingly I found that for CPU_LOG_TB_CPU we don't use the qemu_log()
function at all. TCG calls qemu_log_try_lock() to acquire the raw FILE *
handle and writes directly to it, so we miss all prefix info entirely.
If other parts of QEMU that do big multi-line log dumps do the same,
then we're ok.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


