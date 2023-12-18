Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763918170C3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:47:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDwC-0004Ag-Jy; Mon, 18 Dec 2023 08:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rFDw8-0004AP-DR
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rFDw3-00083T-Vh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702907129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/CDETKskGEFNAKniIuTEBe+wuW0VOImYZRwkakLpYMQ=;
 b=No1O2yOpKpOQFl3XTdeSvIf03Pxuasp+XaLaLV4VorVKH1RUabjngbbFkx+iIKvKgeBkbJ
 E/YhE1HU8/Alv8Bo393eiFE2JcWISiFfeST5qKJ7hIi+BnlKJjbXAfMwGrKmhmULTeu4YH
 EXB1C2Yu9i+SWhXQVCXy6eoWs0IQRys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-t9HDBYaXO9OvufO9TMsRsQ-1; Mon, 18 Dec 2023 08:45:27 -0500
X-MC-Unique: t9HDBYaXO9OvufO9TMsRsQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33652ced20fso2203617f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 05:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702907126; x=1703511926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/CDETKskGEFNAKniIuTEBe+wuW0VOImYZRwkakLpYMQ=;
 b=nwPhUVdaQ35VIvl8GSUorgLyoEx1jGlFn4f063M3vx7vjVH3yD4uckg+2lESjVCyCu
 /t6x/mwaDsTRzuDfqik7uhy0EbKYlq58AgiH33tUHnb+iv+fzZ7yjTrMFgvv2KW4Gpa6
 7zp+ZgIK4rHh5noKnr8unkRCZxW2t1UOJedoDWBh8A4nRaAd0nC14HwATFCWzclj7Oxm
 5AHQ1wvWoM3cCTwD12r2+rxWW+Prf/u8JzMaiN4yCeRczHSI7LdxH1DrxnMfrDMHSKPT
 iefPmrZG4ZvYU9DQUDW63QGGXAiDm2BqeGj83+0izmOgX0LJkFy42bYAbd9+jxMwTAbV
 YjqQ==
X-Gm-Message-State: AOJu0Yxautn9cp2+q2l+JfbcA9X6uu3zP50MTsgkyCxTmd/GTuqULG9/
 v+KU7TghMpTbmkWHKfUxd9EQ7RAzM7++FrKq+eYjtb2NL2XjJ5OCkCwIapoj+DUQV7So0W62pt9
 HGdYG0fmud2M+l24YpIFc6TanBnx+X5U=
X-Received: by 2002:a05:6512:3f0d:b0:50b:f51b:91f7 with SMTP id
 y13-20020a0565123f0d00b0050bf51b91f7mr7405527lfa.103.1702906640102; 
 Mon, 18 Dec 2023 05:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6L8IlVFeOolNDnUmgCURKcysQI1nyju0yrJ/lDRdzgq9UXjxB4vs8wrP/jRJs6h9G70chNyG0Q8JMI5A0kpw=
X-Received: by 2002:a05:6512:3f0d:b0:50b:f51b:91f7 with SMTP id
 y13-20020a0565123f0d00b0050bf51b91f7mr7405506lfa.103.1702906639707; Mon, 18
 Dec 2023 05:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20231124033946.197371-1-demeng@redhat.com>
 <20231124033946.197371-2-demeng@redhat.com>
In-Reply-To: <20231124033946.197371-2-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 18 Dec 2023 15:37:08 +0200
Message-ID: <CAPMcbCruNW=rUFGTp=7fZ=xpeJFpYKAnm4Pe8XEH7yPtNevdng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] qga/linux: Add new api 'guest-network-get-route'
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000588dc5060cc8d956"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

--000000000000588dc5060cc8d956
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dehan,

Thanks for your patch
Please see my comment below

On Fri, Nov 24, 2023 at 5:40=E2=80=AFAM Dehan Meng <demeng@redhat.com> wrot=
e:

