Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E68125EA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 04:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDcMy-00008A-0M; Wed, 13 Dec 2023 22:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1rDcMv-00007r-GF
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 22:26:37 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1rDcMs-0005V4-9a
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 22:26:37 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6cda22140f2so7214803b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 19:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1702524270; x=1703129070;
 darn=nongnu.org; 
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=83IB1V/fMglbfxVwEaWEJCI3uKm+hpL8RGx8YZCl9Vg=;
 b=Oqpz1uYXSnp4tjDB3SerG5v1J7VdFJaZuA5jDqg1u91iAY7mje6i/EMy3VEoPy8UHP
 ywlH7JK6xuk3CN5D4GXq7C0sDrOXidyf9FUE6QRhVffGSqzC8aKCaF/i+TscIp0hGVxS
 bz8F8AnTLzJjiaeB1V/8LJ22a5ryle4dhaGOMI/Hh0xWoBzfewZ0+9rgwQEVHR287aWV
 sAQAYAgKPj6ZerxvIbfqKBGZ3XAs9ZXcokmDKBQt98Q8gmQxpEud8sABRM1lk98fORPQ
 87dC0NyM7JYumdOOA/SlRMRR8qerlplAGCubPgKsjPUpBS6nbSoPe03t7B0icrIqWx4E
 B7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702524270; x=1703129070;
 h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83IB1V/fMglbfxVwEaWEJCI3uKm+hpL8RGx8YZCl9Vg=;
 b=N+tvpgmJ3fX7vrfd42WqGm7KySeoOFyt53mU+NU2Wiy6OcRRtn/LZ6Hg9sRumbCFCA
 JPdz74k0wxA65vCPCqhlLwISfqbsxI5J004tif1WQCCONz7ZBET3j1M9LmHPrDNSnsEy
 tizVM5ZiYB8861zP6Q8Ugp5dKGj4ff7IR2hmwXJrS3VzeoVRlssz7nGF+r63f8MVRL3v
 r8w3RrY8GrFPrTMbC4Hy+YX7aCoJ02jJP6oLG6x8rYi4PvmffU+RqpXcuI60TCc3KW2S
 LK44MRrQyctxYyQXhQ6YP7lJ1Kx9kode4lnUhfdvH960T4V5fmEuZZSCD8gkn0EKfbr0
 cFqg==
X-Gm-Message-State: AOJu0YykAd2vSkKWTiwSJRkK65KYoWBM45p879T5EBjNK9o0oplW1BD/
 PAEaQ68bkbiHzk3foFFBg0wI1Q==
X-Google-Smtp-Source: AGHT+IGz4tekgIUaPuOfGQaBhbJ2JnZ9MVsTYzU/QY8Om4wGRlxEVS3ywav911a0zBO47Cs7vLM7cg==
X-Received: by 2002:a05:6a00:2401:b0:6cd:e8c3:f731 with SMTP id
 z1-20020a056a00240100b006cde8c3f731mr10147228pfh.19.1702524269054; 
 Wed, 13 Dec 2023 19:24:29 -0800 (PST)
