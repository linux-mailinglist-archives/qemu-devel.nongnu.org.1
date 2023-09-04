Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBE79181F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9eL-0007of-Oc; Mon, 04 Sep 2023 09:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qd9eA-0007g5-V8
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:29:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qd9e6-0000k1-9N
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 09:29:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68c3b9f8333so897414b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 06:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1693834054; x=1694438854;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFhGCBAKg+gHQnVyRgyu1urOe/739zifFBUmXWMt6Pw=;
 b=dmGmVsGz/RLZuIJpDj+7XXdT+U1xcriLsOOgvgs6OIFFqADwaLjRS/TiTlHKsf4pd9
 R6fmSdvNoIBz4eaUbf2H0z1MdVvXaFNxi3tRaC7A/NxvWdc0mUT50Q1jv0dpVDHK9JQR
 HKXh0YzT83sh+6zr8q0jjZ6cEMP2K50ve7fEqesLvyMQeoHsI+/WrgZ+jO1t6QSh5I/S
 sskb8930Yg4IPxhCPyr9Vh3cXEVfAn5NuDwKzzy7zNxPr8hA9WV8FOF93D78cW0MlYiI
 Rl7UPoD1fvI7JmIJio/vXavkk4UnKosgKfFTdg01tGAVVeffMHyHQ/0r5hpHkRxWMlIG
 vrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693834054; x=1694438854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFhGCBAKg+gHQnVyRgyu1urOe/739zifFBUmXWMt6Pw=;
 b=hfu7VEp2LmRy6gcfb098oH8Br4eUxZgA3rDbx5LuEaQBZyQRMdum6SMX7kby84mPo/
 w6uKaVYG+a+u4hkRmb8O2QRNPCNvvGvq6N4LDRAM5C/C3taSzqPdi7FB60dZZTDRCJRF
 qlKCkOft4qBZOgCEWMMyr+SY7xY1zB33b+UAuX6oHuEBKUvONSE/3utnph/Wn6EBlXEp
 fxajxnDTwIYVzMKZCCX+C/Kjf47i1o7HKEs/Os1DhGSgdcYMimMNzjZ1xvE97jkOHrmi
 K61iADl5J0WOIYi2oAp0Yz/09bzeAZ0/UKJgWNvel5wvnR44+eolZgeA2jIoXf04TD61
 WVbA==
X-Gm-Message-State: AOJu0YxJT0iH98E4L42aGhR/RvW4kkRllv+RdKhvSbMa9UjwWifW7coX
 LyTJuooQmeMfak9iPgACSg4nxaHL52FVJC/t0TuKVQ==
X-Google-Smtp-Source: AGHT+IELx6AVspEtU/nkTmyh/aax8A7afGSzoN300asYs1akLG/K1tnBioydAYtUEpnUv2/M5Rc/7k6/v5FgTrRNM6M=
X-Received: by 2002:a05:6a00:22c1:b0:68b:a137:373d with SMTP id
 f1-20020a056a0022c100b0068ba137373dmr14258320pfj.17.1693834054162; Mon, 04
 Sep 2023 06:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR11MB6760A4AD57255448B62EDE38F5E4A@SA1PR11MB6760.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6760A4AD57255448B62EDE38F5E4A@SA1PR11MB6760.namprd11.prod.outlook.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 4 Sep 2023 21:27:17 +0800
Message-ID: <CAK9dgmYVeGGf=2jawm77DtiOeqvnN_dEiLvOWK3-r1zzC1DJ8A@mail.gmail.com>
Subject: Re: [PATCH] softmmu/dirtylimit: Fix usleep early return on signal
To: alloc.young@outlook.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001b72800604887901"
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000001b72800604887901
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 1, 2023 at 10:19=E2=80=AFAM <alloc.young@outlook.com> wrote:

> From: alloc <alloc.young@outlook.com>
>
> Timeout functions like usleep can return early on signal, which reduces
> more dirty pages than expected. In dirtylimit case, dirtyrate meter
> thread needs to kick all vcpus out to sync. The callchain:
>
> vcpu_calculate_dirtyrate
>     global_dirty_log_sync
>         memory_global_dirty_log_sync
>             kvm_log_sync_global
>                 kvm_dirty_ring_flush
>                     kvm_cpu_synchronize_kick_all <---- send vcpu signal
>
> For long time sleep, use qemu_cond_timedwait_iothread to handle cpu stop
> event.
>
>
The Dirty Limit algorithm seeks to keep the vCPU dirty page rate within
the set limit; since it focuses more emphasis on processing time and
precision, I feel that improvement should strive for the same result.
Could you please provide the final test results showing the impact of
that improvement?


