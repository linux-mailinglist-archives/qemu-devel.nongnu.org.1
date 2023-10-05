Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC17BA95E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:47:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTMG-0001VK-Tw; Thu, 05 Oct 2023 14:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTM1-0000rq-Ue
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qoTLx-00064D-50
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696531540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uP40ewYxg2w56dpEV1j0/VclathwZfaG9KOKZwewGE=;
 b=QeUGp3SSCsJOfLj+kUa+eVqnW3lPYm68wBziabpsRNrt5QHPPnmc6cVeX1ITOStVG9fIZY
 KtKw1Aic7W2RXyw4BzjOOlKBIKlhN/8FNoD0CuSRnivWIA4Ner/s9T/pQ4cv+hleBfSEwR
 SRbrUbnHXuQitMuLWwcreE8BrtC9wxU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-xRwss8MIM3Sa4LWfLdcNyA-1; Thu, 05 Oct 2023 14:45:27 -0400
X-MC-Unique: xRwss8MIM3Sa4LWfLdcNyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E7403811F20;
 Thu,  5 Oct 2023 18:45:26 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E00E1215670B;
 Thu,  5 Oct 2023 18:45:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/15] maint: Tweak comments in mailmap regarding SPF
Date: Thu,  5 Oct 2023 13:44:49 -0500
Message-ID: <20231005184447.682556-19-eblake@redhat.com>
In-Reply-To: <20231005184447.682556-17-eblake@redhat.com>
References: <20231005184447.682556-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Documenting that we should not add new lines to work around SPF
rewrites sounds foreboding; the intent is instead that new lines here
are okay, but indicate a second problem elsewhere in our build process
that we should also consider fixing at the same time, to keep the
section from growing without bounds.  While we have been doing that
for qemu-devel for a while, we jut recently fixed that for qemu-block:
https://git.linaro.org/people/pmaydell/misc-scripts.git/commit/?id=f9a317392

Mentioning DMARC alongside SPF may also help people grep for this
scenario, as well as documenting the 'git config' workaround that can
be used by submitters to avoid the munging issue in the first place.

Note the subtlety: 'git commit' sets authorship information based on
user.name and user.email (where name is usually unquoted); while 'git
send-email' includes a body 'From:' line only when sendemail.from is
present but differs from authorship information.  Hence the use of
quotes in sendemail.from (not a semantic change to email, but enough
of a difference to add the body 'From:').

Fixes: 3bd2608d ("maint: Add .mailmap entries for patches claiming list authorship")
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230927143815.3397386-7-eblake@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 .mailmap | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 04a7feb005b..fadf6e74506 100644
--- a/.mailmap
+++ b/.mailmap
@@ -40,7 +40,19 @@ Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
 # for the cvs2svn initialization commit e63c3dc74bf.

 # Next, translate a few commits where mailman rewrote the From: line due
-# to strict SPF, although we prefer to avoid adding more entries like that.
+# to strict SPF and DMARC.  Usually, our build process should be flagging
+# commits like these before maintainer merges; if you find the need to add
+# a line here, please also report a bug against the part of the build
+# process that let the mis-attribution slip through in the first place.
+#
+# If the mailing list munges your emails, use:
+#   git config sendemail.from '"Your Name" <your.email@example.com>'
+# the use of "" in that line will differ from the typically unquoted
+# 'git config user.name', which in turn is sufficient for 'git send-email'
+# to add an extra From: line in the body of your email that takes
+# precedence over any munged From: in the mail's headers.
+# See https://lists.openembedded.org/g/openembedded-core/message/166515
+# and https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06784.html
 Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
 Ian McKellar <ianloic@google.com> Ian McKellar via Qemu-devel <qemu-devel@nongnu.org>
 Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
-- 
2.41.0


