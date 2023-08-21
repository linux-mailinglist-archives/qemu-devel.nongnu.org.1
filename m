Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF47835FA
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 00:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYDkR-00018m-7R; Mon, 21 Aug 2023 18:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dverkamp@chromium.org>)
 id 1qYDF7-0005MI-Hl
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 18:19:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dverkamp@chromium.org>)
 id 1qYDF2-0006xD-D2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 18:19:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31ad779e6b3so3295361f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692656357; x=1693261157;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W9Fpcs+dXkCDVF8Jv+BOvaN9jG5QSmJkBIxP60EmVa0=;
 b=HWwpQ49D30nO6tX+Wrbg3U7nL2jKtCCx8BhCUsKuek+DJlpxkAVqbAlHeDB9GDgXeF
 C90qB7HlhOCzdc/9dkFes8lLBF/8/e/fI/Hv6Y76m6y46K8nM+RIVGpYR2gIbJ+UOmzu
 /g0b2CHuj3t4xu9X5VSeHebHEcgCBh2oh8aHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692656357; x=1693261157;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9Fpcs+dXkCDVF8Jv+BOvaN9jG5QSmJkBIxP60EmVa0=;
 b=WavmFGeJoI18FCmsNA8fYMfQArz7t/ydoi1AeVpnuktFpcZtePLgK4IqancJ65DyYm
 jwASIAqSEaUpkRP00DGP7YVEcnLeJmZl7jQS8c3cwi3l5+maQQj4HLQHGOo2xo+/TuPD
 +c3GhRWY6fcnoCQPedTfyRRL6luIVO+0f4A4/Cf8fniSnQjpli04Y81LU9au794eAaWM
 xAZ6YLRiFGpOownvIEK9A+S04C51juwmSt1JVqru/KtM/bsCOXCr7LaVn4fGxvXW68Vp
 yKjydYhHiNoxJHYoz04VY2EQ9g+PsoxXEmA3swMtFmYy4HBpNv0EWTvuFrEMOXz5tmrW
 PeWg==
X-Gm-Message-State: AOJu0YwB1Ri9VbjHohaHagmTJijzT510P3P/cTl7mcF//G+B/gjDnipU
 WTr/sDKKmx3g2XbwC0OqxSBhGHecNyHVsp668uI=
X-Google-Smtp-Source: AGHT+IFkZESYAaWTEHFp6RbMniX5sMHk5QY4SBnXkxPze3isa/GTqb2pAvFT6wEr6sa8eW4gTYzE6A==
X-Received: by 2002:a05:6000:1363:b0:31a:ea9f:1aa6 with SMTP id
 q3-20020a056000136300b0031aea9f1aa6mr5928633wrz.47.1692656357103; 
 Mon, 21 Aug 2023 15:19:17 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com.
 [209.85.218.47]) by smtp.gmail.com with ESMTPSA id
 v13-20020aa7d9cd000000b0052568bf9411sm6545583eds.68.2023.08.21.15.19.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 15:19:16 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-99c47ef365cso521452566b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 15:19:16 -0700 (PDT)
X-Received: by 2002:a17:906:5385:b0:994:4095:3abf with SMTP id
 g5-20020a170906538500b0099440953abfmr6289434ejo.14.1692656356026; Mon, 21 Aug
 2023 15:19:16 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 21 Aug 2023 15:18:50 -0700
X-Gmail-Original-Message-ID: <CABVzXAke4LRt4=S4FsFTFf_WPrAhe1dukoLZto6t6R13kgjw0Q@mail.gmail.com>
Message-ID: <CABVzXAke4LRt4=S4FsFTFf_WPrAhe1dukoLZto6t6R13kgjw0Q@mail.gmail.com>
Subject: virtio queue numbering and optional queues
To: virtio-comment@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d4ab790603764491"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=dverkamp@chromium.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_50=0.8, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 21 Aug 2023 18:51:45 -0400
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

--000000000000d4ab790603764491
Content-Type: text/plain; charset="UTF-8"

Hello virtio folks,

