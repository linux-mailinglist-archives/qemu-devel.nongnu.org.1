Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75C70C509
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 20:18:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1A6G-0001Nm-Dh; Mon, 22 May 2023 14:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q1A5r-0001N3-MF
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:17:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q1A5l-0002TJ-9J
 for qemu-devel@nongnu.org; Mon, 22 May 2023 14:17:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBB3721FE0;
 Mon, 22 May 2023 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684779423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCWnhf8K6HLN5QXSLZW1ajHRqXYuDrufG1Y4BbwA/Fk=;
 b=A+mzSTCibcBGdqRM8g/SBVq62tWzp9DGm9iiAbuw087U7br2EJKRFzLA5Q/rW5sNKnN5Tb
 8lt6625c4ZO9FaP3bgPfI9Ennmt/CZ+lcIADtKwtp/mSNBZHm5HJqfv7pLSnRa+1vI9UMg
 MbR6I0tWUPIpYqsFBsIlNZbRIQTs4Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684779423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCWnhf8K6HLN5QXSLZW1ajHRqXYuDrufG1Y4BbwA/Fk=;
 b=iJBej1CzG574xa9zalZIMT3YdSHRPQhNAS4/KmS1bK/cYdUU8sKFoj+EUoKSOCeMN/D/bv
 s8fm7SYIY7Ugr3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A2FB13336;
 Mon, 22 May 2023 18:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6kwrEZ+xa2TyGgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 22 May 2023 18:17:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 2/2] meson: Deserialize the man pages and html builds
In-Reply-To: <79204af5-6aa9-47c5-56ed-5e356b57c10f@redhat.com>
References: <20230503203947.3417-1-farosas@suse.de>
 <20230503203947.3417-3-farosas@suse.de>
 <79204af5-6aa9-47c5-56ed-5e356b57c10f@redhat.com>
Date: Mon, 22 May 2023 15:17:01 -0300
Message-ID: <87pm6sut7m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 5/3/23 22:39, Fabiano Rosas wrote:
>> For the documentation builds (man pages & manual), we let Sphinx
>> decide when to rebuild and use a depfile to know when to trigger the
>> make target.
>> 
>> We currently use a trick of having the man pages custom_target take as
>> input the html pages custom_target object, which causes both targets
>> to be executed if one of the dependencies has changed. However, having
>> this at the custom_target level means that the two builds are
>> effectively serialized.
>> 
>> We can eliminate the dependency between the targets by adding a second
>> depfile for the man pages build, allowing them to be parallelized by
>> ninja while keeping sphinx in charge of deciding when to rebuild.
>> 
>> Since they can now run in parallel, separate the Sphinx cache
>> directory of the two builds. We need this not only for data
>> consistency but also because Sphinx writes builder-dependent
>> environment information to the cache directory (see notes under
>> smartquotes_excludes in sphinx docs [1]).
>> 
>> Note that after this patch the commands `make man` and `make html`
>> only build the specified target. To keep the old behavior of building
>> both targets, use `make man html` or `make sphinxdocs`.
>> 
>> 1- https://www.sphinx-doc.org/en/master/usage/configuration.html

Sorry it took me a while to get back to this, I've been caught in
downstream work.

>
> Unfortunately this breaks CentOS 8, which has an older version of ninja:
>
> ninja: error: build.ninja:16369: multiple outputs aren't (yet?) 
> supported by depslog; bring this up on the mailing list if it affects you
>
> This was fixed in ninja 1.10.0.
>

It looks like it would be easier to just wait until all our supported
build platforms reach this version.

Is this CentOS 8 or CentOS Stream 8? I believe CentOS Stream 8 would
drop from our support matrix at the end of this year. And CentOS 8
should have already dropped no? Due to Stream 9 being released in
2021. Unless we do not count Stream as a new version over plain CentOS.

For the dates and versions, I'm looking at:
https://en.wikipedia.org/wiki/CentOS
https://repology.org/project/ninja/versions

