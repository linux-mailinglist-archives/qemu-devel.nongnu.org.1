Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74CB07085
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 10:28:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubxUK-0008Tb-Mi; Wed, 16 Jul 2025 04:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubxQV-00033F-EQ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubxQO-0002qn-UW
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 04:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752654215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=STUiBIB+Th2T363ay6GOHVdT+QkghnT6vecX0DXWUeM=;
 b=exXqPj6Wy9JdyE02Sn9DMdT9J2DR76lV62Hav/curm/CDE44nOA8CKpJ3jZhFuhfdgRzfs
 /wgVukx0xolJfn+ZXOL9PCvdvSioGgKZkl1aPWeAqM8wwl3XUavcHTP6oNpM/E/SAi9Cjh
 weEO+mBPaKLZ1WfMVccUP/M4gBt4cVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-41NsQrsXNwWBG8ttagMCbg-1; Wed,
 16 Jul 2025 04:23:32 -0400
X-MC-Unique: 41NsQrsXNwWBG8ttagMCbg-1
X-Mimecast-MFC-AGG-ID: 41NsQrsXNwWBG8ttagMCbg_1752654210
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23F491800366; Wed, 16 Jul 2025 08:23:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8355F1955F16; Wed, 16 Jul 2025 08:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D3D1D21E6A27; Wed, 16 Jul 2025 10:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  kvm@vger.kernel.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v5 28/69] qapi: Move definitions related to accelerators
 in their own file
In-Reply-To: <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 3 Jul 2025 18:42:06
 +0200")
References: <20250703105540.67664-1-philmd@linaro.org>
 <20250703105540.67664-29-philmd@linaro.org>
 <db0b2ce0-e702-4f32-b284-29cccc8d67ba@linaro.org>
Date: Wed, 16 Jul 2025 10:23:26 +0200
Message-ID: <877c08wnlt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Markus,

I missed this one, sorry!

> On 3/7/25 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>> Extract TCG and KVM definitions from machine.json to accelerator.json.
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

[...]

>> diff --git a/qapi/accelerator.json b/qapi/accelerator.json
>> new file mode 100644
>> index 00000000000..00d25427059
>> --- /dev/null
>> +++ b/qapi/accelerator.json
>> @@ -0,0 +1,57 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=3Dpython
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +##
>> +# =3D Accelerators
>> +##
>> +
>> +{ 'include': 'common.json' }
>
> common.json defines @HumanReadableText, ...
>
> [...]
>
>> +##
>> +# @x-query-jit:
>> +#
>> +# Query TCG compiler statistics
>> +#
>> +# Features:
>> +#
>> +# @unstable: This command is meant for debugging.
>> +#
>> +# Returns: TCG compiler statistics
>> +#
>> +# Since: 6.2
>> +##
>> +{ 'command': 'x-query-jit',
>> +  'returns': 'HumanReadableText',
>> +  'if': 'CONFIG_TCG',
>
> ... which is *optionally* used here, triggering when
> TCG is not built in:
>
> qapi/qapi-commands-accelerator.c:85:13: error: =E2=80=98qmp_marshal_outpu=
t_HumanReadableText=E2=80=99 defined but not used [-Werror=3Dunused-functio=
n]
>    85 | static void qmp_marshal_output_HumanReadableText(HumanReadableTex=
t *ret_in,
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors

This is a defect in the QAPI code generator.  More below.

> We previously discussed that issue:
> https://mail.gnu.org/archive/html/qemu-devel/2021-06/msg02667.html
>
> where you said:
>
> "conditional commands returning an unconditional type is a bit
> of a code smell". Is it however a "non-smelly instances of this pattern"?

The instance discussed there wasn't.

You ran into it when you made TPM commands conditional on CONFIG_TPM
without also making the types they return conditional.  The proper
solution was to make the types conditional, too.  Avoided generating
dead code.  I told you "The user is responsible for making T's 'if' the
conjunction of the commands'."

Some of the commands returning HumanReadableText are unconditional, so
said conjunction is also unconditional.  So how do we end up with unused
qmp_marshal_output_HumanReadableText()?

A qmp_marshal_output_T() is only ever called by qmp_marshal_C() for a
command C that returns T.

We've always generated it as a static function on demand, i.e. when we
generate a call.

Since we split up monolithic generated code into modules, we do this on
per module.  This can result in identical (static)
qmp_marshal_output_T() in several modules.  Fine, but we haven't
considered conditionals, yet.

As long as all functions returning T are in the same module, "making T's
'if' the conjunction of the commands'" works.  This is the case for the
TPM commands.

However, it need not work when the functions returning T are in multiple
modules.  For each module, we need the conjunction of that module's
commands' conditions.  We can't make it T's condition unless they are
all the same.  They aren't for HumanReadableText, as you found out.

I need to ponder this to decide on a solution.

Thanks!