I noticed a mismatch between the way the specification defines
device-specific virtqueue indexes and the way device and driver
implementers have interpreted the specification. As a practical example,
consider the traditional memory balloon device [1]. The first two queues
(indexes 0 and 1) are available as part of the baseline device, but the
rest of the queues are tied to feature bits.

Section 5.5.2, "Virtqueues", gives a list that appears to be a mapping from
queue index to queue name/function, defining queue index 3 as free_page_vq
and index 4 as reporting_vq, and declaring that "free_page_vq only exists
if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set" and "reporting_vq only exists if
VIRTIO_BALLOON_F_PAGE_REPORTING is set." This wording is a bit vague, but I
assume "is set" means "is negotiated" (not just "advertised by the
device"). Also presumably "exists" means something like "may only be used
by the driver if the feature bit is negotiated" and "should be ignored by
the device if the feature bit is not negotiated", although it would be nice
to have a proper definition in the spec somewhere.

Section 5.5.3, "Feature bits", gives definitions of the feature bits, with
similar descriptions of the relationship between the feature bits and
virtqueue availability, although the wording is slightly different
("present" rather than "exists"). No dependency between feature bits is
defined, so it seems like it should be valid for a device or driver to
support or accept one of the higher-numbered features while not supporting
a lower-numbered one.


Notably, there is no mention of queue index assignments changing based on
negotiated features in either of these sections. Hence a reader can only
assume that the queue index assignments are fixed (i.e. stats_vq will
always be vq index 4 if F_STATS_VQ is negotiated, regardless of any other
feature bits).

Now consider a scenario where VIRTIO_BALLOON_F_STATS_VQ and
VIRTIO_BALLOON_F_PAGE_REPORTING are negotiated but
VIRTIO_BALLOON_F_FREE_PAGE_HINT is not (perhaps the device supports all of
the defined features but the driver only wants to use reporting_vq, not
free_page_vq). In this case, what queue index should be used by the driver
when enabling reporting_vq? My reading of the specification is that the
reporting_vq is always queue index 4, independent of whether
VIRTIO_BALLOON_F_STATS_VQ or VIRTIO_BALLOON_F_FREE_PAGE_HINT are
negotiated, but this contradicts existing device and driver
implementations, which will use queue index 3 (the next one after stats_vq
= 2) as reporting_vq in this case.

The qemu virtio-ballon device [2] assigns the next-highest unused queue
index when calling virtio_add_queue(), and in the scenario presented above,
free_page_vq will not be added since F_STATS_VQ is not negotiated, so
reporting_vq will be assigned queue index 3, rather than 4. (Additionally,
qemu always adds the stats_vq regardless of negotiated features, but that's
irrelevant in this case since we are assuming the STATS_VQ feature is
negotiated.)

The Linux virtio driver code originally seemed to use the correct (by my
reading) indexes, but it was changed to match the layout used by qemu in a
2019 commit ("virtio_pci: use queue idx instead of array idx to set up the
vq") [3] - in other words, it will now also expect queue index 3 to be
reporting_vq in the scenario laid out above.

I'm not sure how to resolve the mismatch between the specification and
actual implementation behavior. The simplest change would probably be to
rewrite the specification to drop the explicit queue indexes in section
5.5.2 and add some wording about how queues are numbered based on
negotiated feature bits (this would need to be applied to other device
types that have specified queue indexes as well). However, this would also
technically be an incompatible change of the specification. On the other
hand, changing the device and driver implementations to match the
specification would be even more challenging, since it would be an
incompatible change in actual practice, not just a change of the spec to
match consensus implementation behavior.


Perhaps drivers could add a quirk to detect old versions of the qemu device
and use the old behavior, while enabling the correct behavior only for
other device vendors and newer qemu device revisions, and the qemu device
could add an opt-in feature to enable the correct behavior that users would
need to enable only when they know they have a sufficiently new driver with
the fix.


Or maybe there could be a new feature bit that would opt into following the
spec-defined queue indexes (VIRTIO_F_VERSION_2?) and some new wording to
require devices to use the old behavior when that bit is not negotiated,
but that also feels less than ideal to me.

Any thoughts on how to proceed with this situation? Is my reading of the
specification just wrong?

Thanks,

-- Daniel

[1]:
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3160002

[2]:
https://github.com/qemu/qemu/blob/f33c74576425fac2cbb0725229895fe096df4261/hw/virtio/virtio-balloon.c#L879-L897

[3]:
https://github.com/torvalds/linux/commit/ddbeac07a39a81d82331a312d0578fab94fccbf1

--000000000000d4ab790603764491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-8ae35d77-7fff-08ec-06=
e3-f3303f9f6f73"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;font-variant-alternates:normal;vertical-alig=
n:baseline">Hello virtio folks,</span></p><br><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent=
;font-variant-numeric:normal;font-variant-east-asian:normal;font-variant-al=
ternates:normal;vertical-align:baseline">I noticed a mismatch between the w=
ay the specification defines device-specific virtqueue indexes and the way =
device and driver implementers have interpreted the specification. As a pra=
ctical example, consider the traditional memory balloon device [1]. The fir=
st two queues (indexes 0 and 1) are available as part of the baseline devic=
e, but the rest of the queues are tied to feature bits.</span></p><br><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;vertical-align:baseline">Section 5.=
5.2, &quot;Virtqueues&quot;, gives a list that appears to be a mapping from=
 queue index to queue name/function, defining queue index 3 as free_page_vq=
 and index 4 as reporting_vq, and declaring that &quot;free_page_vq only ex=
ists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set&quot; and &quot;reporting_vq=
 only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.&quot; This wording =
is a bit vague, but I assume &quot;is set&quot; means &quot;is negotiated&q=
uot; (not just &quot;advertised by the device&quot;). Also presumably &quot=
;exists&quot; means something like &quot;may only be used by the driver if =
the feature bit is negotiated&quot; and &quot;should be ignored by the devi=
ce if the feature bit is not negotiated&quot;, although it would be nice to=
 have a proper definition in the spec somewhere.</span></p><br><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">Section 5.5.3, &=
quot;Feature bits&quot;, gives definitions of the feature bits, with simila=
r descriptions of the relationship between the feature bits and virtqueue a=
vailability, although the wording is slightly different (&quot;present&quot=
; rather than &quot;exists&quot;). No dependency between feature bits is de=
fined, so it seems like it should be valid for a device or driver to suppor=
t or accept one of the higher-numbered features while not supporting a lowe=
r-numbered one.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-t=
op:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,s=
ans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;font-variant-alternates:normal;vert=
ical-align:baseline"><br></span></p><p dir=3D"ltr" style=3D"line-height:1.3=
8;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-fami=
ly:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;vertical-align:baseline">Notably, there is no mention of queue index =
assignments changing based on negotiated features in either of these sectio=
ns. Hence a reader can only assume that the queue index assignments are fix=
ed (i.e. stats_vq will always be vq index 4 if F_STATS_VQ is negotiated, re=
gardless of any other feature bits).</span></p><br><p dir=3D"ltr" style=3D"=
line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transp=
arent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varia=
nt-alternates:normal;vertical-align:baseline">Now consider a scenario where=
 VIRTIO_BALLOON_F_STATS_VQ and VIRTIO_BALLOON_F_PAGE_REPORTING are negotiat=
ed but VIRTIO_BALLOON_F_FREE_PAGE_HINT is not (perhaps the device supports =
all of the defined features but the driver only wants to use reporting_vq, =
not free_page_vq). In this case, what queue index should be used by the dri=
ver when enabling reporting_vq? My reading of the specification is that the=
 reporting_vq is always queue index 4, independent of whether VIRTIO_BALLOO=
N_F_STATS_VQ or VIRTIO_BALLOON_F_FREE_PAGE_HINT are negotiated, but this co=
ntradicts existing device and driver implementations, which will use queue =
index 3 (the next one after stats_vq =3D 2) as reporting_vq in this case.</=
span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;col=
or:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font=
-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:ba=
seline">The qemu virtio-ballon device [2] assigns the next-highest unused q=
ueue index when calling virtio_add_queue(), and in the scenario presented a=
bove, free_page_vq will not be added since F_STATS_VQ is not negotiated, so=
 reporting_vq will be assigned queue index 3, rather than 4. (Additionally,=
 qemu always adds the stats_vq regardless of negotiated features, but that&=
#39;s irrelevant in this case since we are assuming the STATS_VQ feature is=
 negotiated.)</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ve=
rtical-align:baseline">The Linux virtio driver code originally seemed to us=
e the correct (by my reading) indexes, but it was changed to match the layo=
ut used by qemu in a 2019 commit (&quot;virtio_pci: use queue idx instead o=
f array idx to set up the vq&quot;) [3] - in other words, it will now also =
expect queue index 3 to be reporting_vq in the scenario laid out above.</sp=
an></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;font-variant-alternates:normal;vertical-align:base=
line">I&#39;m not sure how to resolve the mismatch between the specificatio=
n and actual implementation behavior. The simplest change would probably be=
 to rewrite the specification to drop the explicit queue indexes in section=
 5.5.2 and add some wording about how queues are numbered based on negotiat=
ed feature bits (this would need to be applied to other device types that h=
ave specified queue indexes as well). However, this would also technically =
be an incompatible change of the specification. On the other hand, changing=
 the device and driver implementations to match the specification would be =
even more challenging, since it would be an incompatible change in actual p=
ractice, not just a change of the spec to match consensus implementation be=
havior.</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;m=
argin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-seri=
f;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;vertical-ali=
gn:baseline"><br></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;font-variant-alternates:normal;ve=
rtical-align:baseline">Perhaps drivers could add a quirk to detect old vers=
ions of the qemu device and use the old behavior, while enabling the correc=
t behavior only for other device vendors and newer qemu device revisions, a=
nd the qemu device could add an opt-in feature to enable the correct behavi=
or that users would need to enable only when they know they have a sufficie=
ntly new driver with the fix.</span></p><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:Arial,sans-serif;color:rgb(0,0,0);background-color:transparent;font-=
variant-numeric:normal;font-variant-east-asian:normal;font-variant-alternat=
es:normal;vertical-align:baseline"><br></span></p><p dir=3D"ltr" style=3D"l=
ine-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:=
11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:transpa=
rent;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;vertical-align:baseline">Or maybe there could be a new =
feature bit that would opt into following the spec-defined queue indexes (V=
IRTIO_F_VERSION_2?) and some new wording to require devices to use the old =
behavior when that bit is not negotiated, but that also feels less than ide=
al to me.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,san=
s-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:=
normal;font-variant-east-asian:normal;font-variant-alternates:normal;vertic=
al-align:baseline">Any thoughts on how to proceed with this situation? Is m=
y reading of the specification just wrong?</span></p><br><p dir=3D"ltr" sty=
le=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"fon=
t-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;font=
-variant-alternates:normal;vertical-align:baseline">Thanks,</span></p><p di=
r=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span=
 style=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);back=
ground-color:transparent;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;vertical-align:baseline">-- Daniel<=
/span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:b=
aseline">[1]: <a href=3D"https://docs.oasis-open.org/virtio/virtio/v1.2/csd=
01/virtio-v1.2-csd01.html#x1-3160002">https://docs.oasis-open.org/virtio/vi=
rtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-3160002</a></span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-variant-alternates:normal;vertical-align:baseline">[2]: <a href=3D"=
https://github.com/qemu/qemu/blob/f33c74576425fac2cbb0725229895fe096df4261/=
hw/virtio/virtio-balloon.c#L879-L897">https://github.com/qemu/qemu/blob/f33=
c74576425fac2cbb0725229895fe096df4261/hw/virtio/virtio-balloon.c#L879-L897<=
/a></span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;font-variant-alternates:normal;vertical-align:b=
aseline">[3]: <a href=3D"https://github.com/torvalds/linux/commit/ddbeac07a=
39a81d82331a312d0578fab94fccbf1">https://github.com/torvalds/linux/commit/d=
dbeac07a39a81d82331a312d0578fab94fccbf1</a></span></p><br></span></div>

--000000000000d4ab790603764491--

