Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302EAD05FA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Jun 2025 17:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZIj-0008Vy-6p; Fri, 06 Jun 2025 11:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNZIg-0008Vj-4R
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNZIe-0002hu-G4
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749224887;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ScYKysA/aFPDA/diWe5BA2GYW1b333PRuX+VsYidxVA=;
 b=eipbr69ZAu3YoBblPxeopJRYi8cAh5K4P3ZNaEqpl3AjvSbciPYyOG89EiFJD4mSzhImTO
 Vt/XkGrg54+g/c6ycwGhYCbgUq45dfxERjh8hOXN4gP1AP3oco6DN0fEJHs5ZAvv2rqzvP
 WDqYpkFL9gQI+IYIiV5dnta3ajaideM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-QdcsKXj4PIeiWaTC_GJoXg-1; Fri,
 06 Jun 2025 11:48:04 -0400
X-MC-Unique: QdcsKXj4PIeiWaTC_GJoXg-1
X-Mimecast-MFC-AGG-ID: QdcsKXj4PIeiWaTC_GJoXg_1749224883
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46751180883C; Fri,  6 Jun 2025 15:48:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3853618002BA; Fri,  6 Jun 2025 15:47:58 +0000 (UTC)
Date: Fri, 6 Jun 2025 16:47:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Message-ID: <aEMNq8QveADZ_kD0@redhat.com>
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <87plfhvvig.fsf@suse.de>
 <9da21b91-3e4c-4a74-8e90-6d70eadf314c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9da21b91-3e4c-4a74-8e90-6d70eadf314c@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jun 06, 2025 at 09:48:41AM -0500, JAEHOON KIM wrote:
> 
> On 6/6/2025 8:40 AM, Fabiano Rosas wrote:
> > Jaehoon Kim<jhkim@linux.ibm.com> writes:
> > 
> > > When the source VM attempts to connect to the destination VM's Unix
> > > domain socket(cpr.sock) during CPR transfer, the socket file might not
> > > yet be exist if the destination side hasn't completed the bind
> > > operation. This can lead to connection failures when running tests with
> > > the qtest framework.
> > > 
> > Could you provide us the output of qtest in this case? Are you simply running
> > make check or something else?
> 
> Yes, I'm simply running 'make check-qtest-s390x'.
> 
> Here's the qtest output from the failure:
>  # {
>  #     "error": {
>  #         "class": "GenericError",
>  #         "desc": "Failed to connect to '/tmp/migration-test-ZC7Z72/cpr.sock': No such file or directory"
>  #     }
>  # }
>  not ok /s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1453:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
>  Bail out!

So this is showing a failure when using

  $QEMU -incoming cpr:...address...

as opposed to

  $QEMU -incoming cpr:defer

I presume in the former case, the test is spawning QEMU, but the startup
of QEMU & its listening on the UNIX socket is not synchronized with the
parent process.

In the latter case usnig 'defer', listening will be synchronized by the
QMP command used to setup the incoming socket.


So why do we see a race with "-incoming cpr:..address", but not
with a traditional "-incoming ...address.." for non-CPR code ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