Received: from smtpclient.apple ([103.172.41.203])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a62d457000000b006ce9e9d27c7sm11121367pfl.129.2023.12.13.19.24.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Dec 2023 19:24:28 -0800 (PST)
From: Li Feng <fengli@smartx.com>
Message-Id: <D52256EA-0E78-4952-BB96-4A3DC1CB648F@smartx.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_65D2DA90-CE70-4E8D-AB59-6B22189BD03F"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH 1/1] vhost-scsi: fix usage of error_reportf_err()
Date: Thu, 14 Dec 2023 11:25:35 +0800
In-Reply-To: <20231214003117.43960-1-dongli.zhang@oracle.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
References: <20231214003117.43960-1-dongli.zhang@oracle.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--Apple-Mail=_65D2DA90-CE70-4E8D-AB59-6B22189BD03F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Dec 14, 2023, at 08:31, Dongli Zhang <dongli.zhang@oracle.com> =
wrote:
>=20
> It is required to use error_report() instead of error_reportf_err(), =
if the
> prior function does not take local_err as the argument. As a result, =
the
> local_err is always NULL and segment fault may happen.
>=20
> vhost_scsi_start()
> -> vhost_scsi_set_endpoint(s) --> does not allocate local_err
> -> error_reportf_err()
>   -> error_vprepend()
>      -> g_string_append(newmsg, (*errp)->msg) --> (*errp) is NULL
>=20
> In addition, add ": " at the end of other error_reportf_err() logs.
>=20
> Fixes: 7962e432b4e4 ("vhost-user-scsi: support reconnect to backend")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> hw/scsi/vhost-scsi.c      | 4 ++--
> hw/scsi/vhost-user-scsi.c | 3 ++-
> 2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 3126df9e1d..9929c0d14b 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -91,13 +91,13 @@ static int vhost_scsi_start(VHostSCSI *s)
>=20
>     ret =3D vhost_scsi_common_start(vsc, &local_err);
>     if (ret < 0) {
> -        error_reportf_err(local_err, "Error starting vhost-scsi");
> +        error_reportf_err(local_err, "Error starting vhost-scsi: ");
>         return ret;
>     }
>=20
>     ret =3D vhost_scsi_set_endpoint(s);
>     if (ret < 0) {
> -        error_reportf_err(local_err, "Error setting vhost-scsi =
endpoint");
> +        error_report("Error setting vhost-scsi endpoint");
>         vhost_scsi_common_stop(vsc);
>     }
>=20
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 780f10559d..af18c4f3d3 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -83,7 +83,8 @@ static void vhost_user_scsi_set_status(VirtIODevice =
*vdev, uint8_t status)
>     if (should_start) {
>         ret =3D vhost_user_scsi_start(s, &local_err);
>         if (ret < 0) {
> -            error_reportf_err(local_err, "unable to start =
vhost-user-scsi: %s",
> +            error_reportf_err(local_err,
> +                              "unable to start vhost-user-scsi: %s: =
",
>                               strerror(-ret));
>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
> --=20
> 2.34.1
>=20
Looks good.

Reviewed-by: Feng Li <fengli@smartx.com>

Thanks.=

--Apple-Mail=_65D2DA90-CE70-4E8D-AB59-6B22189BD03F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: =
after-white-space;"><br><div><blockquote type=3D"cite"><div>On Dec 14, =
2023, at 08:31, Dongli Zhang &lt;dongli.zhang@oracle.com&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>It is =
required to use error_report() instead of error_reportf_err(), if =
the<br>prior function does not take local_err as the argument. As a =
result, the<br>local_err is always NULL and segment fault may =
happen.<br><br>vhost_scsi_start()<br>-&gt; vhost_scsi_set_endpoint(s) =
--&gt; does not allocate local_err<br>-&gt; error_reportf_err()<br> =
&nbsp;&nbsp;-&gt; error_vprepend()<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&gt; g_string_append(newmsg, =
(*errp)-&gt;msg) --&gt; (*errp) is NULL<br><br>In addition, add ": " at =
the end of other error_reportf_err() logs.<br><br>Fixes: 7962e432b4e4 =
("vhost-user-scsi: support reconnect to backend")<br>Signed-off-by: =
Dongli Zhang &lt;dongli.zhang@oracle.com&gt;<br>---<br> =
hw/scsi/vhost-scsi.c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 4 ++--<br> =
hw/scsi/vhost-user-scsi.c | 3 ++-<br> 2 files changed, 4 insertions(+), =
3 deletions(-)<br><br>diff --git a/hw/scsi/vhost-scsi.c =
b/hw/scsi/vhost-scsi.c<br>index 3126df9e1d..9929c0d14b 100644<br>--- =
a/hw/scsi/vhost-scsi.c<br>+++ b/hw/scsi/vhost-scsi.c<br>@@ -91,13 +91,13 =
@@ static int vhost_scsi_start(VHostSCSI *s)<br><br> =
&nbsp;&nbsp;&nbsp;&nbsp;ret =3D vhost_scsi_common_start(vsc, =
&amp;local_err);<br> &nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"Error starting vhost-scsi");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"Error starting vhost-scsi: ");<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ret;<br> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br><br> &nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_scsi_set_endpoint(s);<br> &nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) =
{<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_reportf_err(local_err, =
"Error setting vhost-scsi endpoint");<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_report("Error setting =
vhost-scsi endpoint");<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vhost_scsi_common_stop(vsc=
);<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><br>diff --git =
a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c<br>index =
780f10559d..af18c4f3d3 100644<br>--- a/hw/scsi/vhost-user-scsi.c<br>+++ =
b/hw/scsi/vhost-user-scsi.c<br>@@ -83,7 +83,8 @@ static void =
vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)<br> =
&nbsp;&nbsp;&nbsp;&nbsp;if (should_start) {<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ret =3D =
vhost_user_scsi_start(s, &amp;local_err);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (ret &lt; 0) {<br>- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
portf_err(local_err, "unable to start vhost-user-scsi: %s",<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;error_re=
portf_err(local_err,<br>+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;"unable to start vhost-user-scsi: %s: ",<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;strerror(-ret));<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;qe=
mu_chr_fe_disconnect(&amp;vs-&gt;conf.chardev);<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>-- =
<br>2.34.1<br><br></div></div></blockquote><pre style=3D"font-size: =
13px; background: rgb(255, 255, 255); color: rgb(0, 0, 51); text-wrap: =
wrap; font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;">Looks good.</pre><pre style=3D"font-size:=
 13px; background: rgb(255, 255, 255); color: rgb(0, 0, 51); text-wrap: =
wrap; font-variant-ligatures: normal; orphans: 2; widows: 2; =
text-decoration-thickness: initial; text-decoration-style: initial; =
text-decoration-color: initial;">
Reviewed-by: Feng Li =
&lt;fengli@smartx.com&gt;</pre></div><br><div>Thanks.</div></body></html>=

--Apple-Mail=_65D2DA90-CE70-4E8D-AB59-6B22189BD03F--

