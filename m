Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A07AF56B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEsG-0007t5-TP; Tue, 26 Sep 2023 16:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlEsE-0007st-O5
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qlEsD-0002up-1V
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695760896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EbdztlSZn+Pz0TIkzhyLScFk7wNq8KfhwBOoWhkoVnM=;
 b=IDHiiB0CsrucvAfxcjzQWJ4AFnzcOMww6CpVFHO8JsHeJp/Qwd2N0XM2k8lh+YEkk/Fal3
 Ya/kKBPW9ZnxvF1bqjEhWW4b3sLs4SPh59UpMTuqOLWKLpIM/HiDcHVrnualcyv8Rd7BJ7
 a2oodw8mbt48blFjrjX6hUVTNtu/Jr4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-4LKw7lWoM0yjw_T6WFssMw-1; Tue, 26 Sep 2023 16:41:32 -0400
X-MC-Unique: 4LKw7lWoM0yjw_T6WFssMw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E592338008BA;
 Tue, 26 Sep 2023 20:41:31 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FC7B492C37;
 Tue, 26 Sep 2023 20:41:31 +0000 (UTC)
From: eblake@redhat.com
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] maint: Tweak comment in mailmap to sound friendlier
Date: Tue, 26 Sep 2023 15:39:47 -0500
Message-ID: <20230926203946.3303600-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Documenting that we should not add new lines to work around SPF
rewrites sounds foreboding; the intent is instead that new lines here
are okay, but indicate a second problem elsewhere in our build process
that we should also consider fixing at the same time, to keep the
section from growing without bounds.

Mentioning DMARC alongside SPF may also help people grep for this
scenario, as well as documenting the 'git config' workaround that can
be used by submitters to avoid the munging issue in the first place.

Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

I'm sending this email with a temporary 'git config sendemail.from
eblake@redhat.com', to see if the added advice actually adds the extra
line. It did not show up in my editor window, though, so this patch
may need further tweaking to get the instructions right.  Since I
don't normally suffer from SPF/DMARC munging, I may not be the best
person to test the right workaround.  Or maybe 'git config' does not
yet have the right workaround already available as a turnkey solution
we can suggest.

 .mailmap | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 64ef9f4de6f..6fb8202715a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -40,7 +40,16 @@ Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
 # for the cvs2svn initialization commit e63c3dc74bf.

 # Next, translate a few commits where mailman rewrote the From: line due
-# to strict SPF, although we prefer to avoid adding more entries like that.
+# to strict SPF and DMARC.  Usually, our build process should be flagging
+# commits like these before maintainer merges; if you find the need to add
+# a line here, please also report a bug against the part of the build
+# process that let the mis-attribution slip through in the first place.
+#
+# If the mailing list munges your emails, consider using something like
+# 'git config --global sendemail.from your.email@example.com'
+# to add an extra From: line in the body of your email that takes
+# precedence over any munged From: in the mail's headers.
+# See https://lists.openembedded.org/g/openembedded-core/message/166515
 Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
 Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
-- 
2.41.0


