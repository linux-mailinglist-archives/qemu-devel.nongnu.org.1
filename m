Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57C9B35CA
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 17:07:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SFp-0003Bh-Pl; Mon, 28 Oct 2024 12:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t5SFk-0003AO-UF
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1t5SFj-0005jc-2Q
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730131556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPM1TjkdR42ttNSOcT/XXx5F503EX3B6Jz0za4NGXRM=;
 b=g5F77KMJ7x3jmX0IX5718tCclypFJAiDdrMiEc9/A38e5CvRTPf/sAtlwFGLqtrjHVYaYG
 uKC2+HO5MQr1l0DRpJs6B3RDru3lhlAr4++Igh2262NnfzRmzxNfztIEsEJI4vvRYHKUm8
 /jp4W0lyHJnsNvzre9/s60LBPiNmGJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-MBchNRQhP9KV0AytdjcjgA-1; Mon,
 28 Oct 2024 12:05:53 -0400
X-MC-Unique: MBchNRQhP9KV0AytdjcjgA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E98A1955F45; Mon, 28 Oct 2024 16:05:51 +0000 (UTC)
Received: from localhost (unknown [10.22.88.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B12AA300018D; Mon, 28 Oct 2024 16:05:46 +0000 (UTC)
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
In-Reply-To: <Zxudl5-fZV1vIaEL@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com>
 <ZxuZkUFz_bwAA1pf@redhat.com>
 <0700af51-a1a6-4b11-a4bf-0eaf6e279c6d@redhat.com>
 <Zxudl5-fZV1vIaEL@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 28 Oct 2024 17:05:44 +0100
Message-ID: <87y128nrfr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 25 2024, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Oct 25, 2024 at 03:28:35PM +0200, Eric Auger wrote:
>> Hi Daniel,
>>=20
>> On 10/25/24 15:13, Daniel P. Berrang=C3=A9 wrote:
>> > On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>> >> From: Cornelia Huck <cohuck@redhat.com>
>> >>
>> >> Add some documentation for the custom model.
>> >>
>> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> >> ---
>> >>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++---=
--
>> >>  1 file changed, 47 insertions(+), 8 deletions(-)
>> >
>> >> @@ -167,6 +196,16 @@ disabling many SVE vector lengths would be quite=
 verbose, the ``sve<N>`` CPU
>> >>  properties have special semantics (see "SVE CPU Property Parsing
>> >>  Semantics").
>> >>=20=20
>> >> +The ``custom`` CPU model needs to be configured via individual ID re=
gister
>> >> +field properties, for example::
>> >> +
>> >> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_=
DP=3D0x0
>> >> +
>> >> +This forces ID_AA64ISAR0_EL1 DP field to 0.
>> > What is the "baseline" featureset implied by 'custom' ?
>> there is no baseline at the moment. By default this is a host
>> passthrough model.
>
> Why do we need to create "custom" at all, as opposed to just letting
> users toggle features on "-cpu host" ?=20

We could consolidate that to the current "host" model, once we figure
out how to handle the currently already existing properties. Models
based on the different architecture extensions would probably be more
useable in the long run; maybe "custom" has a place for testing.


