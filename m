Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7878964206
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Aug 2024 12:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjcUU-0004yr-80; Thu, 29 Aug 2024 06:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcUR-0004xA-RQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjcUM-0004Bm-MS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 06:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724927689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVArTEp6Aqrkh8YQ6sol69DZaPRDK/2JnOjb8HtJwVM=;
 b=gxyIPVGSqBdZsSEcakLF6tEeTI+ydPcBUoR09uC0kR7zKPZDLGwmPRWFQvNXzGC3VixTrG
 nO4Riup8ovy+dXUzGAtXxefURg6e1YA5uLRhedYekTSuDqkbm8sDJfIxcrPggVIvTJXv4V
 SFWYfaHNKEKyzY+HYtTgUm915JJvc90=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-d4eUJzrFNT2H-iiq96dcgA-1; Thu,
 29 Aug 2024 06:34:46 -0400
X-MC-Unique: d4eUJzrFNT2H-iiq96dcgA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D0881955BFA; Thu, 29 Aug 2024 10:34:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3801B300019C; Thu, 29 Aug 2024 10:34:40 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:34:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 35/35] docs/devel/testing: Add documentation for
 functional tests
Message-ID: <ZtBOvBh-keKVeCni@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-36-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821082748.65853-36-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 21, 2024 at 10:27:36AM +0200, Thomas Huth wrote:
> Document the new functional testing framework. The text is originally
> based on the Avocado documentation, but heavily modified to match the
> new framework.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  docs/devel/testing/functional.rst | 269 ++++++++++++++++++++++++++++++
>  docs/devel/testing/index.rst      |   1 +
>  docs/devel/testing/main.rst       |  12 ++
>  3 files changed, 282 insertions(+)
>  create mode 100644 docs/devel/testing/functional.rst

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> +The tests should be written in the style of the Python `unittest`_
> +framework, using stdio for the TAP protocol. The folder
> +``tests/functional/qemu_test`` provides classes (e.g. the ``QemuBaseTest``
> +and the ``QemuSystemTest`` classes) and utility functions that help
> +to get your test into the right shape.

One gotcha when using TAP protocol is that you can't just spew
debug info to stdout/stderr. Each line of debug info needs to
be prefixed with '#' so it is interpreted as diagnostic output.

We should point this out and recommend people to exclusively
using the 'logging' framework.

Particular care should be taken when spawning sub-processes
to capture both stdout/stderr and then log the result if
needed.


> +Overview
> +--------
> +
> +The ``tests/functional/qemu_test`` directory provides the ``qemu_test``
> +Python module, containing the ``qemu_test.QemuSystemTest`` class.
> +Here is a simple usage example:
> +
> +.. code::
> +
> +  #!/usr/bin/env python3
> +
> +  from qemu_test import QemuSystemTest
> +
> +  class Version(QemuSystemTest):
> +
> +      def test_qmp_human_info_version(self):
> +          self.vm.launch()
> +          res = self.vm.cmd('human-monitor-command',
> +                            command_line='info version')
> +          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
> +
> +  if __name__ == '__main__':
> +      QemuSystemTest.main()
> +
> +By providing the "hash bang" line at the beginning of the script,
> +and by calling into QemuSystemTest.main() when it is run directly,
> +the test framework makes sure to run all test_*() functions in the
> +right fassion (e.g. with TAP output that is required by the meson test
> +runner).

Perhaps say that the test file should have execute permissions,
given the hash bang ?



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


