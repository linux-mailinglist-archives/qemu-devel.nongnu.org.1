Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343ED7AE0AF
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 23:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkt4I-0000ot-GM; Mon, 25 Sep 2023 17:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qkt4E-0000ol-V1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 17:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qkt48-0005m0-Ri
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 17:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695677067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CePc2bg3ro2+ZEMybGTiu+mNbV34dYLYhcISpeUqLjk=;
 b=SWgw2jTciN5ZwV2ZuRngfbD8xTE1vDx+PxzmEjarmcife/4CVlrY9YzR2EJU9WJDb2+p0z
 ITclJ+R47REYz00nVrSt16doBlpojl24ZQaO1YTKQXEwOJl4Lo4RnAqL24sxJMFs067l+f
 JM73uysvZY3ZqxI9MFhqV0WGHmFvY/Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-CIuLwHvOOpe0zLPXPv9Bzg-1; Mon, 25 Sep 2023 17:24:25 -0400
X-MC-Unique: CIuLwHvOOpe0zLPXPv9Bzg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b14f88921so33995236d6.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 14:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695677065; x=1696281865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CePc2bg3ro2+ZEMybGTiu+mNbV34dYLYhcISpeUqLjk=;
 b=vNaLIy5I18n9pZukaK1mFf2bnaXW1KzDWUnE21pR+KZ+xNT4aT5FHG/zfZ3mTpnQS7
 kpNg1ZyCk7Ne6NfriD6kZiNMmfrj5pfyKN3thBJIDnsLak2oAoLXLv/FlGWj9TvBeGLG
 RiG1czYqrvfi9TRycTfnyAP8nN1fnMJYw9mGHUC0Ax0wGH/7RiuvTtNUKM1sZLOIyQUr
 swZDlUb1qGUdmp6vSEPdmrKKLSyJwSjR3WWoCNStf2MbvsQV2aOnMf9VZVnjjlCE4gkp
 k681QVU0DUmYwIvjspgDK7gcRROmGzUMr/TKVV2OPAjj2cl8oCDuiRxblQazHDWblmqZ
 nx5Q==
X-Gm-Message-State: AOJu0Yw7EjbvRfhfQbRsk/Jd3ZlHM2nYAkvd+A+5RZwmvM7j+ln1BeKy
 3WkLtOQR/EoVBqUmYxWoFkjXX/mo+9DeZDtARB32/2g7vRoibtGLibCfSGzRYbLbuzCjlAqUPa2
 cgQJaQ0OYVd/YH1E=
X-Received: by 2002:a05:6214:5099:b0:658:b4f2:eff4 with SMTP id
 kk25-20020a056214509900b00658b4f2eff4mr10736838qvb.45.1695677065405; 
 Mon, 25 Sep 2023 14:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbeiPKdcogKDVSI75b7xf6bzYx9ZxYD9AZgb+sVO49s55gW+p3NpUBaUFz6UDAARDO3dyowQ==
X-Received: by 2002:a05:6214:5099:b0:658:b4f2:eff4 with SMTP id
 kk25-20020a056214509900b00658b4f2eff4mr10736815qvb.45.1695677065117; 
 Mon, 25 Sep 2023 14:24:25 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 i11-20020a0cab4b000000b00655e4f57732sm1970859qvb.35.2023.09.25.14.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 14:24:24 -0700 (PDT)
Date: Mon, 25 Sep 2023 17:24:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: use shadow_avail_idx while checking number of
 heads
Message-ID: <20230925172143-mutt-send-email-mst@kernel.org>
References: <20230825170448.1953409-1-i.maximets@ovn.org>
 <CAJSP0QW1Ck2+XG3c9cJM5+K05ypckXjEnxrJkGwx+PVt6m_3Lg@mail.gmail.com>
 <213042b9-5ccd-bbde-2be0-ff1d32b9c52e@ovn.org>
 <CAJSP0QVf_=LgSTMDL8uyjWtHmJyPQZ-Mt6aPGvHQbRH_v9ZREw@mail.gmail.com>
 <3251b5ee-a53d-68ed-963d-5cfe893d8079@ovn.org>
 <CAJSP0QVNskqOqSW19f-SapHF8LcXeB8uweL+XHkp9zKvCZS6mg@mail.gmail.com>
 <db6df992-75a2-3e30-1ab3-affcc98b7956@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6df992-75a2-3e30-1ab3-affcc98b7956@ovn.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 25, 2023 at 10:58:05PM +0200, Ilya Maximets wrote:
