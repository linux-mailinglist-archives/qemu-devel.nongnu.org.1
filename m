Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F310777092
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 08:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTzKl-0006tH-3z; Thu, 10 Aug 2023 02:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qTzKd-0006sj-Ay
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:39:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qTzKY-0007Ou-GH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 02:39:37 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso394894a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691649450; x=1692254250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KnjAL3sq0rT0uWyxkcf43CqP/Q5RgeM4xLwGyujJ4JE=;
 b=oAc5emUYKLNxLqloXIMJiv8esx/cb4W1gY/SCUVUmtKqmrRf5Q2LuMhhZuAYn2ROlO
 qW3VRZmBpu8YVgqM/c32vIh188HEug+MRzO581S/KxODNQ08a1T87H/aTCwjXEvf2yaq
 daJf7br6c3Ud4No2OtpdV11tm1Klg0FCOsIILyiYwyAJzQyeP/b2nPt/sXFfvBbBdd0t
 aAEEsrrGSNLwbAZvcfRHpXFrSRA+xYmD0zjYRNL235zPSY+wUMSRZt/i+Ahyc9sCDWLH
 9U2DFa3eAI2kZphPhdxkVMDwVTJvQbFBn3AX4zJIzKK+6A83DP8kMoXYyEBlV/dpN6Uj
 w/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691649450; x=1692254250;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KnjAL3sq0rT0uWyxkcf43CqP/Q5RgeM4xLwGyujJ4JE=;
 b=L8EPmWqJMULK7wpS1Y6JWHWhdF1YwQFakx4sDf6Ywys6Fd5XMHQTEr1LIrWoSNepFX
 3VK/5H1SGlODeRmpoEH573Dbgeprp8PR8KgrYwyYJVfK8GFCdfVO1y1VKm3FzQCq8WIc
 U8Db8AP5F5/daIOzVEMaejpVrMZC6BqLH3RXK68ExW4eyj+PPnj9SQD10LkDvJZ0shu7
 ty7iRWk71bwsuIfdgXhKEAfNOy2E0DmdCj3nPb3pNIGd9E9IszgP8kzG2Y4/d+I1jUDG
 2vf/6CSDpVTvd5jn96EaZdnQJKuLiR4Ed14aAegtj+7U/1w2odBZyScLpdpljRd8KbNe
 i3Wg==
X-Gm-Message-State: AOJu0Yz8fHS9Ya6p4I2Nz/cPAhwhpB7qryTahA5+wld1CE9lqUqDdEWr
 RnQq2dTLBfIMO4n65Xvy6Z0yq9JGEg+Vk/kWMVX+7Q==
X-Google-Smtp-Source: AGHT+IEKbxVofQxRlqQRZa8FWaulse3thYhpD+GfNJk4IQTveYh5c2TAqKdKqczMSx3KhrsdNXcBX2nk25UEEA2Mhos=
X-Received: by 2002:a17:90b:4b82:b0:268:7d8:597d with SMTP id
 lr2-20020a17090b4b8200b0026807d8597dmr1150227pjb.46.1691649450447; Wed, 09
 Aug 2023 23:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 <87fs4y3cqx.fsf@pond.sub.org>
 <CAK9dgmaW1qu3mTa50noH+v_kTSWvsgH1zCBZU-u4KHJmoVn4tA@mail.gmail.com>
 <ZNObqxnNAB40MR7e@DESKTOP-0LHM7NF.china.huawei.com>
In-Reply-To: <ZNObqxnNAB40MR7e@DESKTOP-0LHM7NF.china.huawei.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 10 Aug 2023 14:37:14 +0800
Message-ID: <CAK9dgmaNaHphD6X-itkkwvMJcQRczOf-VnXAXijD2eLcDeQG2Q@mail.gmail.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
To: gudkov.andrei@huawei.com
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, 
 peterx@redhat.com, leobras@redhat.com, eblake@redhat.com
Content-Type: multipart/alternative; boundary="00000000000094336506028bd4e1"
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52d.google.com
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