> The Route information of the Linux VM needs to be used
> by administrators and users when debugging network problems
> and troubleshooting.
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  qga/commands-posix.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-win32.c |  6 ++++
>  qga/qapi-schema.json | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 6169bbf7a0..894cc43fce 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2747,6 +2747,78 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      return head;
>  }
>
> +char *hexToIPAddress(unsigned int hexValue);
>
remove this declaration and make the function static,
similar to dev_major_minor

+
> +char *hexToIPAddress(unsigned int hexValue)
> +{
> +    unsigned int byte1 =3D (hexValue >> 24) & 0xFF;
> +    unsigned int byte2 =3D (hexValue >> 16) & 0xFF;
> +    unsigned int byte3 =3D (hexValue >> 8) & 0xFF;
> +    unsigned int byte4 =3D hexValue & 0xFF;
> +
> +    return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
> +}
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    GuestNetworkRouteList *head =3D NULL, **tail =3D &head;
> +    const char *routeFile =3D "/proc/net/route";
> +    FILE *fp;
> +    size_t n;
> +    char *line =3D NULL;
> +    int firstLine =3D 1;
> +
> +    fp =3D fopen(routeFile, "r");
> +    if (fp =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", routeFile);
> +        free(line);
> +        return NULL;
> +    }
> +
> +    while (getline(&line, &n, fp) !=3D -1) {
> +        if (firstLine) {
> +            firstLine =3D 0;
> +            continue;
> +        }
> +        GuestNetworkRoute *route =3D NULL;
> +        GuestNetworkRouteStat *networkroute;
> +        int i;
> +        char Iface[16];
>

Use a define IFNAMSIZ from kernel instead of a hardcode
As in
https://github.com/qemu/qemu/blob/039afc5ef7367fbc8fb475580c291c2655e856cb/=
qemu-bridge-helper.c#L62


> +        unsigned int Destination, Gateway, Mask, Flags;
> +        int RefCnt, Use, Metric, MTU, Window, IRTT;
> +
> +        /* Parse the line and extract the values */
> +        i =3D (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
> +                    Iface, &Destination, &Gateway, &Flags, &RefCnt,
> +                    &Use, &Metric, &Mask, &MTU, &Window, &IRTT) =3D=3D 1=
1);
> +        if (i =3D=3D EOF) {
> +            continue;
> +        }
> +
> +        route =3D g_new0(GuestNetworkRoute, 1);
> +        route->type =3D GUEST_NETWORK_ROUTE_TYPE_LINUX;
>
I think we don't need it while flags, refcnt, etc are optional.
Just set FALSE in Windows.


> +
> +        networkroute =3D &route->u.q_linux;
> +        networkroute->iface =3D g_strdup(Iface);
> +        networkroute->destination =3D hexToIPAddress(Destination);
> +        networkroute->gateway =3D hexToIPAddress(Gateway);
> +        networkroute->mask =3D hexToIPAddress(Mask);
> +        networkroute->metric =3D Metric;
> +        networkroute->flags =3D Flags;
> +        networkroute->refcnt =3D RefCnt;
> +        networkroute->use =3D Use;
> +        networkroute->mtu =3D MTU;
> +        networkroute->window =3D Window;
> +        networkroute->irtt =3D IRTT;
>

set networkroute->has_irtt =3D true, etc
for each optional field.

similar to
https://github.com/qemu/qemu/blob/039afc5ef7367fbc8fb475580c291c2655e856cb/=
qga/commands-posix.c#L2598


