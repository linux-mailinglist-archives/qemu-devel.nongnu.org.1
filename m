Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77467AE1A7
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 00:26:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qku0d-0006Mp-Gf; Mon, 25 Sep 2023 18:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qku0b-0006Mh-UO
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 18:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qku0R-0007hT-Jn
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 18:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695680681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dLN+HR6kAAPi3DkJ/O93y3w1CseCVMZ2cmCKGWb48TU=;
 b=JYfJx2qaafa9fETrBWbQq/pDbcycWf6oiYH6VbduF4GoDX8bR6NaF4sfatW4RQP+1pTg0R
 Kt9y4b9rMWONYki6PnZEijImiPuwlXotyZpSUaHff88E6XXO0BdNvqTHqaDnK5ccfMuHGD
 yiT8zZ8oQPBddOD/TMZaGk55gBqMJN4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5Tv4UK7zNnqtoiMg5dMt6Q-1; Mon, 25 Sep 2023 18:24:40 -0400
X-MC-Unique: 5Tv4UK7zNnqtoiMg5dMt6Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4194d8b6fceso3013401cf.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 15:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695680679; x=1696285479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLN+HR6kAAPi3DkJ/O93y3w1CseCVMZ2cmCKGWb48TU=;
 b=NlJt1Az4mk6PyfPTD3KpIOCCGwTZZPPC4crbgoo4tZlLM9khq4k5bQlO5ahFN8H1O/
 SnJKDSbPt2v+mNHqve1GCXxY3xTd+5v2eIf1vs+I+eOjy3IYsS8PrQfQz89NsEBLkZ8h
 G6c6rNxXQ5k8vJxsNWpFICjjGqyMUQP1MKOsfMsVwrpzmFALEUyQvl8cD46b4mVCdVm4
 GzvfOWgxXxPMHAfhYXwfnQ85QmBKwcaKqrAJ2uJPS79530/posTNvopkJqtz+52TrA1Q
 hy8t1l03Fru5WVgqFOsD7XRp7V5703/mytqFCXKwgNBHcmNfSxntXrYatp29kVwe9b+R
 nx1A==
X-Gm-Message-State: AOJu0YwmRBAcbVyxkh6ErXArYyoERScD3ajlLPRFs2Bk6edpSvDV+3fq
 txKnJWjttW+8YFj6x517fOd6Kpwbec1499JRao98hxvB3N0/mer715BFuORqrGJvzIu0rDGUhqx
 FN07oQFNNqYc07EQ=
X-Received: by 2002:a05:622a:487:b0:418:330:f06a with SMTP id
 p7-20020a05622a048700b004180330f06amr11710560qtx.3.1695680679586; 
 Mon, 25 Sep 2023 15:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVraobXf60zr49vZNk67qm7jZBHAtsKBKN0EF1hQ5kR9+XMavNhJDzWn3DLCbUk0Yc2DcMCQ==
X-Received: by 2002:a05:622a:487:b0:418:330:f06a with SMTP id
 p7-20020a05622a048700b004180330f06amr11710550qtx.3.1695680679346; 
 Mon, 25 Sep 2023 15:24:39 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 b16-20020ac844d0000000b0040ff6194ef3sm4148829qto.70.2023.09.25.15.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 15:24:38 -0700 (PDT)
Date: Mon, 25 Sep 2023 18:24:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
Message-ID: <20230925182026-mutt-send-email-mst@kernel.org>
References: <20230825170448.1953409-1-i.maximets@ovn.org>
 <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
 <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
 <CAJSP0QVf_=LgSTMDL8uyjWtHmJyPQZ-Mt6aPGvHQbRH_v9ZREw@mail.gmail.com>
 <3251b5ee-a53d-68ed-963d-5cfe893d8079@ovn.org>
 <CAJSP0QVNskqOqSW19f-SapHF8LcXeB8uweL+XHkp9zKvCZS6mg@mail.gmail.com>
 <db6df992-75a2-3e30-1ab3-affcc98b7956@ovn.org>
 <20230925172143-mutt-send-email-mst@kernel.org>
 <c12950b0-8222-23db-0f25-55a106b98e0c@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12950b0-8222-23db-0f25-55a106b98e0c@ovn.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 12:13:11AM +0200, Ilya Maximets wrote:
