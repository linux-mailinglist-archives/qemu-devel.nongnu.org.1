Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B301C830BC3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:13:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9T4-0004RQ-Ec; Wed, 17 Jan 2024 12:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rQ9Sw-0004Qc-9X
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rQ9St-0000F4-DY
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705511554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T3ffV10rrhLmL/8JoeOex3hv0Ylv1LhWOGU8AwQxRdk=;
 b=OIvD/Tk91XpjW+7EmRLxqWR+q2NIe3wbRrAhiIRc/PC1PsL/STle7c45Ra3LhWO7/qVXlI
 byWaJ4whOJw92M/cuaepGTgyFiZBzMMl4R0/qIsYT6eC+7u/59T95dwZtb2J98PxMZd5f8
 CNEMLpfdBgPi88D14rSGE83XFpyatD0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-TKKae4w5NK6UGubSFqjIJg-1; Wed, 17 Jan 2024 12:12:32 -0500
X-MC-Unique: TKKae4w5NK6UGubSFqjIJg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ccbb39dcddso76876591fa.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511551; x=1706116351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3ffV10rrhLmL/8JoeOex3hv0Ylv1LhWOGU8AwQxRdk=;
 b=M/wCRPkOl2qFAQQdOi6ksUUt5Arc5LHlB84O5AWZ4SJLRGq+GxIC1GIezK+08c3EcE
 RBvNSf9P4MBvye04xZsmnnRU/vZKNO4LQDLtcqsTtu12/6nIbcnE+Y9K/+lkMGQDr2Ps
 RCqbaE6IbWcNVCyQok/XzK6h/pXwBfKc8Ws2ZK/lFCEuh170xV5Hq8BQxUxc7JpX7qe0
 9gQLFWiREbPbkWSYKrqIHjq3L41f0pZOempdqKs4CHfgI/bhF/+OV6UL3YJ6n0TCo4iC
 M3W5jyOqVWi2srt+tEw3FNwKojc1v7Jf3g0DaIOjcBdBqcZbVkfqrfPz0zdg525PDO1X
 RYMA==
X-Gm-Message-State: AOJu0YwZIqjAMRJShTF87Uf+zppx72+TALNBFRkojsAxEp3ijwvmv/ek
 yDeGG68ZuExn4HS8xnhYhnduLa5Z5cDpAskkUWqyYaZmR+2tLpRorBpJx4eHXzRm/a6PUas6QgB
 Yz/FkolResLVz0mE5l9a+bM7DSEo2NxyIhky0Nds=
X-Received: by 2002:ac2:5d47:0:b0:50e:8e94:bcfe with SMTP id
 w7-20020ac25d47000000b0050e8e94bcfemr2730143lfd.64.1705511550804; 
 Wed, 17 Jan 2024 09:12:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcRfhN7Xd8ZxmKcSK9kwukz0hNwBEu3g/8ItyVJ+N2RxUGq716H5hfpkJu9JqztWiz30EyfNRGbdf3Xc1qyhU=
X-Received: by 2002:ac2:5d47:0:b0:50e:8e94:bcfe with SMTP id
 w7-20020ac25d47000000b0050e8e94bcfemr2730140lfd.64.1705511550477; Wed, 17 Jan
 2024 09:12:30 -0800 (PST)
MIME-Version: 1.0
References: <65a04a86.49eda6.3044c037@gateway.sonic.net>
In-Reply-To: <65a04a86.49eda6.3044c037@gateway.sonic.net>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 17 Jan 2024 19:12:19 +0200
Message-ID: <CAPMcbCoow9=b-A33Y9c8=vT3uQPC0fTBik3n-B+o4XfkkCwbvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] qga: Solaris has net/if_arp.h and netinet/if_ether.h
 but not ETHER_ADDR_LEN
To: Nick Briggs <nicholas.h.briggs@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002076ff060f275ab0"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000002076ff060f275ab0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jan 11, 2024 at 10:18=E2=80=AFPM Nick Briggs <nicholas.h.briggs@gma=
il.com>
wrote:

> Solaris has net/if_arp.h and netinet/if_ether.h rather than net/ethernet.=
h,
> but does not define ETHER_ADDR_LEN, instead providing ETHERADDRL.
>
> Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
> ---
>  qga/commands-posix.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 6169bbf7a0..26008db497 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -45,9 +45,12 @@
>  #include <arpa/inet.h>
>  #include <sys/socket.h>
>  #include <net/if.h>
> -#if defined(__NetBSD__) || defined(__OpenBSD__)
> +#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(CONFIG_SOLARI=
S)
>  #include <net/if_arp.h>
>  #include <netinet/if_ether.h>
> +#if !defined(ETHER_ADDR_LEN) && defined(ETHERADDRL)
> +#define ETHER_ADDR_LEN ETHERADDRL
> +#endif
>  #else
>  #include <net/ethernet.h>
>  #endif
> --
> 2.31.1
>
>

--0000000000002076ff060f275ab0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 1=
1, 2024 at 10:18=E2=80=AFPM Nick Briggs &lt;<a href=3D"mailto:nicholas.h.br=
iggs@gmail.com">nicholas.h.briggs@gmail.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Solaris has net/if_arp.h and net=
inet/if_ether.h rather than net/ethernet.h,<br>
but does not define ETHER_ADDR_LEN, instead providing ETHERADDRL.<br>
<br>
Signed-off-by: Nick Briggs &lt;<a href=3D"mailto:nicholas.h.briggs@gmail.co=
m" target=3D"_blank">nicholas.h.briggs@gmail.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 5 ++++-<br>
=C2=A01 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 6169bbf7a0..26008db497 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -45,9 +45,12 @@<br>
=C2=A0#include &lt;arpa/inet.h&gt;<br>
=C2=A0#include &lt;sys/socket.h&gt;<br>
=C2=A0#include &lt;net/if.h&gt;<br>
-#if defined(__NetBSD__) || defined(__OpenBSD__)<br>
+#if defined(__NetBSD__) || defined(__OpenBSD__) || defined(CONFIG_SOLARIS)=
<br>
=C2=A0#include &lt;net/if_arp.h&gt;<br>
=C2=A0#include &lt;netinet/if_ether.h&gt;<br>
+#if !defined(ETHER_ADDR_LEN) &amp;&amp; defined(ETHERADDRL)<br>
+#define ETHER_ADDR_LEN ETHERADDRL<br>
+#endif<br>
=C2=A0#else<br>
=C2=A0#include &lt;net/ethernet.h&gt;<br>
=C2=A0#endif<br>
-- <br>
2.31.1<br>
<br>
</blockquote></div>

--0000000000002076ff060f275ab0--