> +
> +        QAPI_LIST_APPEND(tail, route);
> +    }
> +
> +    free(line);
> +    fclose(fp);
> +    return head;
> +}
> +
>  #else /* defined(__linux__) */
>
>  void qmp_guest_suspend_disk(Error **errp)
> @@ -3118,6 +3190,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      return NULL;
>  }
>
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> +
>  #endif /* CONFIG_FSFREEZE */
>
>  #if !defined(CONFIG_FSTRIM)
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 697c65507c..e62c04800a 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      error_setg(errp, QERR_UNSUPPORTED);
>      return NULL;
>  }
> +
> +GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
> +{
> +    error_setg(errp, QERR_UNSUPPORTED);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 876e2a8ea8..eed9539bb7 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1789,3 +1789,83 @@
>  { 'command': 'guest-get-cpustats',
>    'returns': ['GuestCpuStats']
>  }
> +
> +##
> +# @GuestNetworkRouteType:
> +#
> +# An enumeration of OS type
> +#
> +# Since: 8.2
> +##
> +{ 'enum': 'GuestNetworkRouteType',
> +  'data': [ 'linux' ] }
> +
>

no need for this enum,
GuestNetworkRouteStat is a generic and can be used in windows/linux


> +##
> +# @GuestNetworkRouteStat:
> +#
> +# Route information, currently, only linux supported.
> +#
> +# @iface: The destination network or host's egress network interface in
> the routing table
> +#
> +# @destination: The IP address of the target network or host, The final
> destination of the packet
> +#
> +# @gateway: The IP address of the next hop router
> +#
> +# @mask: Subnet Mask
> +#
> +# @metric: Route metric
> +#
> +# @flags: Route flags (not for windows)
> +#
> +# @irtt: Initial round-trip delay (not for windows)
> +#
> +# @refcnt: The route's reference count (not for windows)
> +#
> +# @use: Route usage count (not for windows)
> +#
> +# @window: TCP window size, used for flow control (not for windows)
> +#
> +# @mtu: Data link layer maximum packet size (not for windows)
> +#
> +# Since: 8.2
> +
> +##
> +{ 'struct': 'GuestNetworkRouteStat',
> +  'data': {'iface': 'str',
> +           'destination': 'str',
> +           'gateway': 'str',
> +           'metric': 'int',
> +           'mask': 'str',
> +           '*irtt': 'int',
> +           '*flags': 'uint64',
> +           '*refcnt': 'int',
> +           '*use': 'int',
> +           '*window': 'int',
> +           '*mtu': 'int'
> +           }}
> +
> +##
> +# @GuestNetworkRoute:
> +#
> +# Get route information of system.
> +#
> +# - @linux: Linux style network route
> +#
> +# Since: 8.2
> +##
> +{ 'union': 'GuestNetworkRoute',
> +  'base': { 'type': 'GuestNetworkRouteType' },
> +  'discriminator': 'type',
> +  'data': { 'linux': 'GuestNetworkRouteStat' } }
> +
> +##
> +# @guest-network-get-route:
> +#
> +# Retrieve information about route of network.
> +# Returns: List of route info of guest.
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'guest-network-get-route',
> +  'returns': ['GuestNetworkRoute']
> +}
> --
> 2.35.1
>
>

