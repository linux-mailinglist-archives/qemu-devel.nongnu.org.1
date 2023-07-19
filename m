Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6575911C
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM365-0000Qo-HE; Wed, 19 Jul 2023 05:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qM361-0000Qf-HM
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qM360-0002cd-18
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689757422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aQn1uREHAvlx0kzncmf8BuIfb2KDvEmDfFRZl4VzBI=;
 b=cqKKlcD68yHqufpdj2K2rSo79x/tuxEoUcEY2lu267w75q/86NjlIRvsnlPPafqVoqNRww
 cd6v9lwIe/iXDIZ1d0GXt+kUPrOKjRf0N91d6rT3vGNNpSbeSdM/v3Vgvz1sxaenwouKDY
 pHyT5HcUT8GHVLdY3PwLeI06t2gLtzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-F6Mao4vjN_GwM-MY6agjfw-1; Wed, 19 Jul 2023 05:03:41 -0400
X-MC-Unique: F6Mao4vjN_GwM-MY6agjfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0201936D23;
 Wed, 19 Jul 2023 09:03:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B63340C6F4C;
 Wed, 19 Jul 2023 09:03:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E98F21E6608; Wed, 19 Jul 2023 11:03:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Juan Quintela
 <quintela@redhat.com>,  "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH QEMU v8 4/9] migration: Introduce dirty-limit capability
References: <168870305868.29142.5121604177475325995-4@git.sr.ht>
 <875y6oj80i.fsf@pond.sub.org>
 <CAK9dgmZ73F2qrD-iM-EBSiARRmwGPPorsLdt8NqmkOSyYaRCVw@mail.gmail.com>
 <87zg3tjxb2.fsf@pond.sub.org>
 <CAK9dgmYyxZC_6CPZcgudXVpRXKcdd6kXTsYLhZ_PTiOh=c4-2g@mail.gmail.com>
 <87a5vsh3p3.fsf@pond.sub.org>
 <CAK9dgmZeJL0M9Lc4S6o5R=GvtyXmKvBeHmTBbcfPiYE7w=uTXQ@mail.gmail.com>
Date: Wed, 19 Jul 2023 11:03:39 +0200
In-Reply-To: <CAK9dgmZeJL0M9Lc4S6o5R=GvtyXmKvBeHmTBbcfPiYE7w=uTXQ@mail.gmail.com>
 (Yong Huang's message of "Wed, 19 Jul 2023 14:14:45 +0800")
Message-ID: <87bkg8ff2s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Yong Huang <yong.huang@smartx.com> writes:

> On Wed, Jul 19, 2023 at 1:26=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> Yong Huang <yong.huang@smartx.com> writes:
>>
>> > On Tue, Jul 18, 2023 at 7:04=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com>
>> wrote:
>> >
>> >> Yong Huang <yong.huang@smartx.com> writes:
>> >>
>> >> > On Thu, Jul 13, 2023 at 8:44=E2=80=AFPM Markus Armbruster <armbru@r=
edhat.com> wrote:

[...]

>> >> Yes, please.  But before that, I have still more questions.  "This
>> >> algorithm only works when vCPU's dirtyrate greater than
>> >> 'vcpu-dirty-limit'" is a condition: "FEATURE only works when CONDITIO=
N".
>> >>
>> > I failed to express my meaning again : ( .  "Throttle algo only works =
when
>> > vCPU's  dirtyrate greater than 'vcpu-dirty-limit' " should change to
>> > "vCPU throttle only works when vCPU's dirtyrate greater than
>> > 'vcpu-dirty-limit'".
>> > Not the whole "algo" !
>>
>> Let me paraphrase to make sure I got it...  The vCPU is throttled as
>> needed to keep its dirty rate within the limit set with
>> set-vcpu-dirty-limit.  Correct?
>>
> Yes. Actually set with the internal function qmp_set_vcpu_dirty_limit.
>
> And a parameter called "vcpu-dirty-limit"  of migration provided by
> dirty-limit
> aims to be the argument of qmp_set_vcpu_dirty_limit.

Alright, let me try to craft some documentation:

  # @dirty-limit: If enabled, migration will throttle vCPUs as needed to
  #     keep their dirty page rate within @vcpu-dirty-limit.  This can
  #     improve responsiveness of large guests during live migration,
  #     and can result in more stable read performance.  Requires KVM
  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)

What do you think?

>> What happens when I enable the dirty limit convergence algorithm without
>> setting a limit with set-vcpu-dirty-limit?
>>
> dirty-limit will use the default value which is defined
> in migration/options.c:
> #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>
> So the default of the dirty-limit is 1MB/s.

Is this default documented in the QAPI schema?  Hmm, looks like it isn't
before this series, but PATCH 3 fixes it.  Okay.

>> >> What happens when the condition is not met?  How can the user ensure =
the
>> >> condition is met?
>> >>
>> >> [...]


