Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF226A30ECD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 15:52:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrbl-00028l-Ja; Tue, 11 Feb 2025 09:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thrbd-000286-9z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thrbb-0006y4-5o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739285476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XHbLEeiICOnMSb9zs+ea/cnUMFlK6isFG+MN18A6tfs=;
 b=BqH2b/nt0u5m0SoKaObU8Nr/QUMJR3T0PGzGFd3fLewOqJoXBrh0qGdjHiVlRQ7HZWpvEi
 Aiu82jS9FfOFYRIDYfEizUE/F/c9ZReydpFxsmYB7k7gvTFjOow69N17rp7Mc0wWNlOzrD
 Nd25J8xOD7aQG9VkPSOJ5mySXg6beMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-4CVNfWAhM2OKXOPrPP91Sg-1; Tue,
 11 Feb 2025 09:51:10 -0500
X-MC-Unique: 4CVNfWAhM2OKXOPrPP91Sg-1
X-Mimecast-MFC-AGG-ID: 4CVNfWAhM2OKXOPrPP91Sg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFF4C18009AD; Tue, 11 Feb 2025 14:51:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 479551800877; Tue, 11 Feb 2025 14:51:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF75A21E6A28; Tue, 11 Feb 2025 15:51:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 01/42] docs/qapidoc: support header-less freeform sections
In-Reply-To: <20250205231208.1480762-2-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:27 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-2-jsnow@redhat.com>
Date: Tue, 11 Feb 2025 15:51:03 +0100
Message-ID: <87msestu08.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

John Snow <jsnow@redhat.com> writes:

> The code as written can't handle if a header isn't found and will crash,
> because `node` will be uninitialized. If we don't have a section title,
> create a generic block to insert text into instead.

Suggest to show input that makes it crash.  Something like

  The code as written crashes when a free-form documentation block
  doesn't start with a heading or subheading, like so

      ##
      # Just text, no heading.
      ##

  The code then uses `node` uninitialized.

  To fix, create a generic block to insert the doc text into.

> (This patch also removes a lingering pylint warning in the QAPIDoc
> implementation that prevents getting a clean baseline to use for
> forthcoming additions.)
>
> I am not attempting to *fully* clean up the existing QAPIDoc
> implementation in pylint because I intend to delete it anyway; this
> patch merely accomplishes a baseline under a specific pylint
> configuration:
>
> PYTHONPATH=../../scripts/ pylint --disable=fixme,too-many-lines,\
> consider-using-f-string,missing-docstring,unused-argument,\
> too-many-arguments,too-many-positional-arguments,\
> too-many-public-methods \
> qapidoc.py
>
> (under at least pylint 3.3.1; more robust tamping down of the
> environment needed to consistently perform checks will happen later -
> hopefully soon, sorry for the inconvenience.)
>
> This at least ensures there aren't regressions outside of these general
> warnings in the new qapidoc.py code to be committed.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform QMP sections)


