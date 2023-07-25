Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D9761D3B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 17:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJrK-00037r-CM; Tue, 25 Jul 2023 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOJrH-00037Z-NR
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qOJrF-000721-Uk
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 11:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690298512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=155ZpFgvWzj3krIREXsBrJb0OU4Q8BS2sfBjgyyB78A=;
 b=OKSWN0DL11VjwPTsC5fvFOxzr2Gyqos9xu0a+rhjXYv/vz8IQ1H2kGadurxcOR8B0lYowX
 dqr+3Lalb9+Xr4so1EO0ypdHdin/1EquK0eRSS+3gRqIGW44mU67h3Wr8rZ72aYoO8eFlZ
 XrvA7JndLu1rTbP59Ia7Qyj3D5tige4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-G7QruGYlMwClxcGDChFVIA-1; Tue, 25 Jul 2023 11:21:49 -0400
X-MC-Unique: G7QruGYlMwClxcGDChFVIA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso2704883f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690298507; x=1690903307;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=155ZpFgvWzj3krIREXsBrJb0OU4Q8BS2sfBjgyyB78A=;
 b=LVUMKqNWMsZCN9bO2pquzvyCVT6p9p5MMcueMz3GdyOhCl/ow/XArZ2kkeZrB1l60a
 QhmBuctI2SoAtKzelFypUrr/JfIjBt8N2bM0+TKsiC2EFMAR/8XHK8qVdHL0Ypn8vbtQ
 ERzAibG48xhlZIfikqwW907egqQO+z5abuU0LucrxyS1gqrQH99Ckq8jukNU1hHWugGU
 QH0X98T6ghubG85Cp8nhbipX8euY2rcjk4emwg8RYjjQ51v7r7olrc81dgeaMJWmIBKI
 LT0jI2iQLPtO+lTenKe6KOs0dct0av26LtuXputzWorxvBOLCCXA0Kxhcmmy860BaCwB
 lwJA==
X-Gm-Message-State: ABy/qLZEIjK558q+fgPM1JCgaXXifNcE6nyy6/eFV2/sP4o+/a+6H4JS
 wubAqHS/dg8z+gLpnVgzpEEUrhO+4ri0Jq8c8uC00+T2iI0dGl12fuLfLWBu8vVn04IAE6tY2Dk
 KJwATMsnosoc11m0D1+T/c9k=
X-Received: by 2002:a5d:4d10:0:b0:314:30ed:9b55 with SMTP id
 z16-20020a5d4d10000000b0031430ed9b55mr9318560wrt.15.1690298506859; 
 Tue, 25 Jul 2023 08:21:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIrlkmuCGkO6OU7gYwrM6LD/tZFV7QL06YbO1aNSFjTep2r+4b5OgrO2Y/cS6R5jCC1YVY/Q==
X-Received: by 2002:a5d:4d10:0:b0:314:30ed:9b55 with SMTP id
 z16-20020a5d4d10000000b0031430ed9b55mr9318546wrt.15.1690298506416; 
 Tue, 25 Jul 2023 08:21:46 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a5d58da000000b0030ae499da59sm16701947wrf.111.2023.07.25.08.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 08:21:45 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------ic4VAqvaAkwG7jdLWI5TmrbQ"
Message-ID: <2a4dd14f-4405-33f5-da68-ddf66a225cb7@redhat.com>
Date: Tue, 25 Jul 2023 17:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio: Fix packed virtqueue used_idx mask
Content-Language: en-US
To: German Maglione <gmaglione@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230721134945.26967-1-hreitz@redhat.com>
 <CAJh=p+5sTOVPmSm-LeV1SJxTQW0dOuL_Lz2GTcdCK6MY6V7LxQ@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJh=p+5sTOVPmSm-LeV1SJxTQW0dOuL_Lz2GTcdCK6MY6V7LxQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------ic4VAqvaAkwG7jdLWI5TmrbQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.23 16:04, German Maglione wrote:
>
>
> On Fri, Jul 21, 2023 at 3:51 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>
>     virtio_queue_packed_set_last_avail_idx() is used by vhost devices
>     to set
>     the internal queue indices to what has been reported by the vhost
>     back-end through GET_VRING_BASE.  For packed virtqueues, this
>     32-bit value is expected to contain both the device's internal
>     avail and
>     used indices, as well as their respective wrap counters.
>
>     To get the used index, we shift the 32-bit value right by 16, and then
>     apply a mask of 0x7ffff.  That seems to be a typo, because it
>     should be
>     0x7fff; first of all, the virtio specification says that the maximum
>     queue size for packed virt queues is 2^15, so the indices cannot
>     exceed
>     2^15 - 1 anyway, making 0x7fff the correct mask.  Second, the mask
>     clearly is wrong from context, too, given that (A) `idx & 0x70000`
>     must
>     be 0 at this point (`idx` is 32 bit and was shifted to the right by 16
>     already), (B) `idx & 0x8000` is the used_wrap_counter, so should
>     not be
>     part of the used index, and (C) `vq->used_idx` is a `uint16_t`, so
>     cannot fit the 0x70000 part of the mask anyway.
>
>     This most likely never produced any guest-visible bugs, though,
>     because
>     for a vhost device, qemu will probably not evaluate the used index
>     outside of virtio_queue_packed_get_last_avail_idx(), where we
>     reconstruct the 32-bit value from avail and used indices and their
>     wrap
>     counters again.  There, it does not matter whether the highest bit of
>     the used_idx is the used index wrap counter, because we put the wrap
>     counter exactly in that position anyway.
>
>     Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>     ---
>      hw/virtio/virtio.c | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>     index 295a603e58..309038fd46 100644
>     --- a/hw/virtio/virtio.c
>     +++ b/hw/virtio/virtio.c
>     @@ -3321,7 +3321,7 @@ static void
>     virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,
>          vq->last_avail_wrap_counter =
>              vq->shadow_avail_wrap_counter = !!(idx & 0x8000);
>          idx >>= 16;
>     -    vq->used_idx = idx & 0x7ffff;
>     +    vq->used_idx = idx & 0x7fff;
>
>
> isn't there a macro with this value?
> or a macro that convert a number of bits in a mask?, something like:
> #define BIT_MASK(n) (~(~0 << n))