> Signed-off-by: alloc <alloc.young@outlook.com>
> ---
>  softmmu/dirtylimit.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
> index fa959d7743..ee938c636d 100644
> --- a/softmmu/dirtylimit.c
> +++ b/softmmu/dirtylimit.c
> @@ -411,13 +411,28 @@ void dirtylimit_set_all(uint64_t quota,
>
>  void dirtylimit_vcpu_execute(CPUState *cpu)
>  {
> +    int64_t sleep_us, endtime_us;
> +
> +    dirtylimit_state_lock();
>      if (dirtylimit_in_service() &&
>          dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
>          cpu->throttle_us_per_full) {
>          trace_dirtylimit_vcpu_execute(cpu->cpu_index,
>                  cpu->throttle_us_per_full);
> -        usleep(cpu->throttle_us_per_full);
> -    }
> +        sleep_us =3D cpu->throttle_us_per_full;
> +        dirtylimit_state_unlock();
> +        endtime_us =3D qemu_clock_get_us(QEMU_CLOCK_REALTIME) + sleep_us=
;
> +        while (sleep_us > 0 && !cpu->stop) {
> +            if (sleep_us > SCALE_US) {
> +                qemu_mutex_lock_iothread();
> +                qemu_cond_timedwait_iothread(cpu->halt_cond, sleep_us /
> SCALE_US);
> +                qemu_mutex_unlock_iothread();
> +            } else
> +                g_usleep(sleep_us);
> +            sleep_us =3D endtime_us -
> qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> +        }
> +    } else
> +        dirtylimit_state_unlock();
>  }
>
>  static void dirtylimit_init(void)
> --
> 2.39.3
>
>

--=20
Best regards

--0000000000001b72800604887901
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 1, 202=
3 at 10:19=E2=80=AFAM &lt;<a href=3D"mailto:alloc.young@outlook.com">alloc.=
young@outlook.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:=
solid;border-left-color:rgb(204,204,204);padding-left:1ex">From: alloc &lt;=
<a href=3D"mailto:alloc.young@outlook.com" target=3D"_blank">alloc.young@ou=
tlook.com</a>&gt;<br>
<br>
Timeout functions like usleep can return early on signal, which reduces<br>
more dirty pages than expected. In dirtylimit case, dirtyrate meter<br>
thread needs to kick all vcpus out to sync. The callchain:<br>
<br>
vcpu_calculate_dirtyrate<br>
=C2=A0 =C2=A0 global_dirty_log_sync<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_sync<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_log_sync_global<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_dirty_ring_flus=
h<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm_c=
pu_synchronize_kick_all &lt;---- send vcpu signal<br>
<br>
For long time sleep, use qemu_cond_timedwait_iothread to handle cpu stop<br=
>
event.<br>
<br></blockquote><div><div class=3D"gmail_default" style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif"><br></div></div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">The Dirty L=
imit algorithm seeks to keep the vCPU dirty page rate within</div><div clas=
s=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-ser=
if">the set limit; since it focuses more emphasis on processing time and</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif">precision, I feel that improvement should strive for the sa=
me result.</div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">Could you please provide the final test result=
s showing the impact of</div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif">that improvement?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,2=
04,204);padding-left:1ex">
Signed-off-by: alloc &lt;<a href=3D"mailto:alloc.young@outlook.com" target=
=3D"_blank">alloc.young@outlook.com</a>&gt;<br>
---<br>
=C2=A0softmmu/dirtylimit.c | 19 +++++++++++++++++--<br>
=C2=A01 file changed, 17 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c<br>
index fa959d7743..ee938c636d 100644<br>
--- a/softmmu/dirtylimit.c<br>
+++ b/softmmu/dirtylimit.c<br>
@@ -411,13 +411,28 @@ void dirtylimit_set_all(uint64_t quota,<br>
<br>
=C2=A0void dirtylimit_vcpu_execute(CPUState *cpu)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 int64_t sleep_us, endtime_us;<br>
+<br>
+=C2=A0 =C2=A0 dirtylimit_state_lock();<br>
=C2=A0 =C2=A0 =C2=A0if (dirtylimit_in_service() &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirtylimit_vcpu_get_state(cpu-&gt;cpu_ind=
ex)-&gt;enabled &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_full) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_dirtylimit_vcpu_execute(cpu-&gt;cpu=
_index,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throt=
tle_us_per_full);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 usleep(cpu-&gt;throttle_us_per_full);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_us =3D cpu-&gt;throttle_us_per_full;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dirtylimit_state_unlock();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 endtime_us =3D qemu_clock_get_us(QEMU_CLOCK_RE=
ALTIME) + sleep_us;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (sleep_us &gt; 0 &amp;&amp; !cpu-&gt;sto=
p) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sleep_us &gt; SCALE_US) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_io=
thread();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_cond_timedwai=
t_iothread(cpu-&gt;halt_cond, sleep_us / SCALE_US);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_unlock_=
iothread();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_usleep(sleep_us)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_us =3D endtime_us - qemu_c=
lock_get_us(QEMU_CLOCK_REALTIME);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dirtylimit_state_unlock();<br>
=C2=A0}<br>
<br>
=C2=A0static void dirtylimit_init(void)<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000001b72800604887901--

