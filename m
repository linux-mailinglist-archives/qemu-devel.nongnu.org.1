Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567482E982
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 07:29:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPcv6-0007kU-Sc; Tue, 16 Jan 2024 01:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPcv4-0007iz-Vi
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPcv3-0002LG-5e
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 01:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705386447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4yYJyxdKrIpGiT/7ShWgUyybogM5qomZ3V49lwJjsE=;
 b=Ueqkvsc80NNmCTW4IBEITsTXP2mJAbRs4hmT/Z6tC0ce6S8xTrh+vEu7LQ+kRQIUxlqPKu
 7a8c1Bx5fVjoTCxIgs22mKsAg2GPwgkJJWXIZLU73gWXMGeUwlA/dYrZ6C0ExOTgNFoy0v
 0ihNGE38d8zNmbki+zkCz6OAy/YxAuY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-NZC61XHQNTaQsF-k8i6FmA-1; Tue,
 16 Jan 2024 01:27:24 -0500
X-MC-Unique: NZC61XHQNTaQsF-k8i6FmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA56C1C05AC2;
 Tue, 16 Jan 2024 06:27:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63434492BC6;
 Tue, 16 Jan 2024 06:27:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 219E921E66C8; Tue, 16 Jan 2024 07:27:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <laurent@vivier.eu>,  qemu-trivial@nongnu.org,  Claudio Imbrenda
 <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
In-Reply-To: <ZaV0QxdfQJDnICdF@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Jan 2024 18:06:59 +0000")
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
 <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
 <ZaV0QxdfQJDnICdF@redhat.com>
Date: Tue, 16 Jan 2024 07:27:22 +0100
Message-ID: <87y1cp94j9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jan 15, 2024 at 05:39:19PM +0000, Peter Maydell wrote:
>> On Mon, 15 Jan 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
>> >
>> > On 12/01/2024 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
>> > > Hi Thomas
>> > >
>> > > +Laurent & Peter
>> > >
>> > > On 12/1/24 11:00, Thomas Huth wrote:
>> > >> It's been marked as deprecated since QEMU 8.1, so it should be fine
>> > >> to remove this now.
>> > >>
>> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>=20
>> > > StatusInfo::singlestep was deprecated at the same time,
>> > > can we remove it?
>> > >
>> > > IOW could we complete your patch with this?
>>=20
>> > > diff --git a/qapi/run-state.json b/qapi/run-state.json
>> > > index ca05502e0a..08bc99cb85 100644
>> > > --- a/qapi/run-state.json
>> > > +++ b/qapi/run-state.json
>> > > @@ -106,25 +106,15 @@
>> > >  #
>> > >  # @running: true if all VCPUs are runnable, false if not runnable
>> > >  #
>> > > -# @singlestep: true if using TCG with one guest instruction per
>> > > -#     translation block
>> > > -#
>> > >  # @status: the virtual machine @RunState
>> > >  #
>> > >  # Features:
>> > >  #
>> > > -# @deprecated: Member 'singlestep' is deprecated (with no
>> > > -#     replacement).
>> > > -#
>> > >  # Since: 0.14
>> > >  #
>> > > -# Notes: @singlestep is enabled on the command line with '-accel
>> > > -#     tcg,one-insn-per-tb=3Don', or with the HMP 'one-insn-per-tb'
>> > > -#     command.
>> > >  ##
>> > >  { 'struct': 'StatusInfo',
>> > >    'data': {'running': 'bool',
>> > > -           'singlestep': { 'type': 'bool', 'features': [ 'deprecate=
d' ]},
>> > >             'status': 'RunState'} }
>> >
>> > Uh, oh, that's a bigger change already ... can we safely remove the fi=
eld
>> > here without upsetting 3rd party apps that rely on this interface?
>>=20
>> That was the whole point of marking it 'deprecated' in the JSON,
>> I thought? We don't think anybody's using it, we've given fair
>> warning, isn't the next step "remove it"? Markus, you're the
>> expert on QAPI deprecations...
>
> Yes, it is fine to delete it without thinking further about possible usag=
e,
> unless someone steps forward quickly with new information that wasn't kno=
wn
> when the deprecation was added....

Concur.

Supporting data:

commit 34c18203d472c5bf969ebd87dc06c7c3a957efc4
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Apr 17 17:40:41 2023 +0100

    qmp: Deprecate 'singlestep' member of StatusInfo
=20=20=20=20
    The 'singlestep' member of StatusInfo has never done what the QMP
    documentation claims it does.  What it actually reports is whether
    TCG is working in "one guest instruction per translation block" mode.
=20=20=20=20
    We no longer need this field for the HMP 'info status' command, as
    we've moved that information to 'info jit'.  It seems unlikely that
    anybody is monitoring the state of this obscure TCG setting via QMP,
    especially since QMP provides no means for changing the setting.  So
    simply deprecate the field, without providing any replacement.
=20=20=20=20
    Until we do eventually delete the member, correct the misstatements
    in the QAPI documentation about it.
=20=20=20=20
    If we do find that there are users for this, then the most likely way
    we would provide replacement access to the information would be to
    put the accelerator QOM object at a well-known path such as
    /machine/accel, which could then be used with the existing qom-set
    and qom-get commands.
=20=20=20=20
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
    Reviewed-by: Markus Armbruster <armbru@redhat.com>
    Message-id: 20230417164041.684562-11-peter.maydell@linaro.org

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6f5e689aa4..d5eda0f566 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -199,6 +199,20 @@ accepted incorrect commands will return an error. User=
s should make sure that
 all arguments passed to ``device_add`` are consistent with the documented
 property types.
=20
+``StatusInfo`` member ``singlestep`` (since 8.1)
+''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``singlestep`` member of the ``StatusInfo`` returned from the
+``query-status`` command is deprecated. This member has a confusing
+name and it never did what the documentation claimed or what its name
+suggests. We do not believe that anybody is actually using the
+information provided in this member.
+
+The information it reports is whether the TCG JIT is in "one
+instruction per translated block" mode (which can be set on the
+command line or via the HMP, but not via QMP). The information remains
+available via the HMP 'info jit' command.
+
[...]