> On 9/25/23 23:24, Michael S. Tsirkin wrote:
> > On Mon, Sep 25, 2023 at 10:58:05PM +0200, Ilya Maximets wrote:
> >> On 9/25/23 17:38, Stefan Hajnoczi wrote:
> >>> On Mon, 25 Sept 2023 at 11:36, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>
> >>>> On 9/25/23 17:12, Stefan Hajnoczi wrote:
> >>>>> On Mon, 25 Sept 2023 at 11:02, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>>>
> >>>>>> On 9/25/23 16:23, Stefan Hajnoczi wrote:
> >>>>>>> On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>>>>>
> >>>>>>>> We do not need the most up to date number of heads, we only want to
> >>>>>>>> know if there is at least one.
> >>>>>>>>
> >>>>>>>> Use shadow variable as long as it is not equal to the last available
> >>>>>>>> index checked.  This avoids expensive qatomic dereference of the
> >>>>>>>> RCU-protected memory region cache as well as the memory access itself
> >>>>>>>> and the subsequent memory barrier.
> >>>>>>>>
> >>>>>>>> The change improves performance of the af-xdp network backend by 2-3%.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >>>>>>>> ---
> >>>>>>>>  hw/virtio/virtio.c | 10 +++++++++-
> >>>>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>>>>>> index 309038fd46..04bf7cc977 100644
> >>>>>>>> --- a/hw/virtio/virtio.c
> >>>>>>>> +++ b/hw/virtio/virtio.c
> >>>>>>>> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >>>>>>>>  /* Called within rcu_read_lock().  */
> >>>>>>>>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
> >>>>>>>>  {
> >>>>>>>> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> >>>>>>>> +    uint16_t num_heads;
> >>>>>>>> +
> >>>>>>>> +    if (vq->shadow_avail_idx != idx) {
> >>>>>>>> +        num_heads = vq->shadow_avail_idx - idx;
> >>>>>>>> +
> >>>>>>>> +        return num_heads;
> >>>>>>>
> >>>>>>> This still needs to check num_heads > vq->vring.num and return -EINVAL
> >>>>>>> as is done below.
> >>>>>>
> >>>>>> Hmm, yeas, you're right.  If the value was incorrect initially, the shadow
> >>>>>> will be incorrect.  However, I think we should just not return here in this
> >>>>>> case and let vring_avail_idx() to grab an actual new value below.  Otherwise
> >>>>>> we may never break out of this error.
> >>>>>>
> >>>>>> Does that make sense?
> >>>>>
> >>>>> No, because virtio_error() marks the device as broken. The device
> >>>>> requires a reset in order to function again. Fetching
> >>>>> vring_avail_idx() again won't help.
> >>>>
> >>>> OK, I see.  In this case we're talking about situation where
> >>>> vring_avail_idx() was called in some other place and stored a bad value
> >>>> in the shadow variable, then virtqueue_num_heads() got called.  Right?
> >>
> >> Hmm, I suppose we also need a read barrier after all even if we use
> >> a shadow index.  Assuming the index is correct, but the shadow variable
> >> was updated by a call outside of this function, then we may miss a
> >> barrier and read the descriptor out of order, in theory.  Read barrier
> >> is going to be a compiler barrier on x86, so the performance gain from
> >> this patch should still be mostly there.  I'll test that.
> > 
> > I can't say I understand generally. shadow is under qemu control,
> > I don't think it can be updated concurrently by multiple CPUs.
> 
> It can't, I agree.  Scenario I'm thinking about is the following:
> 
> 1. vring_avail_idx() is called from one of the places other than
>    virtqueue_num_heads().  Shadow is updated with the current value.
>    Some users of vring_avail_idx() do not use barriers after the call.
> 
> 2. virtqueue_split_get_avail_bytes() is called.
> 
> 3. virtqueue_split_get_avail_bytes() calls virtqueue_num_heads().
> 
> 4. virtqueue_num_heads() checks the shadow and returns early.
> 
> 5. virtqueue_split_get_avail_bytes() calls vring_split_desc_read() and
>    reads the descriptor.
> 
> If between steps 1 and 5 we do not have a read barrier, we potentially
> risk reading descriptor data that is not yet fully written, because
> there is no guarantee that reading the last_avail_idx on step 1 wasn't
> reordered with the descriptor read.
> 
> In current code we always have smp_rmb() in virtqueue_num_heads().
> But if we return from this function without a barrier, we may have an
> issue, IIUC.
> 
> I agree that it's kind of a very unlikely scenario and we will probably
> have a control dependency between steps 1 and 5 that will prevent the
> issue, but it might be safer to just have an explicit barrier in
> virtqueue_num_heads().
> 
> Does that make sense?  Or am I missing something else here?

Aha, got it. Good point, yes. Pls document in a code comment.


> > 
> > 
> >>>>
> >>>> AFAIU, we can still just fall through here and let vring_avail_idx()
> >>>> to read the index again and fail the existing check.  That would happen
> >>>> today without this patch applied.
> >>>
> >>> Yes, that is fine.
> >>>
> >>>>
> >>>> I'm jut trying to avoid duplication of the virtio_error call, i.e.:
> >>>>
> >>>>     if (vq->shadow_avail_idx != idx) {
> >>>>         num_heads = vq->shadow_avail_idx - idx;
> >>>>
> >>>>         /* Check it isn't doing very strange things with descriptor numbers. */
> >>>>         if (num_heads > vq->vring.num) {
> >>>>             virtio_error(vq->vdev, "Guest moved used index from %u to %u",
> >>>>                          idx, vq->shadow_avail_idx);
> >>>>             return -EINVAL;
> >>>>         }
> >>>>         return num_heads;
> >>>>     }
> >>>>
> >>>> vs
> >>>>
> >>>>     if (vq->shadow_avail_idx != idx) {
> >>>>         num_heads = vq->shadow_avail_idx - idx;
> >>>>
> >>>>         /* Only use the shadow value if it was good initially. */
> >>>>         if (num_heads <= vq->vring.num) {
> >>>>             return num_heads;
> >>>>         }
> >>>>     }
> >>>>
> >>>>
> >>>> What do you think?
> >>>
> >>> Sounds good.
> >>>
> >>>>
> >>>> Best regards, Ilya Maximets.
> > 


