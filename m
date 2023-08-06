Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151907713C3
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 08:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSXLA-0001KO-Ht; Sun, 06 Aug 2023 02:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qSXL6-0001K0-Qh
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:34:08 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qSXL3-00051Z-7B
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:34:08 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-563de62f861so1988414a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691303519; x=1691908319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HVY0fOeShk3pM9cG5XxvdZ8MYyx94YbLrOJ+4gu25Mk=;
 b=s8qhuEWIIcDxe0tAQkQJ7g0HNxLoXWsahbuismsgoSuqw/TWzn71nBKNKbWhtd8WpW
 t6GHPMQAaPq0bMu4UMn2t5Zkiid9zey8qCKTOC9VPQ03Pcqa/sJsmlmh930iCQH9+Qcp
 sV6HD6vqlLugahsoTnmVViSJgQy4HS9sfP146Sq39K/91hlxYdO2R9BPys4M6pTxrMCb
 XLQLvjbUiq63P1jCXqJagzBGzCZK9hVRhn/ZnIGCXKefH74b/ukOxYZ/Zi7fYY/P2phE
 4+mFhj60xZm3hVbgdx0dWCHgdadXSNUZvSj/wYRR8e0kSrfJOGzEQmS75lTl5dS2nLyN
 YRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691303519; x=1691908319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HVY0fOeShk3pM9cG5XxvdZ8MYyx94YbLrOJ+4gu25Mk=;
 b=GVuiQDflWCdIvyQ45MtJPtFENSw80yWfEJsKfjts+T2C74/XesJY8pC3xsWhI38iI4
 FLmK6zFzkBf+nDXTscFADF2/g3nJE3yjdiT7RIh/ZI6BNnHLdz7EusDXXBKdtepaA0B9
 6tJFQP6yQ1AMRCwKkHUuH7eB49O4NDGK+OZPq3ZMhq1paAlWlIKGEGUBMPA8PKqGIo/Q
 tVIj9tYaYPa0auHGIWq2cUELIxTjU6cNsHU+T4gB+Ao6x3cOGmwzx2p28Zt1zojlGDPH
 SGxU5Wf3oYD96hA+UsLRhhdKkFl2J/KO1J0R8ej8qB1E/z6oPWow34sRFRbkbEjuvCoK
 HvCw==
X-Gm-Message-State: AOJu0YyDgWj860GkZvUpWFwP7zdhQ6vqQa5sd8ecyAgE+5hTQ+IAIy0g
 4LkMzxIu+p6g0IXZemNwBuFmVFBnnXXeA0QEIZ6b3g==
X-Google-Smtp-Source: AGHT+IGtwsZZtBm0kdRNO6wrhTq9W1qOV4N8olVwuYdWYwKSglVGeFPOcR5SwsHSCHdPWfSj1mhHMntEqdzGI4+xn9Q=
X-Received: by 2002:a17:90a:ce96:b0:262:e564:3ecb with SMTP id
 g22-20020a17090ace9600b00262e5643ecbmr5363914pju.36.1691303519536; Sat, 05
 Aug 2023 23:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 <87fs4y3cqx.fsf@pond.sub.org>
In-Reply-To: <87fs4y3cqx.fsf@pond.sub.org>
From: Yong Huang <yong.huang@smartx.com>
Date: Sun, 6 Aug 2023 14:31:43 +0800
Message-ID: <CAK9dgmaW1qu3mTa50noH+v_kTSWvsgH1zCBZU-u4KHJmoVn4tA@mail.gmail.com>
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, 
 peterx@redhat.com, leobras@redhat.com, eblake@redhat.com
Content-Type: multipart/alternative; boundary="0000000000007d616006023b49ba"
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x530.google.com
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

