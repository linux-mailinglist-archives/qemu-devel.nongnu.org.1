Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B577426B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQkO-0006vz-KM; Tue, 08 Aug 2023 13:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTQkL-0006vl-Lm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:43:53 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTQkJ-0005rE-Fm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:43:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so194128a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691516628; x=1692121428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhAsxUJSWZJ6TPA/+06TNIDkTemEW/ax6+vKwsS1bgY=;
 b=1xt4PM5KzlhR9jOcbFVRLB8FjR9uxUDC98WUElNG8i81lvDXYdldJVOyKE/Um2Oo4A
 vGQIst2IFGixxZz0w+7MqTSni9R307fH+XhjWMtDq58VzNvSe/SCzleDuDJI3ifL1f3l
 QL9Pp99TOTN0K2itE5Xj8cli8R2VV1QfkJ8O3nkxp6mk7P9Q7wVncw6H+Ul3w/7n6+pL
 3eAfr/CSvzXJMrVAS8eeNzimiVUNFUYBosyDsjvbVudwFu68oyitroILM9nO+7RW4S4M
 wvaS23NpQKOj3yMuahSguwwKOyiqANT9ssbm5+TSEECTHNnSI2W4nKlNZc/QhNX9Waxt
 4PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691516628; x=1692121428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhAsxUJSWZJ6TPA/+06TNIDkTemEW/ax6+vKwsS1bgY=;
 b=cuzxkggFEwAC3ORFudJM432jIbsqbrrR6deOdxsuFwD9nWH0CXyHzjadpK4jUTJSPa
 +HxEBX6LYAVt4Sz9aHpxInYgeYVMA05Sr4XgjTO4YmR+uLd+8bp5o6VOs3HvMP+lVuuU
 xIG+iokrtMwTUtjpZVkFvgTm70Y/NvDmb3QODHbE9cfrkXReM6zCgu/DNPFk7BvxEihT
 AUCkBVzKPxt00p+ZIRKX6h6bsrFqqIS45Lkrl9go5w1wrdsInEjtt45Sjx/Btdr0+Wad
 fHJNMxAufKTDtbVSXH39EGXeB4ntCSNj3znM1VEOH/+JmqfFO6+kzoFrTo5YWeWiiuzs
 OFUA==
X-Gm-Message-State: AOJu0YyazrAcnzEIBInKn01qTRJGxzQuCYoGPoYHPduU91TGmtwTGj0g
 kKx5kuH5xbwoSC860fuXMB4NOhL3T+tJmJ6Gz0Wjsw==
X-Google-Smtp-Source: AGHT+IGuyDssG9dH1JO3D5ngzqbvIYWXoQTqjwNN711y2ctXTPzUPlP1zzc/unMaWxVkmrmU69o+Nn5L69DITOr4q8w=
X-Received: by 2002:aa7:c592:0:b0:521:728f:d84e with SMTP id
 g18-20020aa7c592000000b00521728fd84emr711828edq.0.1691516628034; Tue, 08 Aug
 2023 10:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-5-andrew@daynix.com>
 <87sf8yx7qa.fsf@pond.sub.org>
In-Reply-To: <87sf8yx7qa.fsf@pond.sub.org>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 8 Aug 2023 20:43:36 +0300
Message-ID: <CABcq3pHwT1-j_UZOG54yWawrTewdo-HL7X9ROO6xXkdB8hq71A@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] qmp: Added new command to retrieve eBPF blob.
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, 
 berrange@redhat.com, qemu-devel@nongnu.org, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::52a;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi all,
Thanks for the comments - I'll update and send new patches.

On Sat, Aug 5, 2023 at 10:34=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Andrew Melnychenko <andrew@daynix.com> writes:
>
> > Now, the binary objects may be retrieved by id.
> > It would require for future qmp commands that may require specific
> > eBPF blob.
> >
> > Added command "request-ebpf". This command returns
> > eBPF program encoded base64. The program taken from the
> > skeleton and essentially is an ELF object that can be
> > loaded in the future with libbpf.
> >
> > The reason to use the command to provide the eBPF object
> > instead of a separate artifact was to avoid issues related
> > to finding the eBPF itself. eBPF object is an ELF binary
> > that contains the eBPF program and eBPF map description(BTF).
> > Overall, eBPF object should contain the program and enough
> > metadata to create/load eBPF with libbpf. As the eBPF
> > maps/program should correspond to QEMU, the eBPF can't
> > be used from different QEMU build.
> >
> > The first solution was a helper that comes with QEMU
> > and loads appropriate eBPF objects. And the issue is
> > to find a proper helper if the system has several
> > different QEMUs installed and/or built from the source,
> > which helpers may not be compatible.
> >
> > Another issue is QEMU updating while there is a running
> > QEMU instance. With an updated helper, it may not be
> > possible to hotplug virtio-net device to the already
> > running QEMU. Overall, requesting the eBPF object from
> > QEMU itself solves possible failures with acceptable effort.
> >
> > Links:
> > [PATCH 3/5] qmp: Added the helper stamp check.
> > https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
>
> [...]
>
> > diff --git a/qapi/ebpf.json b/qapi/ebpf.json
> > new file mode 100644
> > index 00000000000..40851f8c177
> > --- /dev/null
> > +++ b/qapi/ebpf.json
> > @@ -0,0 +1,57 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=3Dpython
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> > +# See the COPYING file in the top-level directory.
> > +
> > +##
> > +# =3D eBPF Objects
> > +##
> > +
> > +{ 'include': 'common.json' }
>
> This looks superfluous.
>
> > +
> > +##
> > +# @EbpfObject:
> > +#
> > +# Structure that holds eBPF ELF object encoded in base64.
> > +#
> > +# Since: 8.3
>
> 8.2
>
> More of the same below, not noting it again.
>
> > +#
> > +##
>
> You're not documenting member @object.  Leaving a member undocumented
> should be a hard error.  It isn't only because we have hundreds of
> instances to fix.
>
> Generated documentation looks like
>
>     "EbpfObject" (Object)
>     ---------------------
>
>     Structure that holds eBPF ELF object encoded in base64.
>
>
>     Members
>     ~~~~~~~
>
>     "object": "string"
>        Not documented
>
>     [...]
>
> This isn't what you want :)
>
> Better:
>
>    ##
>    # @EbpfObject:
>    #
>    # An eBPF ELF object.
>    #
>    # @object: the eBPF object encoded in base64
>    #
>    # Since: 8.2
>    ##
>
> > +{ 'struct': 'EbpfObject',
> > +  'data': {'object': 'str'},
> > +  'if': 'CONFIG_EBPF' }
> > +
> > +##
> > +# @EbpfProgramID:
> > +#
> > +# The eBPF programs that can be gotten with request-ebpf.
> > +#
> > +# @rss: Receive side scaling, technology that allows steering traffic
> > +# between queues by calculation hash. Users may set up indirection tab=
le
> > +# and hash/packet types configurations. Used with virtio-net.
>
> Please format like
>
>    # @rss: Receive side scaling, technology that allows steering traffic
>    #     between queues by calculation hash.  Users may set up
>    #     indirection table and hash/packet types configurations.  Used
>    #     with virtio-net.
>
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).

