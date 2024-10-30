Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 738999B68F5
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Oct 2024 17:16:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6BM5-0002Y6-5o; Wed, 30 Oct 2024 12:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t6BLu-0002Ux-KJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t6BLt-0002DA-3i
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 12:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730304916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvTbCW4re1QcMj/f1WpWU26bVLEB6tYD9s0VrjhcL4c=;
 b=VYYqXUE6WO4imS+CnB1pgIfCRTULrOOAY0yZYAvez7pjqluyr6JR0acqeDBuEMjOazTJ+9
 23IVpscacWdvbvVCMCmac/APdHDho6+bRPQ+U0NnAJKQiC1zrfZmbDkzHIOPXbvVWKBnbc
 0vPm6BJRsmeWkpxpVrDmbLb5KQMBTIA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-Ma9O6IE1O1W6nofcL3QTew-1; Wed,
 30 Oct 2024 12:15:13 -0400
X-MC-Unique: Ma9O6IE1O1W6nofcL3QTew-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2E1F19560AF; Wed, 30 Oct 2024 16:15:09 +0000 (UTC)
Received: from localhost (unknown [10.22.64.152])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F8EC19560A2; Wed, 30 Oct 2024 16:15:07 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
In-Reply-To: <Zx_CU9eeQByANMRW@linux.dev>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com>
 <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_CU9eeQByANMRW@linux.dev>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 30 Oct 2024 17:15:05 +0100
Message-ID: <87bjz1o9di.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 28 2024, Oliver Upton <oliver.upton@linux.dev> wrote:

> On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
>> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
>> >
>> > On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
>> > > On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
>> > > > On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
>> > > > > On 10/25/24 15:06, Daniel P. Berrang=C3=A9 wrote:
>> > > > > > Also, is this naming convention really the same one that users
>> > > > > > will see when they look at /proc/cpuinfo to view features ? It
>> > > > > No it is not. I do agree that the custom cpu model is very low l=
evel. It
>> > > > > is very well suited to test all series turning ID regs as writab=
le but
>> > > > > this would require an extra layer that adapts /proc/cpuinfo feat=
ure
>> > > > > level to this regid/field abstraction.
>> > > > >
>> > > > > In /cpu/proc you will see somethink like:
>> > > > >  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomic=
s fphp
>> > > > > asimdhp cpuid asimdrdm lrcpc dcpop asimddp
>> > > >
>> > > > Right, IMHO, this is the terminology that QEMU must use in user
>> > > > facing APIs.
>> > >
>> > > /proc/cpuinfo's naming is rather weird for historical
>> > > reasons (for instance there is only one FEAT_FP16 feature
>> > > but cpuinfo lists "fphp" and "asimdhp" separately).
>> >
>> > There's plenty of wierd history in x86 too. In this
>> > case I might suggest just picking one of the two
>> > common names, and ignoring the other.
>> >
>> > If we really wanted to, we could alias the 2nd name
>> > to the first, but its likely not worth the bother.
>>=20
>> Or we could use the standard set of architectural
>> feature names, and not have the problem at all, and not
>> have to document what we mean by our nonstandard names.
>
> +1
>
> There's existing documentation [*] for the standard feature names, which
> provides:
>
>  - A short description of what the feature does
>  - Any dependencies a particular feature has (e.g.FEAT_VHE implies
>    FEAT_LSE, FEAT_Debugv8p1, and FEAT_AA64EL2)
>  - The register fields/values that are used to discover the feature.
>
> This seems like the most user-friendly option...
>
> [*]: https://developer.arm.com/documentation/109697/2024_09

FEAT_XXX sounds good, would be a different approach than this series
obviously, since the user resp. upper software layers would operate on a
per-feature basis, and QEMU would translate to and from registers.

I'm wondering about the amount of translation that would be needed, and
what information would be best exposed via QEMU, given that a feature
may or may not be toggable not only because of what the Arm revision
specifies, but what registers the host kernel allows to be written.

I.e. if we have two cpus that differ in whether FEAT_FOO is provided,
would it make sense to have an extra QMP command so that you can find
out whether FEAT_FOO can be switched off, with QEMU translating from the
set of writable id registers to the set of features that can be changed?