--000000000000588dc5060cc8d956
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div>Hi Deha=
n,</div><div><br></div><div>Thanks for your patch</div><div>Please see my c=
omment below <br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Fri, Nov 24, 2023 at 5:40=E2=80=AFAM Dehan Meng &=
lt;<a href=3D"mailto:demeng@redhat.com">demeng@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">The Route informat=
ion of the Linux VM needs to be used<br>
by administrators and users when debugging network problems<br>
and troubleshooting.<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c | 78 ++++++++++++++++++++++++++++++++++++++++++<=
br>
=C2=A0qga/commands-win32.c |=C2=A0 6 ++++<br>
=C2=A0qga/qapi-schema.json | 80 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A03 files changed, 164 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 6169bbf7a0..894cc43fce 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -2747,6 +2747,78 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
<br>
+char *hexToIPAddress(unsigned int hexValue);<br></blockquote><div>remove t=
his declaration and make the function static,</div><div>similar to dev_majo=
r_minor</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
+<br>
+char *hexToIPAddress(unsigned int hexValue)<br>
+{<br>
+=C2=A0 =C2=A0 unsigned int byte1 =3D (hexValue &gt;&gt; 24) &amp; 0xFF;<br=
>
+=C2=A0 =C2=A0 unsigned int byte2 =3D (hexValue &gt;&gt; 16) &amp; 0xFF;<br=
>
+=C2=A0 =C2=A0 unsigned int byte3 =3D (hexValue &gt;&gt; 8) &amp; 0xFF;<br>
+=C2=A0 =C2=A0 unsigned int byte4 =3D hexValue &amp; 0xFF;<br>
+<br>
+=C2=A0 =C2=A0 return g_strdup_printf(&quot;%u.%u.%u.%u&quot;, byte4, byte3=
, byte2, byte1);<br>
+}<br>
+<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestNetworkRouteList *head =3D NULL, **tail =3D &amp;head;<=
br>
+=C2=A0 =C2=A0 const char *routeFile =3D &quot;/proc/net/route&quot;;<br>
+=C2=A0 =C2=A0 FILE *fp;<br>
+=C2=A0 =C2=A0 size_t n;<br>
+=C2=A0 =C2=A0 char *line =3D NULL;<br>
+=C2=A0 =C2=A0 int firstLine =3D 1;<br>
+<br>
+=C2=A0 =C2=A0 fp =3D fopen(routeFile, &quot;r&quot;);<br>
+=C2=A0 =C2=A0 if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, routeFile);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (getline(&amp;line, &amp;n, fp) !=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (firstLine) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 firstLine =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRoute *route =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNetworkRouteStat *networkroute;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char Iface[16];<br></blockquote><div><br></div=
><div>Use a define=C2=A0IFNAMSIZ from kernel instead of a hardcode<br></div=
><div>As in <a href=3D"https://github.com/qemu/qemu/blob/039afc5ef7367fbc8f=
b475580c291c2655e856cb/qemu-bridge-helper.c#L62">https://github.com/qemu/qe=
mu/blob/039afc5ef7367fbc8fb475580c291c2655e856cb/qemu-bridge-helper.c#L62</=
a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int Destination, Gateway, Mask, Flags=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int RefCnt, Use, Metric, MTU, Window, IRTT;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Parse the line and extract the values */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i =3D (sscanf(line, &quot;%s %X %X %x %d %d %d=
 %X %d %d %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ifac=
e, &amp;Destination, &amp;Gateway, &amp;Flags, &amp;RefCnt,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;Use, &amp;Metric, &amp;Mask, &amp;MTU, &amp;Window, &amp;IRTT) =3D=3D 11);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D EOF) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route =3D g_new0(GuestNetworkRoute, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 route-&gt;type =3D GUEST_NETWORK_ROUTE_TYPE_LI=
NUX;<br></blockquote><div>I think we don&#39;t need it while flags, refcnt,=
 etc are optional.</div><div>Just set FALSE in Windows.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute =3D &amp;route-&gt;u.q_linux;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;iface =3D g_strdup(Iface);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;destination =3D hexToIPAddres=
s(Destination);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;gateway =3D hexToIPAddress(Ga=
teway);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;mask =3D hexToIPAddress(Mask)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;metric =3D Metric;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;flags =3D Flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;refcnt =3D RefCnt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;use =3D Use;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;mtu =3D MTU;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;window =3D Window;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 networkroute-&gt;irtt =3D IRTT;<br></blockquot=
e><div><br></div><div>set networkroute-&gt;has_irtt =3D true, etc</div><div=
>for each optional field.<br></div><div><br></div><div>similar to <a href=
=3D"https://github.com/qemu/qemu/blob/039afc5ef7367fbc8fb475580c291c2655e85=
6cb/qga/commands-posix.c#L2598">https://github.com/qemu/qemu/blob/039afc5ef=
7367fbc8fb475580c291c2655e856cb/qga/commands-posix.c#L2598</a></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, route);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(line);<br>
+=C2=A0 =C2=A0 fclose(fp);<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
+<br>
=C2=A0#else /* defined(__linux__) */<br>
<br>
=C2=A0void qmp_guest_suspend_disk(Error **errp)<br>
@@ -3118,6 +3190,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
=C2=A0#if !defined(CONFIG_FSTRIM)<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 697c65507c..e62c04800a 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **err=
p)<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORTED);<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
+<br>
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 error_setg(errp, QERR_UNSUPPORTED);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 876e2a8ea8..eed9539bb7 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1789,3 +1789,83 @@<br>
=C2=A0{ &#39;command&#39;: &#39;guest-get-cpustats&#39;,<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestCpuStats&#39;]<br>
=C2=A0}<br>
+<br>
+##<br>
+# @GuestNetworkRouteType:<br>
+#<br>
+# An enumeration of OS type<br>
+#<br>
+# Since: 8.2<br>
+##<br>
+{ &#39;enum&#39;: &#39;GuestNetworkRouteType&#39;,<br>
+=C2=A0 &#39;data&#39;: [ &#39;linux&#39; ] }<br>
+<br></blockquote><div><br></div><div>no need for this enum,</div><div>Gues=
tNetworkRouteStat is a generic and can be used in windows/linux<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+##<br>
+# @GuestNetworkRouteStat:<br>
+#<br>
+# Route information, currently, only linux supported.<br>
+#<br>
+# @iface: The destination network or host&#39;s egress network interface i=
n the routing table<br>
+#<br>
+# @destination: The IP address of the target network or host, The final de=
stination of the packet<br>
+#<br>
+# @gateway: The IP address of the next hop router<br>
+#<br>
+# @mask: Subnet Mask<br>
+#<br>
+# @metric: Route metric<br>
+#<br>
+# @flags: Route flags (not for windows)<br>
+#<br>
+# @irtt: Initial round-trip delay (not for windows)<br>
+#<br>
+# @refcnt: The route&#39;s reference count (not for windows)<br>
+#<br>
+# @use: Route usage count (not for windows)<br>
+#<br>
+# @window: TCP window size, used for flow control (not for windows)<br>
+#<br>
+# @mtu: Data link layer maximum packet size (not for windows)<br>
+#<br>
+# Since: 8.2<br>
+<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNetworkRouteStat&#39;,<br>
+=C2=A0 &#39;data&#39;: {&#39;iface&#39;: &#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;destination&#39;: &#39;str&#=
39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;gateway&#39;: &#39;str&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;metric&#39;: &#39;int&#39;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mask&#39;: &#39;str&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*irtt&#39;: &#39;int&#39;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*flags&#39;: &#39;uint64&#39=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*refcnt&#39;: &#39;int&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*use&#39;: &#39;int&#39;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*window&#39;: &#39;int&#39;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*mtu&#39;: &#39;int&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}}<br>
+<br>
+##<br>
+# @GuestNetworkRoute:<br>
+#<br>
+# Get route information of system.<br>
+#<br>
+# - @linux: Linux style network route<br>
+#<br>
+# Since: 8.2<br>
+##<br>
+{ &#39;union&#39;: &#39;GuestNetworkRoute&#39;,<br>
+=C2=A0 &#39;base&#39;: { &#39;type&#39;: &#39;GuestNetworkRouteType&#39; }=
,<br>
+=C2=A0 &#39;discriminator&#39;: &#39;type&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;linux&#39;: &#39;GuestNetworkRouteStat&#39; =
} }<br>
+<br>
+##<br>
+# @guest-network-get-route:<br>
+#<br>
+# Retrieve information about route of network.<br>
+# Returns: List of route info of guest.<br>
+#<br>
+# Since: 8.2<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-network-get-route&#39;,<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute&#39;]<br>
+}<br>
-- <br>
2.35.1<br>
<br>
</blockquote></div></div>

--000000000000588dc5060cc8d956--


