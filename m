Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GObeE72/b2kOMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:47:41 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C148D1E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 18:47:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viCxx-00037J-B0; Tue, 20 Jan 2026 09:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viCxu-00035x-LA
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1viCxt-0006v6-3K
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 09:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768920255;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xy6jHBiqwRi90SjDEekXXmt5eB1Wm8KnZPHsHSU0iS0=;
 b=V4un1rp3lNu8i+WPXfHPMLy9WQprw1V9ppExu7phpLiqFSk6P1W4kHEyngRcEbfROCi8De
 maFb3es3VPVHhUVE/Ksd6NrkS4U+HKb8AahhJiT/IGt/93ErqOawlYfJMnlWbzRw2NbnZy
 xKxrnUfh50b/CVKAX2Mkx+oS2t80MJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-Ffu9svAxMXeOKBWI9nW2Mg-1; Tue,
 20 Jan 2026 09:44:12 -0500
X-MC-Unique: Ffu9svAxMXeOKBWI9nW2Mg-1
X-Mimecast-MFC-AGG-ID: Ffu9svAxMXeOKBWI9nW2Mg_1768920251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D91BB1800370; Tue, 20 Jan 2026 14:44:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 591A730001A8; Tue, 20 Jan 2026 14:44:09 +0000 (UTC)
Date: Tue, 20 Jan 2026 14:44:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] scripts: Allow sha512 in clean_functional_cache.py, too
Message-ID: <aW-UtVdnLwPUv7_H@redhat.com>
References: <20260120121849.131604-1-thuth@redhat.com>
 <aW985Eq4d70yEPpH@redhat.com>
 <4bee294c-e529-4e05-9bdb-48533aeff4f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bee294c-e529-4e05-9bdb-48533aeff4f9@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
X-Spamd-Result: default: False [-1.21 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.20)[mailman];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.gnu.org:rdns,lists.gnu.org:helo,instagram.com:url,libvirt.org:url,entangle-photo.org:url,berrange.com:url];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thuth@redhat.com,m:qemu-devel@nongnu.org,m:jsnow@redhat.com,m:philmd@linaro.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[berrange@redhat.com,qemu-devel-bounces@nongnu.org];
	FORWARDED(0.00)[qemu-devel@nongnu.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	HAS_REPLYTO(0.00)[berrange@redhat.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[berrange@redhat.com,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: F07C148D1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:10:34PM +0100, Thomas Huth wrote:
> On 20/01/2026 14.02, Daniel P. Berrangé wrote:
> > On Tue, Jan 20, 2026 at 01:18:49PM +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > The functional testing frameworks also supports assets that are
> > > identified by their sha512 checksum (instead of only using sha25),
> > > and at least one of the tests (tests/functional/ppc64/test_fadump.py)
> > > is already using such a checksum, so adjust the clean_functional_cache
> > > script to support these checksums, too.
> > 
> > I wrote this code to match what we had in Avocado, but now I'm really
> > struggling to justify why we should choose different checksum algorithms
> > per asset. With only 1 test diverging from sha256, I'd rather we just
> > dropped sha512 support
> 
> Fine for me, too ... could you suggest a patch, or want me to do it?

I'll let you do it

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