--00000000000094336506028bd4e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 9:59=E2=80=AFPM <gudkov.andrei@huawei.com> wrote:

> On Sun, Aug 06, 2023 at 02:31:43PM +0800, Yong Huang wrote:
> > On Sat, Aug 5, 2023 at 2:05=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com>
> wrote:
> >
> > > Andrei Gudkov <gudkov.andrei@huawei.com> writes:
> > >
> > > > Introduces alternative argument calc-time-ms, which is the
> > > > the same as calc-time but accepts millisecond value.
> > > > Millisecond granularity allows to make predictions whether
> > > > migration will succeed or not. To do this, calculate dirty
> > > > rate with calc-time-ms set to max allowed downtime, convert
> > > > measured rate into volume of dirtied memory, and divide by
> > > > network throughput. If the value is lower than max allowed
> > > > downtime, then migration will converge.
> > > >
> > > > Measurement results for single thread randomly writing to
> > > > a 1/4/24GiB memory region:
> > > >
> > > > +--------------+-----------------------------------------------+
> > > > | calc-time-ms |                dirty rate MiB/s               |
> > > > |              +----------------+---------------+--------------+
> > > > |              | theoretical    | page-sampling | dirty-bitmap |
> > > > |              | (at 3M wr/sec) |               |              |
> > > > +--------------+----------------+---------------+--------------+
> > > > |                             1GiB                             |
> > > > +--------------+----------------+---------------+--------------+
> > > > |          100 |           6996 |          7100 |         3192 |
> > > > |          200 |           4606 |          4660 |         2655 |
> > > > |          300 |           3305 |          3280 |         2371 |
> > > > |          400 |           2534 |          2525 |         2154 |
> > > > |          500 |           2041 |          2044 |         1871 |
> > > > |          750 |           1365 |          1341 |         1358 |
> > > > |         1000 |           1024 |          1052 |         1025 |
> > > > |         1500 |            683 |           678 |          684 |
> > > > |         2000 |            512 |           507 |          513 |
> > > > +--------------+----------------+---------------+--------------+
> > > > |                             4GiB                             |
> > > > +--------------+----------------+---------------+--------------+
> > > > |          100 |          10232 |          8880 |         4070 |
> > > > |          200 |           8954 |          8049 |         3195 |
> > > > |          300 |           7889 |          7193 |         2881 |
> > > > |          400 |           6996 |          6530 |         2700 |
> > > > |          500 |           6245 |          5772 |         2312 |
> > > > |          750 |           4829 |          4586 |         2465 |
> > > > |         1000 |           3865 |          3780 |         2178 |
> > > > |         1500 |           2694 |          2633 |         2004 |
> > > > |         2000 |           2041 |          2031 |         1789 |
> > > > +--------------+----------------+---------------+--------------+
> > > > |                             24GiB                            |
> > > > +--------------+----------------+---------------+--------------+
> > > > |          100 |          11495 |          8640 |         5597 |
> > > > |          200 |          11226 |          8616 |         3527 |
> > > > |          300 |          10965 |          8386 |         2355 |
> > > > |          400 |          10713 |          8370 |         2179 |
> > > > |          500 |          10469 |          8196 |         2098 |
> > > > |          750 |           9890 |          7885 |         2556 |
> > > > |         1000 |           9354 |          7506 |         2084 |
> > > > |         1500 |           8397 |          6944 |         2075 |
> > > > |         2000 |           7574 |          6402 |         2062 |
> > > > +--------------+----------------+---------------+--------------+
> > > >
> > > > Theoretical values are computed according to the following formula:
> > > > size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> > > > where size is in bytes, time is in seconds, and wps is number of
> > > > writes per second.
> > > >
> > > > Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> > > > ---
> > > >  qapi/migration.json   | 14 ++++++--
> > > >  migration/dirtyrate.h | 12 ++++---
> > > >  migration/dirtyrate.c | 81
> +++++++++++++++++++++++++------------------
> > > >  3 files changed, 67 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > index 8843e74b59..82493d6a57 100644
> > > > --- a/qapi/migration.json
> > > > +++ b/qapi/migration.json
> > > > @@ -1849,7 +1849,11 @@
> > > >  # @start-time: start time in units of second for calculation
> > > >  #
> > > >  # @calc-time: time period for which dirty page rate was measured
> > > > -#     (in seconds)
> > > > +#     (rounded down to seconds).
> > > > +#
> > > > +# @calc-time-ms: actual time period for which dirty page rate was
> > > > +#     measured (in milliseconds).  Value may be larger than
> requested
> > > > +#     time period due to measurement overhead.
> > > >  #
> > > >  # @sample-pages: number of sampled pages per GiB of guest memory.
> > > >  #     Valid only in page-sampling mode (Since 6.1)
> > > > @@ -1866,6 +1870,7 @@
> > > >             'status': 'DirtyRateStatus',
> > > >             'start-time': 'int64',
> > > >             'calc-time': 'int64',
> > > > +           'calc-time-ms': 'int64',
> > > >             'sample-pages': 'uint64',
> > > >             'mode': 'DirtyRateMeasureMode',
> > > >             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> > > > @@ -1908,6 +1913,10 @@
> > > >  #     dirty during @calc-time period, further writes to this page
> will
> > > >  #     not increase dirty page rate anymore.
> > > >  #
> > > > +# @calc-time-ms: the same as @calc-time but in milliseconds.  Thes=
e
> > > > +#    two arguments are mutually exclusive.  Exactly one of them mu=
st
> > > > +#    be specified. (Since 8.1)
> > > > +#
> > > >  # @sample-pages: number of sampled pages per each GiB of guest
> memory.
> > > >  #     Default value is 512.  For 4KiB guest pages this corresponds
> to
> > > >  #     sampling ratio of 0.2%.  This argument is used only in page
> > > > @@ -1925,7 +1934,8 @@
> > > >  #                                                 'sample-pages':
> 512} }
> > > >  # <- { "return": {} }
> > > >  ##
> > > > -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> > > > +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> > > > +                                         '*calc-time-ms': 'int64',
> > > >                                           '*sample-pages': 'int',
> > > >                                           '*mode':
> > > 'DirtyRateMeasureMode'} }
> > > >
> > >
> > > Having both @calc-time and @calc-time-ms is ugly.
> > >
> > > Can we deprecate @calc-time?
> > >
> > Since the upper app Libvirt has used this field to implement
> > the virDomainStartDirtyRateCalc API unfortunately.
> > Deprecating this requires the extra patch on Libvirt but no
> > functional improvement, IMHO, the field could remain untouched.
> >
> > >
> > > I don't like the name @calc-time-ms.  We don't put units in names
> > > elsewhere.
> > >
> > > Differently ugly: new member containing the fractional part, i.e. tim=
e
> > > in seconds =3D calc-time + fractional-part / 1000.  With a better nam=
e,
> of
> > > course.
> > >
> > > [...]
> > >
> > >
>
> As another alternative I can propose to add an optional field that
> specifies time unit.
>
> Initiate dirty page rate measurements for 300ms period:
> {"execute": "calc-dirty-rate",
>  "arguments":{"calc-time": 300, "time-unit": "millis"}}
>
> Query dirty rate. Report calc-time in milliseconds:
> {"execute": "query-dirty-rate",
>  "arguments":{"time-unit": "millis"}}
>

