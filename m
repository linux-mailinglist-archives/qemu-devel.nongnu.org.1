Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB970BCE0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14HI-0006Rp-RF; Mon, 22 May 2023 08:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q14HF-0006RQ-Ii
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:04:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1q14HC-0002Km-Rk
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684757074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zqyo5rJ8j59rDGA94pvvhHY82P2NKop29y8JPKXIx9A=;
 b=XmfiVoOOKa32fqizsAgVR8+TbVvBPgCmUzwvZW0a9ivhXR1q5XDujRaFxoaN6SLjXVkriS
 SYVxbzSeDWY8gSHaJDmGujmw49Sb09dGoZ2DlLKCiOCzV8OR3sQxO13oh2n6Z/NuhNHh40
 QwGugCYJnSUG37FlFzZ/bISqZHtUcYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-5Qq3rbTSNVqd0y0Tzgym1w-1; Mon, 22 May 2023 08:04:30 -0400
X-MC-Unique: 5Qq3rbTSNVqd0y0Tzgym1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0ADF28007D9;
 Mon, 22 May 2023 12:04:30 +0000 (UTC)
Received: from localhost (unknown [10.39.194.141])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB3C2C58DC1;
 Mon, 22 May 2023 12:04:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, Eric
 Auger <eauger@redhat.com>, Juan Quintela <quintela@redhat.com>, Gavin Shan
 <gshan@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Andrea Bolognani
 <abologna@redhat.com>
Subject: Re: [PATCH v7 0/1] arm: enable MTE for QEMU + kvm
In-Reply-To: <20230428095533.21747-1-cohuck@redhat.com>
Organization: Red Hat GmbH
References: <20230428095533.21747-1-cohuck@redhat.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 22 May 2023 14:04:28 +0200
Message-ID: <87v8gkzi5v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 28 2023, Cornelia Huck <cohuck@redhat.com> wrote:

> Another open problem is mte vs mte3: tcg emulates mte3, kvm gives the guest
> whatever the host supports. Without migration support, this is not too much
> of a problem yet, but for compatibility handling, we'll need a way to keep
> QEMU from handing out mte3 for guests that might be migrated to a mte3-less
> host. We could tack this unto the mte property (specifying the version or
> max supported), or we could handle this via cpu properties if we go with
> handling compatibility via cpu models (sorting this out for kvm is probably
> going to be interesting in general.) In any case, I think we'll need a way
> to inform kvm of it.

Before I start to figure out the initialization breakage, I think it
might be worth pointing to this open issue again. As Andrea mentioned in
https://listman.redhat.com/archives/libvir-list/2023-May/239926.html,
libvirt wants to provide a stable guest ABI, not only in the context of
migration compatibility (which we can handwave away via the migration
blocker.)

The part I'm mostly missing right now is how to tell KVM to not present
mte3 to a guest while running on a mte3 capable host (i.e. the KVM
interface for that; it's more a case of "we don't have it right now",
though.) I'd expect it to be on the cpu level, rather than on the vm
level, but it's not there yet; we also probably want something that's
not fighting whatever tcg (or other accels) end up doing.

I see several options here:
- Continue to ignore mte3 and its implications for now. The big risk is
  that someone might end up implementing support for MTE in libvirt again,
  with the same stable guest ABI issues as for this version.
- Add a "version" qualifier to the mte machine prop (probably with
  semantics similar to the gic stuff), with the default working with tcg
  as it does right now (i.e. defaulting to mte3). KVM would only support
  "no mte" or "same as host" (with no stable guest ABI guarantees) for
  now. I'm not sure how hairy this might get if we end up with a per-cpu
  configuration of mte (and other features) with kvm.
- Add cpu properties for mte and mte3. I think we've been there before
  :) It would likely match any KVM infrastructure well, but we gain
  interactions with the machine property. Also, there's a lot in the
  whole CPU model area that need proper figuring out first... if we go
  that route, we won't be able to add MTE support with KVM anytime soon,
  I fear.

The second option might be the most promising, except for potential
future headaches; but a lot depends on where we want to be going with
cpu models for KVM in general.


