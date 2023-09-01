Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F43478FDC8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3eG-0000qd-7G; Fri, 01 Sep 2023 08:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc3eE-0000q6-7U
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qc3e6-0006la-Rc
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693572784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UazYN2agKoybDP3HK3SYARlcHUFpWq6eNW2XaaCGQU=;
 b=TnVrcNIGtFWnkJDdp5JhPX+X0sIuEkBIGilL1lVVNV8QtxLish1ZEhJQbJ41DaFzabcIcH
 pRpepHcR/Dw8K4/G4d4AirKNBF9jVHJr3Dl+MnNFJQhtV2xJTruIKiNFVDYV6JphO/ohBd
 PVeM4GrQyRI5M55Xh2T/wOjJJ2FSKzM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-jAzkcK5BMy2QtGvBDIwLJQ-1; Fri, 01 Sep 2023 08:53:02 -0400
X-MC-Unique: jAzkcK5BMy2QtGvBDIwLJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F13D83C0EAAB;
 Fri,  1 Sep 2023 12:53:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE584412F2CD;
 Fri,  1 Sep 2023 12:53:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC7EC21E692A; Fri,  1 Sep 2023 14:52:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,  qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel =?utf-8?Q?P?=
 =?utf-8?Q?=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Greg Kurz
 <groug@kaod.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v3 11/11] machine: Improve error message when using
 default RAM backend id
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-12-david@redhat.com>
 <209b4b8c.54bc.18a2b7b6f53.Coremail.logoerthiner1@163.com>
 <e81b5069-e49a-cfb4-bea9-3c7ab6a358ca@redhat.com>
 <87msyfo5b0.fsf@pond.sub.org>
 <bd8f7f13-b982-6cf6-1ef7-16b4738b94ac@redhat.com>
 <87sf87momv.fsf@pond.sub.org>
 <d87ac218-0051-ad91-5867-d1bec9f4fda4@redhat.com>
 <78fd367f-740a-4b37-0faf-dd0cabae4bd6@redhat.com>
Date: Fri, 01 Sep 2023 14:52:59 +0200
In-Reply-To: <78fd367f-740a-4b37-0faf-dd0cabae4bd6@redhat.com> (David
 Hildenbrand's message of "Fri, 25 Aug 2023 12:10:38 +0200")
Message-ID: <87ttsexdg4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

David Hildenbrand <david@redhat.com> writes:

> On 25.08.23 11:59, David Hildenbrand wrote:

[...]

>> ... hopefully I'm done with that error-handling pain in QEMU soon and
>> can continue focusing on things that make me feel more productive :P

I'm afraid you'll be done with error handling right when you're done
with developing software.

> ... hoping it's as simple as this:
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f0d35c6401..09f40c7f07 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1352,6 +1352,7 @@ out:
>   
>   void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
>   {
> +    ERRP_GUARD();
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> @@ -1380,9 +1381,13 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>                  numa_uses_legacy_mem()) {
>           if (object_property_find(object_get_objects_root(),
>                                    machine_class->default_ram_id)) {
> -            error_setg(errp, "object name '%s' is reserved for the default"
> -                " RAM backend, it can't be used for any other purposes."
> -                " Change the object's 'id' to something else",
> +            error_setg(errp, "object's id '%s' is reserved for the default"
> +                " RAM backend, it can't be used for any other purposes",
> +                machine_class->default_ram_id);
> +            error_append_hint(errp,
> +                "Change the object's 'id' to something else or disable"
> +                " automatic creation of the default RAM backend by setting"
> +                " 'memory-backend=%s' with '-machine'.\n",
>                   machine_class->default_ram_id);
>               return;
>           }

Looks good to me!


