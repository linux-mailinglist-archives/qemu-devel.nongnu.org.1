Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8653DB07192
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 11:25:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyNV-00031v-9r; Wed, 16 Jul 2025 05:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubyNP-0002y2-4B
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubyNM-0007ix-5c
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 05:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752657870;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWNQdSEpfaOY2a4nUWkKCi7tzS/2GKrr+dfvj8bLCno=;
 b=ZtDTqO5VE1DDk/I18e6zoy/e4z/kmc7zjMD/3EICPGlQoEhITSbaiS7lJR4DPmiXXuirbI
 +s/T0V+sg1QOjBqlRwiSmUHzISatD8JJfSiWkEEF76RxrJhbsSBR4a8KvLxNfmYh4CZAus
 RXh1i5cTqgrMvTQ91aGfr+aAfV3yKhI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-4ff33AIpOnqdepdhKsfFUQ-1; Wed,
 16 Jul 2025 05:24:27 -0400
X-MC-Unique: 4ff33AIpOnqdepdhKsfFUQ-1
X-Mimecast-MFC-AGG-ID: 4ff33AIpOnqdepdhKsfFUQ_1752657866
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC251956095; Wed, 16 Jul 2025 09:24:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.68])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B11830001A2; Wed, 16 Jul 2025 09:24:20 +0000 (UTC)
Date: Wed, 16 Jul 2025 10:24:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v5 28/69] qapi: Move definitions related to accelerators
 in their own file
Message-ID: <aHdvwYM7kXBU4cji@redhat.com>
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-29-philmd@linaro.org>
 <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
 <877c08wnlt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877c08wnlt.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jul 16, 2025 at 10:23:26AM +0200, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > Hi Markus,
> 
> I missed this one, sorry!
> 
> > On 3/7/25 12:54, Philippe Mathieu-Daudé wrote:
> >> Extract TCG and KVM definitions from machine.json to accelerator.json.
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> [...]
> 
> >> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
> >> new file mode 100644
> >> index 00000000000..00d25427059
> >> --- /dev/null
> >> +++ b/qapi/accelerator.json
> >> @@ -0,0 +1,57 @@
> >> +# -*- Mode: Python -*-
> >> +# vim: filetype=python
> >> +#
> >> +# SPDX-License-Identifier: GPL-2.0-or-later
> >> +
> >> +##
> >> +# = Accelerators
> >> +##
> >> +
> >> +{ 'include': 'common.json' }
> >
> > common.json defines @HumanReadableText, ...
> >
> > [...]
> >
> >> +##
> >> +# @x-query-jit:
> >> +#
> >> +# Query TCG compiler statistics
> >> +#
> >> +# Features:
> >> +#
> >> +# @unstable: This command is meant for debugging.
> >> +#
> >> +# Returns: TCG compiler statistics
> >> +#
> >> +# Since: 6.2
> >> +##
> >> +{ 'command': 'x-query-jit',
> >> +  'returns': 'HumanReadableText',
> >> +  'if': 'CONFIG_TCG',
> >
> > ... which is *optionally* used here, triggering when
> > TCG is not built in:
> >
> > qapi/qapi-commands-accelerator.c:85:13: error: ‘qmp_marshal_output_HumanReadableText’ defined but not used [-Werror=unused-function]
> >    85 | static void qmp_marshal_output_HumanReadableText(HumanReadableText *ret_in,
> >       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> 
> This is a defect in the QAPI code generator.  More below.
> 
> > We previously discussed that issue:
> > https://mail.gnu.org/archive/html/qemu-devel/2021-06/msg02667.html
> >
> > where you said:
> >
> > "conditional commands returning an unconditional type is a bit
> > of a code smell". Is it however a "non-smelly instances of this pattern"?
> 
> The instance discussed there wasn't.
> 
> You ran into it when you made TPM commands conditional on CONFIG_TPM
> without also making the types they return conditional.  The proper
> solution was to make the types conditional, too.  Avoided generating
> dead code.  I told you "The user is responsible for making T's 'if' the
> conjunction of the commands'."
> 
> Some of the commands returning HumanReadableText are unconditional, so
> said conjunction is also unconditional.  So how do we end up with unused
> qmp_marshal_output_HumanReadableText()?
> 
> A qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
> command C that returns T.
> 
> We've always generated it as a static function on demand, i.e. when we
> generate a call.

..snip..

> I need to ponder this to decide on a solution.

Functionally the redundat function is harmless, so the least effort
option is to change the generated QAPI headers to look like

  #pragma GCC diagnostic push
  #pragma GCC ignored "-Wunused-function"

  ... rest of QAPI header...

  #pragma GCC diagnostic pop

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


