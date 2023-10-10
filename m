Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A547BF20B
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 06:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq4oO-0004Vl-Tu; Tue, 10 Oct 2023 00:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qq4oK-0004V6-Dp
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 00:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qq4oI-0001q0-G5
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 00:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696913853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b71yav+R71Jw2yG7JHTA5wojUJRx7/5OgMDQOdmoGV0=;
 b=H4sVCKpTWo9/bCSCSFAs3CT0kptq94Hceh2EznoWxuLgE04NLTkQqNe0shoBVhMtMpeUGp
 rRkCZf64iM6jgcQFjF+XYENS7RSedhmTwPKvOxG9BrlHHSauTnNd3uDAaNPfKYwS9gE76f
 BoCPAFcpe6lVqPWGFPVCmlBcsuBlOTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-RizMZUr2PPS-ShwDHedU2Q-1; Tue, 10 Oct 2023 00:57:12 -0400
X-MC-Unique: RizMZUr2PPS-ShwDHedU2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0F8A858F1B;
 Tue, 10 Oct 2023 04:57:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6950B40C6EA8;
 Tue, 10 Oct 2023 04:57:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 72D8F21E6904; Tue, 10 Oct 2023 06:57:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Brian Cain <bcain@quicinc.com>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org,
 quic_mathbern@quicinc.com,  stefanha@redhat.com,  ale@rev.ng,
 anjo@rev.ng,  quic_mliebel@quicinc.com,  ltaylorsimpson@gmail.com,
 Thomas Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
 <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
Date: Tue, 10 Oct 2023 06:57:10 +0200
In-Reply-To: <187100e7-a516-4024-1739-a08c630d76f3@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 9 Oct 2023 08:43:05
 +0200")
Message-ID: <877cnvxeft.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 9/10/23 08:09, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Brian,
>> On 6/10/23 00:22, Brian Cain wrote:
>>> The typedef `vaddr` is shadowed by `vaddr` identifiers, so we rename the
>>> identifiers to avoid shadowing the type name.
>> This one surprises me, since we have other occurences:
>> include/exec/memory.h:751:bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb=
, void **vaddr,
>>  =C2=A0=C2=A0=C2=A0=C2=A0include/qemu/plugin.h:199:void qemu_plugin_vcpu=
_mem_cb(CPUState *cpu, uint64_t vaddr,
>> target/arm/internals.h:643:G_NORETURN void arm_cpu_do_unaligned_access(C=
PUState *cs, vaddr vaddr,
>> target/i386/tcg/helper-tcg.h:70:G_NORETURN void handle_unaligned_access(=
CPUX86State *env, vaddr vaddr,
>> ...
>> $ git grep -w vaddr, | wc -l
>>  =C2=A0=C2=A0=C2=A0=C2=A0 207
>> What is the error/warning like?
>
> OK I could reproduce, I suppose you are building with Clang which
> doesn't support shadow-local so you get global warnings too (as
> mentioned in this patch subject...):
>
> In file included from ../../gdbstub/trace.h:1,
>                  from ../../gdbstub/softmmu.c:30:
> trace/trace-gdbstub.h: In function '_nocheck__trace_gdbstub_hit_watchpoin=
t':
> trace/trace-gdbstub.h:903:106: error: declaration of 'vaddr' shadows a gl=
obal declaration [-Werror=3Dshadow]
>   903 | static inline void _nocheck__trace_gdbstub_hit_watchpoint(const c=
har * type, int cpu_gdb_index, uint64_t vaddr)
>       |                                  ~~~~~~~~~^~~~~
> In file included from include/sysemu/accel-ops.h:13,
>                  from include/sysemu/cpus.h:4,
>                  from ../../gdbstub/softmmu.c:21:
> include/exec/cpu-common.h:21:18: note: shadowed declaration is here
>    21 | typedef uint64_t vaddr;
>       |                  ^~~~~
> trace/trace-gdbstub.h: In function 'trace_gdbstub_hit_watchpoint':
> trace/trace-gdbstub.h:923:96: error: declaration of 'vaddr' shadows a glo=
bal declaration [-Werror=3Dshadow]
>   923 | static inline void trace_gdbstub_hit_watchpoint(const char * type=
, int cpu_gdb_index, uint64_t vaddr)
>       |                        ~~~~~~~~~^~~~~
> include/exec/cpu-common.h:21:18: note: shadowed declaration is here
>    21 | typedef uint64_t vaddr;
>       |                  ^~~~~
>
> Clang users got confused by this, IIUC Markus and Thomas idea is
> to only enable these warnings for GCC, enforcing them for Clang
> users via CI (until Clang get this option supported). Personally
> I'd rather enable the warning once for all, waiting for Clang
> support (or clean/enable global shadowing for GCC too).
>
> See this thread:
> https://lore.kernel.org/qemu-devel/11abc551-188e-85c0-fe55-b2b58d35105d@r=
edhat.com/

The idea to enable some variation of -Wshadow goes back to this thread:

    Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
    Date: Thu, 24 Aug 2023 14:18:53 +0100
    Message-ID: <CAFEAcA8wobO5F16vYhbQCjeadfN5Zwx5CQ7L4vQ3fh8c_6ngJg@mail.g=
mail.com>
    https://lore.kernel.org/qemu-devel/CAFEAcA8wobO5F16vYhbQCjeadfN5Zwx5CQ7=
L4vQ3fh8c_6ngJg@mail.gmail.com/

I've been aiming at -Wshadow=3Dlocal because (1) it seemed more practical
(a lot less cleanup needed before we can enable the warning), and (2)
local shadowing is basically always foolish and fully our own fault.

No objection to additional -Wshadow work as long as I'm not the one
doing it :)


