Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67264ADABD7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 11:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR65N-0002lE-QB; Mon, 16 Jun 2025 05:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR63N-0000Ou-8N
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uR63J-0005Ii-Vk
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750065771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiIK4Ng2NUigzAsQEhP3LzUekXkRimZT+fiVxrWmEJk=;
 b=QUSuN0oMX9jfkZp0GiZ5WJjvgcuLoSFRfUO3suqEBRbww3lYrUnixraygJjoUXuGfDIWrS
 nGnUDJoa0kaM+5b8n/RGxdX20/esQDDdc8s93SnnTD2AAds6tJfYdOeKqBI1CON0eG6ENG
 W3Dje2rjzfIFYDt6DGVgOmRvRf07zL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177--UT4I0qINQ63Wy8q6F-XHg-1; Mon,
 16 Jun 2025 05:22:48 -0400
X-MC-Unique: -UT4I0qINQ63Wy8q6F-XHg-1
X-Mimecast-MFC-AGG-ID: -UT4I0qINQ63Wy8q6F-XHg_1750065766
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4511808984; Mon, 16 Jun 2025 09:22:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 995D030044D8; Mon, 16 Jun 2025 09:22:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA80321E6924; Mon, 16 Jun 2025 11:22:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 1/3] docs: introduce dedicated page about code provenance /
 sign-off
Date: Mon, 16 Jun 2025 11:22:39 +0200
Message-ID: <20250616092241.212898-2-armbru@redhat.com>
In-Reply-To: <20250616092241.212898-1-armbru@redhat.com>
References: <20250616092241.212898-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Currently we have a short paragraph saying that patches must include
a Signed-off-by line, and merely link to the kernel documentation.
The linked kernel docs have a lot of content beyond the part about
sign-off an thus are misleading/distracting to QEMU contributors.