This sounds good and compatible with the old api. Thanks !

>
> > Thanks,
> >
> > Yong
> > --
> > Best regards
>

yong.

--=20
Best regards

--00000000000094336506028bd4e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 9, 202=
3 at 9:59=E2=80=AFPM &lt;<a href=3D"mailto:gudkov.andrei@huawei.com">gudkov=
.andrei@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style=
:solid;border-left-color:rgb(204,204,204);padding-left:1ex">On Sun, Aug 06,=
 2023 at 02:31:43PM +0800, Yong Huang wrote:<br>
&gt; On Sat, Aug 5, 2023 at 2:05=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt; <br>
&gt; &gt; Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huawei.com" tar=
get=3D"_blank">gudkov.andrei@huawei.com</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt; &gt; Introduces alternative argument calc-time-ms, which is the<b=
r>
&gt; &gt; &gt; the same as calc-time but accepts millisecond value.<br>
&gt; &gt; &gt; Millisecond granularity allows to make predictions whether<b=
r>
&gt; &gt; &gt; migration will succeed or not. To do this, calculate dirty<b=
r>
&gt; &gt; &gt; rate with calc-time-ms set to max allowed downtime, convert<=
br>
&gt; &gt; &gt; measured rate into volume of dirtied memory, and divide by<b=
r>
&gt; &gt; &gt; network throughput. If the value is lower than max allowed<b=
r>
&gt; &gt; &gt; downtime, then migration will converge.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Measurement results for single thread randomly writing to<br=
>
&gt; &gt; &gt; a 1/4/24GiB memory region:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +--------------+--------------------------------------------=
---+<br>
&gt; &gt; &gt; | calc-time-ms |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dirty rate MiB/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +---------=
-------+---------------+--------------+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | theoreti=
cal=C2=A0 =C2=A0 | page-sampling | dirty-bitmap |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (at 3M w=
r/sec) |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01GiB=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7100 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03192 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A04606 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4660 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02655 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A03305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3280 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02371 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02534 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2525 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02154 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2044 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01871 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01365 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1341 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01358 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1052 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01025 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0678 =
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 684 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 512 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0507 =
|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 513 |<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04GiB=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 10232 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8880 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A04070 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A08954 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8049 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03195 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A07889 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7193 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02881 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6530 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02700 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A06245 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5772 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02312 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A04829 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4586 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02465 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A03865 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3780 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02178 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02694 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2633 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02004 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2031 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01789 |<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024GiB=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 11495 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8640 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A05597 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 11226 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8616 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A03527 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 10965 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8386 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A02355 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 10713 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8370 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A02179 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 10469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8196 |=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A02098 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A09890 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7885 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02556 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A09354 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7506 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02084 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A08397 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6944 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02075 |<br>
&gt; &gt; &gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A07574 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6402 |=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02062 |<br>
&gt; &gt; &gt; +--------------+----------------+---------------+-----------=
---+<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Theoretical values are computed according to the following f=
ormula:<br>
&gt; &gt; &gt; size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),<br>
&gt; &gt; &gt; where size is in bytes, time is in seconds, and wps is numbe=
r of<br>
&gt; &gt; &gt; writes per second.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.an=
drei@huawei.com" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0| 14 ++++++--<br>
&gt; &gt; &gt;=C2=A0 migration/dirtyrate.h | 12 ++++---<br>
&gt; &gt; &gt;=C2=A0 migration/dirtyrate.c | 81 +++++++++++++++++++++++++--=
----------------<br>
&gt; &gt; &gt;=C2=A0 3 files changed, 67 insertions(+), 40 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; &gt; &gt; index 8843e74b59..82493d6a57 100644<br>
&gt; &gt; &gt; --- a/qapi/migration.json<br>
&gt; &gt; &gt; +++ b/qapi/migration.json<br>
&gt; &gt; &gt; @@ -1849,7 +1849,11 @@<br>
&gt; &gt; &gt;=C2=A0 # @start-time: start time in units of second for calcu=
lation<br>
&gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt;=C2=A0 # @calc-time: time period for which dirty page rate wa=
s measured<br>
&gt; &gt; &gt; -#=C2=A0 =C2=A0 =C2=A0(in seconds)<br>
&gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0(rounded down to seconds).<br>
&gt; &gt; &gt; +#<br>
&gt; &gt; &gt; +# @calc-time-ms: actual time period for which dirty page ra=
te was<br>
&gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0measured (in milliseconds).=C2=A0 Valu=
e may be larger than requested<br>
&gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0time period due to measurement overhea=
d.<br>
&gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt;=C2=A0 # @sample-pages: number of sampled pages per GiB of gu=
est memory.<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Valid only in page-sampling mode =
(Since 6.1)<br>
&gt; &gt; &gt; @@ -1866,6 +1870,7 @@<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;status&#=
39;: &#39;DirtyRateStatus&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;start-ti=
me&#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-tim=
e&#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time-ms&=
#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-p=
ages&#39;: &#39;uint64&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mode&#39=
;: &#39;DirtyRateMeasureMode&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*vcpu-di=
rty-rate&#39;: [ &#39;DirtyRateVcpu&#39; ] } }<br>
&gt; &gt; &gt; @@ -1908,6 +1913,10 @@<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0dirty during @calc-time period, f=
urther writes to this page will<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0not increase dirty page rate anym=
ore.<br>
&gt; &gt; &gt;=C2=A0 #<br>
&gt; &gt; &gt; +# @calc-time-ms: the same as @calc-time but in milliseconds=
.=C2=A0 These<br>
&gt; &gt; &gt; +#=C2=A0 =C2=A0 two arguments are mutually exclusive.=C2=A0 =
Exactly one of them must<br>
&gt; &gt; &gt; +#=C2=A0 =C2=A0 be specified. (Since 8.1)<br>
&gt; &gt; &gt; +#<br>
&gt; &gt; &gt;=C2=A0 # @sample-pages: number of sampled pages per each GiB =
of guest memory.<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Default value is 512.=C2=A0 For 4=
KiB guest pages this corresponds to<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0sampling ratio of 0.2%.=C2=A0 Thi=
s argument is used only in page<br>
&gt; &gt; &gt; @@ -1925,7 +1934,8 @@<br>
&gt; &gt; &gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;: 512=
} }<br>
&gt; &gt; &gt;=C2=A0 # &lt;- { &quot;return&quot;: {} }<br>
&gt; &gt; &gt;=C2=A0 ##<br>
&gt; &gt; &gt; -{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#=
39;: {&#39;calc-time&#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt; +{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#=
39;: {&#39;*calc-time&#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;*calc-time-ms&#39;: &#39;int64&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;*sample-pages&#39;: &#39;int&#39;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;*mode&#39;:<br>
&gt; &gt; &#39;DirtyRateMeasureMode&#39;} }<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Having both @calc-time and @calc-time-ms is ugly.<br>
&gt; &gt;<br>
&gt; &gt; Can we deprecate @calc-time?<br>
&gt; &gt;<br>
&gt; Since the upper app Libvirt has used this field to implement<br>
&gt; the virDomainStartDirtyRateCalc API unfortunately.<br>
&gt; Deprecating this requires the extra patch on Libvirt but no<br>
&gt; functional improvement, IMHO, the field could remain untouched.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t like the name @calc-time-ms.=C2=A0 We don&#39;t put u=
nits in names<br>
&gt; &gt; elsewhere.<br>
&gt; &gt;<br>
&gt; &gt; Differently ugly: new member containing the fractional part, i.e.=
 time<br>
&gt; &gt; in seconds =3D calc-time + fractional-part / 1000.=C2=A0 With a b=
etter name, of<br>
&gt; &gt; course.<br>
&gt; &gt;<br>
&gt; &gt; [...]<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
As another alternative I can propose to add an optional field that<br>
specifies time unit.<br>
<br>
Initiate dirty page rate measurements for 300ms period:<br>
{&quot;execute&quot;: &quot;calc-dirty-rate&quot;,<br>
=C2=A0&quot;arguments&quot;:{&quot;calc-time&quot;: 300, &quot;time-unit&qu=
ot;: &quot;millis&quot;}}<br>
<br>
Query dirty rate. Report calc-time in milliseconds:<br>
{&quot;execute&quot;: &quot;query-dirty-rate&quot;,<br>
=C2=A0&quot;arguments&quot;:{&quot;time-unit&quot;: &quot;millis&quot;}}<br=
></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif">This sounds good and compatible w=
ith the old api. Thanks !</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;borde=
r-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; Thanks,<br>
&gt; <br>
&gt; Yong<br>
&gt; -- <br>
&gt; Best regards<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">yong.</div><br></div=
><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" clas=
s=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-se=
rif">Best regards</font></div></div></div>

--00000000000094336506028bd4e1--

