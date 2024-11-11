Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE6E9C40F0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Nov 2024 15:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVQO-0005hV-Lw; Mon, 11 Nov 2024 09:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tAVQE-0005hC-Qv
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:29:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tAVQC-0008CP-Ie
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731335378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjRAGOxPKBLWWtMTL71YPmNIL38UX8S0tDkwH3bqdKI=;
 b=VCbfJdxQDa+Z/7fg3Sk0a5dg/83Gb8NWDsbduRab7pKbRi1MDfTAm/20/885qooEoSSPCH
 K3VrT8F5Hqfwx8iyjXfeDe60tGOS2M+a4b2yqSS7EyNruYWfqbVBEtM14berUWk7xMAYR1
 l7uSb6XJFCGtf/khNvOXsjDS4PWkcMg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-qAk2hGD9OWOnj-H9L20ntQ-1; Mon,
 11 Nov 2024 09:29:32 -0500
X-MC-Unique: qAk2hGD9OWOnj-H9L20ntQ-1
X-Mimecast-MFC-AGG-ID: qAk2hGD9OWOnj-H9L20ntQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA9FA1955DC3; Mon, 11 Nov 2024 14:29:28 +0000 (UTC)
Received: from localhost (unknown [10.22.80.107])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76976300019E; Mon, 11 Nov 2024 14:29:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
In-Reply-To: <63c232c2-a325-48d6-8ed4-753a7c6e3b4e@redhat.com>
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
 <Zx_EGxj2aqc_2-kY@redhat.com>
 <63c232c2-a325-48d6-8ed4-753a7c6e3b4e@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 11 Nov 2024 15:29:23 +0100
Message-ID: <87ikstn8sc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 04 2024, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Daniel,
>
> On 10/28/24 18:04, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Oct 28, 2024 at 04:48:18PM +0000, Peter Maydell wrote:
>>> On Mon, 28 Oct 2024 at 16:35, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
>>>> On Mon, Oct 28, 2024 at 04:16:31PM +0000, Peter Maydell wrote:
>>>>> On Fri, 25 Oct 2024 at 14:24, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
>>>>>> On Fri, Oct 25, 2024 at 03:18:25PM +0200, Eric Auger wrote:
>>>>>>> On 10/25/24 15:06, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>> Also, is this naming convention really the same one that users
>>>>>>>> will see when they look at /proc/cpuinfo to view features ? It
>>>>>>> No it is not. I do agree that the custom cpu model is very low leve=
l. It
>>>>>>> is very well suited to test all series turning ID regs as writable =
but
>>>>>>> this would require an extra layer that adapts /proc/cpuinfo feature
>>>>>>> level to this regid/field abstraction.
>>>>>>>
>>>>>>> In /cpu/proc you will see somethink like:
>>>>>>>  Features    : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics f=
php
>>>>>>> asimdhp cpuid asimdrdm lrcpc dcpop asimddp
>>>>>> Right, IMHO, this is the terminology that QEMU must use in user
>>>>>> facing APIs.
>>>>> /proc/cpuinfo's naming is rather weird for historical
>>>>> reasons (for instance there is only one FEAT_FP16 feature
>>>>> but cpuinfo lists "fphp" and "asimdhp" separately).
>>>> There's plenty of wierd history in x86 too. In this
>>>> case I might suggest just picking one of the two
>>>> common names, and ignoring the other.
>>>>
>>>> If we really wanted to, we could alias the 2nd name
>>>> to the first, but its likely not worth the bother.
>>> Or we could use the standard set of architectural
>>> feature names, and not have the problem at all, and not
>>> have to document what we mean by our nonstandard names.
>>> (cpuinfo names do actually mostly line up with the
>>> standard names, just not 100%. Similarly gcc/clang command
>>> line options are mostly the architectural feature name.)
>> Ah, right, yes. Sorry I mis-understood you originally to be suggesting
>> the same low level names as this patch.
> If my understanding is correct, Peter suggested to rely on the
> terminology used in
>
> https://developer.arm.com/documentation/109697/2024_09
>
> the doc pointed to by Oliver.
>
> So I think the next step is to understand how those "high level" features=
 do map onto low level ID register field values. I think a high level featu=
re can map onto separate fields in separate ID regs. This may not be the mo=
st common case though.=20

I went through all the FEAT_xxx features defined so far and tried to
categorize them (probably with some errors here and there, but the
general trend should be correct.)

There's 335 features defined at the moment.

Of these, the majority (295 by my count) map to one or more values in
one or more id registers. These are what I'd consider the "easy" ones
(added complexity if we deal with serveral values, but in general, it is
clear how to handle them, and most of them actually map to a single
value.) Of course, dependencies may be on top of that.

Then, we have some features (~25 or so) that are actually defined by
dependencies (i.e. FEAT_FOO and FEAT_BAR mean that we have FEAT_BAZ,
sometimes with an architecture extension dependency thrown in as well.)
These features are not really relevant when we compare two cpus since
they do not map to registers directly, but they are relevant if we allow
them to be specified (and use them as a kind of shorthand.) IOW, we'd
need to think about how we'd handle them for comparisons and baselining.

Next, let's talk about architecture extensions. All features have a
level where they have been introduced as optional, some have an upper
limit (e.g. FEAT_AA32EL1 is not allowed from v9.0 onwards), and quite a
number of them (~65 or so) become mandatory with a certain architecture
extension. Sometimes, FEAT_FOO + arch ext also implies FEAT_BAR. If we
introduce Armvx.y named models, we'd need to enforce that some features
are (not) set for a certain model. Complex, but not a showstopper. (We'd
also need to deal with that if we worked on the register level.)

We also have some registers like MIDR/REVIDR that do not correlate with
any FEAT_xxx, but that we still need to handle; I would suggest to deal
with them via separate cpu properties (e.g. specify a list of possible
MIDR/REVIDR pairs.) I hope that there are not too many of them, although
we do have some impdef registers.

That leaves some headscratchers (at least for me.) E.g. FEAT_UINJ, which
is optional from v9.5, and mandatory from v9.6, but where I'm unsure how
we'd discover it, especially as we do not have a way to discover the
architecture extensions. Maybe this will work for named actual cpus
only? I'm also not sure if I understand FEAT_CHK, which is listed as
optional from v8.0 and mandatory from v9.4, but every aarch64 cpu is
supposed to be compliant, because CHKFEAT might be a NOP (and this is
only supposed to check for FEAT_GCS? Yes, I'm confused.)

So tl;dr, we cover a lot of the ID register space via FEAT_xxx (with
varying complexity), but we already know about some exceptions. For some
FEAT_xxx, I'm not sure if we want to handle them at all.

(I also seem to remember that there some things like perf counters that
don't map to any on/off features, but no idea about the details here.)


