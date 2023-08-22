Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C978420F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:28:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRQL-0006ce-Oq; Tue, 22 Aug 2023 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYRQJ-0006aD-82
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYRQG-0003sq-Sr
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692710872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E9o7H94etu7JWY7Q+ZJIsMV0C8D46s248ZHLN6wXok0=;
 b=TqeK+iUopIiuMUvmiaFeSaK38l6ZxOwvsg8bP3PmIq96vLm+tmi7HScEPF6dTWWbO3vsOF
 zGW13C8+y+MYbdmV7kQTc85NHVP+jJRNXl8HKFhTsJEtThCfAdas9CWtVjmUxlkbqb6Ykd
 4BYpOadHhOheIVtI1HnMdWzpG+adJ+0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-4aHABKqsN7ymaY9GhFXqIA-1; Tue, 22 Aug 2023 09:27:47 -0400
X-MC-Unique: 4aHABKqsN7ymaY9GhFXqIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F24173C0DDAC;
 Tue, 22 Aug 2023 13:27:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0BF6140E970;
 Tue, 22 Aug 2023 13:27:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A759421E690D; Tue, 22 Aug 2023 15:27:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-ppc@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Thiner Logoer <logoerthiner1@163.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Greg Kurz
 <groug@kaod.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH v2 3/9] backends/hostmem-file: Add "rom" property to
 support VM templating with R/O files
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-4-david@redhat.com>
Date: Tue, 22 Aug 2023 15:27:45 +0200
In-Reply-To: <20230822114504.239505-4-david@redhat.com> (David Hildenbrand's
 message of "Tue, 22 Aug 2023 13:44:51 +0200")
Message-ID: <87v8d72omm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

David Hildenbrand <david@redhat.com> writes:

> For now, "share=off,readonly=on" would always result in us opening the
> file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
> turning it into ROM.
>
> Especially for VM templating, "share=off" is a common use case. However,
> that use case is impossible with files that lack write permissions,
> because "share=off,readonly=on" will not give us writable RAM.
>
> The sole user of ROM via memory-backend-file are R/O NVDIMMs, but as we
> have users (Kata Containers) that rely on the existing behavior --
> malicious VMs should not be able to consume COW memory for R/O NVDIMMs --
> we cannot change the semantics of "share=off,readonly=on"
>
> So let's add a new "rom" property with on/off/auto values. "auto" is
> the default and what most people will use: for historical reasons, to not
> change the old semantics, it defaults to the value of the "readonly"
> property.
>
> For VM templating, one can now use:
>     -object memory-backend-file,share=off,readonly=on,rom=off,...
>
> But we'll disallow:
>     -object memory-backend-file,share=on,readonly=on,rom=off,...
> because we would otherwise get an error when trying to mmap the R/O file
> shared and writable. An explicit error message is cleaner.
>
> We will also disallow for now:
>     -object memory-backend-file,share=off,readonly=off,rom=on,...
>     -object memory-backend-file,share=on,readonly=off,rom=on,...
> It's not harmful, but also not really required for now.
>
> Alternatives that were abandoned:
> * Make "unarmed=on" for the NVDIMM set the memory region container
>   readonly. We would still see a change of ROM->RAM and possibly run
>   into memslot limits with vhost-user. Further, there might be use cases
>   for "unarmed=on" that should still allow writing to that memory
>   (temporary files, system RAM, ...).
> * Add a new "readonly=on/off/auto" parameter for NVDIMMs. Similar issues
>   as with "unarmed=on".
> * Make "readonly" consume "on/off/file" instead of being a 'bool' type.
>   This would slightly changes the behavior of the "readonly" parameter:
>   values like true/false (as accepted by a 'bool'type) would no longer be
>   accepted.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

[...]

>  static void file_backend_instance_finalize(Object *o)
> diff --git a/qapi/qom.json b/qapi/qom.json
> index fa3e88c8e6..0cf83c6f39 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -668,6 +668,9 @@
>  # @readonly: if true, the backing file is opened read-only; if false,
>  #     it is opened read-write.  (default: false)
>  #
> +# @rom: whether to create Read Only Memory (ROM).  If set to 'auto', it
> +#       defaults to the value of @readonly.  (default: auto, since 8.2)
> +#
>  # Since: 2.1
>  ##

The commit message discusses how @readonly, @rom and @share interact.
The doc comments don't, and users have to guess.

I can see two ways to help users:

1. Describe their interaction in full, so users can understand how to
get from them what they need.

2. Provide suitable guidance on how to use them.

>  { 'struct': 'MemoryBackendFileProperties',
> @@ -677,7 +680,8 @@
>              '*discard-data': 'bool',
>              'mem-path': 'str',
>              '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
> -            '*readonly': 'bool' } }
> +            '*readonly': 'bool',
> +            '*rom': 'OnOffAuto' } }
>  ##
>  # @MemoryBackendMemfdProperties:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 29b98c3d4c..03ce0b0a30 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4976,7 +4976,7 @@ SRST
>      they are specified. Note that the 'id' property must be set. These
>      objects are placed in the '/objects' path.
>  
> -    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off``
> +    ``-object memory-backend-file,id=id,size=size,mem-path=dir,share=on|off,discard-data=on|off,merge=on|off,dump=on|off,prealloc=on|off,host-nodes=host-nodes,policy=default|preferred|bind|interleave,align=align,offset=offset,readonly=on|off,rom=on|off|auto``
>          Creates a memory file backend object, which can be used to back
>          the guest RAM with huge pages.
>  
> @@ -5066,6 +5066,14 @@ SRST
>          The ``readonly`` option specifies whether the backing file is opened
>          read-only or read-write (default).
>  
> +        The ``rom`` option specifies whether to create Read Only Memory (ROM)
> +        that cannot be modified by the VM. If set to ``on``, the VM cannot
> +        modify the memory. If set to ``off``, the VM can modify the memory.
> +        If set to ``auto`` (default), the value of the ``readonly`` property
> +        is used. This option is primarily helpful for VM templating, where we
> +        want to open a file readonly (``readonly=on``) and allow private
> +        modifications of the memory by the VM (``share=off``, ``rom=off``).
> +

Here, you provide some guidance.

>      ``-object memory-backend-ram,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>          Creates a memory backend object, which can be used to back the
>          guest RAM. Memory backend objects offer more control than the


