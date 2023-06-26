Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF373DB3D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiP8-0007pY-AY; Mon, 26 Jun 2023 05:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDiP3-0007p7-Br
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDiP0-0007wu-37
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687771253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KPxgUMUgoaBaglrWT9PnBHEU+kMUs50BA/yptrRTKYI=;
 b=R3VvGWfKVdpEHWGNQVUJ6dOY19uHX2fboOGuK1LwK+RG8U3zRE8/fjHmwjyU8wdjcDndqR
 8pJx8/a3Ngo9Je0aMYzQ8u09k9OLLl5YGxKSdsTTwu+UA3hvNCKH6WXTx9DU8lDYh+hz17
 ObZFFcXH7+kEXAk5KMxEGO32cPL+w6M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-IYLKsQ1iPluvdWCYTlgwHg-1; Mon, 26 Jun 2023 05:20:48 -0400
X-MC-Unique: IYLKsQ1iPluvdWCYTlgwHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBCEF3C0F684
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 09:20:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C924C585A0;
 Mon, 26 Jun 2023 09:20:47 +0000 (UTC)
Date: Mon, 26 Jun 2023 10:20:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] target/i386: allow using named CPU modeles with
 user mode emulation
Message-ID: <ZJlYbXKwd4SxoaxY@redhat.com>
References: <20230626083317.144746-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230626083317.144746-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jun 26, 2023 at 10:33:14AM +0200, Paolo Bonzini wrote:
> When running qemu-i386 even with -cpu Nehalem (aka x86_64-v2), it raises the
> warning
> 
>   TCG doesn't support requested feature: CPUID.80000001H:EDX.lm [bit 29]
>
> Likewise using qemu-x86_64 with -cpu Haswell, it raises warnings for
> 
>   TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
>   TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit 21]
>   TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadline [bit 24]
>   TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bit 10]
> 
> Even though x86_64-v3 is the level that qemu-user is supposed to provide.

> These are two related problems:
> 
> - for Haswell, the 4 missing features are only relevant to code running
>   in kernel mode; we can ignore them and mark them as supported even
>   though they are not.  The supported features are only used to print
>   the warnings
> 
> - for qemu-i386, the issue is that this emulator is restricted to running
>   programs on a 32-bit processor, even though it is actually emulating
>   programs that use the 32-bit kernel ABI on any processor.  The behavior
>   the processor in compatibility (32-bit CS, EFER.LMA=1) mode is mostly
>   the same as when EFER.LMA=0 and the little code that is needed to handle
>   64-bit ring-0 is even present in the qemu-i386 binary, just hidden
>   behind checks for HF_LMA_MASK.  So, LM can also be treated as a feature
>   that is only relevant in kernel mode; not entirely, so this cannot yet
>   be extended to bsd-user, but the required changes are minimal.

IMHO in this case we should hard block all named CPUs with
'lm' set from qemu-i386. It only makes sense to use named CPU
models that were actually from the 32-bit era with qemu-i386.

If someone wants Nehalem then they should be using qemu-x86_64.
If someone wants qemu-i386 then they should be using an older
named CPU model predating 'lm'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