--0000000000007d616006023b49ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 5, 2023 at 2:05=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> Andrei Gudkov <gudkov.andrei@huawei.com> writes:
>
> > Introduces alternative argument calc-time-ms, which is the
> > the same as calc-time but accepts millisecond value.
> > Millisecond granularity allows to make predictions whether
> > migration will succeed or not. To do this, calculate dirty
> > rate with calc-time-ms set to max allowed downtime, convert
> > measured rate into volume of dirtied memory, and divide by
> > network throughput. If the value is lower than max allowed
> > downtime, then migration will converge.
> >
> > Measurement results for single thread randomly writing to
> > a 1/4/24GiB memory region:
> >
> > +--------------+-----------------------------------------------+
> > | calc-time-ms |                dirty rate MiB/s               |
> > |              +----------------+---------------+--------------+
> > |              | theoretical    | page-sampling | dirty-bitmap |
> > |              | (at 3M wr/sec) |               |              |
> > +--------------+----------------+---------------+--------------+
> > |                             1GiB                             |
> > +--------------+----------------+---------------+--------------+
> > |          100 |           6996 |          7100 |         3192 |
> > |          200 |           4606 |          4660 |         2655 |
> > |          300 |           3305 |          3280 |         2371 |
> > |          400 |           2534 |          2525 |         2154 |
> > |          500 |           2041 |          2044 |         1871 |
> > |          750 |           1365 |          1341 |         1358 |
> > |         1000 |           1024 |          1052 |         1025 |
> > |         1500 |            683 |           678 |          684 |
> > |         2000 |            512 |           507 |          513 |
> > +--------------+----------------+---------------+--------------+
> > |                             4GiB                             |
> > +--------------+----------------+---------------+--------------+
> > |          100 |          10232 |          8880 |         4070 |
> > |          200 |           8954 |          8049 |         3195 |
> > |          300 |           7889 |          7193 |         2881 |
> > |          400 |           6996 |          6530 |         2700 |
> > |          500 |           6245 |          5772 |         2312 |
> > |          750 |           4829 |          4586 |         2465 |
> > |         1000 |           3865 |          3780 |         2178 |
> > |         1500 |           2694 |          2633 |         2004 |
> > |         2000 |           2041 |          2031 |         1789 |
> > +--------------+----------------+---------------+--------------+
> > |                             24GiB                            |
> > +--------------+----------------+---------------+--------------+
> > |          100 |          11495 |          8640 |         5597 |
> > |          200 |          11226 |          8616 |         3527 |
> > |          300 |          10965 |          8386 |         2355 |
> > |          400 |          10713 |          8370 |         2179 |
> > |          500 |          10469 |          8196 |         2098 |
> > |          750 |           9890 |          7885 |         2556 |
> > |         1000 |           9354 |          7506 |         2084 |
> > |         1500 |           8397 |          6944 |         2075 |
> > |         2000 |           7574 |          6402 |         2062 |
> > +--------------+----------------+---------------+--------------+
> >
> > Theoretical values are computed according to the following formula:
> > size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),
> > where size is in bytes, time is in seconds, and wps is number of
> > writes per second.
> >
> > Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> > ---
> >  qapi/migration.json   | 14 ++++++--
> >  migration/dirtyrate.h | 12 ++++---
> >  migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------------
> >  3 files changed, 67 insertions(+), 40 deletions(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8843e74b59..82493d6a57 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1849,7 +1849,11 @@
> >  # @start-time: start time in units of second for calculation
> >  #
> >  # @calc-time: time period for which dirty page rate was measured
> > -#     (in seconds)
> > +#     (rounded down to seconds).
> > +#
> > +# @calc-time-ms: actual time period for which dirty page rate was
> > +#     measured (in milliseconds).  Value may be larger than requested
> > +#     time period due to measurement overhead.
> >  #
> >  # @sample-pages: number of sampled pages per GiB of guest memory.
> >  #     Valid only in page-sampling mode (Since 6.1)
> > @@ -1866,6 +1870,7 @@
> >             'status': 'DirtyRateStatus',
> >             'start-time': 'int64',
> >             'calc-time': 'int64',
> > +           'calc-time-ms': 'int64',
> >             'sample-pages': 'uint64',
> >             'mode': 'DirtyRateMeasureMode',
> >             '*vcpu-dirty-rate': [ 'DirtyRateVcpu' ] } }
> > @@ -1908,6 +1913,10 @@
> >  #     dirty during @calc-time period, further writes to this page will
> >  #     not increase dirty page rate anymore.
> >  #
> > +# @calc-time-ms: the same as @calc-time but in milliseconds.  These
> > +#    two arguments are mutually exclusive.  Exactly one of them must
> > +#    be specified. (Since 8.1)
> > +#
> >  # @sample-pages: number of sampled pages per each GiB of guest memory.
> >  #     Default value is 512.  For 4KiB guest pages this corresponds to
> >  #     sampling ratio of 0.2%.  This argument is used only in page
> > @@ -1925,7 +1934,8 @@
> >  #                                                 'sample-pages': 512}=
 }
