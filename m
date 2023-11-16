Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F337EE17D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cMB-0001OS-Ho; Thu, 16 Nov 2023 08:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3cM5-0001J5-L8
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:24:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3cLt-0006LX-2Z
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700141050;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7w1l0Eciv16lpsD68WHs8ywsOhPhLud/8f3oZC21GlQ=;
 b=Ql6taUWEHvtp86DWodZBtWAtZ5Ps+IsM9KkM3QgLDynXuHMHmlu49a2VAoMQAdB42hwQyi
 oUBhkCChIFF2jciH6rLj9vDniIJS0FaXmHW98iahRnCrIJ3p1WKPitFM+VOI+KYDM19i6O
 /pkwGzuIZjyPnyKVviKjCXZ2YZ7V5ao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-5FrnNVxpOlCkFUnmEgX67Q-1; Thu,
 16 Nov 2023 08:24:08 -0500
X-MC-Unique: 5FrnNVxpOlCkFUnmEgX67Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF3F3C0FC8B;
 Thu, 16 Nov 2023 13:24:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A88FB492BE0;
 Thu, 16 Nov 2023 13:24:04 +0000 (UTC)
Date: Thu, 16 Nov 2023 13:24:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 5/5] qom/object: Limit type names to alphanumerical
 and some few special characters
Message-ID: <ZVYX8mcanVBl9-ho@redhat.com>
References: <20231116131454.541434-1-thuth@redhat.com>
 <20231116131454.541434-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231116131454.541434-6-thuth@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Nov 16, 2023 at 02:14:54PM +0100, Thomas Huth wrote:
> QOM names currently don't have any enforced naming rules. This
> can be problematic, e.g. when they are used on the command line
> for the "-device" option (where the comma is used to separate
> properties). To avoid that such problematic type names come in
> again, let's restrict the set of acceptable characters during the
> type registration.
> 
> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
> names should begin with a letter, and contain only ASCII letters,
> digits, hyphen, and underscore. However, we already have so many
> pre-existing types like:
> 
>     486-x86_64-cpu
>     cfi.pflash01
>     power5+_v2.1-spapr-cpu-core
>     virt-2.6-machine
>     pc-i440fx-3.0-machine
> 
> ... so that we have to allow "." and "+" for now, too. While the
> dot is used in a lot of places, the "+" can fortunately be limited
> to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).
> 
> We also cannot enforce the rule that names must start with a letter
> yet, since there are lot of types that start with a digit. Still,
> at least limiting the first characters to the alphanumerical range
> should be way better than nothing.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/qom/object.c b/qom/object.c
> index 95c0dc8285..571ef68950 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
>      return ti;
>  }
>  
> +static bool type_name_is_valid(const char *name)
> +{
> +    const int slen = strlen(name);
> +
> +    g_assert(slen > 1);
> +
> +    /*
> +     * Ideally, the name should start with a letter - however, we've got
> +     * too many names starting with a digit already, so allow digits here,
> +     * too (except '0' which is not used yet)
> +     */
> +    if (!g_ascii_isalnum(name[0]) || name[0] == '0') {
> +        return false;
> +    }
> +
> +    for (int i = 1; i < slen; i++) {
> +        if (name[i] != '-' && name[i] != '_' && name[i] != '.' &&
> +            !g_ascii_isalnum(name[i])) {
> +            if (name[i] == '+') {
> +                if (i == 6 && !strncmp(name, "power", 5)) {
> +                    /* It's a legacy name like "power5+" */
> +                    continue;
> +                }
> +                if (i >= 17 && !strncmp(name, "Sun-UltraSparc", 14)) {
> +                    /* It's a legacy name like "Sun-UltraSparc-IV+" */
> +                    continue;
> +                }
> +            }
> +            return false;
> +        }
> +    }

Replace this big loop with strspn, which has an asm optimized impl
in glibc

      ALPHA_LC "abcdefghijklmnopqrstuvwxyz"
      ALPHA_UC "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
      OTHER "0123456789-_."

      return (strspn(name, ALPHA_UC ALPHA_LC OTHER) == slen) ||
          (g_str_has_prefix(name, "power") && slen > 6 && name[6] == '+') ||
	  (g_str_has_prefix(name, "Sun-UltraSparc") && slen > 17 && name[17] == '+');


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


