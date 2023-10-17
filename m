Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8BB7CC917
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnGs-0005yW-A4; Tue, 17 Oct 2023 12:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qsnGq-0005xj-AS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:50:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qsnGj-0006rk-Dx
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:50:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 090F81F8A4;
 Tue, 17 Oct 2023 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697561407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8N2JvrJd0u3JM9oQtB87LSgpWUU5B7n0OVWxDx0y8w4=;
 b=qG7nGOpNiMfFE1d7P+tej+1Qb7NKN1p0XfSGMpq7qmTZWw0nx+k8Alu2JyMbVM2+Ntbh9q
 W+wAwVQPiCi2KhgnWM7jNYF2bmOyzrZWMiEV2TdXSI9yhA42gnZDORy9eUXP7QdgmpYVdC
 xU28knn71LKIaQaFxcoB7/zK0k7p//U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697561407;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8N2JvrJd0u3JM9oQtB87LSgpWUU5B7n0OVWxDx0y8w4=;
 b=6p52dkuh/btebsciijBFz76fjRYDd5RDRCNEUZjaLm1YgIslmANPhTVtvg5z1w8avMVFBz
 g7K7iF62xhIiR5Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9099E13597;
 Tue, 17 Oct 2023 16:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2gcjFz67LmXLZQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 17 Oct 2023 16:50:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 2/3] migration/doc: How to migrate when hosts have
 different features
In-Reply-To: <20231017151857.21328-3-quintela@redhat.com>
References: <20231017151857.21328-1-quintela@redhat.com>
 <20231017151857.21328-3-quintela@redhat.com>
Date: Tue, 17 Oct 2023 13:50:04 -0300
Message-ID: <87mswhw5vn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> Sometimes devices have different features depending of things outside
> of qemu.  For instance the kernel.  Document how to handle that cases.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> ---
>
> If you have some example to put here, I am all ears.  I guess that
> virtio-* with some features that are on qemu but not on all kernel
> would do the trick, but I am not a virtio guru myself.  Patches
> welcome.
> ---
>  docs/devel/migration.rst | 96 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 5ef2b36e9e..e671df729e 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -358,6 +358,102 @@ machine types to have the right value: ::
>           ...
>       };
>  
> +A device with diferent features on both sides
> +---------------------------------------------
> +
> +Let's assume that we are using the same QEMU binary on both sides,
> +just to make the things easier.  But we have a device that has
> +different features on both sides of the migration.  That can be
> +because the devices are different, because the kernel driver of both
> +devices have different features, whatever.
> +
> +How can we get this to work with migration.  The way to do that is
> +"theoretically" easy.  You have to get the features that the device
> +has in the source of the migration.  The features that the device has
> +on the target of the migration, you get the intersection of the
> +features of both sides, and that is the way that you should launch
> +QEMU.
> +
> +Notice that this is not completely related to QEMU.  The most
> +important thing here is that this should be handle by the managing

s/handle/handled/

> +application that launches QEMU.  If QEMU is configured correctly, the
> +migration will suceeed.

s/suceeed/succeed/

> +
> +Once that we have defined that, doing this is complicated.  Almost all

I get what you mean here, but it is slightly confusing. Maybe

"Once we have defined that, doing it is complicated." or
"That said, actually doing it is complicated."

> +devices are bad at being able to be launched with only some features
> +enabled.  With one big exception: cpus.
> +
> +You can read the documentation for QEMU x86 cpu models here:
> +
> +https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html
> +
> +See when they talk about migration they recommend that one chooses the
> +newest cpu model that is supported for all cpus.
> +
> +Let's say that we have:
> +
> +Host A:
> +
> +Device X has the feature Y
> +
> +Host B:
> +
> +Device X has not the feature Y
> +
> +If we try to migrate without any care from host A to host B, it will
> +fail because when migration tries to load the feature Y on
> +destination, it will find that the hardware is not there.
> +
> +Doing this would be the equivalent of doing with cpus:
> +
> +Host A:
> +
> +$ qemu-system-x86_64 -cpu host
> +
> +Host B:
> +
> +$ qemu-system-x86_64 -cpu host
> +
> +When both hosts have different cpu features this is waranteed to
> fail.

s/waranteed/guaranteed/

> +Especially if Host B has less features than host A.  If host A has
> +less features than host B, sometimes it works.  Important word of last
> +sentence is "sometimes".
> +
> +So, forgetting about cpu models and continuing with the -cpu host
> +example, let's see that the differences of the cpus is that Host A and
> +B have the following features:
> +
> +Features:   'pcid'  'stibp' 'taa-no'
> +Host A:        X       X
> +Host B:                        X
> +
> +And we want to migrate between them, the way configure both QEMU cpu
> +will be:
> +
> +Host A:
> +
> +$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
> +
> +Host B:
> +
> +$ qemu-system-x86_64 -cpu host,taa-no=off
> +
> +And you would be able to migrate between them.  It is responsability
> +of the management application or of the user to make sure that the
> +configuration is correct.  QEMU don't know how to look at this kind of

s/don't/doesn't/

> +features in general.
> +
> +Notice that we don't recomend to use -cpu host for migration.  It is
> +used in this example because it makes the exampler simpler.

s/exampler/example/

> +
> +Other devices have worse control about individual features.  If they
> +want to be able to migrate between hosts that show different features,
> +the device needs a way to configure which ones it is going to use.
> +
> +In this section we have considered that we are using the same QEMU
> +binary in both sides of the migration.  If we use different QEMU
> +versions process, then we need to have into account all other
> +differences and the examples become even more complicated.
>  
>  VMState
>  -------

