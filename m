Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B439BB8A7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Nov 2024 16:12:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yj0-00022o-J4; Mon, 04 Nov 2024 10:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t7yiu-00022W-Gj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:10:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t7yir-0000O3-J7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730733025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KBJ7PkpL3WRiaJXmMyl/XKwu2L7S7VQTOFmbr5G/qO4=;
 b=HByVbWnOH2UjWMIq+phpZ54+T1ljV4bKY1rnF9CUBl+ft/6gCtPT7VLAvXFkOlEa8bL4P3
 M6ndqIbDZ3ZFPKp8+S0WwMyknEUPwsgUpHcD3ZoFW8OrQi794382p3Nti2W3EUWFXtvgeY
 /olRMQflAI8unMpjV+/ghGqCgRzsns8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-wfbnJoZUPda7qzDWiv5kcA-1; Mon,
 04 Nov 2024 10:10:21 -0500
X-MC-Unique: wfbnJoZUPda7qzDWiv5kcA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2F9A1955BF2; Mon,  4 Nov 2024 15:10:18 +0000 (UTC)
Received: from localhost (dhcp-192-244.str.redhat.com [10.33.192.244])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 655FC300018D; Mon,  4 Nov 2024 15:10:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eric Auger
 <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
In-Reply-To: <ZyjgWJ3bZ69sueE2@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com> <87y128nrfr.fsf@redhat.com>
 <Zx-3OUioG1l47hW3@redhat.com>
 <24ca0278-5018-41e3-a097-ac560a16f8fa@redhat.com>
 <ZyjgWJ3bZ69sueE2@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 04 Nov 2024 16:10:12 +0100
Message-ID: <875xp3nigb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Nov 04, 2024 at 03:45:13PM +0100, Eric Auger wrote:
>> Hi
>>=20
>> On 10/28/24 17:09, Daniel P. Berrang=C3=A9 wrote:
>> > On Mon, Oct 28, 2024 at 05:05:44PM +0100, Cornelia Huck wrote:
>> >> On Fri, Oct 25 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
>> >>
>> >>> On Fri, Oct 25, 2024 at 03:28:35PM +0200, Eric Auger wrote:
>> >>>> Hi Daniel,
>> >>>>
>> >>>> On 10/25/24 15:13, Daniel P. Berrang=C3=A9 wrote:
>> >>>>> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>> >>>>>> From: Cornelia Huck <cohuck@redhat.com>
>> >>>>>>
>> >>>>>> Add some documentation for the custom model.
>> >>>>>>
>> >>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> >>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> >>>>>> ---
>> >>>>>>  docs/system/arm/cpu-features.rst | 55 ++++++++++++++++++++++++++=
+-----
>> >>>>>>  1 file changed, 47 insertions(+), 8 deletions(-)
>> >>>>>> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be q=
uite verbose, the ``sve<N>`` CPU
>> >>>>>>  properties have special semantics (see "SVE CPU Property Parsing
>> >>>>>>  Semantics").
>> >>>>>>=20=20
>> >>>>>> +The ``custom`` CPU model needs to be configured via individual I=
D register
>> >>>>>> +field properties, for example::
>> >>>>>> +
>> >>>>>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_=
EL1_DP=3D0x0
>> >>>>>> +
>> >>>>>> +This forces ID_AA64ISAR0_EL1 DP field to 0.
>> >>>>> What is the "baseline" featureset implied by 'custom' ?
>> >>>> there is no baseline at the moment. By default this is a host
>> >>>> passthrough model.
>> >>> Why do we need to create "custom" at all, as opposed to just letting
>> >>> users toggle features on "-cpu host" ?=20
>> >> We could consolidate that to the current "host" model, once we figure
>> >> out how to handle the currently already existing properties. Models
>> >> based on the different architecture extensions would probably be more
>> >> useable in the long run; maybe "custom" has a place for testing.
>> > If you can set the features against "host", then any testing could
>> > be done with "host" surely, making 'custom' pointless ?
>> Yeah I do agree that we may not need to introduce this "custom" model
>> bus just enhance the custom host model with the capability to tweek some
>> features. For instance we have the case where migration between 2 Ampere
>> systems fails with host model but if you tweek 1 field in CTR_EL0 it
>> passes. So I think in itself this modality can be useful. Same for
>> debug/test purpose. As mentionned in the cover letter the number of
>> writable ID regs continue to grow and this enhanced host model gives
>> flexibility to test new support and may provide enhanced debug
>> capabilities for migration (getting a straight understanding of which ID
>> reg field(s) causes the migration failure could be helpful I think)
>
> FYI, in x86 target the -cpu command has had a "migratable=3Dbool" property
> for a long time , which defaults to 'true' for 'host' model. This causes
> QEMU to explicitly drop features which would otherwise prevent migration
> between two hosts with identical physical CPUs.
>
> IOW, if there are some bits present in 'host' that cause migration
> problems on Ampere hosts, ideally either QEMU (or KVM kmod) would
> detect them and turn them off automatically if migratable=3Dtrue is
> set. See commit message in 84f1b92f & 120eee7d1fd for some background
> info

How does this work for version-sensitive features -- are they always
defaulting to off? How many features are left with that in the end?

>
> NB "migratable" is defined in i386 target code today, but conceptually
> we should expand/move that to apply to all targets for consistency,
> even if it is effectively a no-op some targets (eg if they are
> guaranteed migratable out of the box already with '-cpu host').

How does this compare to s390x, which defines some migration-safe cpu
models, based upon the different hw generations? If I look at the QEMU
code for x86 and s390x, the s390x approach seems cleaner to me (probably
because it came later, and therefore could start afresh without having
to care for legacy things.) Given that we'll cook up a new model for Arm
migration as well, we might as well start with a clean implementation :)

(Not sure what this looks like on the libvirt side.)


