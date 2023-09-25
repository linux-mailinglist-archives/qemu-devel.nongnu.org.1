Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754D7ACD58
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 02:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkZtE-0007i6-RI; Sun, 24 Sep 2023 20:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qkZtC-0007hh-CF
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 20:55:54 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qkZt9-0005Uc-GI
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 20:55:54 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57b5ef5b947so3232231eaf.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695603227; x=1696208027;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u0vz8ZdhcITKudvgRDvEZOlBWS0ISWtLBk3scuv/Mb4=;
 b=CcJJEfsPaOmALvW01fyTltbJxTe8y2lT3ylMTytCdkPc7XGu1ftqDw93RLzX9vq+Vo
 YW1ci/j3Ox4hNCeykZTx09Lkjz3gJElK5gG04v/OOpTzz9DvzXMcwPWr/BmA13g69UW6
 vhUKAfJ1LsGynwm5uLlvGf91sPbfeh+LRUuSBk3Njt76bZVzwWIgln4Pd7vaxDsJeqby
 R17h5b726bxJYp04w6mVYDCHMp0nUGubpblv74rEU2pbz880W1/TdWJM7HsJ/RihRxKj
 TNHUMizAp/qYdR5CecGVbsqVyXMLH3HOCkEOMk8LskdcqJAWngkpSmb80ygqNX235sfU
 hYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695603227; x=1696208027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0vz8ZdhcITKudvgRDvEZOlBWS0ISWtLBk3scuv/Mb4=;
 b=g0snby23XrNdAhRbvxdl+D44UDF6sN008v3t3jef20m3lU21Jyt4PEQuZ/fRd/Timg
 j3xwWe30OGlhgt/KuBMbUheSXgYiEzozap5G9eSvw/1EhoKuDmAalmVlo89qI0JnCVMX
 1q2mIAfdnYHYzFxaluldCXMAyinKVk6qtx61h+yjzi4veXPRqpsApdukx/lsdoqUubpv
 wHBtvkakHcKCGZ13Irpi1ivIZJT4sqQYcizhrI4BJ+XQmV8mr3F+fVnmIYdqW59JGNHz
 BJun1dO0NY/41afVX/PC3LpGW5XmBRs0HflYH3Y1HiLNVZQMNrqz7ebJEBxZxu/8rS7L
 vqHg==
X-Gm-Message-State: AOJu0Yz/CU48RMoArQhYKVrbXHXnHKc4j7zgdOTiENfLxRbeNU7szSPc
 KTLnKNUx/hfyJ8iOQ1t6BqABK9KLF+QZS5aWqLb5GQ==
X-Google-Smtp-Source: AGHT+IGr7znkPJHMgLSQGtkZuUVnK42+X6SZ3q6xgQ2y0zvMQFlzRlekfXa4W98TocOCfX6MwKeZ61nipUXHxBNIEwM=
X-Received: by 2002:a05:6358:912:b0:134:e631:fd2b with SMTP id
 r18-20020a056358091200b00134e631fd2bmr6152643rwi.0.1695603227422; Sun, 24 Sep
 2023 17:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
In-Reply-To: <399861531e3b24a1ecea2ba453fb2c3d129fb03a.1693905328.git.gudkov.andrei@huawei.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 25 Sep 2023 08:53:31 +0800
Message-ID: <CAK9dgmZrztaWv8dzS0wHV-nEAbbHmefGfMy0O6L51EGAKmUvOw@mail.gmail.com>
Subject: Re: [PATCH] migration/dirtyrate: use QEMU_CLOCK_HOST to report
 start-time
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 leobras@redhat.com, eblake@redhat.com, armbru@redhat.com
Content-Type: multipart/alternative; boundary="0000000000000d080106062464be"
Received-SPF: none client-ip=2607:f8b0:4864:20::c35;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc35.google.com
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

--0000000000000d080106062464be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 5, 2023 at 5:19=E2=80=AFPM Andrei Gudkov <gudkov.andrei@huawei.=
com>
wrote:

> Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as
> the source for start-time field. This translates to
> clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds
> since host boot. This is not very useful. The only
> reasonable use case of start-time I can imagine is to
> check whether previously completed measurements are
> too old or not. But this makes sense only if start-time
> is reported as host wall-clock time.
>
> This patch replaces source of start-time from
> QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/migration.json   |  4 ++--
>  migration/dirtyrate.c | 15 ++++++---------
>  2 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8843e74b59..63deb8e387 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1941,12 +1941,12 @@
>  # 1. Measurement is in progress:
>  #
>  # <- {"status": "measuring", "sample-pages": 512,
> -#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
> +#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10=
}
>  #
>  # 2. Measurement has been completed:
>  #
>  # <- {"status": "measured", "sample-pages": 512, "dirty-rate": 108,
> -#     "mode": "page-sampling", "start-time": 3665220, "calc-time": 10}
> +#     "mode": "page-sampling", "start-time": 1693900454, "calc-time": 10=
}
>  ##
>  { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bccb3515e3..0510d68765 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -259,11 +259,10 @@ static struct DirtyRateInfo
> *query_dirty_rate_info(void)
>      return info;
>  }
>
> -static void init_dirtyrate_stat(int64_t start_time,
> -                                struct DirtyRateConfig config)
> +static void init_dirtyrate_stat(struct DirtyRateConfig config)
>  {
>      DirtyStat.dirty_rate =3D -1;
> -    DirtyStat.start_time =3D start_time;
> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>      DirtyStat.calc_time =3D config.sample_period_seconds;
>      DirtyStat.sample_pages =3D config.sample_pages_per_gigabytes;
>
> @@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct
> DirtyRateConfig config)
>      record_dirtypages_bitmap(&dirty_pages, true);
>
>      start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -    DirtyStat.start_time =3D start_time / 1000;
> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>
>      msec =3D config.sample_period_seconds * 1000;
>      msec =3D dirty_stat_wait(msec, start_time);
> @@ -628,7 +627,7 @@ static void calculate_dirtyrate_dirty_ring(struct
> DirtyRateConfig config)
>      /* start log sync */
>      global_dirty_log_change(GLOBAL_DIRTY_DIRTY_RATE, true);
>
> -    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 10=
00;
> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>
>      /* calculate vcpu dirtyrate */
>      duration =3D vcpu_calculate_dirtyrate(config.sample_period_seconds *
> 1000,
> @@ -657,6 +656,7 @@ static void calculate_dirtyrate_sample_vm(struct
> DirtyRateConfig config)
>
>      rcu_read_lock();
>      initial_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
>      if (!record_ramblock_hash_info(&block_dinfo, config, &block_count)) =
{
>          goto out;
>      }
> @@ -664,7 +664,6 @@ static void calculate_dirtyrate_sample_vm(struct
> DirtyRateConfig config)
>
>      msec =3D config.sample_period_seconds * 1000;
>      msec =3D dirty_stat_wait(msec, initial_time);
> -    DirtyStat.start_time =3D initial_time / 1000;
>      DirtyStat.calc_time =3D msec / 1000;
>
>      rcu_read_lock();
> @@ -727,7 +726,6 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>      static struct DirtyRateConfig config;
>      QemuThread thread;
>      int ret;
> -    int64_t start_time;
>
>      /*
>       * If the dirty rate is already being measured, don't attempt to
> start.
> @@ -799,8 +797,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>       **/
>      dirtyrate_mode =3D mode;
>
> -    start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
> -    init_dirtyrate_stat(start_time, config);
> +    init_dirtyrate_stat(config);
>
>      qemu_thread_create(&thread, "get_dirtyrate", get_dirtyrate_thread,
>                         (void *)&config, QEMU_THREAD_DETACHED);
> --
> 2.30.2
>
>

Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--0000000000000d080106062464be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 5, 202=
3 at 5:19=E2=80=AFPM Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huaw=
ei.com">gudkov.andrei@huawei.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
Currently query-dirty-rate uses QEMU_CLOCK_REALTIME as<br>
the source for start-time field. This translates to<br>
clock_gettime(CLOCK_MONOTONIC), i.e. number of seconds<br>
since host boot. This is not very useful. The only<br>
reasonable use case of start-time I can imagine is to<br>
check whether previously completed measurements are<br>
too old or not. But this makes sense only if start-time<br>
is reported as host wall-clock time.<br>
<br>
This patch replaces source of start-time from<br>
QEMU_CLOCK_REALTIME to QEMU_CLOCK_HOST.<br>
<br>
Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huawei.com=
" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
---<br>
=C2=A0qapi/migration.json=C2=A0 =C2=A0|=C2=A0 4 ++--<br>
=C2=A0migration/dirtyrate.c | 15 ++++++---------<br>
=C2=A02 files changed, 8 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/qapi/migration.json b/qapi/migration.json<br>
index 8843e74b59..63deb8e387 100644<br>
--- a/qapi/migration.json<br>
+++ b/qapi/migration.json<br>
@@ -1941,12 +1941,12 @@<br>
=C2=A0# 1. Measurement is in progress:<br>
=C2=A0#<br>
=C2=A0# &lt;- {&quot;status&quot;: &quot;measuring&quot;, &quot;sample-page=
s&quot;: 512,<br>
-#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10}<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 1693900454, &quot;calc-time&quot;: 10}<br>
=C2=A0#<br>
=C2=A0# 2. Measurement has been completed:<br>
=C2=A0#<br>
=C2=A0# &lt;- {&quot;status&quot;: &quot;measured&quot;, &quot;sample-pages=
&quot;: 512, &quot;dirty-rate&quot;: 108,<br>
-#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 3665220, &quot;calc-time&quot;: 10}<br>
+#=C2=A0 =C2=A0 =C2=A0&quot;mode&quot;: &quot;page-sampling&quot;, &quot;st=
art-time&quot;: 1693900454, &quot;calc-time&quot;: 10}<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;query-dirty-rate&#39;, &#39;returns&#39;: &=
#39;DirtyRateInfo&#39; }<br>
<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index bccb3515e3..0510d68765 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -259,11 +259,10 @@ static struct DirtyRateInfo *query_dirty_rate_info(vo=
id)<br>
=C2=A0 =C2=A0 =C2=A0return info;<br>
=C2=A0}<br>
<br>
-static void init_dirtyrate_stat(int64_t start_time,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct DirtyRateConfig config)<br>
+static void init_dirtyrate_stat(struct DirtyRateConfig config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.dirty_rate =3D -1;<br>
-=C2=A0 =C2=A0 DirtyStat.start_time =3D start_time;<br>
+=C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) =
/ 1000;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.calc_time =3D config.sample_period_seconds;<b=
r>
=C2=A0 =C2=A0 =C2=A0DirtyStat.sample_pages =3D config.sample_pages_per_giga=
bytes;<br>
<br>
@@ -600,7 +599,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct Dir=
tyRateConfig config)<br>
=C2=A0 =C2=A0 =C2=A0record_dirtypages_bitmap(&amp;dirty_pages, true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);<=
br>
-=C2=A0 =C2=A0 DirtyStat.start_time =3D start_time / 1000;<br>
+=C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) =
/ 1000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0msec =3D config.sample_period_seconds * 1000;<br>
=C2=A0 =C2=A0 =C2=A0msec =3D dirty_stat_wait(msec, start_time);<br>
@@ -628,7 +627,7 @@ static void calculate_dirtyrate_dirty_ring(struct Dirty=
RateConfig config)<br>
=C2=A0 =C2=A0 =C2=A0/* start log sync */<br>
=C2=A0 =C2=A0 =C2=A0global_dirty_log_change(GLOBAL_DIRTY_DIRTY_RATE, true);=
<br>
<br>
-=C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTI=
ME) / 1000;<br>
+=C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) =
/ 1000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* calculate vcpu dirtyrate */<br>
=C2=A0 =C2=A0 =C2=A0duration =3D vcpu_calculate_dirtyrate(config.sample_per=
iod_seconds * 1000,<br>
@@ -657,6 +656,7 @@ static void calculate_dirtyrate_sample_vm(struct DirtyR=
ateConfig config)<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
=C2=A0 =C2=A0 =C2=A0initial_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME)=
;<br>
+=C2=A0 =C2=A0 DirtyStat.start_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST) =
/ 1000;<br>
=C2=A0 =C2=A0 =C2=A0if (!record_ramblock_hash_info(&amp;block_dinfo, config=
, &amp;block_count)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -664,7 +664,6 @@ static void calculate_dirtyrate_sample_vm(struct DirtyR=
ateConfig config)<br>
<br>
=C2=A0 =C2=A0 =C2=A0msec =3D config.sample_period_seconds * 1000;<br>
=C2=A0 =C2=A0 =C2=A0msec =3D dirty_stat_wait(msec, initial_time);<br>
-=C2=A0 =C2=A0 DirtyStat.start_time =3D initial_time / 1000;<br>
=C2=A0 =C2=A0 =C2=A0DirtyStat.calc_time =3D msec / 1000;<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_read_lock();<br>
@@ -727,7 +726,6 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0static struct DirtyRateConfig config;<br>
=C2=A0 =C2=A0 =C2=A0QemuThread thread;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
-=C2=A0 =C2=A0 int64_t start_time;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * If the dirty rate is already being measured, don&#39=
;t attempt to start.<br>
@@ -799,8 +797,7 @@ void qmp_calc_dirty_rate(int64_t calc_time,<br>
=C2=A0 =C2=A0 =C2=A0 **/<br>
=C2=A0 =C2=A0 =C2=A0dirtyrate_mode =3D mode;<br>
<br>
-=C2=A0 =C2=A0 start_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000=
;<br>
-=C2=A0 =C2=A0 init_dirtyrate_stat(start_time, config);<br>
+=C2=A0 =C2=A0 init_dirtyrate_stat(config);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_thread_create(&amp;thread, &quot;get_dirtyrate&quo=
t;, get_dirtyrate_thread,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (void *)&amp;config, QEMU_THREAD_DETACHED);<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div><div><br></div><br clear=3D"all"><div><span style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Reviewed-by: Hyman Huang &lt=
;</span><a href=3D"mailto:yong.huang@smartx.com" target=3D"_blank" style=3D=
"font-family:&quot;comic sans ms&quot;,sans-serif">yong.huang@smartx.com</a=
><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">&gt;</spa=
n><br></div><div><span style=3D"font-family:&quot;comic sans ms&quot;,sans-=
serif"><br></span></div><span class=3D"gmail_signature_prefix">-- </span><b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D=
"comic sans ms, sans-serif">Best regards</font></div></div></div>

--0000000000000d080106062464be--