This introduces a dedicated 'code-provenance' page in QEMU talking
about why we require sign-off, explaining the other tags we commonly
use, and what to do in some edge cases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/code-provenance.rst    | 230 ++++++++++++++++++++++++++++++
 docs/devel/index-process.rst      |   1 +
 docs/devel/submitting-a-patch.rst |  23 +--
 3 files changed, 233 insertions(+), 21 deletions(-)
 create mode 100644 docs/devel/code-provenance.rst

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
new file mode 100644
index 0000000000..95b2dd34e2
--- /dev/null
+++ b/docs/devel/code-provenance.rst
@@ -0,0 +1,230 @@
+.. _code-provenance:
+
+Code provenance
+===============
+
+Certifying patch submissions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The QEMU community **mandates** all contributors to certify provenance of
+patch submissions they make to the project. To put it another way,
+contributors must indicate that they are legally permitted to contribute to
+the project.
+
+Certification is achieved with a low overhead by adding a single line to the
+bottom of every git commit::
+
+   Signed-off-by: YOUR NAME <YOUR@EMAIL>
+
+The addition of this line asserts that the author of the patch is contributing
+in accordance with the clauses specified in the
+`Developer's Certificate of Origin <https://developercertificate.org>`__:
+
+.. _dco:
+
+  Developer's Certificate of Origin 1.1
+
+  By making a contribution to this project, I certify that:
+
+  (a) The contribution was created in whole or in part by me and I
+      have the right to submit it under the open source license
+      indicated in the file; or
+
+  (b) The contribution is based upon previous work that, to the best
+      of my knowledge, is covered under an appropriate open source
+      license and I have the right under that license to submit that
+      work with modifications, whether created in whole or in part
+      by me, under the same open source license (unless I am
+      permitted to submit under a different license), as indicated
+      in the file; or
+
+  (c) The contribution was provided directly to me by some other
+      person who certified (a), (b) or (c) and I have not modified
+      it.
+
+  (d) I understand and agree that this project and the contribution
+      are public and that a record of the contribution (including all
+      personal information I submit with it, including my sign-off) is
+      maintained indefinitely and may be redistributed consistent with
+      this project or the open source license(s) involved.
+
+The name used with "Signed-off-by" does not need to be your legal name, nor
+birth name, nor appear on any government ID. It is the identity you choose to
+be known by in the community, but should not be anonymous, nor misrepresent
+whom you are.
+
+It is generally expected that the name and email addresses used in one of the
+``Signed-off-by`` lines, matches that of the git commit ``Author`` field.
+It's okay if you subscribe or contribute to the list via more than one
+address, but using multiple addresses in one commit just confuses
+things.
+
+If the person sending the mail is not one of the patch authors, they are
+nonetheless expected to add their own ``Signed-off-by`` to comply with the
+DCO clause (c).
+
+Multiple authorship
+~~~~~~~~~~~~~~~~~~~
+
+It is not uncommon for a patch to have contributions from multiple authors. In
+this scenario, git commits will usually be expected to have a ``Signed-off-by``
+line for each contributor involved in creation of the patch. Some edge cases:
+
+  * The non-primary author's contributions were so trivial that they can be
+    considered not subject to copyright. In this case the secondary authors
+    need not include a ``Signed-off-by``.
+
+    This case most commonly applies where QEMU reviewers give short snippets
+    of code as suggested fixes to a patch. The reviewers don't need to have
+    their own ``Signed-off-by`` added unless their code suggestion was
+    unusually large, but it is common to add ``Suggested-by`` as a credit
+    for non-trivial code.
+
+  * Both contributors work for the same employer and the employer requires
+    copyright assignment.
+
+    It can be said that in this case a ``Signed-off-by`` is indicating that
+    the person has permission to contribute from their employer who is the
+    copyright holder. It is nonetheless still preferable to include a
+    ``Signed-off-by`` for each contributor, as in some countries employees are
+    not able to assign copyright to their employer, and it also covers any
+    time invested outside working hours.
+
+When multiple ``Signed-off-by`` tags are present, they should be strictly kept
+in order of authorship, from oldest to newest.
+
+Other commit tags
+~~~~~~~~~~~~~~~~~
+
+While the ``Signed-off-by`` tag is mandatory, there are a number of other tags
+that are commonly used during QEMU development:
+
+ * **``Reviewed-by``**: when a QEMU community member reviews a patch on the
+   mailing list, if they consider the patch acceptable, they should send an
+   email reply containing a ``Reviewed-by`` tag. Subsystem maintainers who
+   review a patch should add this even if they are also adding their
+   ``Signed-off-by`` to the same commit.
+
+ * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch that
+   touches their subsystem, but intends to allow a different maintainer to
+   queue it and send a pull request, they would send a mail containing a
+   ``Acked-by`` tag. Where a patch touches multiple subsystems, ``Acked-by``
+   only implies review of the maintainers' own areas of responsibility. If a
+   maintainer wants to indicate they have done a full review they should use
+   a ``Reviewed-by`` tag.
+
+ * **``Tested-by``**: when a QEMU community member has functionally tested the
+   behaviour of the patch in some manner, they should send an email reply
+   containing a ``Tested-by`` tag.
+
+ * **``Reported-by``**: when a QEMU community member reports a problem via the
+   mailing list, or some other informal channel that is not the issue tracker,
+   it is good practice to credit them by including a ``Reported-by`` tag on
+   any patch fixing the issue. When the problem is reported via the GitLab
+   issue tracker, however, it is sufficient to just include a link to the
+   issue.
+
+ * **``Suggested-by``**: when a reviewer or other 3rd party makes non-trivial
+   suggestions for how to change a patch, it is good practice to credit them
+   by including a ``Suggested-by`` tag.
+
+Subsystem maintainer requirements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When a subsystem maintainer accepts a patch from a contributor, in addition to
+the normal code review points, they are expected to validate the presence of
+suitable ``Signed-off-by`` tags.
+
+At the time they queue the patch in their subsystem tree, the maintainer
+**must** also then add their own ``Signed-off-by`` to indicate that they have
+done the aforementioned validation. This is in addition to any of their own
+``Reviewed-by`` tags the subsystem maintainer may wish to include.
+
+When the maintainer modifies the patch after pulling into their tree, they
+should record their contribution.  This is typically done via a note in the
+commit message, just prior to the maintainer's ``Signed-off-by``::
+
+    Signed-off-by: Cory Contributor <cory.contributor@example.com>
+    [Comment rephrased for clarity]
+    Signed-off-by: Mary Maintainer <mary.maintainer@mycorp.test>
+
+
+Tools for adding ``Signed-off-by``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are a variety of ways tools can support adding ``Signed-off-by`` tags
+for patches, avoiding the need for contributors to manually type in this
+repetitive text each time.
+
+git commands
+^^^^^^^^^^^^
+
+When creating, or amending, a commit the ``-s`` flag to ``git commit`` will
+append a suitable line matching the configured git author details.
+
+If preparing patches using the ``git format-patch`` tool, the ``-s`` flag can
+be used to append a suitable line in the emails it creates, without modifying
+the local commits. Alternatively to modify all the local commits on a branch::
+
+  git rebase master -x 'git commit --amend --no-edit -s'
+
+emacs
+^^^^^
+
+In the file ``$HOME/.emacs.d/abbrev_defs`` add:
+
+.. code:: elisp
+
+  (define-abbrev-table 'global-abbrev-table
+    '(
+      ("8rev" "Reviewed-by: YOUR NAME <your@email.addr>" nil 1)
+      ("8ack" "Acked-by: YOUR NAME <your@email.addr>" nil 1)
+      ("8test" "Tested-by: YOUR NAME <your@email.addr>" nil 1)
+      ("8sob" "Signed-off-by: YOUR NAME <your@email.addr>" nil 1)
+     ))
+
+with this change, if you type (for example) ``8rev`` followed by ``<space>``
+or ``<enter>`` it will expand to the whole phrase.
+
+vim
+^^^
+
+In the file ``$HOME/.vimrc`` add::
+
+  iabbrev 8rev Reviewed-by: YOUR NAME <your@email.addr>
+  iabbrev 8ack Acked-by: YOUR NAME <your@email.addr>
+  iabbrev 8test Tested-by: YOUR NAME <your@email.addr>
+  iabbrev 8sob Signed-off-by: YOUR NAME <your@email.addr>
+
+with this change, if you type (for example) ``8rev`` followed by ``<space>``
+or ``<enter>`` it will expand to the whole phrase.
+
+Re-starting abandoned work
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For a variety of reasons there are some patches that get submitted to QEMU but
+never merged. An unrelated contributor may decide (months or years later) to
+continue working from the abandoned patch and re-submit it with extra changes.
+
+The general principles when picking up abandoned work are:
+
+ * Continue to credit the original author for their work, by maintaining their
+   original ``Signed-off-by``
+ * Indicate where the original patch was obtained from (mailing list, bug
+   tracker, author's git repo, etc) when sending it for review
+ * Acknowledge the extra work of the new contributor by including their
+   ``Signed-off-by`` in the patch in addition to the orignal author's
+ * Indicate who is responsible for what parts of the patch. This is typically
+   done via a note in the commit message, just prior to the new contributor's
+   ``Signed-off-by``::
+
+    Signed-off-by: Some Person <some.person@example.com>
+    [Rebased and added support for 'foo']
+    Signed-off-by: New Person <new.person@mycorp.test>
+
+In complicated cases, or if otherwise unsure, ask for advice on the project
+mailing list.
+
+It is also recommended to attempt to contact the original author to let them
+know you are interested in taking over their work, in case they still intended
+to return to the work, or had any suggestions about the best way to continue.
diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index cb7c6640fd..5807752d70 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -13,6 +13,7 @@ Notes about how to interact with the community and how and where to submit patch
    maintainers
    style
    submitting-a-patch
+   code-provenance
    trivial-patches
    stable-process
    submitting-a-pull-request
diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index 65c64078cb..f7917b899f 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -344,28 +344,9 @@ Patch emails must include a ``Signed-off-by:`` line
 
 Your patches **must** include a Signed-off-by: line. This is a hard
 requirement because it's how you say "I'm legally okay to contribute
-this and happy for it to go into QEMU". The process is modelled after
-the `Linux kernel
-<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__
-policy.
+this and happy for it to go into QEMU". For full guidance, read the
+:ref:`code-provenance` documentation.
 
-If you wrote the patch, make sure your "From:" and "Signed-off-by:"
-lines use the same spelling. It's okay if you subscribe or contribute to
-the list via more than one address, but using multiple addresses in one
-commit just confuses things. If someone else wrote the patch, git will
-include a "From:" line in the body of the email (different from your
-envelope From:) that will give credit to the correct author; but again,
-that author's Signed-off-by: line is mandatory, with the same spelling.
-
-The name used with "Signed-off-by" does not need to be your legal name,
-nor birth name, nor appear on any government ID. It is the identity you
-choose to be known by in the community, but should not be anonymous,
-nor misrepresent whom you are.
-
-There are various tooling options for automatically adding these tags
-include using ``git commit -s`` or ``git format-patch -s``. For more
-information see `SubmittingPatches 1.12
-<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
 
 .. _include_a_meaningful_cover_letter:
 
-- 
2.49.0


