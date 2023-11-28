Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8E7FBE65
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:47:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80HF-0004GN-0Z; Tue, 28 Nov 2023 10:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1r80Gz-0004DS-AD
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1r80Gp-0006UO-12
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701186302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yrCoDS9MUG1priUGb3Q/37WaBBDo23c1ylxj95tSakw=;
 b=X04NTuT/0EFnIrspzTksJhjNb0o/ivC2uEz069rXdQ4M3nAFQFaH86YFwjwfF9wIc2j+98
 05jC2qwbZRng0fM+0OZPsy9LLRIf2hwySYH/GeY6Pn5XvD0wKfg/+VXiCPP8Le54aulVcE
 C8J6tZcygTp8mw/1gNK3O/uru5/CuDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-LSUyNFYgOfOZs6DG0AF3fg-1; Tue, 28 Nov 2023 10:42:58 -0500
X-MC-Unique: LSUyNFYgOfOZs6DG0AF3fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15DF6185A790;
 Tue, 28 Nov 2023 15:42:58 +0000 (UTC)
Received: from pinwheel (unknown [10.39.195.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC7C51121308;
 Tue, 28 Nov 2023 15:42:56 +0000 (UTC)
Date: Tue, 28 Nov 2023 16:42:54 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, rust-vmm@lists.opendev.org,
 devel@lists.libvirt.org
Subject: [Call for Presentations] FOSDEM 2024: Virt & IaaS Devroom
Message-ID: <ZWYKfu48zxiAlbFq@pinwheel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

[Cross-posted to KVM, Rust-VMM, QEMU, and libvirt lists)

Hi, the CFP for the "Virt & IaaS" DevRoom is out[+].

Something new this year is a new talk-submission system: so you need to
create a new account, even if you've had an account with the older
talk-submission system.  Details in the "Submit Your Proposal" section
below.

========================================================================
We are excited to announce that the call for proposals is now open for
the Virtualization and Cloud infrastructure devroom at the upcoming
FOSDEM 2024, to be hosted on February 3rd 2024.

This devroom is a collaborative effort, and is organized by dedicated
folks from projects such as OpenStack, Xen Project, KubeVirt, QEMU, KVM,
and Foreman. We would like to invite all those who are involved in these
fields to submit your proposals by December 8th, 2023.

Important Dates
---------------

Submission deadline: 8th December 2023

Acceptance notifications: 10th December 2023

Final schedule announcement: 15th December 2023

Devroom: 3rd February 2024

About the Devroom
-----------------

The Virtualization & IaaS devroom will feature session topics such as
open source hypervisors or virtual machine managers such as Xen Project,
KVM, bhyve and VirtualBox as well as Infrastructure-as-a-Service
projects such as KubeVirt, Apache CloudStack, OpenStack, QEMU and
OpenNebula.

This devroom will host presentations that focus on topics of shared
interest, such as KVM; libvirt; shared storage; virtualized networking;
cloud security; clustering and high availability; interfacing with
multiple hypervisors; hyperconverged deployments; and scaling across
hundreds or thousands of servers.

Presentations in this devroom will be aimed at developers working on
these platforms who are looking to collaborate and improve shared
infrastructure or solve common problems. We seek topics that encourage
dialog between projects and continued work post-FOSDEM.

Submit Your Proposal
--------------------

All submissions must be made via the Pretalx event planning site[1]. It
is a new submission system so you will need to create an account. If you
submitted proposals for FOSDEM in previous years, you won’t be able to
use your existing account.

During submission please make sure to select Virtualization and Cloud
infrastructure from the Track list. Please fill out all the required
fields, and provide a meaningful abstract and description of your
proposed session.

Submission Guidelines
---------------------

We expect more proposals than we can possibly accept, so it is vitally
important that you submit your proposal on or before the deadline. Late
submissions are unlikely to be considered.

All presentation slots are 30 minutes, with 20 minutes planned for
presentations, and 10 minutes for Q&A.

All presentations will be recorded and made available under Creative
Commons licenses. In the Submission notes field, please indicate that
you agree that your presentation will be licensed under the CC-By-SA-4.0
or CC-By-4.0 license and that you agree to have your presentation
recorded.  For example:

"If my presentation is accepted for FOSDEM, I hereby agree to license
all recordings, slides, and other associated materials under the
Creative Commons Attribution Share-Alike 4.0 International License.

Sincerely,

<NAME>."

In the Submission notes field, please also confirm that if your talk is
accepted, you will be able to attend FOSDEM and deliver your
presentation.  We will not consider proposals from prospective speakers
who are unsure whether they will be able to secure funds for travel and
lodging to attend FOSDEM. (Sadly, we are not able to offer travel
funding for prospective speakers.)

Code of Conduct
---------------

Following the release of the updated code of conduct for FOSDEM, we'd
like to remind all speakers and attendees that all of the presentations
and discussions in our devroom are held under the guidelines set in the
CoC and we expect attendees, speakers, and volunteers to follow the CoC
at all times.

If you submit a proposal and it is accepted, you will be required to
confirm that you accept the FOSDEM CoC. If you have any questions about
the CoC or wish to have one of the devroom organizers review your
presentation slides or any other content for CoC compliance, please
email us and we will do our best to assist you.

Questions?
----------

If you have any questions about this devroom, please send your questions
to our devroom mailing list[2]. You can also subscribe to the list to
receive updates about important dates, session announcements, and to
connect with other attendees.

See you all at FOSDEM!

[1] https://pretalx.fosdem.org/fosdem-2024/cfp
[2] virtualization-devroom-manager at fosdem.org
=======================================================================

[+] This email is a slightly formatted version of the official announce:
    https://lists.fosdem.org/pipermail/fosdem/2023q4/003481.html

-- 
/kashyap


