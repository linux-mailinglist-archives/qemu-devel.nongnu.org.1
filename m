Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36794B1A09E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Aug 2025 13:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitSa-0003hf-4A; Mon, 04 Aug 2025 07:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uitSC-0003OO-WB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uitSA-0008Ed-Jz
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754307243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilgD5Zz0ngSgLt/RoTpHFnRGqtmSqoGg/dDNBPn5N1k=;
 b=IH23ejjGupYHTQg+pChtLKm1YiN/u5zxQTvJvYAJfkcffCQIruUJZvv/m+LH+nPn+b2HBA
 NmOXsNGlKmLVOmD5eL/vPu+UZVMHfPBRJHp6X/e4ibbyJL8BGye0aewiBKps+WiNuVNjML
 miTRwgGtmPvKY1FII24ZA4zxs2yy4/0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-MQY3lX6EPBuVGX6psz6SBQ-1; Mon,
 04 Aug 2025 07:34:01 -0400
X-MC-Unique: MQY3lX6EPBuVGX6psz6SBQ-1
X-Mimecast-MFC-AGG-ID: MQY3lX6EPBuVGX6psz6SBQ_1754307240
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68CDF1800349; Mon,  4 Aug 2025 11:34:00 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.203])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B79C518003FC; Mon,  4 Aug 2025 11:33:56 +0000 (UTC)
Date: Mon, 4 Aug 2025 13:33:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Martin Kletzander <mkletzan@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, werner@suse.de
Subject: Re: [PATCH 2/2] tests/qemu-iotests: Indent expected error messages
Message-ID: <aJCaoULvGgKjEL16@redhat.com>
References: <cover.1754060086.git.mkletzan@redhat.com>
 <f5be6d407c105fa199d10867f5de48bbd25c008c.1754060086.git.mkletzan@redhat.com>
 <aIzhtcg-TNZE0zH8@redhat.com> <87v7n63lld.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7n63lld.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 01.08.2025 um 21:09 hat Fabiano Rosas geschrieben:
> Daniel P. Berrang� <berrange@redhat.com> writes:
> 
> > On Fri, Aug 01, 2025 at 04:59:50PM +0200, Martin Kletzander wrote:
> >> From: Martin Kletzander <mkletzan@redhat.com>
> >> 
> >> When running all tests the expected "killed" messages are indented
> >> differently than the actual ones, by three more spaces.  Change it so
> >> that the messages match and tests pass.
> >
> > This would break the tests on my system and CI too.
> >
> > What distro are you seeing this on ?
> >
> > I'm guessing this is a different in either valgrind or C library ?
> 
> It's bash, we have an open issue about it:
> 
> https://gitlab.com/qemu-project/qemu/-/issues/3050

I see a patch has been posted to that bug, the most important part of
which is this added filtering:

--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter  2025-07-25 11:39:22.419665788 +0000
@@ -75,7 +75,7 @@ _filter_qemu_io()
     _filter_win32 | \
     gsed -e "s/[0-9]* ops\; [0-9/:. sec]* ([0-9/.inf]* [EPTGMKiBbytes]*\/sec and [0-9/.inf]* ops\/sec)/X ops\; XX:XX:XX.X (XXX YYY\/sec and XXX ops\/sec)/" \
         -e "s/: line [0-9][0-9]*:  *[0-9][0-9]*\( Aborted\| Killed\)/:\1/" \
-        -e "s/qemu-io> //g"
+        -e "s/qemu-io> //g" -e '/Killed/{ s/ \{2,\}/ /}'
 }

 # replace occurrences of QEMU_PROG with "qemu"

This approach makes sense to me, though I would have kept each sed
expression on a separate line.

And given that the context line above includes "Aborted" as well, maybe
have it here, too, though none of the actual test outputs have an
Aborted message any more since commit 3f39447. Or we could have a
cleanup patch first that removes the unused "Abort" above, just to keep
things consistent.

Either way, please post this as a proper patch on the mailing list.

Kevin