> On 9/25/23 17:38, Stefan Hajnoczi wrote:
> > On Mon, 25 Sept 2023 at 11:36, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>
> >> On 9/25/23 17:12, Stefan Hajnoczi wrote:
> >>> On Mon, 25 Sept 2023 at 11:02, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>
> >>>> On 9/25/23 16:23, Stefan Hajnoczi wrote:
> >>>>> On Fri, 25 Aug 2023 at 13:04, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>>>>
> >>>>>> We do not need the most up to date number of heads, we only want to
> >>>>>> know if there is at least one.
> >>>>>>
> >>>>>> Use shadow variable as long as it is not equal to the last available
> >>>>>> index checked.  This avoids expensive qatomic dereference of the
> >>>>>> RCU-protected memory region cache as well as the memory access itself
> >>>>>> and the subsequent memory barrier.
> >>>>>>
> >>>>>> The change improves performance of the af-xdp network backend by 2-3%.
> >>>>>>
> >>>>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >>>>>> ---
> >>>>>>  hw/virtio/virtio.c | 10 +++++++++-
> >>>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>>>>> index 309038fd46..04bf7cc977 100644
> >>>>>> --- a/hw/virtio/virtio.c
> >>>>>> +++ b/hw/virtio/virtio.c
> >>>>>> @@ -999,7 +999,15 @@ void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >>>>>>  /* Called within rcu_read_lock().  */
> >>>>>>  static int virtqueue_num_heads(VirtQueue *vq, unsigned int idx)
> >>>>>>  {
> >>>>>> -    uint16_t num_heads = vring_avail_idx(vq) - idx;
> >>>>>> +    uint16_t num_heads;
> >>>>>> +
> >>>>>> +    if (vq->shadow_avail_idx != idx) {
> >>>>>> +        num_heads = vq->shadow_avail_idx - idx;
> >>>>>> +
> >>>>>> +        return num_heads;
> >>>>>
> >>>>> This still needs to check num_heads > vq->vring.num and return -EINVAL
> >>>>> as is done below.
> >>>>
> >>>> Hmm, yeas, you're right.  If the value was incorrect initially, the shadow
> >>>> will be incorrect.  However, I think we should just not return here in this
> >>>> case and let vring_avail_idx() to grab an actual new value below.  Otherwise
> >>>> we may never break out of this error.
> >>>>
> >>>> Does that make sense?
> >>>
> >>> No, because virtio_error() marks the device as broken. The device
> >>> requires a reset in order to function again. Fetching
> >>> vring_avail_idx() again won't help.
> >>
> >> OK, I see.  In this case we're talking about situation where
> >> vring_avail_idx() was called in some other place and stored a bad value
> >> in the shadow variable, then virtqueue_num_heads() got called.  Right?
> 
> Hmm, I suppose we also need a read barrier after all even if we use
> a shadow index.  Assuming the index is correct, but the shadow variable
> was updated by a call outside of this function, then we may miss a
> barrier and read the descriptor out of order, in theory.  Read barrier
> is going to be a compiler barrier on x86, so the performance gain from
> this patch should still be mostly there.  I'll test that.

I can't say I understand generally. shadow is under qemu control,
I don't think it can be updated concurrently by multiple CPUs.


> >>
> >> AFAIU, we can still just fall through here and let vring_avail_idx()
> >> to read the index again and fail the existing check.  That would happen
> >> today without this patch applied.
> > 
> > Yes, that is fine.
> > 
> >>
> >> I'm jut trying to avoid duplication of the virtio_error call, i.e.:
> >>
> >>     if (vq->shadow_avail_idx != idx) {
> >>         num_heads = vq->shadow_avail_idx - idx;
> >>
> >>         /* Check it isn't doing very strange things with descriptor numbers. */
> >>         if (num_heads > vq->vring.num) {
> >>             virtio_error(vq->vdev, "Guest moved used index from %u to %u",
> >>                          idx, vq->shadow_avail_idx);
> >>             return -EINVAL;
> >>         }
> >>         return num_heads;
> >>     }
> >>
> >> vs
> >>
> >>     if (vq->shadow_avail_idx != idx) {
> >>         num_heads = vq->shadow_avail_idx - idx;
> >>
> >>         /* Only use the shadow value if it was good initially. */
> >>         if (num_heads <= vq->vring.num) {
> >>             return num_heads;
> >>         }
> >>     }
> >>
> >>
> >> What do you think?
> > 
> > Sounds good.
> > 
> >>
> >> Best regards, Ilya Maximets.


