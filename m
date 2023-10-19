Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9297C7D02E1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:58:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZ8u-0003Ru-V3; Thu, 19 Oct 2023 15:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtZ8r-0003Rh-Ti
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:57:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtZ8p-0008Rf-SU
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:57:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE8621FD94;
 Thu, 19 Oct 2023 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697745429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqq8iVdqqoU028TKO4NTcTxk3QYD7gcexcAEK3/5Md8=;
 b=lIgZSfzaYKXWHcwGTBwrPH6EorX6AzmmNn7wTvd3AIkVsDvAXPsNKA9X8gYnu+699V/sw2
 G4rMq/4e7ES01yOntoPwoN8KCDMdcKeWiralO0e0eqBOWFOHFzyMLG/N5Duo5wbNXg3k92
 mKZ3X9h7yvB34jnjbdzaDz8gPyg2f5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697745429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqq8iVdqqoU028TKO4NTcTxk3QYD7gcexcAEK3/5Md8=;
 b=rdWJ0zX/xwFQyAolZqML5PJq4FAbesx4WM/GAKUi25lNyJ3wpV3PuSeLfveST7/aMUiFlE
 WFrX1vc9WSaureBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49F6F1357F;
 Thu, 19 Oct 2023 19:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wkvDBRWKMWUeIgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 19:57:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH 6/6] docs/migration: Add the dirty limit section
In-Reply-To: <59985366f38053caac40c14d86b2a50bead944f6.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
 <59985366f38053caac40c14d86b2a50bead944f6.1697502089.git.yong.huang@smartx.com>
Date: Thu, 19 Oct 2023 16:57:06 -0300
Message-ID: <87ttqm5qst.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hyman Huang <yong.huang@smartx.com> writes:

> The dirty limit feature has been introduced since the 8.1
> QEMU release but has not reflected in the document, add a
> section for that.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  docs/devel/migration.rst | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..1cbec22e2a 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -588,6 +588,77 @@ path.
>       Return path  - opened by main thread, written by main thread AND po=
stcopy
>       thread (protected by rp_mutex)
>=20=20
> +Dirty limit
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +The dirty limit, short for dirty page rate upper limit, is a new capabil=
ity
> +introduced in the 8.1 QEMU release that uses a new algorithm based on th=
e KVM
> +dirty ring to throttle down the guest during live migration.
> +
> +The algorithm framework is as follows:
> +
> +::
> +
> +  ----------------------------------------------------------------------=
--------
> +  main   --------------> throttle thread ------------> PREPARE(1) <-----=
---
> +  thread  \                                                |            =
  |
> +           \                                               |            =
  |
> +            \                                              V            =
  |
> +             -\                                        CALCULATE(2)     =
  |
> +               \                                           |            =
  |
> +                \                                          |            =
  |
> +                 \                                         V            =
  |
> +                  \                                    SET PENALTY(3) --=
---
> +                   -\                                      |
> +                     \                                     |
> +                      \                                    V
> +                       -> virtual CPU thread -------> ACCEPT PENALTY(4)
> +  ----------------------------------------------------------------------=
--------
> +
> +When the qmp command qmp_set_vcpu_dirty_limit is called for the first ti=
me,
> +the QEMU main thread starts the throttle thread. The throttle thread, on=
ce
> +launched, executes the loop, which consists of three steps:
> +
> +  - PREPARE (1)
> +
> +     The entire work of PREPARE (1) is prepared for the second stage,

s/prepare/preparation/ might be more appropriate

> +     CALCULATE(2), as the name implies. It involves preparing the dirty
> +     page rate value and the corresponding upper limit of the VM:
> +     The dirty page rate is calculated via the KVM dirty ring mechanism,
> +     which tells QEMU how many dirty pages a virtual CPU has had since t=
he
> +     last KVM_EXIT_DIRTY_RING_RULL exception; The dirty page rate upper

s/RULL/FULL

> +     limit is specified by caller, therefore fetch it directly.
> +
> +  - CALCULATE (2)
> +
> +     Calculate a suitable sleep period for each virtual CPU, which will =
be
> +     used to determine the penalty for the target virtual CPU. The
> +     computation must be done carefully in order to reduce the=C2=A0dirt=
y page

There's a non-breaking space artifact between 'the' and 'dirty'

> +     rate progressively down to the upper limit without oscillation. To
> +     achieve this, two strategies are provided: the first is to add or
> +     subtract sleep time based on the ratio of the current dirty page ra=
te
> +     to the limit, which is used when the current dirty page rate is far
> +     from the limit; the second is to add or subtract a fixed time when
> +     the current dirty page rate is close to the limit.
> +
> +  - SET PENALTY (3)
> +
> +     Set the sleep time for each virtual CPU that should be penalized ba=
sed
> +     on the results of the calculation supplied by step CALCULATE (2).
> +
> +After completing the three above stages, the throttle thread loops back
> +to step PREPARE (1) until the dirty limit is reached.
> +
> +On the other hand, each virtual CPU thread reads the sleep duration and
> +sleeps in the path of the KVM_EXIT_DIRTY_RING_RULL exception handler, th=
at

s/RULL/FULL

> +is ACCEPT PENALTY (4). Virtual CPUs tied with writing processes will
> +obviously exit to the path and get penalized, whereas virtual CPUs invol=
ved
> +with read processes will not.
> +
> +In summary, thanks to the KVM dirty ring technology, the dirty limit
> +algorithm will restrict virtual CPUs as needed to keep their dirty page
> +rate inside the limit. This leads to more steady reading performance dur=
ing
> +live migration and can aid in improving large guest responsiveness.
> +
>  Postcopy
>  =3D=3D=3D=3D=3D=3D=3D=3D

