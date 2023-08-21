Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B55782F46
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 19:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY8Vl-0000mu-1o; Mon, 21 Aug 2023 13:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY8VU-0000mh-4r
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qY8VR-00005w-Jd
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 13:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692638156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8olqO7ZvdKc07kSyKxloCofZ5Rm+dvTQOxgwYQqHB2M=;
 b=SXsmD9LiLXz59MeMTwFdm2Bo2BsE7D47TuykxwLucmFlWDNR1VvJ7C+tmCUqN6hRzHgzVA
 0UC2g1svUM/Bb/zK41cRbTn7ld6pm0GEdJOL2YIUd4BZzmrJN60+OmkWzZE35C2AtrHOMj
 uSdLRX4RS3EOoQZNLRFUwJoZD8kqkzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-CgHAJ1AjNRK-89BBv0-Zrw-1; Mon, 21 Aug 2023 13:15:54 -0400
X-MC-Unique: CgHAJ1AjNRK-89BBv0-Zrw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E78D8D40A2;
 Mon, 21 Aug 2023 17:15:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F10CD492C14;
 Mon, 21 Aug 2023 17:15:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E58DB21E690D; Mon, 21 Aug 2023 19:15:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrew Melnichenko <andrew@daynix.com>
Cc: Markus Armbruster <armbru@redhat.com>,  jasowang@redhat.com,
 mst@redhat.com,  eblake@redhat.com,  berrange@redhat.com,
 qemu-devel@nongnu.org,  yuri.benditovich@daynix.com,  yan@daynix.com
Subject: Re: [PATCH v5 4/5] qmp: Added new command to retrieve eBPF blob.
References: <20230802204125.33688-1-andrew@daynix.com>
 <20230802204125.33688-5-andrew@daynix.com>
 <87sf8yx7qa.fsf@pond.sub.org>
 <CABcq3pHwT1-j_UZOG54yWawrTewdo-HL7X9ROO6xXkdB8hq71A@mail.gmail.com>
Date: Mon, 21 Aug 2023 19:15:52 +0200
In-Reply-To: <CABcq3pHwT1-j_UZOG54yWawrTewdo-HL7X9ROO6xXkdB8hq71A@mail.gmail.com>
 (Andrew Melnichenko's message of "Tue, 8 Aug 2023 20:43:36 +0300")
Message-ID: <87pm3g8gfr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Andrew Melnichenko <andrew@daynix.com> writes:

> Hi all,
> Thanks for the comments - I'll update and send new patches.
>
> On Sat, Aug 5, 2023 at 10:34=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Andrew Melnychenko <andrew@daynix.com> writes:
>>
>> > Now, the binary objects may be retrieved by id.
>> > It would require for future qmp commands that may require specific
>> > eBPF blob.
>> >
>> > Added command "request-ebpf". This command returns
>> > eBPF program encoded base64. The program taken from the
>> > skeleton and essentially is an ELF object that can be
>> > loaded in the future with libbpf.
>> >
>> > The reason to use the command to provide the eBPF object
>> > instead of a separate artifact was to avoid issues related
>> > to finding the eBPF itself. eBPF object is an ELF binary
>> > that contains the eBPF program and eBPF map description(BTF).
>> > Overall, eBPF object should contain the program and enough
>> > metadata to create/load eBPF with libbpf. As the eBPF
>> > maps/program should correspond to QEMU, the eBPF can't
>> > be used from different QEMU build.
>> >
>> > The first solution was a helper that comes with QEMU
>> > and loads appropriate eBPF objects. And the issue is
>> > to find a proper helper if the system has several
>> > different QEMUs installed and/or built from the source,
>> > which helpers may not be compatible.
>> >
>> > Another issue is QEMU updating while there is a running
>> > QEMU instance. With an updated helper, it may not be
>> > possible to hotplug virtio-net device to the already
>> > running QEMU. Overall, requesting the eBPF object from
>> > QEMU itself solves possible failures with acceptable effort.
>> >
>> > Links:
>> > [PATCH 3/5] qmp: Added the helper stamp check.
>> > https://lore.kernel.org/all/20230219162100.174318-4-andrew@daynix.com/
>> >
>> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
>> > ---
>>
>> [...]
>>
>> > diff --git a/qapi/ebpf.json b/qapi/ebpf.json
>> > new file mode 100644
>> > index 00000000000..40851f8c177
>> > --- /dev/null
>> > +++ b/qapi/ebpf.json

[...]

>> > +##
>> > +# @request-ebpf:
>> > +#
>> > +# Returns eBPF object that can be loaded with libbpf.
>> > +# Management applications (g.e. libvirt) may load it and pass file
>> > +# descriptors to QEMU. Which allows running QEMU without BPF capabili=
ties.
>> > +# It's crucial that eBPF program/map is compatible with QEMU, so it's
>> > +# provided through QMP.
>> > +#
>> > +# Returns: RSS eBPF object encoded in base64.
>>
>> What does "RSS" mean?
>
> RSS - Receive-side Scaling.

Suggest to use something like "receive-side scaling (RSS)" the first
time.

You could also put a general introduction right below the header, like

      ##
      # =3D eBPF Objects
      #
      # Text goes here
      ##

This is not a demand.

[...]