Thank you, I'll check it!

>
> > +#
> > +# Since: 8.3
> > +##
> > +{ 'enum': 'EbpfProgramID',
> > +  'if': 'CONFIG_EBPF',
> > +  'data': [ { 'name': 'rss' } ] }
> > +
> > +##
> > +# @request-ebpf:
> > +#
> > +# Returns eBPF object that can be loaded with libbpf.
> > +# Management applications (g.e. libvirt) may load it and pass file
> > +# descriptors to QEMU. Which allows running QEMU without BPF capabilit=
ies.
> > +# It's crucial that eBPF program/map is compatible with QEMU, so it's
> > +# provided through QMP.
> > +#
> > +# Returns: RSS eBPF object encoded in base64.
>
> What does "RSS" mean?

RSS - Receive-side Scaling.

>
> > +#
> > +# Since: 8.3
> > +#
> > +##
>
> You're not documenting argument @id.
>
> Generated documentation looks like
>
>     "request-ebpf" (Command)
>     ------------------------
>
>     Returns eBPF object that can be loaded with libbpf. Management
>     applications (g.e. libvirt) may load it and pass file descriptors to
>     QEMU. Which allows running QEMU without BPF capabilities. It's crucia=
l
>     that eBPF program/map is compatible with QEMU, so it's provided
>     through QMP.
>
>
>     Arguments
>     ~~~~~~~~~
>
>     "id": "EbpfProgramID"
>        Not documented
>
>
>     Returns
>     ~~~~~~~
>
>     RSS eBPF object encoded in base64.
>     [...]
>
> Here's my try:
>
>     ##
>     # @request-ebpf:
>     #
>     # Retrieve an eBPF object that can be loaded with libbpf.  Management
>     # applications (g.e. libvirt) may load it and pass file descriptors t=
o
>     # QEMU, so they can run running QEMU without BPF capabilities.
>     #
>     # @id: The ID of the program to return.
>     #
>     # Returns: RSS eBPF object encoded in base64.
>     #
>     # Since: 8.3
>     ##
>
> I omitted the "It's crucial" part, because I feel rationale doesn't
> belong here.  The commit message still has us covered.
>
> > +{ 'command': 'request-ebpf',
> > +  'data': { 'id': 'EbpfProgramID' },
> > +  'returns': 'EbpfObject',
> > +  'if': 'CONFIG_EBPF' }
>
> Terminology: you use "eBPF program" and "eBPF object".  What's the
> difference?  If there's none, use only one term, please.  To me,
> "program" feels more clear.

The eBPF object/blob is an ELF containing eBPF program and eBPF map
descriptions.
I've tried to cover it in the commit letter - I think adding an
explanation in the .json file is a good idea.
The "request-ebpf" should return an ELF object, so libbpf could open
and load it.


>
> > diff --git a/qapi/meson.build b/qapi/meson.build
> > index 60a668b3432..90047dae1c8 100644
> > --- a/qapi/meson.build
> > +++ b/qapi/meson.build
> > @@ -33,6 +33,7 @@ qapi_all_modules =3D [
> >    'crypto',
> >    'cxl',
> >    'dump',
> > +  'ebpf',
> >    'error',
> >    'introspect',
> >    'job',
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 6594afba312..2c82a49baec 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -53,6 +53,7 @@
> >  { 'include': 'char.json' }
> >  { 'include': 'dump.json' }
> >  { 'include': 'net.json' }
> > +{ 'include': 'ebpf.json' }
> >  { 'include': 'rdma.json' }
> >  { 'include': 'rocker.json' }
> >  { 'include': 'tpm.json' }
>