> >  # <- { "return": {} }
> >  ##
> > -{ 'command': 'calc-dirty-rate', 'data': {'calc-time': 'int64',
> > +{ 'command': 'calc-dirty-rate', 'data': {'*calc-time': 'int64',
> > +                                         '*calc-time-ms': 'int64',
> >                                           '*sample-pages': 'int',
> >                                           '*mode':
> 'DirtyRateMeasureMode'} }
> >
>
> Having both @calc-time and @calc-time-ms is ugly.
>
> Can we deprecate @calc-time?
>
Since the upper app Libvirt has used this field to implement
the virDomainStartDirtyRateCalc API unfortunately.
Deprecating this requires the extra patch on Libvirt but no
functional improvement, IMHO, the field could remain untouched.

>
> I don't like the name @calc-time-ms.  We don't put units in names
> elsewhere.
>
> Differently ugly: new member containing the fractional part, i.e. time
> in seconds =3D calc-time + fractional-part / 1000.  With a better name, o=
f
> course.
>
> [...]
>
>
Thanks,

Yong
--=20
Best regards

--0000000000007d616006023b49ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 5, 202=
3 at 2:05=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.=
com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-s=
tyle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Andrei Gudk=
ov &lt;<a href=3D"mailto:gudkov.andrei@huawei.com" target=3D"_blank">gudkov=
.andrei@huawei.com</a>&gt; writes:<br>
<br>
&gt; Introduces alternative argument calc-time-ms, which is the<br>
&gt; the same as calc-time but accepts millisecond value.<br>
&gt; Millisecond granularity allows to make predictions whether<br>
&gt; migration will succeed or not. To do this, calculate dirty<br>
&gt; rate with calc-time-ms set to max allowed downtime, convert<br>
&gt; measured rate into volume of dirtied memory, and divide by<br>
&gt; network throughput. If the value is lower than max allowed<br>
&gt; downtime, then migration will converge.<br>
&gt;<br>
&gt; Measurement results for single thread randomly writing to<br>
&gt; a 1/4/24GiB memory region:<br>
&gt;<br>
&gt; +--------------+-----------------------------------------------+<br>
&gt; | calc-time-ms |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dirty rate MiB/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +----------------+--=
-------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | theoretical=C2=A0 =
=C2=A0 | page-sampling | dirty-bitmap |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | (at 3M wr/sec) |=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7100 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A03192 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A04606 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4660 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02655 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A03305 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3280 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02371 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02534 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2525 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02154 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2044 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01871 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01365 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1341 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01358 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01024 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1052 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01025 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 683 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0678 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 684 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 512 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0507 |=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 513 |<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 10232 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8880 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A04070 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A08954 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8049 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A03195 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A07889 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7193 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02881 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06996 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6530 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02700 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A06245 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5772 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02312 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A04829 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4586 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02465 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A03865 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3780 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02178 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02694 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2633 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02004 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A02041 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2031 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A01789 |<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A024GiB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 100 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 11495 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8640 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A05597 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 200 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 11226 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8616 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A03527 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 300 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 10965 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8386 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02355 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 400 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 10713 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8370 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02179 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 10469 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 8196 |=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A02098 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 750 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A09890 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7885 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02556 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A09354 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7506 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02084 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01500 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A08397 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6944 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02075 |<br>
&gt; |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02000 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A07574 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6402 |=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02062 |<br>
&gt; +--------------+----------------+---------------+--------------+<br>
&gt;<br>
&gt; Theoretical values are computed according to the following formula:<br=
>
&gt; size * (1 - (1-(4096/size))^(time*wps)) / (time * 2^20),<br>
&gt; where size is in bytes, time is in seconds, and wps is number of<br>
&gt; writes per second.<br>
&gt;<br>
&gt; Signed-off-by: Andrei Gudkov &lt;<a href=3D"mailto:gudkov.andrei@huawe=
i.com" target=3D"_blank">gudkov.andrei@huawei.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0| 14 ++++++--<br>
&gt;=C2=A0 migration/dirtyrate.h | 12 ++++---<br>
&gt;=C2=A0 migration/dirtyrate.c | 81 +++++++++++++++++++++++++------------=
------<br>
&gt;=C2=A0 3 files changed, 67 insertions(+), 40 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 8843e74b59..82493d6a57 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -1849,7 +1849,11 @@<br>
&gt;=C2=A0 # @start-time: start time in units of second for calculation<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @calc-time: time period for which dirty page rate was measured=
<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0(in seconds)<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0(rounded down to seconds).<br>
&gt; +#<br>
&gt; +# @calc-time-ms: actual time period for which dirty page rate was<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0measured (in milliseconds).=C2=A0 Value may be l=
arger than requested<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0time period due to measurement overhead.<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # @sample-pages: number of sampled pages per GiB of guest memory=
.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Valid only in page-sampling mode (Since 6.1=
)<br>
&gt; @@ -1866,6 +1870,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;status&#39;: &#39;=
DirtyRateStatus&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;start-time&#39;: &=
#39;int64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time&#39;: &#=
39;int64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;calc-time-ms&#39;: &#39=
;int64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;:=
 &#39;uint64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mode&#39;: &#39;Di=
rtyRateMeasureMode&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;*vcpu-dirty-rate&#=
39;: [ &#39;DirtyRateVcpu&#39; ] } }<br>
&gt; @@ -1908,6 +1913,10 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0dirty during @calc-time period, further wri=
tes to this page will<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0not increase dirty page rate anymore.<br>
&gt;=C2=A0 #<br>
&gt; +# @calc-time-ms: the same as @calc-time but in milliseconds.=C2=A0 Th=
ese<br>
&gt; +#=C2=A0 =C2=A0 two arguments are mutually exclusive.=C2=A0 Exactly on=
e of them must<br>
&gt; +#=C2=A0 =C2=A0 be specified. (Since 8.1)<br>
&gt; +#<br>
&gt;=C2=A0 # @sample-pages: number of sampled pages per each GiB of guest m=
emory.<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0Default value is 512.=C2=A0 For 4KiB guest =
pages this corresponds to<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0sampling ratio of 0.2%.=C2=A0 This argument=
 is used only in page<br>
&gt; @@ -1925,7 +1934,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;sample-pages&#39;: 512} }<br>
&gt;=C2=A0 # &lt;- { &quot;return&quot;: {} }<br>
&gt;=C2=A0 ##<br>
&gt; -{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: {&#39=
;calc-time&#39;: &#39;int64&#39;,<br>
&gt; +{ &#39;command&#39;: &#39;calc-dirty-rate&#39;, &#39;data&#39;: {&#39=
;*calc-time&#39;: &#39;int64&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&#39;*calc-time-ms&#39;: &#39;int64&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;*sample-pages&#39;: &#39;int&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;*mode&#39;: &#39;DirtyRateMeasureMode&#39;} }<br>
&gt;=C2=A0 <br>
<br>
Having both @calc-time and @calc-time-ms is ugly.<br>
<br>
Can we deprecate @calc-time?<br></blockquote><div class=3D"gmail_default" s=
tyle=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Since the upper a=
pp Libvirt has used this field to implement</div><div class=3D"gmail_defaul=
t" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">the virDomain=
StartDirtyRateCalc API unfortunately.</div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Deprecating this re=
quires=C2=A0the extra patch on Libvirt but no</div><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">functional =
improvement, IMHO, the field could remain untouched.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
I don&#39;t like the name @calc-time-ms.=C2=A0 We don&#39;t put units in na=
mes<br>
elsewhere.<br>
<br>
Differently ugly: new member containing the fractional part, i.e. time<br>
in seconds =3D calc-time + fractional-part / 1000.=C2=A0 With a better name=
, of<br>
course.<br>
<br>
[...]<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default" styl=
e=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Thanks,</div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif"><br></div><div class=3D"gmail_default" style=3D"font-family:&quot;com=
ic sans ms&quot;,sans-serif">Yong</div></div><span class=3D"gmail_signature=
_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font></div>=
</div></div>

--0000000000007d616006023b49ba--

