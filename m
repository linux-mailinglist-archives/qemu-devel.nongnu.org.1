Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4C7E9B87
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:57:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2VXR-0000z3-GZ; Mon, 13 Nov 2023 06:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2VXN-0000yn-75
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r2VXJ-0001j9-QO
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699876524;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9953VO21WxY6UG1pQbrmWIQpBssmHOr8kZnVbAOJ+3Q=;
 b=dBYgYzn7niavUJcjJOcdz2IvhgI3RrT3uiX1gzcPobMMu6ElGIt56n/ZL36T7132c9g31e
 twwHYIalSTnlGGzzMTGI0FDSywtbCoIaxzZ9Q3BC0laEGuEiMPCX2Fb9xexrpMHU/MFNnG
 M8l7/Hapv6u4BMorxuNVvJ5laLNTunI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-qhmZ86dqOWWEmS38zkdzhQ-1; Mon,
 13 Nov 2023 06:55:21 -0500
X-MC-Unique: qhmZ86dqOWWEmS38zkdzhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C2941C18CC2;
 Mon, 13 Nov 2023 11:55:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A8831121306;
 Mon, 13 Nov 2023 11:55:19 +0000 (UTC)
Date: Mon, 13 Nov 2023 11:55:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PULL 21/38] plugins: update lockstep to use g_memdup2
Message-ID: <ZVIOpZNbIEw6FKYR@redhat.com>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
 <20230703134427.1389440-22-alex.bennee@linaro.org>
 <91b491ca-5600-4272-b694-37d6c8ba2a90@redhat.com>
 <87r0ktyj8d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r0ktyj8d.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 13, 2023 at 11:40:18AM +0000, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 03/07/2023 15.44, Alex Bennée wrote:
> >> The old g_memdup is deprecated, use the replacement.
> >> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> Message-Id: <20230630180423.558337-22-alex.bennee@linaro.org>
> >> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> >> index e36f0b9562..3614c3564c 100644
> >> --- a/contrib/plugins/lockstep.c
> >> +++ b/contrib/plugins/lockstep.c
> >> @@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
> >>           }
> >>       }
> >>       divergence_log = g_slist_prepend(divergence_log,
> >> -                                     g_memdup(&divrec, sizeof(divrec)));
> >> +                                     g_memdup2(&divrec, sizeof(divrec)));
> >>         /* Output short log entry of going out of sync... */
> >>       if (verbose || divrec.distance == 1 || diverged) {
> >
> > FYI, this seems to trigger a compiler warning on Ubuntu 20.04:
> >
> > https://app.travis-ci.com/github/huth/qemu/jobs/613144955#L1914
> 
> Isn't 20.04 outside of our support range now? Otherwise we could add a
> helper to glib-compat.

We're still in the 2 year overlap since 22.04 was released, so 20.04 will
remain a target until April next year.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


