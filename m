Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29A7ADBA8
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 17:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qknfU-0000Gp-Vr; Mon, 25 Sep 2023 11:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qknfT-0000GZ-91
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:38:39 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qknfK-0001j6-16
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 11:38:39 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c09f1f4610so3344476a34.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695656308; x=1696261108; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jwSAkh+7xeKiuEhfnRuSfAiI3GbFw26LJuO18D4pAZU=;
 b=CzwCx2oYmPUJaJLEgka2Vwg1Blt+0MCoZGMwynX9P3SGJlMKPJ4G832NDkGqx6xk6O
 tTRrVQXtIkKgQCotEJfOVBSaqKPh41DaXyq4nRM0qqU//yd6VVNrIFKt/h4MYotyD2J9
 QWM/644gOqkt0U08TVCURmEnUXgN3hZNLUIf1NLPgZKTWmD9EbrSUUgxTZDGA3y5WxUo
 QtV3OvGnXbBe2wCBCJvDXpe+lGgEnhT4YeMK1Bh+iMHYJiT4mLCGaHlWgoebEQ3eU5ux
 xDmiGZZkGdNQzCJL7hNB4G3QFl0DyB6QaZL7/k1CMV92wY/IkSmgbKSbA8fPwghtZTQ5
 jAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695656308; x=1696261108;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwSAkh+7xeKiuEhfnRuSfAiI3GbFw26LJuO18D4pAZU=;
 b=uIOfwO8I93ifoFJy2bvs1/OeQEdsLt+nElZY9dxj3brEWrZx6QA9AaHCDMsRj1Xo7D
 1EDlp/CPIQ+PhTdtJEYq+tmZbEyvAI6DuAAdLsWTWVAq2jK+Ay/cvO5AXKTFMPDMUKH2
 Y5/zgFGcKER5eomeQRNUIPqbFCx6310Iwiqub2rdaFuO1T/ohCj2N/oyEWfnrTk9uspC
 s16VD1DXu6SWAPkrvbkCrKxku+NqBLTBRvGdYBnoo42mNdLu4MRpSdgC/isPXzsUB4jx
 hzE3c1aeU7u1WL4zPraRwcc/Cj6vauHHRbcVIzcZJGkbqCbJtnnMLhfT2fsKDmfl85o9
 ewjQ==
X-Gm-Message-State: AOJu0YzfyXAZDuyoNcDKmfejWj1oDc424k4SRxpQbZb3e4nhmbC6w+XX
 PqMcjTfLeEJO220G1hNeGtyj0Pp/GMtZwe7v+JI=
X-Google-Smtp-Source: AGHT+IEclBFXx1fTPMRbmAQ8GfrvdRUiBJiIh2xIloM8jBwfrHRTSq05ORxFx9/C+yNw+fAQ1GF3b6MZGHwEm9Mw2N0=
X-Received: by 2002:a9d:7384:0:b0:6b7:56d9:533 with SMTP id
 j4-20020a9d7384000000b006b756d90533mr5715152otk.28.1695656308626; Mon, 25 Sep
 2023 08:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230825170448.1953409-1-i.maximets@ovn.org>
 <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
 <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
 <CAJSP0QVf_=LgSTMDL8uyjWtHmJyPQZ-Mt6aPGvHQbRH_v9ZREw@mail.gmail.com>
 <3251b5ee-a53d-68ed-963d-5cfe893d8079@ovn.org>
In-Reply-To: <3251b5ee-a53d-68ed-963d-5cfe893d8079@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 25 Sep 2023 11:38:16 -0400
Message-ID: <CAJSP0QVNskqOqSW19f-SapHF8LcXeB8uweL+XHkp9zKvCZS6mg@mail.gmail.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 25 Sept 2023 at 11:36, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 9/25/23 17:12, Stefan Hajnoczi wrote:
> > On Mon, 25 Sept 2023 at 11:02, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>
> >> On 9/25/23 16:23, Stefan Hajnoczi wrote:
> >>> On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>
> >>>> We do not need the most up to date number of heads, we only want to
> >>>> know if there is at least one.
> >>>>
> >>>> Use shadow variable as long as it is not equal to the last available
> >>>> index checked.  This avoids expensive qatomic dereference of the
> >>>> RCU-protected memory region cache as well as the memory access itself
> >>>> and the subsequent memory barrier.
> >>>>
> >>>> The change improves performance of the af-xdp network backend by 2-3%.
> >>>>
> >>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >>>> ---
> >>>>  hw/virtio/virtio.c | 10 +++++++++-
> >>>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>> index 309038fd46..04bf7cc977 100644
> >>>> --- a/hw/virtio/virtio.c
> >>>> +++ b/hw/virtio/virtio.c
> >>>> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >>>>  /* Called within rcu_read_lock().  */
> >>>>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
> >>>>  {
> >>>> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> >>>> +    uint16_t num_heads;
> >>>> +
> >>>> +    if (vq->shadow_avail_idx != idx) {
> >>>> +        num_heads = vq->shadow_avail_idx - idx;
> >>>> +
> >>>> +        return num_heads;
> >>>
> >>> This still needs to check num_heads > vq->vring.num and return -EINVAL
> >>> as is done below.
> >>
> >> Hmm, yeas, you're right.  If the value was incorrect initially, the shadow
> >> will be incorrect.  However, I think we should just not return here in this
> >> case and let vring_avail_idx() to grab an actual new value below.  Otherwise
> >> we may never break out of this error.
> >>
> >> Does that make sense?
> >
> > No, because virtio_error() marks the device as broken. The device
> > requires a reset in order to function again. Fetching
> > vring_avail_idx() again won't help.
>
> OK, I see.  In this case we're talking about situation where
> vring_avail_idx() was called in some other place and stored a bad value
> in the shadow variable, then virtqueue_num_heads() got called.  Right?
>
> AFAIU, we can still just fall through here and let vring_avail_idx()
> to read the index again and fail the existing check.  That would happen
> today without this patch applied.

Yes, that is fine.

>
> I'm jut trying to avoid duplication of the virtio_error call, i.e.:
>
>     if (vq->shadow_avail_idx != idx) {
>         num_heads = vq->shadow_avail_idx - idx;
>
>         /* Check it isn't doing very strange things with descriptor numbers. */
>         if (num_heads > vq->vring.num) {
>             virtio_error(vq->vdev, "Guest moved used index from %u to %u",
>                          idx, vq->shadow_avail_idx);
>             return -EINVAL;
>         }
>         return num_heads;
>     }
>
> vs
>
>     if (vq->shadow_avail_idx != idx) {
>         num_heads = vq->shadow_avail_idx - idx;
>
>         /* Only use the shadow value if it was good initially. */
>         if (num_heads <= vq->vring.num) {
>             return num_heads;
>         }
>     }
>
>
> What do you think?

Sounds good.

>
> Best regards, Ilya Maximets.