((1 << n) - 1) would be what I’d come up with; in any case, there is 
MAKE_64BIT_MASK in qemu/bitops.h, but I don’t know whether I really like 
MAKE_64BIT_MASK(0, 15) more than 0x7fff.  In addition, that would need 
to be done throughout that function and I don’t think that’s worth it 
right now.

Hanna
--------------ic4VAqvaAkwG7jdLWI5TmrbQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 25.07.23 16:04, German Maglione
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJh=p+5sTOVPmSm-LeV1SJxTQW0dOuL_Lz2GTcdCK6MY6V7LxQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Fri, Jul 21, 2023 at
            3:51 PM Hanna Czenczek &lt;<a
              href="mailto:hreitz@redhat.com" moz-do-not-send="true"
              class="moz-txt-link-freetext">hreitz@redhat.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">virtio_queue_packed_set_last_avail_idx()
            is used by vhost devices to set<br>
            the internal queue indices to what has been reported by the
            vhost<br>
            back-end through GET_VRING_BASE.  For packed virtqueues,
            this<br>
            32-bit value is expected to contain both the device's
            internal avail and<br>
            used indices, as well as their respective wrap counters.<br>
            <br>
            To get the used index, we shift the 32-bit value right by
            16, and then<br>
            apply a mask of 0x7ffff.  That seems to be a typo, because
            it should be<br>
            0x7fff; first of all, the virtio specification says that the
            maximum<br>
            queue size for packed virt queues is 2^15, so the indices
            cannot exceed<br>
            2^15 - 1 anyway, making 0x7fff the correct mask.  Second,
            the mask<br>
            clearly is wrong from context, too, given that (A) `idx
            &amp; 0x70000` must<br>
            be 0 at this point (`idx` is 32 bit and was shifted to the
            right by 16<br>
            already), (B) `idx &amp; 0x8000` is the used_wrap_counter,
            so should not be<br>
            part of the used index, and (C) `vq-&gt;used_idx` is a
            `uint16_t`, so<br>
            cannot fit the 0x70000 part of the mask anyway.<br>
            <br>
            This most likely never produced any guest-visible bugs,
            though, because<br>
            for a vhost device, qemu will probably not evaluate the used
            index<br>
            outside of virtio_queue_packed_get_last_avail_idx(), where
            we<br>
            reconstruct the 32-bit value from avail and used indices and
            their wrap<br>
            counters again.  There, it does not matter whether the
            highest bit of<br>
            the used_idx is the used index wrap counter, because we put
            the wrap<br>
            counter exactly in that position anyway.<br>
            <br>
            Signed-off-by: Hanna Czenczek &lt;<a
              href="mailto:hreitz@redhat.com" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">hreitz@redhat.com</a>&gt;<br>
            ---<br>
             hw/virtio/virtio.c | 2 +-<br>
             1 file changed, 1 insertion(+), 1 deletion(-)<br>
            <br>
            diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>
            index 295a603e58..309038fd46 100644<br>
            --- a/hw/virtio/virtio.c<br>
            +++ b/hw/virtio/virtio.c<br>
            @@ -3321,7 +3321,7 @@ static void
            virtio_queue_packed_set_last_avail_idx(VirtIODevice *vdev,<br>
                 vq-&gt;last_avail_wrap_counter =<br>
                     vq-&gt;shadow_avail_wrap_counter = !!(idx &amp;
            0x8000);<br>
                 idx &gt;&gt;= 16;<br>
            -    vq-&gt;used_idx = idx &amp; 0x7ffff;<br>
            +    vq-&gt;used_idx = idx &amp; 0x7fff;<br>
          </blockquote>
          <div><br>
          </div>
          <div>isn't there a macro with this value?<br>
            or a macro that convert a number of bits in a mask?,
            something like:<br>
          </div>
          <div>#define BIT_MASK(n) (~(~0 &lt;&lt; n))<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    ((1 &lt;&lt; n) - 1) would be what I’d come up with; in any case,
    there is MAKE_64BIT_MASK in qemu/bitops.h, but I don’t know whether
    I really like MAKE_64BIT_MASK(0, 15) more than 0x7fff.  In addition,
    that would need to be done throughout that function and I don’t
    think that’s worth it right now.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------ic4VAqvaAkwG7jdLWI5TmrbQ--


